using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Globalization;

namespace Cb.Utility
{
    public class DGCUserControl : UserControl
    {
        #region Field
        private string template_path;
        private string pageName = string.Empty, langId, urlCid = string.Empty, urlCidSub = string.Empty, urlId = string.Empty, urlIdSub = string.Empty;
        private int langInt;
        private CultureInfo ci;
        #endregion

        #region Properties

        public CultureInfo Ci
        {
            get { return ci; }
            set { ci = value; }
        }

        public int LangInt
        {
            get { return langInt; }
            set { langInt = value; }
        }

        public string PageName
        {
            get { return pageName; }
            set { pageName = value; }
        }

        public string LangId
        {
            get { return langId; }
            set { langId = value; }
        }

        public string Template_path
        {
            get { return template_path; }
            set { template_path = value; }
        }

        public string UrlCid
        {
            get { return urlCid; }
            set { urlCid = value; }
        }

        public string UrlCidSub
        {
            get { return urlCidSub; }
            set { urlCidSub = value; }
        }

        public string UrlId
        {
            get { return urlId; }
            set { urlId = value; }
        }

        public string UrlIdSub
        {
            get { return urlIdSub; }
            set { urlIdSub = value; }
        }

        #endregion

        protected override void OnInit(EventArgs e)
        {
            Page p = this.Page;
            //template_path = Utils.GetValueProperties(p, "Template_path").ToString();
            //langId = Utils.GetValueProperties(p, "LangId").ToString();
            //LangInt = Convert.ToInt32(Utils.GetValueProperties(p, "LangInt"));
            //ci = Utils.GetValueProperties(p, "Ci") as CultureInfo;

            template_path = WebUtils.GetBaseUrl();
            langId = Utils.GetParameter("langid", Constant.DB.langVn);
            this.ci = WebUtils.getResource(langId);
            langInt = langId == Constant.DB.langVn ? 1 : 2;

            pageName = Utils.GetParameter("page", langId);
            urlCid = Utils.GetParameter("cid", string.Empty);
            urlCidSub = Utils.GetParameter("cidsub", string.Empty);
            urlId = Utils.GetParameter("id", string.Empty);
            urlIdSub = Utils.GetParameter("idsub", string.Empty);

            //template_path = WebUtils.GetBaseUrl();
            //langId = Constant.DB.langVn;
            //this.ci = WebUtils.getResource(langId);
            //langInt = langId == Constant.DB.langVn ? 1 : 2;

            //langId = Utils.GetParameter("langid", Constant.DB.langVn);
            //this.ci = WebUtils.getResource(langId);
            //langInt = langId == Constant.DB.langVn ? 1 : 2;
        }
    }
}
