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
using Cb.Model.ContentStatic;

namespace Cb.BLL
{
    [Serializable]
    public class ContentStaticBLL
    {
        private static IGeneric2C<PNK_ContentStatic, PNK_ContentStaticDesc> dal_2C;

        private string prefixParam;

        public ContentStaticBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic2C<PNK_ContentStatic, PNK_ContentStaticDesc>);
            dal_2C = DataAccessGeneric2C<PNK_ContentStatic, PNK_ContentStaticDesc>.CreateSession(t.FullName);

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

        public IList<PNK_ContentStatic> GetList(int langId, string name, string Id, string newsCateId, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_ContentStatic> lst = new List<PNK_ContentStatic>();
            DGCParameter[] param = new DGCParameter[6];

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

            if (!string.IsNullOrEmpty(newsCateId))
                param[4] = new DGCParameter(string.Format("{0}cateId", prefixParam), DbType.String, newsCateId);
            else
                param[4] = new DGCParameter(string.Format("{0}cateId", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(Id))
                param[5] = new DGCParameter(string.Format("{0}Id", prefixParam), DbType.String, Id);
            else
                param[5] = new DGCParameter(string.Format("{0}Id", prefixParam), DbType.String, DBNull.Value);

            lst = dal_2C.GetList("ContentStatic_Get", param, out total);
            return lst;
        }
    }
}
