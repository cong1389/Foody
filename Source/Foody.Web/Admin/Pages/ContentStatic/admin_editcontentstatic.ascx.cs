// =============================================
// Author:		Congtt
// Create date: 22/09/2014
// Description:	Edit danh sach contentstatic
// =============================================

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Cb.DBUtility;
using Cb.Utility;
using Cb.BLL;
using Cb.Localization;
using System.IO;
using Cb.Model;
using Cb.Model.ContentStatic;

namespace Cb.Web.Admin.Pages.ContentStatic
{
    public partial class admin_editcontentstatic : DGCUserControl
    {
        #region Parameter

        protected int productcategoryId = int.MinValue;
        protected string template_path;

        private Generic<PNK_ContentStatic> genericBLL;
        private Generic<PNK_ContentStaticDesc> genericDescBLL;
        private Generic2C<PNK_ContentStatic, PNK_ContentStaticDesc> generic2CBLL;
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

            block_baseimage.ImagePath = ConfigurationManager.AppSettings["ContentStaticUpload"];
            block_baseimage.MinWidth = ConfigurationManager.AppSettings["minWidthCategory"];
            block_baseimage.MinHeigh = ConfigurationManager.AppSettings["minHeightCategory"];
            block_baseimage.MaxWidth = ConfigurationManager.AppSettings["maxWidthCategory"];
            block_baseimage.MaxHeight = ConfigurationManager.AppSettings["maxHeightCategory"];
            block_baseimage.MaxWidthBox = ConfigurationManager.AppSettings["maxWidthBoxCategory"];
            block_baseimage.MaxHeightBox = ConfigurationManager.AppSettings["maxHeightBoxCategory"];

            #endregion

            //get ID param          
            genericBLL = new Generic<PNK_ContentStatic>();
            generic2CBLL = new Generic2C<PNK_ContentStatic, PNK_ContentStaticDesc>();
            genericDescBLL = new Generic<PNK_ContentStaticDesc>();
            string strID = Utils.GetParameter("cid", string.Empty);
            this.productcategoryId = strID == string.Empty ? int.MinValue : DBConvert.ParseInt(strID);
            this.template_path = WebUtils.GetWebPath();
        }

        /// <summary>
        ///Hien thi o upload hinh anh( true: chua upload hinh) 
        /// </summary>
        /// <param name="isShowUplImg"></param>
        /// <param name="filename"></param>
        private void SetVisibleImg(bool isShowUplImg, string filename)
        {
            if (isShowUplImg)
            {
                fuImage.Visible = true;
                btnUploadImage.Visible = true;
                lbnView.Visible = false;
                lbnDelete.Visible = false;
            }
            else
            {
                fuImage.Visible = false;
                btnUploadImage.Visible = false;
                lbnView.Attributes["href"] = filename;
                lbnView.Visible = true;
                lbnDelete.Visible = true;
            }
        }

        /// <summary>
        /// Show location
        /// </summary>
        private void ShowProductcategory()
        {
            if (this.productcategoryId != int.MinValue)
            {
                PNK_ContentStatic productcatObj = new PNK_ContentStatic();
                string[] fields = { "Id" };
                productcatObj.Id = this.productcategoryId;
                productcatObj = generic2CBLL.Load(productcatObj, fields, Constant.DB.LangId);
                this.chkPublished.Checked = productcatObj.Published == "1" ? true : false;
                txtPhone.Value = productcatObj.Phone;
                block_baseimage.ImageName = productcatObj.Image;

                IList<PNK_ContentStaticDesc> lst = genericDescBLL.GetAllBy(new PNK_ContentStaticDesc(), string.Format(" where mainid = {0}", this.productcategoryId), null);
                foreach (PNK_ContentStaticDesc item in lst)
                {
                    switch (item.LangId)
                    {
                        case 1:
                            this.txtName.Value = item.Title;
                            this.txtIntro.Text = item.Brief;
                            this.editBriefVi.Text = item.Detail;
                            //this.editDetailVi.Text = item.Detail;
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
        private PNK_ContentStatic GetDataObjectParent(PNK_ContentStatic productcatObj)
        {
            productcatObj.CategoryId = 1;
            productcatObj.Phone = this.txtPhone.Value;
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
        private PNK_ContentStaticDesc GetDataObjectChild(PNK_ContentStaticDesc productcatdescObj, int lang)
        {
            switch (lang)
            {
                case 1:
                    productcatdescObj.MainId = this.productcategoryId;
                    productcatdescObj.LangId = Constant.DB.LangId;
                    //string str = SanitizeHtml.Sanitize(txtName.Value);

                    productcatdescObj.Title = SanitizeHtml.Sanitize(txtName.Value);
                    productcatdescObj.Brief = txtIntro.Text;
                    productcatdescObj.Detail = editBriefVi.Text;

                    break;
                case 2:
                    productcatdescObj.MainId = this.productcategoryId;
                    productcatdescObj.LangId = Constant.DB.LangId_En;
                    productcatdescObj.Title = string.IsNullOrEmpty(txtNameEng.Value) ? SanitizeHtml.Sanitize(txtName.Value) : SanitizeHtml.Sanitize(txtNameEng.Value);
                    productcatdescObj.Brief = string.IsNullOrEmpty(txtIntroEn.Text) ? txtIntro.Text : txtIntroEn.Text;
                    productcatdescObj.Detail = string.IsNullOrEmpty(editBriefEn.Text) ? editBriefVi.Text : editBriefEn.Text;

                    break;
            }
            return productcatdescObj;
        }

        /// <summary>
        /// Save location
        /// </summary>
        private void SaveContentStaticCategory()
        {
            //Xoá cache trước khi lưu
            CacheHelper.ClearContains("ContentStatic");

            PNK_ContentStatic productcatObj = new PNK_ContentStatic();
            PNK_ContentStaticDesc productcatObjVn = new PNK_ContentStaticDesc();
            PNK_ContentStaticDesc productcatObjEn = new PNK_ContentStaticDesc();
            if (this.productcategoryId == int.MinValue)
            {
                //get data insert
                productcatObj = this.GetDataObjectParent(productcatObj);
                productcatObj.PostDate = DateTime.Now;
                productcatObj.Ordering = genericBLL.getOrdering();
                productcatObjVn = this.GetDataObjectChild(productcatObjVn, Constant.DB.LangId);
                productcatObjEn = this.GetDataObjectChild(productcatObjEn, Constant.DB.LangId_En);

                List<PNK_ContentStaticDesc> lst = new List<PNK_ContentStaticDesc>();
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
                List<PNK_ContentStaticDesc> lst = new List<PNK_ContentStaticDesc>();
                lst.Add(productcatObjVn);
                lst.Add(productcatObjEn);
                //excute
                generic2CBLL.Update(productcatObj, lst, fields);
                //neu ve Published oo thay doi thi chay ham ChangeWithTransaction de doi Published cac con va cac product
                //if (publisheddOld != productcatObj.Published)
                //    PNK_ContentStatic.ChangeWithTransaction(DBConvert.ParseString(this.productcategoryId), productcatObj.Published);
            }

        }

        /// <summary>
        /// delete location
        /// </summary>
        /// <param name="cid"></param>
        private void DeleteContentStaticCategory(string cid)
        {
            if (cid != null)
            {

                string link, url;

                if (generic2CBLL.Delete(cid))
                    link = LinkHelper.GetAdminLink("contentstatic", "delete");
                else
                    link = LinkHelper.GetAdminLink("contentstatic", "delfail");
                url = Utils.CombineUrl(template_path, link);
                Response.Redirect(url);

            }
        }

        /// <summary>
        /// Cancel content
        /// </summary>
        private void CancelContentStaticCategory()
        {
            string url = LinkHelper.GetAdminLink("contentstatic");
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
                SaveContentStaticCategory();
                string url = LinkHelper.GetAdminMsgLink("contentstatic", "save");
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
                SaveContentStaticCategory();
                string url = LinkHelper.GetAdminLink("edit_contentstatic", this.productcategoryId);
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
            DeleteContentStaticCategory(DBConvert.ParseString(this.productcategoryId));
        }

        /// <summary>
        /// btnCancel_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            CancelContentStaticCategory();
        }

        protected void btnUploadImage_Click(object sender, EventArgs e)
        {

            try
            {
                if (fuImage.HasFile)
                {

                    filenameUpload = string.Format("{0}.{1}", GenerateString.Generate(10), fuImage.FileName.Split('.')[1]);
                    //string str = Path.Combine(Request.PhysicalApplicationPath, Constant.DSC.NewsUploadFolder.Replace("/", "\\") + filenameUpload);
                    fuImage.SaveAs(Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["ContentStaticUpload"]), filenameUpload));


                    //string strTemp = string.Format("<a class='zoom-image' href='{0}''>&nbsp;{1}</a>", Utils.CombineUrl(template_path, string.Format("{0}/{1}", Constant.DSC.NewsUploadFolder.Replace("\\", "/"), filename)), LocalizationUtility.GetText("strView"));
                    //strTemp += string.Format("<a href='{0}' >{1}</a>",LocalizationUtility.GetText("strDelete"));
                    //ltrImage.Text = strTemp;
                    SetVisibleImg(false, string.Format("{0}/{1}", ConfigurationManager.AppSettings["ContentStaticUpload"], filenameUpload));
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("admin_editcontentstatic", "btnUploadImage_Click", ex.ToString());
            }
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

        protected void lbnDelete_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(filenameUpload))
            {
                SetVisibleImg(true, string.Empty);

                filenameUpload = string.Empty; string f = Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["ContentStaticUpload"]), filenameUpload);
                if (File.Exists(f))
                {
                    try
                    {
                        File.Delete(f);
                    }
                    catch { }
                }
            }
        }

        #endregion
    }
}