/**
 * @version $Id:
 * @package Digicom.NET
 * @author Digicom Dev <dev@dgc.vn>
 * @copyright Copyright (C) 2009 by Digicom. All rights reserved.
 * @link http://www.dgc.vn
 */
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Dgc.DALFactory
{
    public static class DBController {
        private static Dictionary<string, bool> startedSqlDependency = new Dictionary<string, bool>(StringComparer.OrdinalIgnoreCase);

        public static SqlFactory GetFactory()
        {
            return new SqlFactory();
        }

        public static Database CreateDatabase() {
            return CreateDatabase(SiteNavigation.GetHost());
        }
        
        public static Database CreateDatabase(string connectionStringName) {
            return ConfigurationController.SiteConfigurationController.CreateDatabase(connectionStringName);
        }

        public static SqlCacheDependency GetSqlCacheDependency(SqlCommand cmd) {
            return GetSqlCacheDependency(SiteNavigation.GetHost(), cmd);
        }

        public static SqlCacheDependency GetSqlCacheDependency(string host, SqlCommand cmd) {
            string connectionString = ConfigurationController.SiteConfigurationController.GetSiteConnectionString(host);
            if (!startedSqlDependency.ContainsKey(connectionString)) {
                SqlDependency.Start(connectionString);
                lock (startedSqlDependency) { //Use the late lock to improve performance
                    if (!startedSqlDependency.ContainsKey(connectionString))
                        startedSqlDependency.Add(connectionString, true);
                }
            }
            return new SqlCacheDependency(cmd);
        }
    }
}
