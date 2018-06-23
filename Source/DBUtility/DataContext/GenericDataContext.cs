using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq;
using System.Configuration;

namespace Cb.DBUtility.DataContext
{
    public class GenericDataContext<TEntity> where TEntity : class
    {
        protected System.Data.Linq.DataContext dataContext = new System.Data.Linq.DataContext(ConfigurationManager.ConnectionStrings["SQLConnString1"].ConnectionString);

        public Table<TEntity> Entities
        {
            get { return dataContext.GetTable<TEntity>(); }
        }
    }
}
