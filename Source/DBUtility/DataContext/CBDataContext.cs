using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Data.Linq;
using System.Data.Linq.Mapping;

namespace Cb.DBUtility.DataContext
{
    [Database(Name = "buildSite_db")]
    public class CbDataContext : System.Data.Linq.DataContext 
    {
        public CbDataContext()
            : base(ConfigurationManager.ConnectionStrings["SQLConnString1"].ConnectionString)
        {

        }

       
    }
}
