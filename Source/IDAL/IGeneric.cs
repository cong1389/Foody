using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.DBUtility;
using System.Data;

namespace Cb.IDAL
{
    public interface IGeneric<T> where T : class,new()
    {

        IList<T> GetAll();

        int Insert(T obj);

        int InsertIDENTITY(T obj);

        int InsertWithTransaction(T obj, IFactory factory);

        int InsertIDENTITYWithTransaction(T obj, IFactory factory);

        /// <summary>
        /// For Max val filed By Identity
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="factory"></param>
        /// <param name="fieldMax"></param>
        /// <returns></returns>
        int InsertIDENTITYWithTransactionWithMaxField(T obj, IFactory factory, string fieldMax);

        IList<T> Results(IDataReader dre);

        /// <summary>
        /// dung de Load bang ngon ngu
        /// </summary>
        /// <param name="dre"></param>
        /// <returns></returns>
        IList<T> ResultsDesc(IDataReader dre);

        /// <summary>
        /// Dung để load 1 bang ngon ngu(truong hop GetList) </summary>
        /// <param name="dre"></param> <returns></returns>
        T OneResultsDesc(IDataReader dre);

        void Update(T currentObj, T expectedObj, string[] primaryKeyNames);
        void UpdateDoub(T currentObj, T expectedObj, string[] primaryKeyNames, string[] primaryKeyNames2);
        void UpdateWithTransaction(T currentObj, T expectedObj, string[] primaryKeyNames, IFactory factory);

        T Load(T obj, string[] primaryKeyNames);

        T Load(T obj, string[] primaryKeyNames, IFactory factory);

        void ChangeWithTransaction(string arrId, string state);

        bool Delete(string arrId);

        //bool Delete(string arrId, string keyName);

        int getOrdering();

        IList<T> GetAllBy(T obj, string whereClause, DGCParameter[] parameters);

        IList<T> GetAllBy(T obj, string selectClause, string whereClause, DGCParameter[] parameters);

        IList<T> GetList(string storedProc, DGCParameter[] parameters, out int total);

        void ExcuteNonQueryFromStore(string storedProc, DGCParameter[] parameters, IFactory factory);

        void Move(T obj, int inc);

        T LoadByObjectAndLang(int objId, int langId);

        T LoadByObjectAndLang(int objId, int langId, IFactory factory);
    }
}
