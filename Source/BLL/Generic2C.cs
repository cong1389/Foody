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
    public class Generic2C<T, TDesc>
        where T : class,new()
        where TDesc : class,new()
    {
        private static IGeneric2C<T, TDesc> dalDesc;

        public Generic2C()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic2C<T, TDesc>);
            dalDesc = DataAccessGeneric2C<T, TDesc>.CreateSession(t.FullName);
        }

        public T Load(T obj, string[] primaryKeyNames, int langId)
        {
            return dalDesc.Load(obj, primaryKeyNames, langId);
        }

        public T LoadById(T obj, int id, int langId)
        {
            string[] primaryKeyNames = new string[] { DBConvert.ParseString(id) };
            return dalDesc.Load(obj, primaryKeyNames, langId);
        }

        public int Insert(T obj, List<TDesc> lst)
        {
            return dalDesc.Insert(obj, lst);
        }

        public void Update(T obj, List<TDesc> lst, string[] primaryKeyNames)
        {
            dalDesc.Update(obj, lst, primaryKeyNames);
        }

        public void UpdatebyId(T obj, List<TDesc> lst, int id)
        {
            string[] primaryKeyNames = new string[] { DBConvert.ParseString(id) };
            dalDesc.Update(obj, lst, primaryKeyNames);
        }

        public bool Delete(string arrId)
        {
            return dalDesc.Delete(arrId);
        }
    }
}
