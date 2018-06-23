using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cb.Utility
{
    /// <summary>
    /// Class generate url 
    /// </summary>

    public static class LinkHelper
    {
        public static string GetLink(string pageName)
        {
            string re = string.Format("/{0}", pageName);
            return re;
        }

        public static string GetLink(string pageName, string langId)
        {
            string re = string.Format("/{0}/{1}", pageName, langId);
            return re;
        }

        public static string GetLink(string pageName, string langId, object catId)
        {
            string re = string.Format("/{0}/{1}/{2}", pageName, langId, catId);
            return re;
        }

        public static string GetLink(string pageName, string langId, int catId, int id)
        {
            string cat_temp = catId == int.MinValue ? "cid" : catId.ToString();
            string re = string.Format("/{0}/{1}/{2}/{3}", pageName, langId, cat_temp, id);
            return re;
        }

        public static string GetLink(string pageName, string langId, int catId, int id, string msg)
        {
            string cat_temp = catId == int.MinValue ? "cid" : catId.ToString();
            string re = string.Format("/{0}/{1}/{2}/{3}/{4}", pageName, langId, cat_temp, id, msg);
            return re;
        }

        public static string GetLink(string pageName, string langId, string viewtype, object catId)
        {
            string re = string.Format("/{0}/{1}/{2}/{3}", pageName, langId, viewtype, catId);
            return re;
        }

        public static string GetLink(string pageName, string langId, string viewtype, int catId, int id)
        {
            string cat_temp = catId == int.MinValue ? "cid" : catId.ToString();
            string re = string.Format("/{0}/{1}/{2}/{3}/{4}", pageName, langId, viewtype, cat_temp, id);
            return re;
        }

        public static string GetLink(string pageName, string langId, string viewtype, string catName, string idName)
        {
            string cat_temp = catName == string.Empty ? "cid" : catName.ToString();
            string re = string.Format("/{0}/{1}/{2}/{3}/{4}", pageName, langId, viewtype, cat_temp, idName);
            return re;
        }

        public static string GetAdminLink(string page)
        {
            string re = string.Format("/adm/{0}", page);
            return re;
        }

        public static string GetAdminLink(string page, object id)
        {
            string re = string.Format("/adm/{0}/{1}", page, id);
            return re;
        }

        public static string GetAdminLink(string page, string cid, string id)
        {
            string re = string.Format("/adm/{0}/{1}/{2}", page, cid, id);
            return re;
        }

        public static string GetAdminMsgLink(string page, string msg)
        {
            string re = string.Format("/admmsg/{0}/{1}", page, msg);
            return re;
        }

        public static string GetAdminMsgLink(string page, string cid, string msg)
        {
            string re = string.Format("/admmsg/{0}/{1}/{2}", page, cid, msg);
            return re;
        }

        public static string GetAdminModuleLink(string page, string module)
        {
            string re = string.Format("/adm/{0}/{1}", page, module);
            return re;
        }

        public static string GetAdminModuleLink(string page, string module, object id)
        {
            string re = string.Format("/adm/{0}/{1},{2}", page, module, id);
            return re;
        }

        public static string GetLinkNoRewrite(string pageName, object langId, object catId)
        {
            string re = string.Format("/default.aspx?page={0}&type={1}&cid={2}", pageName, langId, catId);
            return re;
        }
    }
}
