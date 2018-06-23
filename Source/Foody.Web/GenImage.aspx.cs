using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.DBUtility;
using Cb.Web;

namespace Cb.Web
{
    public partial class GenImage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string text = Global.ToDecoding(Request.QueryString["id"]);
                ImageObject.DrawTextImage(text, "Arial", Server.MapPath("images") + "\\mabaove.jpg", Response.OutputStream);
            }
            catch (Exception ex)
            {
                string t = ex.Message;
            }
        }
    }
}
