using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Globalization;
using Cb.Utility;

namespace Cb.Utility
{
    public class DGCPage : Page
    {
        #region Field
        private string template_path;
        private string langId;
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

        #endregion

        protected override void OnInit(EventArgs e)
        {
            template_path = WebUtils.GetBaseUrl();
            langId = Utils.GetParameter("langid", Constant.DB.langVn);
            this.ci = WebUtils.getResource(langId);
            langInt = langId == Constant.DB.langVn ? 1 : 2;
        }

    }
}
