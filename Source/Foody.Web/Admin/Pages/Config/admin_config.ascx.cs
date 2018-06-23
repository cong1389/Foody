using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Model;
using Cb.DBUtility;
using Cb.BLL;
using Cb.Localization;
using System.Data;
using System.IO;
using System.Configuration;
using System.Xml;
using System.Xml.Linq;
using Cb.Utility;

namespace Cb.Web.Admin.Pages.Config
{
    public partial class admin_config : System.Web.UI.UserControl
    {
        #region Parameter

        protected string template_path;

        #endregion

        #region Common

        private void InitPage()
        {
            this.template_path = WebUtils.GetWebPath();

            SetRoleMenu();
            GetWebconfig();
            GetImageSize();
            GetEmailAccount();
        }

        /// <summary>
        /// Phân quyền tài khoản Congtt full quyền, những tk còn lại k có quyền xóa và Edit
        /// </summary>
        private void SetRoleMenu()
        {
            PNK_User lst_user = (PNK_User)Session[Global.SESS_USER];
            if (lst_user.Username != "congtt")
            {
                tabWebConfig.Style.Add("display", "none");
            }
        }

        /// <summary>
        ///GetWebconfig
        /// </summary>
        private void GetWebconfig()
        {
            var myXml = WebUtils.LoadWebConfig();
            txtWebConfig.Value = myXml.ToXml();
        }

        private void GetImageSize()
        {
            #region Category Image

            txtMinWidthCategory.Text = WebUtils.GetWebConfigKey("minWidthCategory");
            txtMinHeightCategory.Text = WebUtils.GetWebConfigKey("minHeightCategory");
            txtMaxWidthCategory.Text = WebUtils.GetWebConfigKey("maxWidthCategory");
            txtMaxHeightCategory.Text = WebUtils.GetWebConfigKey("maxHeightCategory");
            txtmaxWidthBoxCategory.Text = WebUtils.GetWebConfigKey("maxWidthBoxCategory");
            txtMaxHeightBoxCategory.Text = WebUtils.GetWebConfigKey("maxHeightBoxCategory");

            #endregion

            #region Item Image

            txtMinWidthItem.Text = WebUtils.GetWebConfigKey("minWidthItem");
            txtMinHeightItem.Text = WebUtils.GetWebConfigKey("minHeightItem");
            txtMaxWidthItem.Text = WebUtils.GetWebConfigKey("maxWidthItem");
            txtMaxHeightItem.Text = WebUtils.GetWebConfigKey("maxHeightItem");
            txtmaxWidthBoxItem.Text = WebUtils.GetWebConfigKey("maxWidthBoxItem");
            txtMaxHeightBoxItem.Text = WebUtils.GetWebConfigKey("maxHeightBoxItem");

            #endregion

            #region Item Slider

            txtMinWidthSlider.Text = WebUtils.GetWebConfigKey("minWidthSlider");
            txtMinHeightSlider.Text = WebUtils.GetWebConfigKey("minHeightSlider");
            txtMaxWidthSlider.Text = WebUtils.GetWebConfigKey("maxWidthSlider");
            txtMaxHeightSlider.Text = WebUtils.GetWebConfigKey("maxHeightSlider");
            txtmaxWidthBoxSlider.Text = WebUtils.GetWebConfigKey("maxWidthBoxSlider");
            txtmaxHeightBoxSlider.Text = WebUtils.GetWebConfigKey("maxHeightBoxSlider");

            #endregion
        }

        private void SetImageSize()
        {
            #region Category Image

            WebUtils.SetWebConfigKey("minWidthCategory", txtMinWidthCategory.Text);
            WebUtils.SetWebConfigKey("minHeightCategory", txtMinHeightCategory.Text);
            WebUtils.SetWebConfigKey("maxWidthCategory", txtMaxWidthCategory.Text);
            WebUtils.SetWebConfigKey("maxHeightCategory", txtMaxHeightCategory.Text);
            WebUtils.SetWebConfigKey("maxWidthBoxCategory", txtmaxWidthBoxCategory.Text);
            WebUtils.SetWebConfigKey("maxHeightBoxCategory", txtMaxHeightBoxCategory.Text);

            #endregion

            #region Item Image

            WebUtils.SetWebConfigKey("minWidthItem", txtMinWidthItem.Text);
            WebUtils.SetWebConfigKey("minHeightItem", txtMinHeightItem.Text);
            WebUtils.SetWebConfigKey("maxWidthItem", txtMaxWidthItem.Text);
            WebUtils.SetWebConfigKey("maxHeightItem", txtMaxHeightItem.Text);
            WebUtils.SetWebConfigKey("maxWidthBoxItem", txtmaxWidthBoxItem.Text);
            WebUtils.SetWebConfigKey("maxHeightBoxItem", txtMaxHeightBoxItem.Text);

            #endregion

            #region Item Image

            WebUtils.SetWebConfigKey("minWidthSlider", txtMinWidthSlider.Text);
            WebUtils.SetWebConfigKey("minHeightSlider", txtMinHeightSlider.Text);
            WebUtils.SetWebConfigKey("maxWidthSlider", txtMaxWidthSlider.Text);
            WebUtils.SetWebConfigKey("maxHeightSlider", txtMaxHeightSlider.Text);
            WebUtils.SetWebConfigKey("maxWidthBoxSlider", txtmaxWidthBoxSlider.Text);
            WebUtils.SetWebConfigKey("maxHeightBoxSlider", txtmaxHeightBoxSlider.Text);

            #endregion
        }

        private void GetEmailAccount()
        {
            txtHost.Value = WebUtils.GetWebConfigKey("SmtpServer");
            txtUser.Value = WebUtils.GetWebConfigKey("UserMail");
            txtPass.Value = WebUtils.GetWebConfigKey("PassMail");
            txtEmail.Value = WebUtils.GetWebConfigKey("MailTo");
            chkSSL.Checked = WebUtils.GetWebConfigKey("EnableSsl") == "true" ? true : false;
            txtPort.Value = WebUtils.GetWebConfigKey("Port");
        }

        private void SetEmailAccount()
        {
            WebUtils.SetWebConfigKey("SmtpServer", txtHost.Value);
            WebUtils.SetWebConfigKey("UserMail", txtUser.Value);
            WebUtils.SetWebConfigKey("PassMail", txtPass.Value);
            WebUtils.SetWebConfigKey("MailTo", txtEmail.Value);
            WebUtils.SetWebConfigKey("EnableSsl", chkSSL.Checked ? "true" : "false");
            WebUtils.SetWebConfigKey("Port", txtPort.Value);
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            //check role
            PNK_User user = (PNK_User)Session[Global.SESS_USER];
            if (user != null && user.Role != DBConvert.ParseInt(Constant.Security.AdminRoleValue))
            {
                Response.Redirect(LinkHelper.GetAdminLink("home"));
            }
            //end

            if (!this.IsPostBack)
            {
                InitPage();
                this.ltrAdminSave.Text = Constant.UI.admin_save;
                LocalizationUtility.SetValueControl(this);
            }
        }

        /// <summary>
        /// btnSave_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SetImageSize();
                SetEmailAccount();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('{0}','Message');", Constant.UI.admin_msg_save_success), true);
            }
        }

        /// <summary>
        /// Read Value by Key from Web.config
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnGetWebConfig_Click(object sender, EventArgs e)
        {
            txtWebConfigValue.Value = WebUtils.GetWebConfigKey(txtWebConfigKey.Value.Trim());
        }

        /// <summary>
        /// Write Value by Key from Web.config
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSetWebConfig_Click(object sender, EventArgs e)
        {
            WebUtils.SetWebConfigKey(txtWebConfigKey.Value.Trim(), txtWebConfigValue.Value.Trim());
            GetWebconfig();
        }

        #endregion
    }
}