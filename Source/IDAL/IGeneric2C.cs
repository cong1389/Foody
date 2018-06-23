using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.DBUtility;
using System.Data;

namespace Cb.IDAL
{
    public interface IGeneric2C<T, TDesc>
        where T : class,new()
        where TDesc : class
    {
        IList<T> Results(IDataReader dre);

        int Insert(T obj, List<TDesc> lst);

        int InsertWithTransaction(T obj, List<TDesc> lst, IFactory factory);

        void Update(T obj, List<TDesc> lst, string[] primaryKeyNames);

        void UpdateWithTransaction(T obj, List<TDesc> lst, string[] primaryKeyNames, IFactory factory);

        IList<T> GetList(string storedProc, DGCParameter[] parameters, out int total);
        IList<T> GetListT(string storedProc, DGCParameter[] parameters);
        bool Delete(string arrId);

        T Load(T obj, string[] primaryKeyNames, int langId);
    }
}
