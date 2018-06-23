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
using Cb.Model.ProductGroup;

namespace Cb.BLL
{
    [Serializable]
    public class ProductGroupBLL
    {
        private static IGeneric2C<PNK_ProductGroup, PNK_ProductGroupDesc> dal_2C;

        private string prefixParam;

        public ProductGroupBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic2C<PNK_ProductGroup, PNK_ProductGroupDesc>);
            dal_2C = DataAccessGeneric2C<PNK_ProductGroup, PNK_ProductGroupDesc>.CreateSession(t.FullName);

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

        public IList<PNK_ProductGroup> GetList(int langId, string name, string Id, string divisionId, string productTypeId, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_ProductGroup> lst = new List<PNK_ProductGroup>();
            DGCParameter[] param = new DGCParameter[7];

            if (langId != int.MinValue)
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int16, langId);
            else
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int16, DBNull.Value);

            if (!string.IsNullOrEmpty(name))
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, name);
            else
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, DBNull.Value);

            if (pageIndex != int.MinValue)
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, pageIndex);
            else
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, DBNull.Value);

            if (pageSize != int.MinValue)
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, pageSize);
            else
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, DBNull.Value);

            if (!string.IsNullOrEmpty(divisionId))
                param[4] = new DGCParameter(string.Format("{0}divisionId", prefixParam), DbType.String, divisionId);
            else
                param[4] = new DGCParameter(string.Format("{0}divisionId", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(Id))
                param[5] = new DGCParameter(string.Format("{0}Id", prefixParam), DbType.String, Id);
            else
                param[5] = new DGCParameter(string.Format("{0}Id", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(productTypeId))
                param[6] = new DGCParameter(string.Format("{0}productTypeId", prefixParam), DbType.String, productTypeId);
            else
                param[6] = new DGCParameter(string.Format("{0}productTypeId", prefixParam), DbType.String, DBNull.Value);

            lst = dal_2C.GetList("ProductGroup_Get", param, out total);
            return lst;
        }
    }
}
