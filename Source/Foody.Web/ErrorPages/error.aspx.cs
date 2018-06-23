using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cb.Web.ErrorPages
{
    public partial class error : DGCPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hypHomePage.HRef = LinkHelper.GetLink("trang-chu");
        }
    }
}