using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Reflection;

namespace Cb.DALFactory
{
    public sealed class DataAccessGeneric<T> where T : class,new()
    {
        private static readonly string path = ConfigurationManager.AppSettings["WebDAL"];
        private static readonly string orderPath = ConfigurationManager.AppSettings["OrdersDAL"];

        public static Cb.IDAL.IGeneric<T> CreateSession(string typeName)
        {
            return (Cb.IDAL.IGeneric<T>)Assembly.Load(path).CreateInstance(typeName);
            
        }
    }
}
