using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Configuration;

namespace Cb.DALFactory
{
    public sealed class DataAccessGeneric2C<T, TDesc>
        where T : class ,new()
        where TDesc : class
    {
        private static readonly string path = ConfigurationManager.AppSettings["WebDAL"];
        private static readonly string orderPath = ConfigurationManager.AppSettings["OrdersDAL"];

        public static Cb.IDAL.IGeneric2C<T, TDesc> CreateSession(string typeName)
        {


            return (Cb.IDAL.IGeneric2C<T, TDesc>)Assembly.Load(path).CreateInstance(typeName);
        }
    }
}
