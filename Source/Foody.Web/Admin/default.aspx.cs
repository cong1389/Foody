using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Model;
using Cb.DBUtility;
using Cb.BLL;
using Cb.Utility;

namespace Cb.Web.Admin
{
    public partial class _default : DGCPage
    {
        #region Parameter

        private string pageName;
        private int id;
        private XMLConfigBLL configXML;

        #endregion

        #region Common

        private void GetPageName(string pageName)
        {
            try
            {
                pageName = configXML.LoadPage(pageName, Constant.DSC.IdXmlPageAdmin, id);
                UserControl contentView = (UserControl)Page.LoadControl(pageName);
                phdContent.Controls.Add(contentView);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("GetPageName", "Admin default", ex.Message);
            }
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            //check login
            if (Session[Global.SESS_USER] == null)
            {
                string link = string.Empty;
                string url = string.Empty;
                link = string.Format(SiteNavigation.link_login, Constant.DB.langVn);
                url = Utils.CombineUrl(WebUtils.GetWebPath(), link);
                Response.Redirect(url);
            }
            pageName = Utils.GetParameter("page", "home");
            id = DBConvert.ParseInt(Utils.GetParameter("id", string.Empty));
            configXML = new XMLConfigBLL();
            GetPageName(pageName);
        }


        #endregion
    }
}
