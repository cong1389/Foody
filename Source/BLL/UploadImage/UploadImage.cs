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
    public class UploadImageBLL
    {
        private static IGeneric<PNK_UploadImage> dal;
        private string prefixParam;
        public UploadImageBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<PNK_UploadImage>);
            dal = DataAccessGeneric<PNK_UploadImage>.CreateSession(t.FullName);

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

        public IList<PNK_UploadImage> GetList(string id, string productid, string publish, int pageIndex, int pageSize, out int total)
        {
            return GetList(id, productid, publish, int.MinValue, pageIndex, pageSize, out total);
        }

        public IList<PNK_UploadImage> GetList(string id, string productid, string publish, int type, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_UploadImage> lst = new List<PNK_UploadImage>();
            DGCParameter[] param = new DGCParameter[6];
            total = 0;
            if (!string.IsNullOrEmpty(id))
                param[0] = new DGCParameter(string.Format("{0}id", prefixParam), DbType.String, id);
            else
                param[0] = new DGCParameter(string.Format("{0}id", prefixParam), DbType.String, DBNull.Value);

            if (pageIndex != int.MinValue)
                param[1] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, pageIndex);
            else
                param[1] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, DBNull.Value);

            if (pageSize != int.MinValue)
                param[2] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, pageSize);
            else
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, DBNull.Value);

            if (!string.IsNullOrEmpty(publish))
                param[3] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, publish);
            else
                param[3] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(productid))
                param[4] = new DGCParameter(string.Format("{0}productid", prefixParam), DbType.String, productid);
            else
                param[4] = new DGCParameter(string.Format("{0}productid", prefixParam), DbType.String, DBNull.Value);

            if (type != int.MinValue)
                param[5] = new DGCParameter(string.Format("{0}type", prefixParam), DbType.Int32, type);
            else
                param[5] = new DGCParameter(string.Format("{0}type", prefixParam), DbType.Int32, DBNull.Value);

            lst = dal.GetList("UploadImage_Get", param, out total);
            return lst;
        }

        //public int Insert(string action, string imageName, string createdBy, out int total)
        //{
        //    DGCParameter[] param = new DGCParameter[3];
        //    total = 0;
        //    if (!string.IsNullOrEmpty(action))
        //        param[0] = new DGCParameter(string.Format("{0}action", prefixParam), DbType.String, action);
        //    else
        //        param[0] = new DGCParameter(string.Format("{0}action", prefixParam), DbType.String, DBNull.Value);

        //    if (!string.IsNullOrEmpty(imageName))
        //        param[1] = new DGCParameter(string.Format("{0}imageName", prefixParam), DbType.String, imageName);
        //    else
        //        param[1] = new DGCParameter(string.Format("{0}imageName", prefixParam), DbType.String, DBNull.Value);

        //    //param[2] = new DGCParameter(string.Format("{0}image", prefixParam), DbType.Byte, image);

        //    if (!string.IsNullOrEmpty(createdBy))
        //        param[2] = new DGCParameter(string.Format("{0}createdBy", prefixParam), DbType.String, createdBy);
        //    else
        //        param[2] = new DGCParameter(string.Format("{0}createdBy", prefixParam), DbType.String, DBNull.Value);

        //    dal.GetList("sp_ImageUpload", param, out total);
        //    return total;
        //}
    }
}
