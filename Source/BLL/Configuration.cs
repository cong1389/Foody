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
using Cb.Utility;

namespace Cb.BLL
{
    [Serializable]
    public class ConfigurationBLL
    {
        private static IGeneric<PNK_Configuration> dal_2C;
        private string prefixParam;

        public ConfigurationBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<PNK_Configuration>);
            dal_2C = DataAccessGeneric<PNK_Configuration>.CreateSession(t.FullName);

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

        public IList<PNK_Configuration> GetList()
        {
            IList<PNK_Configuration> lst = new List<PNK_Configuration>();
            if (!CacheHelper.Get("Configuration_GetList_" + WebUtils.CurrentUserIP, out lst))
            {
                lst = dal_2C.GetAllBy(new PNK_Configuration(), null, null);
                CacheHelper.Add(lst, "Configuration_GetList_" + WebUtils.CurrentUserIP);
            }
            return lst;
        }

        /// <summary>
        /// SaveConfig
        /// </summary>
        public void SaveConfig(string email, string phone, string sitename, string fax, string skype, string yahoo, string companyName, string companyNameEng, string address, string address1
            , string logoHeader, string logoFooter, string location, string title, string metaDescription, string metaKeyword, string config_FBFanPage, string googleplus
            , string twitter, string h1, string h2, string h3, string analytic, string likepage, string vchat, string lantitude, string longitude, string footer
            , string linkedin, string pinterest, string reddit, string fbFooter)
        {
            Generic<PNK_Configuration> cf = new Generic<PNK_Configuration>();

            DGCParameter[] param = new DGCParameter[32];
            if (!string.IsNullOrEmpty(email))
                param[0] = new DGCParameter(string.Format("{0}config_email", prefixParam), DbType.String, email);
            else
                param[0] = new DGCParameter(string.Format("{0}config_email", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(phone))
                param[1] = new DGCParameter(string.Format("{0}config_phone", prefixParam), DbType.String, phone);
            else
                param[1] = new DGCParameter(string.Format("{0}config_phone", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(sitename))
                param[2] = new DGCParameter(string.Format("{0}config_sitename", prefixParam), DbType.String, sitename);
            else
                param[2] = new DGCParameter(string.Format("{0}config_sitename", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(fax))
                param[3] = new DGCParameter(string.Format("{0}config_fax", prefixParam), DbType.String, fax);
            else
                param[3] = new DGCParameter(string.Format("{0}config_fax", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(skype))
                param[4] = new DGCParameter(string.Format("{0}config_skypeid", prefixParam), DbType.String, skype);
            else
                param[4] = new DGCParameter(string.Format("{0}config_skypeid", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(yahoo))
                param[5] = new DGCParameter(string.Format("{0}config_yahooid", prefixParam), DbType.String, yahoo);
            else
                param[5] = new DGCParameter(string.Format("{0}config_yahooid", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(companyName))
                param[6] = new DGCParameter(string.Format("{0}config_company_name_vi", prefixParam), DbType.String, companyName);
            else
                param[6] = new DGCParameter(string.Format("{0}config_company_name_vi", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(address))
                param[7] = new DGCParameter(string.Format("{0}config_address_vi", prefixParam), DbType.String, address);
            else
                param[7] = new DGCParameter(string.Format("{0}config_address_vi", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(address1))
                param[8] = new DGCParameter(string.Format("{0}config_address1_vi", prefixParam), DbType.String, address1);
            else
                param[8] = new DGCParameter(string.Format("{0}config_address1_vi", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(logoFooter))
                param[9] = new DGCParameter(string.Format("{0}config_logoFooter", prefixParam), DbType.String, logoFooter);
            else
                param[9] = new DGCParameter(string.Format("{0}config_logoFooter", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(location))
                param[10] = new DGCParameter(string.Format("{0}config_location", prefixParam), DbType.String, location);
            else
                param[10] = new DGCParameter(string.Format("{0}config_location", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(logoHeader))
                param[11] = new DGCParameter(string.Format("{0}config_logoHeader", prefixParam), DbType.String, logoHeader);
            else
                param[11] = new DGCParameter(string.Format("{0}config_logoHeader", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(title))
                param[12] = new DGCParameter(string.Format("{0}title", prefixParam), DbType.String, title);
            else
                param[12] = new DGCParameter(string.Format("{0}title", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(metaDescription))
                param[13] = new DGCParameter(string.Format("{0}metaDescription", prefixParam), DbType.String, metaDescription);
            else
                param[13] = new DGCParameter(string.Format("{0}metaDescription", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(metaKeyword))
                param[14] = new DGCParameter(string.Format("{0}metaKeyword", prefixParam), DbType.String, metaKeyword);
            else
                param[14] = new DGCParameter(string.Format("{0}metaKeyword", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(config_FBFanPage))
                param[15] = new DGCParameter(string.Format("{0}config_FBFanPage", prefixParam), DbType.String, config_FBFanPage);
            else
                param[15] = new DGCParameter(string.Format("{0}config_FBFanPage", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(googleplus))
                param[16] = new DGCParameter(string.Format("{0}googleplus", prefixParam), DbType.String, googleplus);
            else
                param[16] = new DGCParameter(string.Format("{0}googleplus", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(twitter))
                param[17] = new DGCParameter(string.Format("{0}twitter", prefixParam), DbType.String, twitter);
            else
                param[17] = new DGCParameter(string.Format("{0}twitter", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(h1))
                param[18] = new DGCParameter(string.Format("{0}config_h1", prefixParam), DbType.String, h1);
            else
                param[18] = new DGCParameter(string.Format("{0}config_h1", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(h2))
                param[19] = new DGCParameter(string.Format("{0}config_h2", prefixParam), DbType.String, h2);
            else
                param[19] = new DGCParameter(string.Format("{0}config_h2", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(h3))
                param[20] = new DGCParameter(string.Format("{0}config_h3", prefixParam), DbType.String, h3);
            else
                param[20] = new DGCParameter(string.Format("{0}config_h3", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(analytic))
                param[21] = new DGCParameter(string.Format("{0}config_analytic", prefixParam), DbType.String, analytic);
            else
                param[21] = new DGCParameter(string.Format("{0}config_analytic", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(likepage))
                param[22] = new DGCParameter(string.Format("{0}config_FBLike", prefixParam), DbType.String, likepage);
            else
                param[22] = new DGCParameter(string.Format("{0}config_FBLike", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(vchat))
                param[23] = new DGCParameter(string.Format("{0}vchat", prefixParam), DbType.String, vchat);
            else
                param[23] = new DGCParameter(string.Format("{0}vchat", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(lantitude))
                param[24] = new DGCParameter(string.Format("{0}config_latitude", prefixParam), DbType.String, lantitude);
            else
                param[24] = new DGCParameter(string.Format("{0}config_latitude", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(longitude))
                param[25] = new DGCParameter(string.Format("{0}config_longitude", prefixParam), DbType.String, longitude);
            else
                param[25] = new DGCParameter(string.Format("{0}config_longitude", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(footer))
                param[26] = new DGCParameter(string.Format("{0}config_footer", prefixParam), DbType.String, footer);
            else
                param[26] = new DGCParameter(string.Format("{0}config_footer", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(companyNameEng))
                param[27] = new DGCParameter(string.Format("{0}config_company_name_en", prefixParam), DbType.String, companyNameEng);
            else
                param[27] = new DGCParameter(string.Format("{0}config_company_name_en", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(linkedin))
                param[28] = new DGCParameter(string.Format("{0}config_linkedin", prefixParam), DbType.String, linkedin);
            else
                param[28] = new DGCParameter(string.Format("{0}config_linkedin", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(pinterest))
                param[29] = new DGCParameter(string.Format("{0}config_pinterest", prefixParam), DbType.String, pinterest);
            else
                param[29] = new DGCParameter(string.Format("{0}config_pinterest", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(reddit))
                param[30] = new DGCParameter(string.Format("{0}config_reddit", prefixParam), DbType.String, reddit);
            else
                param[30] = new DGCParameter(string.Format("{0}config_reddit", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(fbFooter))
                param[31] = new DGCParameter(string.Format("{0}config_fbfanpageLarge", prefixParam), DbType.String, fbFooter);
            else
                param[31] = new DGCParameter(string.Format("{0}config_fbfanpageLarge", prefixParam), DbType.String, DBNull.Value);

            //arrli

            //if (!CacheHelper.Get("Configuration_Update" + WebUtils.CurrentUserIP + langId + name + id + parentId + isTree + field + pageIndex + pageSize, out lst))
            //{
            cf.ExcuteNonQueryFromStore("Configuration_Update", param);
            //    CacheHelper.Add(lst, "Configuration_Update" + WebUtils.CurrentUserIP + langId + name + id + parentId + isTree + field + pageIndex + pageSize);
            //}
        }
    }
}
