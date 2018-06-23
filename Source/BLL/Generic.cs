using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.IDAL;
using Cb.DALFactory;
using Cb.DBUtility;

namespace Cb.BLL
{
    [Serializable]
    public class Generic<T> where T : class,new()
    {
        private static IGeneric<T> dal;

        public Generic()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<T>);
            dal = DataAccessGeneric<T>.CreateSession(t.FullName);
        }

        #region IGeneric<T> Members

        public IList<T> GetAll()
        {
            return dal.GetAll();
        }


        public T Load(T obj, string[] primaryKeyNames)
        {
            return dal.Load(obj, primaryKeyNames);
        }

        public void ChangeWithTransaction(string arrId, string state)
        {
            dal.ChangeWithTransaction(arrId, state);
        }

        public IList<T> GetAllBy(T obj, string whereClause, DGCParameter[] parameters)
        {
            return dal.GetAllBy(obj, whereClause, parameters);
        }

        public IList<T> GetAllBy(T obj, string selectClause, string whereClause, DGCParameter[] parameters)
        {
            return dal.GetAllBy(obj, selectClause, whereClause, parameters);
        }
       
        public int Insert(T obj)
        {
            return dal.Insert(obj);
        }

        public int InsertIDENTITY(T obj)
        {
            return dal.InsertIDENTITY(obj);
        }

        public int InsertWithTransaction(T obj, IFactory factory)
        {
            return dal.InsertWithTransaction(obj, factory);
        }

        public int InsertIDENTITYWithTransaction(T obj, IFactory factory)
        {
            return dal.InsertIDENTITYWithTransaction(obj, factory);
        }

        public int InsertIDENTITYWithTransactionWithMaxField(T obj, IFactory factory, string fieldMax)
        {
            return dal.InsertIDENTITYWithTransactionWithMaxField(obj, factory, fieldMax);
        }

        public void Update(T currentObj, T expectedObj, string[] primaryKeyNames)
        {
            dal.Update(currentObj, expectedObj, primaryKeyNames);
        }

        public void UpdateWithTransaction(T currentObj, T expectedObj, string[] primaryKeyNames, IFactory factory)
        {
            dal.UpdateWithTransaction(currentObj, expectedObj, primaryKeyNames, factory);
        }

        public bool Delete(string arrId)
        {
            return dal.Delete(arrId);
        }

        //public bool Delete(string arrId, string keyName)
        //{
        //    return dal.Delete(arrId, keyName);
        //}

        public int getOrdering()
        {
            return dal.getOrdering();
        }

        public void Move(T obj, int inc)
        {
            dal.Move(obj, inc);
        }

        public void ExcuteNonQueryFromStore(string storename, DGCParameter[] parameters)
        {
            IFactory factory = DBHelper.CreateFactory();
            dal.ExcuteNonQueryFromStore(storename, parameters, factory);
        }

        #endregion
    }
}
