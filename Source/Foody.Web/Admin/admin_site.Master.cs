using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Model;
using Cb.Utility;

namespace Cb.Web.Admin
{
    public partial class admin_site : System.Web.UI.MasterPage
    {
        #region Parameter

        protected string template_path;

        #endregion

        #region Common

        private void InitPage()
        {
            this.template_path = WebUtils.GetWebPath();
            //WebUtils.IncludeCSS(this.Page, template_path + "/Style/style.css");
            WebUtils.IncludeCSS(this.Page, template_path + "/Style/jquery.alerts.css");
            WebUtils.IncludeJS(this.Page, template_path + "/javascript/jquery.alerts.js");
            WebUtils.IncludeJS(this.Page, template_path + "/javascript/functions.js");
                       
        }

        #endregion

        #region Event


        protected void Page_Load(object sender, EventArgs e)
        {
            InitPage();
        }


        #endregion

    }
}
