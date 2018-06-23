using System.Reflection;
using System.Configuration;

namespace Cb.DALFactory {

    /// <summary>
    /// This class is implemented following the Abstract Factory pattern to create the DAL implementation
    /// specified from the configuration file
    /// </summary>
    public sealed class DataAccess {

        // Look up the DAL implementation we should be using
        private static readonly string path = ConfigurationManager.AppSettings["WebDAL"];
        private static readonly string orderPath = ConfigurationManager.AppSettings["OrdersDAL"];
        
        private DataAccess() { }

       
    }
}
