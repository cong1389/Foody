using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.IDAL;
using Cb.DBUtility;
using Cb.DALFactory;
using System.Data.Common;
using System.Data;
using System.Reflection;
using System.Data.SqlClient;
using Cb.Utility;

namespace Cb.SQLServerDAL
{
    public class Generic2C<T, TDesc> : IGeneric2C<T, TDesc>
        where T : class,new()
        where TDesc : class,new()
    {
        private static IGeneric<T> dal;
        private static IGeneric<TDesc> dalDesc;

        public Generic2C()
        {
            Type t = typeof(Generic<T>);
            dal = DataAccessGeneric<T>.CreateSession(t.FullName);
            t = typeof(Generic<TDesc>);
            dalDesc = DataAccessGeneric<TDesc>.CreateSession(t.FullName);
        }

        #region IGeneric2C<T,TDesc> Members

        public int Insert(T obj, List<TDesc> lst)
        {
            IFactory factory = DBHelper.CreateFactory();
            factory.BeginTransaction();
            int output = 0;
            try
            {
                output = dal.InsertWithTransaction(obj, factory);
                foreach (var item in lst)
                {
                    item.GetType().GetProperty("MainId").SetValue(item, output, null);
                    dalDesc.InsertWithTransaction(item, factory);
                }
                factory.Commit();
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic2C<T, TDesc>", string.Format("Insert({0} obj, List<TDesc> lst)", obj.GetType().Name), ex.Message);
                factory.Rollback();
            }
            finally
            {
                factory.Release();
            }
            return output;
        }

        public int InsertWithTransaction(T obj, List<TDesc> lst, IFactory factory)
        {
            int output = dal.InsertWithTransaction(obj, factory);
            foreach (var item in lst)
            {
                item.GetType().GetProperty("MainId").SetValue(item, output, null);
                dalDesc.InsertWithTransaction(item, factory);
            }
            return output;
        }

        public void Update(T obj, List<TDesc> lst, string[] primaryKeyNames)
        {
            IFactory factory = DBHelper.CreateFactory();
            factory.BeginTransaction();
            try
            {
                dal.UpdateWithTransaction(obj, obj, primaryKeyNames, factory);
                string[] fields = { "MainId", "LangId" };
                foreach (var item in lst)
                {
                    dalDesc.UpdateWithTransaction(item, item, fields, factory);
                }
                factory.Commit();
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic2C<T, TDesc>", string.Format("Update({0} obj, List<TDesc> lst, string[] primaryKeyNames)", obj.GetType().Name), ex.Message);
                factory.Rollback();
            }
            finally
            {
                factory.Release();
            }

        }

        public void UpdateWithTransaction(T obj, List<TDesc> lst, string[] primaryKeyNames, IFactory factory)
        {
            dal.UpdateWithTransaction(obj, obj, primaryKeyNames, factory);
            string[] fields = { "MainId", "LangId" };
            foreach (var item in lst)
            {
                dalDesc.UpdateWithTransaction(item, item, fields, factory);
            }
        }

        public IList<T> GetList(string storedProc, DGCParameter[] parameters, out int total)
        {
            total = 0;

            IFactory factory = DBHelper.CreateFactory();
            IList<T> lst = new List<T>();
            try
            {
                DbCommand cmd = factory.MakeCommandFromStore(storedProc);
                GenerateQuery.PrepareParametersList(cmd, parameters);

                IDbDataParameter para = cmd.CreateParameter();
                para.ParameterName = "@total";
                para.DbType = DbType.Int32;
                para.Direction = ParameterDirection.Output;
                para.Value = total;
                cmd.Parameters.Add(para);

                IDataReader dre = factory.ExecuteReader(cmd);
                lst = Results(dre);
                object strTemp = cmd.Parameters["@total"].Value;
                total = Convert.ToInt32(strTemp);

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic2C<T, TDesc>", string.Format("GetList(string storedProc, DGCParameter[] parameters, out {0} obj, out TDesc objDesc, out int total)", typeof(T).Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
            return lst;
        }

        public IList<T> GetListT(string storedProc, DGCParameter[] parameters)
        {


            IFactory factory = DBHelper.CreateFactory();
            IList<T> lst = new List<T>();
            try
            {
                DbCommand cmd = factory.MakeCommandFromStore(storedProc);
                GenerateQuery.PrepareParametersList(cmd, parameters);
                IDataReader dre = factory.ExecuteReader(cmd);
                lst = Results(dre);

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic2C<T, TDesc>", string.Format("GetList(string storedProc, DGCParameter[] parameters, out {0} obj, out TDesc objDesc, out int total)", typeof(T).Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
            return lst;
        }

        public bool Delete(string arrId)
        {
            IFactory factory = DBHelper.CreateFactory();
            bool isDelete = false;
            factory.BeginTransaction();
            try
            {
                string query = string.Format(@"DELETE FROM {0} WHERE  Id in ({1})", typeof(T).Name.ToLower(), arrId);
                DbCommand cmd = factory.MakeCommand(query);
                factory.ExecuteNonQuery(cmd);

                query = string.Format(@"DELETE FROM {0} WHERE  MainId in ({1})", typeof(TDesc).Name.ToLower(), arrId);
                cmd = factory.MakeCommand(query);
                factory.ExecuteNonQuery(cmd);

                factory.Commit();
                isDelete = true;
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic2C<T, TDesc>", string.Format("Delete<{0}, TDesc>(string arrId)", typeof(T).Name), ex.Message);
                factory.Rollback();
            }
            finally
            {
                factory.Release();
            }
            return isDelete;
        }

        public T Load(T obj, string[] primaryKeyNames, int langId)
        {
            Type t = typeof(T);
            IFactory factory = DBHelper.CreateFactory();
            try
            {
                obj = dal.Load(obj, primaryKeyNames, factory);
                string[] fields = { "MainId", "LangId" };


                PropertyInfo property = t.GetProperty(("Id"));
                int id = Convert.ToInt32(property.GetValue(obj, null));
                TDesc objDesc = dalDesc.LoadByObjectAndLang(id, langId, factory);
                property = t.GetProperty(Utils.GetPropertyDescName(typeof(TDesc)));
                property.SetValue(obj, objDesc, null);

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic2C<T, TDesc>", string.Format("Load({0} obj, string[] primaryKeyNames, int langId, out TDesc objDesc)", t.Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
            return obj;
        }

        public IList<T> Results(IDataReader dre)
        {
            IList<T> sessions = new List<T>();
            PropertyInfo[] properties;
            try
            {
                while (dre.Read())
                {
                    T obj = new T();
                    properties = obj.GetType().GetProperties();

                    foreach (var property in properties)
                    {
                        if (property.PropertyType == typeof(TDesc))
                            property.SetValue(obj, dalDesc.OneResultsDesc(dre), null);
                        else
                            property.SetValue(obj, DBConvert.ParseDBToObject(dre, property), null);
                    }
                    sessions.Add(obj);
                }

            }

            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("IList<{0}> Results(IDataReader dre)", typeof(T).Name), ex.Message);
            }
            finally
            {
                dre.Close();
            }
            return sessions;
        }

        #endregion


    }
}
