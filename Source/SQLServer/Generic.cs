using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.IDAL;
using Cb.DBUtility;
using System.Data.Common;
using System.Data;
using System.Reflection;
using System.Configuration;
using Cb.DBUtility.DataContext;

namespace Cb.SQLServerDAL
{
    public class Generic<T> : IGeneric<T> where T : class, new()
    {
        public static string PARAM_PREFIX
        {
            get
            {
                string re = string.Empty;
                switch (ConfigurationSettings.AppSettings["Database"])
                {
                    case "SQLServer":
                        re = "@";
                        break;
                    case "MySQL":
                        re = "?";
                        break;
                }
                return re;
            }
        }

        #region Class Main

        public IList<T> GetAll()
        {
            GenericDataContext<T> db = new GenericDataContext<T>();

            return db.Entities.ToList();
        }

        public int Insert(T obj)
        {
            IFactory factory = DBHelper.CreateFactory();
            factory.BeginTransaction();
            object output = null;
            int re = int.MinValue;
            try
            {
                string query = GenerateQuery.CommandTextInsert(obj);
                DbCommand cmd = factory.MakeCommand(query);
                GenerateQuery.PrepareParametersInsert(cmd, obj);
                output = factory.ExecuteScalar(cmd);
                factory.Commit();
                re = DBConvert.ParseInt(output);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("Insert({0} obj)", obj.GetType().Name), ex.Message);
                factory.Rollback();
            }
            finally
            {
                factory.Release();
            }
            return re;
        }

        public int InsertIDENTITY(T obj)
        {
            IFactory factory = DBHelper.CreateFactory();
            factory.BeginTransaction();
            object output = null;
            int re = int.MinValue;
            try
            {
                string query = GenerateQuery.CommandTextInsertIDENTITY(obj);
                DbCommand cmd = factory.MakeCommand(query);
                GenerateQuery.PrepareParametersInsert(cmd, obj);
                output = factory.ExecuteScalar(cmd);
                factory.Commit();
                re = DBConvert.ParseInt(output);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("Insert({0} obj)", obj.GetType().Name), ex.Message);
                factory.Rollback();
            }
            finally
            {
                factory.Release();
            }
            return re;
        }

        public int InsertWithTransaction(T obj, IFactory factory)
        {
            string query = GenerateQuery.CommandTextInsert(obj);
            DbCommand cmd = factory.MakeCommand(query);
            GenerateQuery.PrepareParametersInsert(cmd, obj);
            object output = factory.ExecuteScalar(cmd);
            return DBConvert.ParseInt(output);
        }

        public int InsertIDENTITYWithTransaction(T obj, IFactory factory)
        {
            string query = GenerateQuery.CommandTextInsertIDENTITY(obj);
            DbCommand cmd = factory.MakeCommand(query);
            GenerateQuery.PrepareParametersInsert(cmd, obj);
            object output = factory.ExecuteScalar(cmd);
            return int.Parse(output.ToString());
        }

        public int InsertIDENTITYWithTransactionWithMaxField(T obj, IFactory factory, string fieldMax)
        {
            string query = GenerateQuery.CommandTextInsertIDENTITYWithMaxFiels(obj, fieldMax);
            DbCommand cmd = factory.MakeCommand(query);
            GenerateQuery.PrepareParametersInsert(cmd, obj);
            object output = factory.ExecuteScalar(cmd);
            return int.Parse(output.ToString());
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

        public void Update(T currentObj, T expectedObj, string[] primaryKeyNames)
        {
            IFactory factory = DBHelper.CreateFactory();
            try
            {
                string query = GenerateQuery.CommandTextUpdate(currentObj, primaryKeyNames);
                DbCommand cmd = factory.MakeCommand(query);
                GenerateQuery.PrepareParametersUpdate(cmd, currentObj, expectedObj, primaryKeyNames);
                cmd.CommandTimeout = 10;
                factory.ExecuteNonQuery(cmd);

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("Update({0} currentObj, {0} expectedObj, string[] primaryKeyNames)", typeof(T).Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
        }

        public void UpdateDoub(T currentObj, T expectedObj, string[] primaryKeyNames, string[] primaryKeyNames2)
        {
            IFactory factory = DBHelper.CreateFactory();
            try
            {
                string query = GenerateQuery.CommandTextUpdate(currentObj, primaryKeyNames, primaryKeyNames2);
                DbCommand cmd = factory.MakeCommand(query);
                GenerateQuery.PrepareParametersUpdate(cmd, currentObj, expectedObj, primaryKeyNames, primaryKeyNames2);
                cmd.CommandTimeout = 10;
                factory.ExecuteNonQuery(cmd);

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("Update({0} currentObj, {0} expectedObj, string[] primaryKeyNames)", typeof(T).Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
        }

        public void UpdateWithTransaction(T currentObj, T expectedObj, string[] primaryKeyNames, IFactory factory)
        {
            string query = GenerateQuery.CommandTextUpdate(currentObj, primaryKeyNames);
            DbCommand cmd = factory.MakeCommand(query);
            GenerateQuery.PrepareParametersUpdate(cmd, currentObj, expectedObj, primaryKeyNames);
            factory.ExecuteNonQuery(cmd);
        }

        public T Load(T obj, string[] primaryKeyNames)
        {
            IList<T> sessions = new List<T>();
            IFactory factory = DBHelper.CreateFactory();
            DbCommand cmd = null;
            try
            {
                string query = GenerateQuery.CommandTextLoad(obj, primaryKeyNames);
                cmd = factory.MakeCommand(query);
                GenerateQuery.PrepareParametersLoad(cmd, obj, primaryKeyNames);
                IDataReader dre = factory.ExecuteReader(cmd);
                sessions = Results(dre);
                if (sessions.Count > 0)
                    return sessions[0];
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("Load({0} obj, string[] primaryKeyNames)", typeof(T).Name), ex.Message);
            }
            finally
            {
                cmd.Connection.Close();
                cmd.Connection.Dispose();
            }
            return default(T);
        }

        public T Load(T obj, string[] primaryKeyNames, IFactory factory)
        {
            IList<T> sessions = new List<T>();
            DbCommand cmd = null;
            try
            {
                string query = GenerateQuery.CommandTextLoad(obj, primaryKeyNames);
                cmd = factory.MakeCommand(query);
                GenerateQuery.PrepareParametersLoad(cmd, obj, primaryKeyNames);
                IDataReader dre = factory.ExecuteReader(cmd);
                sessions = Results(dre);
                if (sessions.Count > 0)
                    return sessions[0];
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("Load({0} obj, string[] primaryKeyNames)", typeof(T).Name), ex.Message);
            }
            return default(T);
        }

        public void Move(T obj, int inc)
        {
            IFactory factory = DBHelper.CreateFactory();
            string query = string.Empty;
            Type t = typeof(T);
            PropertyInfo property = t.GetProperty("Ordering");
            int order = Convert.ToInt32(property.GetValue(obj, null));
            property = t.GetProperty("Id");
            int id = Convert.ToInt32(property.GetValue(obj, null));

            if (inc < 0)
            {
                query = string.Format(@"Select top 1 id, ordering from {0}
                                        where ordering < {1} order by ordering desc ", t.Name.ToLower(), order);
            }
            else if (inc > 0)
            {
                query = string.Format(@"Select top 1 id, ordering from {0}
                                        where ordering > {1} order by ordering asc ", t.Name.ToLower(), order);
            }
            else
            {
                query = string.Format(@"Select top 1 id, ordering from {0}
                                        where ordering = {1} ", t.Name.ToLower(), order);
            }

            DbCommand cmd = factory.MakeCommand(query);
            IDataReader dre = factory.ExecuteReader(cmd);
            object objKey = null;
            object objOrdering = null;
            while (dre.Read())
            {
                objKey = dre.GetValue(0);
                objOrdering = dre.GetValue(1);
            }
            factory.Release();

            //factory.BeginTransaction();
            try
            {
                if (objKey != null)
                {
                    query = string.Format(@"UPDATE {0} SET ordering = {1} WHERE id = {2} ", t.Name.ToLower(), order, objKey);
                    cmd = factory.MakeCommand(query);
                    factory.ExecuteNonQuery(cmd);

                    query = string.Format(@"UPDATE {0} SET ordering = {1} WHERE id = {2} ", t.Name.ToLower(), objOrdering, id);
                    cmd = factory.MakeCommand(query);
                    factory.ExecuteNonQuery(cmd);
                    factory.Commit();
                }
            }
            catch (Exception ex)
            {
                factory.Rollback();
                Write2Log.WriteLogs("Generic<T>", string.Format("Move({0} obj, int inc)", typeof(T).Name), ex.Message);
            }

            finally
            {
                factory.Release();
            }
        }

        public void ChangeWithTransaction(string arrId, string state)
        {
            IFactory factory = DBHelper.CreateFactory();
            factory.BeginTransaction();
            try
            {
                string query = string.Format(@"UPDATE {0} SET published = {1}
                                              WHERE  Id in ({2})"
                                               , typeof(T).Name.ToLower(), state, arrId);
                DbCommand cmd = factory.MakeCommand(query);
                factory.ExecuteNonQuery(cmd);
                factory.Commit();
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("ChangeWithTransaction<{0}>", typeof(T).Name), ex.Message);
                factory.Rollback();
            }
            finally
            {
                factory.Release();
            }
        }

        public bool Delete(string arrId)
        {
            IFactory factory = DBHelper.CreateFactory();
            bool isDelete = false;
            try
            {
                string query = string.Format(@"DELETE FROM {0} WHERE  Id in ({1})", typeof(T).Name.ToLower(), arrId);
                DbCommand cmd = factory.MakeCommand(query);
                factory.ExecuteNonQuery(cmd);
                factory.Release();
                isDelete = true;
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("Delete<T>", typeof(T).Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
            return isDelete;
        }

        public IList<T> GetAllBy(T obj, string whereClause, DGCParameter[] parameters)
        {
            IList<T> sessions = new List<T>();
            IFactory factory = DBHelper.CreateFactory();
            try
            {
                string query = GenerateQuery.CommandTextList(obj, whereClause);
                DbCommand cmd = factory.MakeCommand(query);
                GenerateQuery.PrepareParametersList(cmd, parameters);
                IDataReader dre = factory.ExecuteReader(cmd);
                sessions = Results(dre);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("GetAllBy({0} obj, string whereClause, DGCParameter[] parameters)", typeof(T).Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
            return sessions;
        }

        public IList<T> GetAllBy(T obj, string selectClause, string whereClause, DGCParameter[] parameters)
        {
            IList<T> sessions = new List<T>();
            IFactory factory = DBHelper.CreateFactory();
            try
            {
                string query = selectClause + whereClause;
                DbCommand cmd = factory.MakeCommand(query);
                GenerateQuery.PrepareParametersList(cmd, parameters);
                IDataReader dre = factory.ExecuteReader(cmd);
                sessions = Results(dre);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("GetAllBy({0} obj, string whereClause, DGCParameter[] parameters)", typeof(T).Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
            return sessions;
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
                para.Value = "0";
                cmd.Parameters.Add(para);

                IDataReader dre = factory.ExecuteReader(cmd);
                lst = Results(dre);
                object strTemp = cmd.Parameters["@total"].Value;
                total = Convert.ToInt32(strTemp);

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("GetList(string storedProc, DGCParameter[] parameters, out {0} obj, out TDesc objDesc, out int total)", typeof(T).Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
            return lst;
        }

        public int getOrdering()
        {
            int result = 1;
            IFactory factory = DBHelper.CreateFactory();
            string query = string.Empty;
            try
            {
                switch (ConfigurationSettings.AppSettings["Database"])
                {
                    case "SQLServer":
                        query = string.Format("select TOP (1) ordering from {0} order by ordering desc", typeof(T).Name.ToLower());
                        break;
                    case "MySQL":
                        query = string.Format("select ordering from {0} order by ordering desc LIMIT 1 ", typeof(T).Name.ToLower());
                        break;

                }
                DbCommand cmd = factory.MakeCommand(query);
                IDataReader dre = factory.ExecuteReader(cmd);
                object obj = null;
                while (dre.Read())
                {
                    obj = dre.GetValue(0);
                }
                if (obj != null)
                {
                    result = (int)obj + 1;
                }
            }
            catch (Exception ex)
            {

                Write2Log.WriteLogs("Generic<T>", string.Format("getOrdering() of 'T'", typeof(T).Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
            return result;
        }


        #endregion

        #region Class Desc


        public T LoadByObjectAndLang(int objId, int langId)
        {
            IList<T> sessions = new List<T>();
            IFactory factory = DBHelper.CreateFactory();
            try
            {
                string query = string.Format(@"Select * from {0} where MainId = {1}MainId and LangId = {1}LangId", typeof(T).Name, PARAM_PREFIX);
                DbCommand cmd = factory.MakeCommand(query);
                DGCDataParameter.AddParameter(cmd, string.Format("{0}MainId", PARAM_PREFIX), DbType.Int32, objId);
                DGCDataParameter.AddParameter(cmd, string.Format("{0}LangId", PARAM_PREFIX), DbType.Int32, langId);
                IDataReader dre = factory.ExecuteReader(cmd);
                sessions = Results(dre);
                if (sessions.Count > 0)
                    return sessions[0];
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("{0} LoadByObjectAndLang(int objId, int langId)", typeof(T).Name), ex.Message);
            }
            finally
            {
                factory.Release();
            }
            return null;
        }

        public T LoadByObjectAndLang(int objId, int langId, IFactory factory)
        {
            IList<T> sessions = new List<T>();
            try
            {
                string query = string.Format(@"Select * from {0} where MainId = {1}MainId and LangId = {1}LangId", typeof(T).Name.ToLower(), PARAM_PREFIX);
                DbCommand cmd = factory.MakeCommand(query);
                DGCDataParameter.AddParameter(cmd, string.Format("{0}MainId", PARAM_PREFIX), DbType.Int32, objId);
                DGCDataParameter.AddParameter(cmd, string.Format("{0}LangId", PARAM_PREFIX), DbType.Int32, langId);
                IDataReader dre = factory.ExecuteReader(cmd);
                sessions = Results(dre);
                if (sessions.Count > 0)
                    return sessions[0];
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("{0} LoadByObjectAndLang(int objId, int langId)", typeof(T).Name), ex.Message);
            }
            return null;
        }

        public IList<T> ResultsDesc(IDataReader dre)
        {
            IList<T> lst = new List<T>();
            PropertyInfo[] properties;
            try
            {
                while (dre.Read())
                {
                    T obj = new T();
                    properties = obj.GetType().GetProperties(BindingFlags.SetProperty);

                    foreach (var property in properties)
                    {
                        //Truong hop la Id bang Main
                        if (property.Name.StartsWith("Main"))
                        {
                            property.SetValue(obj, DBConvert.ParseDBToInt(dre, "Id"), null);
                        }

                        //Turong hop l Id thi lay tu SubId
                        if (property.Name.StartsWith("id"))
                        {
                            property.SetValue(obj, DBConvert.ParseDBToInt(dre, "subId"), null);
                        }

                        else
                        {
                            property.SetValue(obj, DBConvert.ParseDBToObject(dre, property), null);
                        }
                    }
                    lst.Add(obj);
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
            return lst;
        }

        public T OneResultsDesc(IDataReader dre)
        {
            T obj = new T();
            PropertyInfo[] properties;
            try
            {

                properties = obj.GetType().GetProperties();

                foreach (var property in properties)
                {
                    //Truong hop la Id bang Main
                    if (property.Name.StartsWith("Main"))
                    {
                        property.SetValue(obj, DBConvert.ParseDBToInt(dre, "Id"), null);
                    }

                    //Turong hop l Id thi lay tu SubId
                    if (property.Name.StartsWith("id"))
                    {
                        property.SetValue(obj, DBConvert.ParseDBToInt(dre, "subId"), null);
                    }

                    else
                    {
                        property.SetValue(obj, DBConvert.ParseDBToObject(dre, property), null);
                    }
                }

            }

            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", string.Format("IList<{0}> Results(IDataReader dre)", typeof(T).Name), ex.Message);
            }
            return obj;
        }

        #endregion

        #region Util
        public void ExcuteNonQueryFromStore(string storedProc, DGCParameter[] parameters, IFactory factory)
        {
            DbCommand cmd = factory.MakeCommandFromStore(storedProc);
            GenerateQuery.PrepareParametersList(cmd, parameters);
            factory.ExecuteNonQuery(cmd);
        }

        #endregion


    }
}
