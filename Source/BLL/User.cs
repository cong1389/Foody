using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.IDAL;
using Cb.Model;
using Cb.DALFactory;
using Cb.DBUtility;
using System.Data;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Data.Common;
using Cb.Utility;
using Cb.Localization;
//using Cb.Localization;

namespace Cb.BLL
{
    [Serializable]
    public class UserBLL
    {
        private static IGeneric<PNK_User> dal_2C;
        private string prefixParam;
        public UserBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<PNK_User>);
            dal_2C = DataAccessGeneric<PNK_User>.CreateSession(t.FullName);

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

        public IList<PNK_User> GetList(string username, string isnewsletter, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_User> lst = new List<PNK_User>();
            DGCParameter[] param = new DGCParameter[4];
            if (!string.IsNullOrEmpty(username))
                param[0] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, username);
            else
                param[0] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(isnewsletter))
                param[1] = new DGCParameter(string.Format("{0}isnewsletter", prefixParam), DbType.String, isnewsletter);
            else
                param[1] = new DGCParameter(string.Format("{0}isnewsletter", prefixParam), DbType.String, DBNull.Value);

            if (pageIndex != int.MinValue)
                param[2] = new DGCParameter("pageIndex", DbType.Int16, pageIndex);
            else
                param[2] = new DGCParameter("pageIndex", DbType.Int16, DBNull.Value);

            if (pageSize != int.MinValue)
                param[3] = new DGCParameter("pageSize", DbType.Int16, pageSize);
            else
                param[3] = new DGCParameter("pageSize", DbType.Int16, DBNull.Value);

            lst = dal_2C.GetList("User_Get", param, out total);
            return lst;
        }
        public static string GetRoleName(int roleId)
        {
            switch (roleId)
            {
                case (int)enuRoleUser.admin:
                    return LocalizationUtility.GetText(string.Format("{0}_{1}", typeof(enuRoleUser).Name, enuRoleUser.admin));
                case (int)enuRoleUser.mod:
                    return LocalizationUtility.GetText(string.Format("{0}_{1}", typeof(enuRoleUser).Name, enuRoleUser.mod));
                case (int)enuRoleUser.user:
                    return LocalizationUtility.GetText(string.Format("{0}_{1}", typeof(enuRoleUser).Name, enuRoleUser.user));
                case (int)enuRoleUser.All_none:
                    return LocalizationUtility.GetText(string.Format("{0}_{1}", typeof(enuRoleUser).Name, enuRoleUser.All_none));
                default:
                    return string.Empty;
            }
        }
        public static void BindRoleName(DropDownList _drp)
        {
            _drp.Items.Clear();
            Type t = typeof(enuRoleUser);
            foreach (var item in Enum.GetNames(t))
            {
                if ((int)Enum.Parse(typeof(enuRoleUser), item) != int.MinValue)
                    _drp.Items.Add(new ListItem(LocalizationUtility.GetText(t.Name + "_" + item), (int)Enum.Parse(typeof(enuRoleUser), item) + ""));
            }
        }
        public static bool CheckValidUsername(string username)
        {
            IFactory factory = DBHelper.CreateFactory();
            bool re = false;
            try
            {
                string prefix = string.Empty;
                switch (ConfigurationManager.AppSettings["Database"])
                {
                    case "SQLServer":
                        prefix = "@";
                        break;
                    case "MySQL":
                        prefix = "v_";
                        break;
                }

                DbCommand cmd = factory.MakeCommandFromStore("CheckValidUSer");
                IDbDataParameter para = cmd.CreateParameter();
                para.ParameterName = string.Format("{0}Username", prefix);
                para.DbType = DbType.String;
                para.Value = username;
                cmd.Parameters.Add(para);

                para = cmd.CreateParameter();
                para.ParameterName = "@total";
                para.DbType = DbType.Int32;
                para.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(para);

                cmd.ExecuteNonQuery();
                int strTemp = DBConvert.ParseInt(cmd.Parameters["@total"].Value.ToString());
                if (strTemp == 1)
                    re = false;
                else if (strTemp == 0)
                    re = true;
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("UserBLL", "CheckValidUsername", ex.ToString());

            }
            finally
            {
                factory.Release();
            }

            return re;


        }
    }
}
