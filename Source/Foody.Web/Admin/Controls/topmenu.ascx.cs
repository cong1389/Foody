using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Model;
using Cb.Utility;
using Cb.Localization;

namespace Cb.Web.Admin.Controls
{
    public partial class topmenu : DGCUserControl
    {
        #region Parameter

        protected string action;

        string template_path = string.Empty, pageName = string.Empty;

        #endregion

        #region Common

        private void SetLang()
        {
            pageName = Utils.GetParameter("page", "home");
            template_path = WebUtils.GetWebPath();

            string link, url, name, rawUrl, cid = "cid", id = "content", tagA = "<a href='{0}'><img border='0' id='{1}' title='{2}' src='{3}' /></a>";
            if (pageName == "home")
            {
                //ltrLangVn
                link = string.Format(SiteNavigation.link_trang_chu_rewrite, Constant.DB.langVn, cid, id);
                hypVN.HRef = string.Format("{0}{1}", template_path, link);
                name = LocalizationUtility.GetText("lang_VietNamese", Ci);
                //hypVN.HRef = string.Format(tagA, url, Constant.DB.langVn, name, template_path + "/images/flagvn.png");

                //ltrLangEn
                link = string.Format(SiteNavigation.link_trang_chu_rewrite, Constant.DB.langEng, cid, id);
                hypEng.HRef = string.Format("{0}{1}", template_path, link);
                //name = LocalizationUtility.GetText("lang_English", Ci);
                //hypEng.HRef = string.Format(tagA, url, Constant.DB.langEng, name, template_path + "/images/flagen.png");
            }
            else
            {
                rawUrl = Request.RawUrl;
                //ltrLangVn
                hypVN.HRef = rawUrl.Replace(Constant.DB.langEng, Constant.DB.langVn);
                //name = LocalizationUtility.GetText("lang_VietNamese", Ci);
                //hypVN.HRef = string.Format(tagA, url, Constant.DB.langVn, name, template_path + "/images/flagvn.png");

                //ltrLangEn
                hypEng.HRef = rawUrl.Replace(Constant.DB.langVn, Constant.DB.langEng);
                //name = LocalizationUtility.GetText("lang_English", Ci);
                //hypEng.HRef = string.Format(tagA, url, Constant.DB.langEng, name, template_path + "/images/flagen.png");
            }

            ltrWebsite.Text = LocalizationUtility.GetText("ltrWebsite");
            ltrSignOut.Text = LocalizationUtility.GetText("ltrSignOut");
        }

        private void GetAction()
        {
            hypAdmin.HRef = SiteNavigation.link_adminPage_rewrite;
            hypLogOut.HRef = Utils.CombineUrl(WebUtils.GetBaseUrl(), "logout.aspx");
            hypkPreview.HRef = WebUtils.GetBaseUrl(); // WebUtils.RedirectHomePage();

            this.action = Request.Form["task"];
            string cid = Request.Form["cid[]"];
            switch (action)
            {
                case "preview":
                    //hypkPreview.HRef = WebUtils.RedirectHomePage();
                    break;
            }
        }

        private void GetUserInfo()
        {
            PNK_User lstUser = (PNK_User)Session[Global.SESS_USER];
            enuRoleUser enu = (enuRoleUser)lstUser.Role;

            ltrUserName.Text = lstUser.Username;
            ltrFullName.Text = string.Format("{0} - {1}", lstUser.FullName, (enuRoleUser)lstUser.Role).ToUpper();
            ltrEmail.Text = string.Format("{0} - {1}", lstUser.Email, lstUser.Phone);
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SetLang();
                GetAction();
                GetUserInfo();
            }
        }

        protected void btnPreview_Click(object sender, EventArgs e)
        {
            //Clear cache

            //Redirect về FrontEnd
            //Response.Write("<script> window.open( '" + WebUtils.RedirectHomePage() + "','_blank' ); </script>");
            //Response.End();
            Response.Redirect(WebUtils.RedirectHomePage());
        }

        #endregion
    }
}