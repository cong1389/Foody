using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Model;
using Cb.Utility;

namespace Cb.Web
{
    public partial class logout : System.Web.UI.Page
    {
        protected string template_path;
        protected void Page_Load(object sender, EventArgs e)
        {
            template_path = WebUtils.GetWebPath();
            Session.RemoveAll();
            Response.Redirect(string.Format(SiteNavigation.link_adminPage_rewrite, Constant.DB.langVn));
        }
    }
}