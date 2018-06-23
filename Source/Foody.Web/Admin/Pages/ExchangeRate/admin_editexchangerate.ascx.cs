// =============================================
// Author:		Congtt
// Create date: 22/09/2014
// Description:	Edit danh sach exchangerate
// =============================================

using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Cb.DBUtility;
using Cb.Utility;
using Cb.BLL;
using Cb.Localization;
using System.IO;
using Microsoft.Security.Application;
using Cb.Model;

namespace Cb.Web.Admin.Pages.ExchangeRate
{
    public partial class admin_editexchangerate : DGCUserControl
    {
        #region Parameter

        protected int productcategoryId = int.MinValue;
        protected string template_path;

        private Generic<PNK_ExchangeRate> genericBLL;
        private Generic<PNK_ExchangeRateDesc> genericDescBLL;
        private Generic2C<PNK_ExchangeRate, PNK_ExchangeRateDesc> generic2CBLL;
        private string filenameUpload
        {
            get
            {
                if (ViewState["filenameUpload"] != null)
                    return ViewState["filenameUpload"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["filenameUpload"] = value;
            }
        }

        #endregion

        #region Common

        /// <summary>
        /// Init page
        /// </summary>
        private void InitPage()
        {
            LocalizationUtility.SetValueControl(this);
            ltrAdminApply.Text = Constant.UI.admin_apply;
            ltrAdminCancel.Text = Constant.UI.admin_cancel;
            ltrAdminDelete.Text = Constant.UI.admin_delete;
            ltrAdminSave.Text = Constant.UI.admin_save;

            reqv_txtNameVi.Text = Constant.UI.alert_empty_name_outsite;
            reqv_txtNameVi.ErrorMessage = Constant.UI.alert_empty_name;

            ltrAminLangVi.Text = Constant.UI.admin_lang_Vi;
            ltrAminLangEn.Text = Constant.UI.admin_lang_En;
        }

        private void GetId()
        {
            #region Set thuoc tinh cho block_baseimage

            block_baseimage.ImagePath = ConfigurationManager.AppSettings["ExchangeRateUpload"];
            block_baseimage.MinWidth = ConfigurationManager.AppSettings["minWidthCategory"];
            block_baseimage.MinHeigh = ConfigurationManager.AppSettings["minHeightCategory"];
            block_baseimage.MaxWidth = ConfigurationManager.AppSettings["maxWidthCategory"];
            block_baseimage.MaxHeight = ConfigurationManager.AppSettings["maxHeightCategory"];
            block_baseimage.MaxWidthBox = ConfigurationManager.AppSettings["maxWidthBoxCategory"];
            block_baseimage.MaxHeightBox = ConfigurationManager.AppSettings["maxHeightBoxCategory"];

            #endregion

            //get ID param          
            genericBLL = new Generic<PNK_ExchangeRate>();
            generic2CBLL = new Generic2C<PNK_ExchangeRate, PNK_ExchangeRateDesc>();
            genericDescBLL = new Generic<PNK_ExchangeRateDesc>();
            string strID = Utils.GetParameter("cid", string.Empty);
            this.productcategoryId = strID == string.Empty ? int.MinValue : DBConvert.ParseInt(strID);
            this.template_path = WebUtils.GetWebPath();
        }

        /// <summary>
        /// Show location
        /// </summary>
        private void ShowProductcategory()
        {
            if (this.productcategoryId != int.MinValue)
            {
                PNK_ExchangeRate productcatObj = new PNK_ExchangeRate();
                string[] fields = { "Id" };
                productcatObj.Id = this.productcategoryId;
                productcatObj = generic2CBLL.Load(productcatObj, fields, Constant.DB.LangId);
                this.chkPublished.Checked = productcatObj.Published == "1" ? true : false;              
                block_baseimage.ImageName = productcatObj.Image;

                IList<PNK_ExchangeRateDesc> lst = genericDescBLL.GetAllBy(new PNK_ExchangeRateDesc(), string.Format(" where mainid = {0}", this.productcategoryId), null);
                foreach (PNK_ExchangeRateDesc item in lst)
                {
                    switch (item.LangId)
                    {
                        case 1:
                            this.txtName.Value = item.Title;
                            this.txtIntro.Text = item.Brief;
                            this.editBriefVi.Text = item.Detail;

                            this.txtAmount.Value = item.Amount.ToString();
                            //this.txtFromCurrency.Value = item.FromCurrency;
                            //this.txtToCurrency.Value = item.ToCurrency;                            
                            break;
                        case 2:
                            this.txtNameEng.Value = item.Title;
                            this.txtIntroEn.Text = item.Brief;
                            this.editBriefEn.Text = item.Detail;
                            //this.editDetailEn.Text = item.Detail;
                            //editDetailEn.Text = item.Intro;
                            break;
                    }
                }
            }
        }

        /// <summary>
        /// get data for insert update
        /// </summary>
        /// <param name="userObj"></param>
        /// <returns></returns>
        private PNK_ExchangeRate GetDataObjectParent(PNK_ExchangeRate productcatObj)
        {
            productcatObj.CategoryId = 1;            
            productcatObj.Published = chkPublished.Checked ? "1" : "0";
            productcatObj.UpdateDate = DateTime.Now;

            HtmlControl hddImageName = block_baseimage.FindControl("hddImageName") as HtmlControl;
            if (hddImageName != null && hddImageName.Attributes["value"] != null)
            {
                productcatObj.Image = hddImageName.Attributes["value"].ToString();
            }
            else
            {
                productcatObj.Image = "";
            }
            return productcatObj;
        }

        /// <summary>
        /// get data child for insert update
        /// </summary>
        /// <param name="contdescObj"></param>
        /// <returns></returns>
        private PNK_ExchangeRateDesc GetDataObjectChild(PNK_ExchangeRateDesc productcatdescObj, int lang)
        {
            switch (lang)
            {
                case 1:
                    productcatdescObj.MainId = this.productcategoryId;
                    productcatdescObj.LangId = Constant.DB.LangId;                    
                    productcatdescObj.Title = SanitizeHtml.Sanitize(txtName.Value);
                    productcatdescObj.Amount = DBConvert.ParseDecimal(txtAmount.Value);
                    productcatdescObj.FromCurrency = txtFromCurrency.Value;
                    productcatdescObj.ToCurrency = txtToCurrency.Value;
                    productcatdescObj.TitleUrl = Utils.RemoveUnicode(SanitizeHtml.Sanitize(txtName.Value));
                    productcatdescObj.Brief = txtIntro.Text;
                    productcatdescObj.Detail = editBriefVi.Text;

                    break;
                case 2:
                    productcatdescObj.MainId = this.productcategoryId;
                    productcatdescObj.LangId = Constant.DB.LangId_En;
                    productcatdescObj.Title = string.IsNullOrEmpty(txtNameEng.Value) ? SanitizeHtml.Sanitize(txtName.Value) : SanitizeHtml.Sanitize(txtNameEng.Value);
                    productcatdescObj.TitleUrl = string.IsNullOrEmpty(txtNameEng.Value) ? Utils.RemoveUnicode(SanitizeHtml.Sanitize(txtName.Value)) : Utils.RemoveUnicode(SanitizeHtml.Sanitize(txtNameEng.Value));
                    productcatdescObj.Brief = string.IsNullOrEmpty(txtIntroEn.Text) ? txtIntro.Text : txtIntroEn.Text;
                    productcatdescObj.Detail = string.IsNullOrEmpty(editBriefEn.Text) ? editBriefVi.Text : editBriefEn.Text;

                    break;
            }
            return productcatdescObj;
        }

        /// <summary>
        /// Save location
        /// </summary>
        private void SaveExchangeRateCategory()
        {
            PNK_ExchangeRate productcatObj = new PNK_ExchangeRate();
            PNK_ExchangeRateDesc productcatObjVn = new PNK_ExchangeRateDesc();
            PNK_ExchangeRateDesc productcatObjEn = new PNK_ExchangeRateDesc();
            if (this.productcategoryId == int.MinValue)
            {
                //get data insert
                productcatObj = this.GetDataObjectParent(productcatObj);
                productcatObj.PostDate = DateTime.Now;
                productcatObj.Ordering = genericBLL.getOrdering();
                productcatObjVn = this.GetDataObjectChild(productcatObjVn, Constant.DB.LangId);
                productcatObjEn = this.GetDataObjectChild(productcatObjEn, Constant.DB.LangId_En);

                List<PNK_ExchangeRateDesc> lst = new List<PNK_ExchangeRateDesc>();
                lst.Add(productcatObjVn);
                lst.Add(productcatObjEn);
                //excute
                this.productcategoryId = generic2CBLL.Insert(productcatObj, lst);
            }
            else
            {
                string[] fields = { "Id" };
                productcatObj.Id = this.productcategoryId;

                productcatObj = genericBLL.Load(productcatObj, fields);
                //string publisheddOld = productcatObj.Published;
                //get data update
                productcatObj = this.GetDataObjectParent(productcatObj);
                productcatObjVn = this.GetDataObjectChild(productcatObjVn, Constant.DB.LangId);
                productcatObjEn = this.GetDataObjectChild(productcatObjEn, Constant.DB.LangId_En);
                List<PNK_ExchangeRateDesc> lst = new List<PNK_ExchangeRateDesc>();
                lst.Add(productcatObjVn);
                lst.Add(productcatObjEn);
                //excute
                generic2CBLL.Update(productcatObj, lst, fields);
                //neu ve Published oo thay doi thi chay ham ChangeWithTransaction de doi Published cac con va cac product
                //if (publisheddOld != productcatObj.Published)
                //    PNK_ExchangeRate.ChangeWithTransaction(DBConvert.ParseString(this.productcategoryId), productcatObj.Published);
            }

        }

        /// <summary>
        /// delete location
        /// </summary>
        /// <param name="cid"></param>
        private void DeleteExchangeRateCategory(string cid)
        {
            if (cid != null)
            {

                string link, url;

                if (generic2CBLL.Delete(cid))
                    link = LinkHelper.GetAdminLink("exchangerate", "delete");
                else
                    link = LinkHelper.GetAdminLink("exchangerate", "delfail");
                url = Utils.CombineUrl(template_path, link);
                Response.Redirect(url);

            }
        }

        /// <summary>
        /// Cancel content
        /// </summary>
        private void CancelExchangeRateCategory()
        {
            string url = LinkHelper.GetAdminLink("exchangerate");
            Response.Redirect(url);
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            btn_Delete.Attributes["onclick"] = string.Format("javascript:return confirm('{0}');", Constant.UI.admin_msg_confirm_delete_item);
            GetId();
            if (!IsPostBack)
            {
                InitPage();
                ShowProductcategory();
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
                SaveExchangeRateCategory();
                string url = LinkHelper.GetAdminMsgLink("exchangerate", "save");
                Response.Redirect(url);
            }
        }

        /// <summary>
        /// btnApply_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnApply_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SaveExchangeRateCategory();
                string url = LinkHelper.GetAdminLink("edit_exchangerate", this.productcategoryId);
                Response.Redirect(url);
            }
        }

        /// <summary>
        /// btnDelete_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            DeleteExchangeRateCategory(DBConvert.ParseString(this.productcategoryId));
        }

        /// <summary>
        /// btnCancel_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            CancelExchangeRateCategory();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="alert"></param>
        private void Alert(string alert)
        {
            string script = string.Format("alert('{0}')", alert);
            ScriptManager.RegisterStartupScript(this, GetType(), "alertproductcategory", script, true);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="source"></param>
        /// <param name="args"></param>
        protected void csv_drpCategory_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //args.IsValid = !CheckParentIsThisOrChild();
            //if (!args.IsValid)
            //    Alert(Constant.UI.alert_invalid_parent_productcategory);
        }

        #endregion
    }
}