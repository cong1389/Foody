using Cb.BLL;
using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Localization;
using Cb.Model;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cb.Web.Pages.Contact
{
    public partial class Contact : DGCUserControl
    {
        #region Parameter

        protected string pageName, template_path = string.Empty, id = string.Empty, cid = string.Empty, cidsub = string.Empty;
        private int total;

        #endregion

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            cidsub = Utils.GetParameter("cidsub", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            GetConfig();
            SetHeader();

            ltrAddressName.Text = LocalizationUtility.GetText("ltrAddressName", Ci);
            ltrPhoneName.Text = LocalizationUtility.GetText("ltrPhoneName", Ci);
            btnSend.Text = LocalizationUtility.GetText("ltrSend", Ci);
            ltrCateNameTitle.Text = LocalizationUtility.GetText("ltrCateNameTitle", Ci);
        }

        private void SetHeader()
        {
            //Set header
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lst = pcBll.GetList(LangInt, pageName, string.Empty, int.MinValue, int.MinValue, false, string.Empty, 1, 1, out  total);
            if (total > 0)
            {
                //Gen html image category
                ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0]);


                ltrCategoryBrief.Text = lst[0].ProductCategoryDesc.Brief;

                WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
                WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);
            }
        }

        private void GetConfig()
        {
            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Configuration item in lst)
                {
                    if (LangInt == 1)
                    {
                        if (item.Key_name == Constant.Configuration.config_address_vi)
                        {
                            ltrAddressValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.phone)
                        {
                            ltrPhoneValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.email)
                        {
                            ltrEmail.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.skypeid)
                        {
                            ltrHouse.Text = item.Value_name;
                        }
                    }
                    else
                    {
                        if (item.Key_name == Constant.Configuration.config_address1_vi)
                        {
                            ltrAddressValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.phone)
                        {
                            ltrPhoneValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.email)
                        {
                            ltrEmail.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.skypeid)
                        {
                            ltrHouse.Text = item.Value_name;
                        }
                    }
                }
            }
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                InitPage();
            }
        }

        protected void btnSend_ServerClick(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    bool result = false;
                    string path = Request.PhysicalApplicationPath;
                    string strHtml = WebUtils.GetMailTemplate(Path.Combine(path, "TemplateMail/Contact.txt"));
                    string body = string.Format(strHtml, "admin", txtFullName.Value, txtEmail.Value, txtMessage.Value);
                    result = WebUtils.SendEmail("Contact", txtEmail.Value, string.Empty, body);

                    if (result == true)
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('Send success.','Message',function(r) {{window.location='{0}'}});", Request.RawUrl), true);
                    else
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('Send fail.','Message',function(r) {{window.location='{0}'}});", Request.RawUrl), true);
                    txtEmail.Value = txtMessage.Value = txtFullName.Value = "";
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("btnSend_ServerClick.aspx", "Contact", ex.Message);
            }
        }

        #endregion
    }
}