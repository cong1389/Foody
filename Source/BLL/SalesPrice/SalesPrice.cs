using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.IDAL;
using Cb.DALFactory;
using Cb.Model;
using Cb.DBUtility;
using System.Data;
using System.Configuration;

namespace Cb.BLL
{
    [Serializable]
    public class SalesPriceBLL
    {
        private static IGeneric<PNK_SalesPrice> dal;

        private string prefixParam;

        public SalesPriceBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<PNK_SalesPrice>);
            dal = DataAccessGeneric<PNK_SalesPrice>.CreateSession(t.FullName);

            switch (ConfigurationManager.AppSettings["Database"])
            {
                case "SQLServer":
                    prefixParam = "@";
                    break;
                case "MySQL":
                    prefixParam = "v_";
                    break;
            }
        }

        public IList<PNK_SalesPrice> GetList(string productId, string storeGroup,DateTime fromDate,DateTime toDate, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_SalesPrice> lst = new List<PNK_SalesPrice>();
            DGCParameter[] param = new DGCParameter[6];

            if (!string.IsNullOrEmpty(productId))
                param[0] = new DGCParameter(string.Format("{0}productId", prefixParam), DbType.String, productId);
            else
                param[0] = new DGCParameter(string.Format("{0}productId", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(storeGroup))
                param[1] = new DGCParameter(string.Format("{0}storeGroup", prefixParam), DbType.String, storeGroup);
            else
                param[1] = new DGCParameter(string.Format("{0}storeGroup", prefixParam), DbType.String, DBNull.Value);

            if (pageIndex != int.MinValue)
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, pageIndex);
            else
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, DBNull.Value);

            if (pageSize != int.MinValue)
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, pageSize);
            else
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, DBNull.Value);

            if (fromDate != DateTime.MinValue)
                param[4] = new DGCParameter(string.Format("{0}fromDate", prefixParam), DbType.DateTime, fromDate);
            else
                param[4] = new DGCParameter(string.Format("{0}fromDate", prefixParam), DbType.DateTime, DBNull.Value);

            if (toDate != DateTime.MinValue)
                param[5] = new DGCParameter(string.Format("{0}toDate", prefixParam), DbType.DateTime, toDate);
            else
                param[5] = new DGCParameter(string.Format("{0}toDate", prefixParam), DbType.DateTime, DBNull.Value);

            lst = dal.GetList("SalePrice_Get", param, out total);
            return lst;
        }
    }
}
