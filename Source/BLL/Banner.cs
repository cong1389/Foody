using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.IDAL;
using Cb.Model;
using Cb.DALFactory;
using Cb.DBUtility;
using System.Data;
using System.Data.Common;
using System.Web.UI.WebControls;
using System.Configuration;
using Cb.Model;

namespace Cb.BLL
{
    [Serializable]
    public class BannerBLL
    {
        private static IGeneric<PNK_Banner> dal;
        private string prefixParam;
        public BannerBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<PNK_Banner>);
            dal = DataAccessGeneric<PNK_Banner>.CreateSession(t.FullName);

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

        public IList<PNK_Banner> GetList(int position, string name, string publish, int pageIndex, int pageSize, out int total)
        {
            return GetList(position, name, publish, string.Empty, pageIndex, pageSize, out  total);
        }

        public IList<PNK_Banner> GetList(int position, string name, string publish, string pageName, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_Banner> lst = new List<PNK_Banner>();
            DGCParameter[] param = new DGCParameter[6];
            total = 0;
            if (position != int.MinValue)
                param[0] = new DGCParameter(string.Format("{0}position", prefixParam), DbType.Int32, position);
            else
                param[0] = new DGCParameter(string.Format("{0}position", prefixParam), DbType.Int32, DBNull.Value);

            if (!string.IsNullOrEmpty(name))
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, name);
            else
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, DBNull.Value);

            if (pageIndex != int.MinValue)
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int16, pageIndex);
            else
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int16, DBNull.Value);

            if (pageSize != int.MinValue)
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int16, pageSize);
            else
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int16, DBNull.Value);

            if (!string.IsNullOrEmpty(publish))
                param[4] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, publish);
            else
                param[4] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(pageName))
                param[5] = new DGCParameter(string.Format("{0}pageName", prefixParam), DbType.AnsiString, pageName);
            else
                param[5] = new DGCParameter(string.Format("{0}pageName", prefixParam), DbType.AnsiString, DBNull.Value);

            //ConfigSection cfs = new ConfigSection();
            //string key = WebUtils.GetCacheKey(new string[] { position + name + publish + pageIndex + pageSize, "PNK_Configuration" });
            //if (cfs.EnableCaching && WebUtils.Cache[key] != null)
            //{
            //    lst = (List<PNK_Banner>)WebUtils.Cache[key];
            //}
            //else
            //{
            lst = dal.GetList("Banner_Get", param, out total);
            //WebUtils.CacheData(key, lst);
            //}
            return lst;
        }
    }
}
