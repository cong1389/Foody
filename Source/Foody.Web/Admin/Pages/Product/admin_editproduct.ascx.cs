// =============================================
// Author:		Congtt
// Create date: 22/09/2014
// Description:	Edit danh sach sản phẩm
//    Cột Area lưu file name PDF
//    Cột Hot lưu sach hay nhat
//    Cột Feature lưu sach nổi bật
//    Cột Design lưu tagName
//    Cột Utility lưu tagUrl
//    Cột Bathroom lưu hiển thị sản phẩm trang chủ
// =============================================

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Cb.DBUtility;
using Cb.Model;
using Cb.BLL;
using Cb.Localization;
using System.IO;
using Cb.Model.Products;
using Cb.BLL.Product;
using System.Net;
using Cb.Utility;

namespace Cb.Web.Admin.Pages.Products
{
    public partial class admin_editproduct : DGCUserControl
    {
        #region Parameter

        private Generic<PNK_Product> genericBLL;
        private Generic<PNK_ProductDesc> genericDescBLL;
        private Generic2C<PNK_Product, PNK_ProductDesc> generic2CBLL;

        protected int productcategoryId = int.MinValue;
        string productCategoryName = string.Empty;
        protected string template_path;

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

        private string categoryId
        {
            get
            {
                if (ViewState["categoryId"] != null)
                    return ViewState["categoryId"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["categoryId"] = value;
            }
        }

        private string id
        {
            get
            {
                if (ViewState["id"] != null)
                    return ViewState["id"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["id"] = value;
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
            ltrPageDetail.Text = LocalizationUtility.GetText(ltrPageDetail.ID);

            this.ltrAdminApply.Text = Constant.UI.admin_apply;
            this.ltrAdminCancel.Text = Constant.UI.admin_cancel;
            this.ltrAdminDelete.Text = Constant.UI.admin_delete;
            this.ltrAdminSave.Text = Constant.UI.admin_save;
            //this.ltrAminName.Text = Constant.UI.admin_name;
            this.ltrAminLangVi.Text = Constant.UI.admin_lang_Vi;
            this.ltrAminLangEn.Text = Constant.UI.admin_lang_En;
            //this.ltrAminName_En.Text = Constant.UI.admin_name_en;

            reqv_txtNameVi.Text = Constant.UI.alert_empty_name_outsite;
            reqv_txtNameVi.ErrorMessage = Constant.UI.alert_empty_name;

            //load category
            GetDataDropDownCategory(this.drpCategory);

            BindCost();
            SetRoleMenu();
        }

        /// <summary>
        /// GetId
        /// </summary>
        private void GetId()
        {
            txtToDate.Text = DateTime.Today.ToString();

            #region Set thuoc tinh cho block_baseimage

            block_baseimage.ImagePath = block_uploadimage.ImagePath = ConfigurationManager.AppSettings["ProductUpload"];
            block_baseimage.MinWidth = ConfigurationManager.AppSettings["minWidthItem"];
            block_baseimage.MinHeigh = ConfigurationManager.AppSettings["minHeightItem"];
            block_baseimage.MaxWidth = ConfigurationManager.AppSettings["maxWidthItem"];
            block_baseimage.MaxHeight = ConfigurationManager.AppSettings["maxHeightItem"];
            block_baseimage.MaxWidthBox = ConfigurationManager.AppSettings["maxWidthBoxItem"];
            block_baseimage.MaxHeightBox = ConfigurationManager.AppSettings["maxHeightBoxItem"];

            block_uploadimage.CategoryId = categoryId.ToString();
            block_uploadimage.Id = id;

            #endregion

            genericBLL = new Generic<PNK_Product>();
            generic2CBLL = new Generic2C<PNK_Product, PNK_ProductDesc>();
            genericDescBLL = new Generic<PNK_ProductDesc>();
            categoryId = Utils.GetParameter("cid", string.Empty);
            id = Utils.GetParameter("id", string.Empty);
            productcategoryId = id == string.Empty ? int.MinValue : DBConvert.ParseInt(id);
            template_path = WebUtils.GetWebPath();

            //Show tab upload file khi đã cập nhật vào bảng
            if (id == string.Empty)
            {

            }

            //Set link chương trình tourr
            hypProgramTour.HRef = string.Format("/adm/programtour/{0}", id);

            block_bookingprice.ProductId = id;
        }

        /// <summary>
        /// Xem PDF file
        /// </summary>
        /// <param name="fileName"></param>
        private void ViewPdf(string fileName)
        {
            //string path = Request.PhysicalApplicationPath;            
            //string url = Path.Combine(ConfigurationManager.AppSettings["ProductUpload"], fileName).Replace("/","\\");
            //url = Utils.CombineUrl(path, url);

            string url = string.Format("{0}/{1}", ConfigurationManager.AppSettings["ProductUpload"], fileName);
            url = Utils.CombineUrl(WebUtils.GetBaseUrl(), url);

            WebClient wc = new WebClient();
            Byte[] buffer = wc.DownloadData(url);
            if (buffer != null)
            {
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(buffer);
                Response.Flush();
                Response.End();
            }
        }

        /// <summary>
        /// UploadMp3
        /// </summary>
        /// <param name="fu"></param>
        /// <returns></returns>
        private string UploadMp3(FileUpload fu)
        {
            //File giữ nguyen định dạng
            string fileNameMp3 = string.Format("{0}{1}.{2}", WebUtils.GetFileName(fu.PostedFile.FileName.Split('.')[0]), DateTime.Now.ToString("ddMMyyyyhhmmss"), WebUtils.GetFileExtension(fu.FileName));
            string pathNameMp3 = Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["ProductUpload"]), fileNameMp3);
            string fileNameOgg = pathNameMp3.Replace("mp3", "ogg").Replace("MP3", "ogg");
            //if (File.Exists(fileNameMp3))
            //{
            fu.SaveAs(pathNameMp3);
            fu.SaveAs(fileNameOgg);
            //}
            return fileNameMp3;
        }

        /// <summary>
        /// ViewMusic
        /// </summary>
        /// <param name="fu"></param>
        /// <returns></returns>
        private void ViewMusic(string fileName)
        {
            string path = Request.PhysicalApplicationPath;
            string url = string.Format("{0}/{1}", ConfigurationManager.AppSettings["ProductUpload"], fileName);
            url = Utils.CombineUrl(path, url);
            WebClient wc = new WebClient();
            Byte[] buffer = wc.DownloadData(url);
            if (buffer != null)
            {
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(buffer);
                Response.Flush();
                Response.End();
            }
        }

        /// <summary>
        /// Phân quyền tài khoản Congtt full quyền, những tk còn lại k có quyền xóa và edit
        /// </summary>
        private void SetRoleMenu()
        {
            PNK_User lst_user = (PNK_User)Session[Global.SESS_USER];
            if (lst_user.Username != "congtt")
            {
                divPage.Attributes.Add("class", "hidden");
            }
        }

        /// <summary>
        /// ShowProduct
        /// </summary>
        private void ShowProduct()
        {
            if (this.productcategoryId != int.MinValue)
            {
                PNK_Product productcatObj = new PNK_Product();
                string[] fields = { "Id" };
                productcatObj.Id = this.productcategoryId;
                productcatObj = generic2CBLL.Load(productcatObj, fields, Constant.DB.LangId);
                chkPublished.Checked = productcatObj.Published == "1" ? true : false;
                chkPublishedHot.Checked = productcatObj.Hot == "1" ? true : false;
                chkPublishedFeature.Checked = productcatObj.Feature == "1" ? true : false;
                // chkNewInHome.Checked = productcatObj.Bathroom == "1" ? true : false;

                txtBedRoom.Value = DBConvert.ParseString(productcatObj.Bedroom);

                txtToDate.Text = productcatObj.Code;
                txtStatus.Value = productcatObj.Status;
                try
                {
                    this.drpProvince.SelectedValue = productcatObj.Province == string.Empty ? "" : drpProvince.Items.FindByText(productcatObj.Province).Value;
                    //this.drpDistrict.SelectedValue = productcatObj.District == string.Empty ? "" : drpDistrict.Items.FindByText(productcatObj.District).Value;
                }
                catch (Exception)
                {
                    drpProvince.SelectedIndex = 0;
                }
                this.drpCategory.SelectedValue = productcatObj.CategoryId.ToString();

                chkProjectNew.Checked = productcatObj.Price == "1" ? true : false;

                drpCost.SelectedValue = DBConvert.ParseString(productcatObj.Cost);
                txtWebsite.Text = productcatObj.Website;
                txtPost.Text = productcatObj.Post;

                txtLatitude.Value = productcatObj.Latitude;
                txtLongitude.Value = productcatObj.Longitude;
                txtPage.Text = productcatObj.Page == "" ? ConfigurationManager.AppSettings["pagePathProductDetail"] : productcatObj.Page;

                #region Set image

                block_baseimage.ImageName = productcatObj.Image;

                if (productcatObj.ImageType == 1 || productcatObj.ImageType == null)
                {
                    HtmlControl rdImage = block_baseimage.FindControl("rdImage") as HtmlControl;
                    rdImage.Attributes["checked"] = "checked";
                }
                if (productcatObj.ImageType == 2)
                {
                    HtmlControl txtFontName = block_baseimage.FindControl("txtFontName") as HtmlControl;
                    txtFontName.Attributes["value"] = productcatObj.ImageFont;

                    HtmlControl rdImageFont = block_baseimage.FindControl("rdImageFont") as HtmlControl;
                    rdImageFont.Attributes["checked"] = "checked";
                }

                try
                {
                    cboArea.SelectedValue = productcatObj.Area == string.Empty ? "1" : cboArea.Items.FindByText(productcatObj.Area).Value;
                }
                catch (Exception)
                {
                    cboArea.SelectedIndex = 0;
                }
                //cboArea.Items.FindByText(productcatObj.Area).Selected = true;

                #endregion

                block_uploadfile.ImageName = productcatObj.Bathroom;

                IList<PNK_ProductDesc> lst = genericDescBLL.GetAllBy(new PNK_ProductDesc(), string.Format(" where mainid = {0}", this.productcategoryId), null);
                foreach (PNK_ProductDesc item in lst)
                {
                    switch (item.LangId)
                    {
                        case 1:
                            this.txtName.Value = item.Title;
                            this.txtIntro.Text = item.Brief;
                            this.txtDetailVi.Text = Server.HtmlDecode(item.Detail);
                            this.txtPositionVi.Text = item.Position;
                            this.txtUtilityVi.Text = item.Utility;
                            this.txtPicturesVi.Text = item.Pictures;
                            this.txtDesignVi.Text = item.Design;
                            this.txtPaymentVi.Text = item.Payment;
                            this.txtContactVi.Text = item.Contact;
                            this.txtMetaTitle.Text = item.MetaTitle;
                            this.txtMetaDescription.Text = item.Metadescription;
                            this.txtMetaKeyword.Text = item.MetaKeyword;
                            this.txtH1.Text = item.H1;
                            this.txtH2.Text = item.H2;
                            this.txtH3.Text = item.H3;
                            break;
                        case 2:
                            this.txtNameEng.Value = item.Title;
                            this.txtIntroEng.Text = item.Brief;
                            this.txtDetailEng.Text = item.Detail;
                            this.txtUtilityEng.Text = item.Utility;
                            this.txtPicturesEng.Text = item.Pictures;
                            this.txtDesignEng.Text = item.Design;
                            this.txtPaymentEng.Text = item.Payment;
                            this.txtContactEng.Text = item.Contact;
                            this.txtMetaTitleEng.Text = item.MetaTitle;
                            this.txtMetaTitleEng.Text = item.Metadescription;
                            this.txtMetaTitleEng.Text = item.MetaKeyword;
                            this.txtMetaTitleEng.Text = item.MetaKeyword;
                            this.txtH1Eng.Text = item.H1;
                            this.txtH2Eng.Text = item.H2;
                            this.txtH3Eng.Text = item.H3;
                            break;
                    }
                }
            }
        }

        /// <summary>
        /// BindCost
        /// </summary>
        private void BindCost()
        {
            drpCost.Items.Clear();
            drpCost.Items.Add(new ListItem(LocalizationUtility.GetText("strSelAItem"), string.Empty));
            string full;
            Type t = typeof(enuCostId);
            Array arr = Enum.GetValues(t);
            foreach (enuCostId enu in arr)
            {
                if (enu.ToString("d") != int.MinValue.ToString())
                {
                    full = string.Format("{0}_{1}", t.Name, enu.ToString());
                    drpCost.Items.Add(new ListItem(LocalizationUtility.GetText(full), enu.ToString("d")));
                }
            }
            drpCost.SelectedIndex = 1;
        }

        /// <summary>
        /// get data for insert update
        /// </summary>
        /// <param name="userObj"></param>
        /// <returns></returns>
        private PNK_Product GetDataObjectParent(PNK_Product productcatObj)
        {
            try
            {
                productcatObj.Published = chkPublished.Checked ? "1" : "0";
                productcatObj.Hot = chkPublishedHot.Checked ? "1" : "0";
                productcatObj.Feature = chkPublishedFeature.Checked ? "1" : "0";
                productcatObj.Price = chkProjectNew.Checked ? "1" : "0";

                //File upload
                //   productcatObj.Bathroom = fileUpload1.FileName;

                productcatObj.Cost = drpCost.SelectedValue;
                //productcatObj.District = drpDistrict.SelectedItem == null ? string.Empty : drpDistrict.SelectedItem.Text;
                productcatObj.Bedroom = txtBedRoom.Value;

                //productcatObj.Code = txtToDate.Text;
                productcatObj.Area = cboArea.SelectedItem.Text;

                //nguyên giá
                productcatObj.Website = txtWebsite.Text;
                //giá khuyến mãi
                productcatObj.Post = txtPost.Text;
                //Điểm đến
                productcatObj.Status = txtStatus.Value;

                productcatObj.Province = drpProvince.SelectedItem == null ? string.Empty : drpProvince.SelectedItem.Text;
                productcatObj.UpdateDate = DateTime.Now;
                productcatObj.CategoryId = DBConvert.ParseInt(drpCategory.SelectedValue);


                productcatObj.Longitude = txtLongitude.Value;//Kinh do   
                productcatObj.Latitude = txtLatitude.Value;
                productcatObj.Page = txtPage.Text.Trim();

                //update by
                if (Session[Global.SESS_USER] != null)
                {
                    PNK_User user = (PNK_User)Session[Global.SESS_USER];
                    productcatObj.UpdateBy = user.Username;
                }

                #region Get image

                HtmlControl txtFontName = block_baseimage.FindControl("txtFontName") as HtmlControl;
                productcatObj.ImageFont = string.IsNullOrEmpty(txtFontName.Attributes["value"]) == true ? string.Empty : txtFontName.Attributes["value"];

                HtmlControl rdImageFont = block_baseimage.FindControl("rdImageFont") as HtmlControl;
                if (rdImageFont != null && rdImageFont.Attributes["checked"] == "checked")
                    productcatObj.ImageType = DBConvert.ParseInt(rdImageFont.Attributes["value"]);
                else
                    productcatObj.ImageType = 1;

                HtmlControl hddImageName = block_baseimage.FindControl("hddImageName") as HtmlControl;
                if (hddImageName != null && hddImageName.Attributes["value"] != null)
                {
                    productcatObj.Image = hddImageName.Attributes["value"].ToString();
                }
                else
                {
                    productcatObj.Image = "";
                }

                #endregion

                HtmlControl hddNameFileUpload = block_uploadfile.FindControl("hddNameFileUpload") as HtmlControl;
                if (hddNameFileUpload != null && hddNameFileUpload.Attributes["value"] != null)
                {
                    productcatObj.Bathroom = hddNameFileUpload.Attributes["value"].ToString();
                }
                else
                {
                    productcatObj.Bathroom = "";
                }

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("GetDataObjectParent", "admin_editproduct", ex.Message);
            }

            return productcatObj;
        }

        /// <summary>
        /// get data child for insert update
        /// </summary>
        /// <param name="contdescObj"></param>
        /// <returns></returns>
        private PNK_ProductDesc GetDataObjectChild(PNK_ProductDesc productcatdescObj, int lang)
        {
            switch (lang)
            {
                case 1:
                    productcatdescObj.MainId = this.productcategoryId;
                    productcatdescObj.LangId = Constant.DB.LangId;
                    productcatdescObj.Title = SanitizeHtml.Sanitize(txtName.Value);
                    productcatdescObj.TitleUrl = Utils.RemoveUnicode(SanitizeHtml.Sanitize(txtName.Value));
                    productcatdescObj.Brief = txtIntro.Text;
                    productcatdescObj.Detail = txtDetailVi.Text;
                    productcatdescObj.Position = txtPositionVi.Text;
                    productcatdescObj.Utility = txtUtilityVi.Text;
                    productcatdescObj.Pictures = txtPicturesVi.Text;
                    productcatdescObj.Design = txtDesignVi.Text;
                    productcatdescObj.Payment = txtPaymentVi.Text;
                    productcatdescObj.Contact = txtContactVi.Text;
                    productcatdescObj.MetaTitle = txtMetaTitle.Text;
                    productcatdescObj.Metadescription = txtMetaDescription.Text;
                    productcatdescObj.MetaKeyword = txtMetaKeyword.Text;
                    productcatdescObj.H1 = txtH1.Text;
                    productcatdescObj.H2 = txtH2.Text;
                    productcatdescObj.H3 = txtH3.Text;
                    break;
                case 2:
                    productcatdescObj.MainId = this.productcategoryId;
                    productcatdescObj.LangId = Constant.DB.LangId_En;
                    string title = string.IsNullOrEmpty(txtNameEng.Value) ? SanitizeHtml.Sanitize(txtName.Value) : SanitizeHtml.Sanitize(txtNameEng.Value);
                    productcatdescObj.Title = title;
                    productcatdescObj.TitleUrl = Utils.RemoveUnicode(title);
                    productcatdescObj.Brief = string.IsNullOrEmpty(txtIntroEng.Text) ? txtIntro.Text : txtIntroEng.Text;
                    productcatdescObj.Detail = string.IsNullOrEmpty(txtDetailVi.Text) ? txtDetailVi.Text : txtDetailEng.Text;

                    productcatdescObj.Position = string.IsNullOrEmpty(txtPositionEng.Text) ? txtPositionVi.Text : txtPositionEng.Text;

                    productcatdescObj.Design = string.IsNullOrEmpty(txtDesignEng.Text) ? txtDesignVi.Text : txtDesignEng.Text;
                    productcatdescObj.Pictures = string.IsNullOrEmpty(txtPicturesEng.Text) ? txtPicturesVi.Text : txtPicturesEng.Text;
                    productcatdescObj.Payment = string.IsNullOrEmpty(txtPaymentEng.Text) ? txtPaymentVi.Text : txtPaymentEng.Text;
                    productcatdescObj.Contact = string.IsNullOrEmpty(txtContactEng.Text) ? txtContactVi.Text : txtContactEng.Text;

                    productcatdescObj.MetaTitle = string.IsNullOrEmpty(txtMetaTitleEng.Text) ? txtMetaTitle.Text : txtMetaTitleEng.Text;
                    productcatdescObj.Metadescription = string.IsNullOrEmpty(txtMetaDescriptionEng.Text) ? txtMetaDescription.Text : txtMetaDescriptionEng.Text;
                    productcatdescObj.MetaKeyword = string.IsNullOrEmpty(txtMetaKeywordEng.Text) ? txtMetaKeyword.Text : txtMetaKeywordEng.Text;
                    productcatdescObj.H1 = string.IsNullOrEmpty(txtH1Eng.Text) ? txtH1.Text : txtH1Eng.Text;
                    productcatdescObj.H2 = string.IsNullOrEmpty(txtH2Eng.Text) ? txtH2.Text : txtH2Eng.Text;
                    productcatdescObj.H3 = string.IsNullOrEmpty(txtH3Eng.Text) ? txtH3.Text : txtH3Eng.Text;
                    break;
            }
            return productcatdescObj;
        }

        /// <summary>
        /// Save location
        /// </summary>
        private void SaveProduct()
        {
            //Xoá cache trước khi lưu
            CacheHelper.ClearAll();

            PNK_Product productcatObj = new PNK_Product();
            PNK_ProductDesc productcatObjVn = new PNK_ProductDesc();
            PNK_ProductDesc productcatObjEn = new PNK_ProductDesc();
            if (this.productcategoryId == int.MinValue)
            {
                //get data insert
                productcatObj = this.GetDataObjectParent(productcatObj);
                productcatObj.PostDate = DateTime.Now;
                productcatObj.Ordering = genericBLL.getOrdering();
                productcatObjVn = this.GetDataObjectChild(productcatObjVn, Constant.DB.LangId);
                productcatObjEn = this.GetDataObjectChild(productcatObjEn, Constant.DB.LangId_En);

                List<PNK_ProductDesc> lst = new List<PNK_ProductDesc>();
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

                //get data update
                productcatObj = this.GetDataObjectParent(productcatObj);
                productcatObjVn = this.GetDataObjectChild(productcatObjVn, Constant.DB.LangId);
                productcatObjEn = this.GetDataObjectChild(productcatObjEn, Constant.DB.LangId_En);
                List<PNK_ProductDesc> lst = new List<PNK_ProductDesc>();
                lst.Add(productcatObjVn);
                lst.Add(productcatObjEn);
                //excute
                generic2CBLL.Update(productcatObj, lst, fields);
                //neu ve Published oo thay doi thi chay ham ChangeWithTransaction de doi Published cac con va cac product
                //if (publisheddOld != productcatObj.Published)
                //    PNK_Product.ChangeWithTransaction(DBConvert.ParseString(this.productcategoryId), productcatObj.Published);
            }

        }

        /// <summary>
        /// Delete Image In Folder
        /// </summary>
        private bool DeleteImage()
        {
            bool result = false;
            if (!string.IsNullOrEmpty(filenameUpload))
            {
                string f = Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["ProductUpload"]), filenameUpload);
                if (File.Exists(f))
                {
                    try
                    {
                        File.Delete(f);
                        filenameUpload = null;
                        SetVisibleImg(true, string.Empty);
                        result = true;
                    }
                    catch
                    {
                        result = false;
                    }
                }
                else
                {
                    filenameUpload = null;
                    SetVisibleImg(true, string.Empty);
                }
            }
            return result;
        }

        /// <summary>
        /// Delete image in folder and database
        /// </summary>
        /// <param name="cid"></param>
        private void DeleteProduct(string cid)
        {
            //Xoá cache trước khi lưu
            CacheHelper.ClearAll();

            string link, url;

            if (generic2CBLL.Delete(cid) && DeleteImage())
                link = LinkHelper.GetAdminLink("product", categoryId, "delete");
            else
                link = LinkHelper.GetAdminLink("product", categoryId, "delfail");
            url = Utils.CombineUrl(template_path, link);
            Response.Redirect(url);
        }

        /// <summary>
        /// Cancel content
        /// </summary>
        private void CancelProduct()
        {
            string url = LinkHelper.GetAdminLink("product");
            Response.Redirect(url);
        }

        /// <summary>
        /// getDataDropDownCategory
        /// </summary>
        /// <param name="_drp"></param>
        public static void GetDataDropDownCategory(DropDownList _drp)
        {
            int totalrow;
            string strTemp;
            _drp.Items.Clear();
            _drp.Items.Add(new ListItem(Constant.UI.admin_Category, Constant.DSC.IdRootProductCategory.ToString()));
            ProductCategoryBLL ncBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lst = ncBll.GetList(Constant.DB.LangId, string.Empty, 1, 300, out totalrow);
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_ProductCategory item in lst)
                {
                    strTemp = Utils.GetScmplit(item.ProductCategoryDesc.Name, item.PathTree);
                    _drp.Items.Add(new ListItem(strTemp, DBConvert.ParseString(item.Id)));
                }
            }
            //_drp.SelectedIndex = _drp.Items.IndexOf(_drp.Items.FindByValue(ConfigurationManager.AppSettings["parentIdLeture"]));
        }

        /// <summary>
        ///Hien thi o upload hinh anh( true: chua upload hinh) 
        /// </summary>
        /// <param name="isShowUplImg"></param>
        /// <param name="filename"></param>
        private void SetVisibleImg(bool isShowUplImg, string filename)
        {
            //if (isShowUplImg)
            //{
            //    fuImage.Visible = btnUploadImage.Visible = true;
            //    lbnView.Visible = lbnDelete.Visible = false;
            //}
            //else
            //{
            //    fuImage.Visible = btnUploadImage.Visible = false;
            //    //lbnView.Attributes["href"] = filename;
            //    lbnView.Visible = lbnDelete.Visible = true;
            //}
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(admin_txtnews), this.Page);
            btn_Delete.Attributes["onclick"] = string.Format("javascript:return confirm('{0}');", Constant.UI.admin_msg_confirm_delete_item);
            GetId();
            if (!IsPostBack)
            {
                InitPage();
                ShowProduct();
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
                SaveProduct();
                string url = LinkHelper.GetAdminMsgLink("product", categoryId, "save");
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
                SaveProduct();
                //string url = LinkHelper.GetAdminLink("edit_product", categoryId, productcategoryId.ToString());
                //Response.Redirect(url);
            }
        }

        /// <summary>
        /// btnDelete_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            DeleteProduct(DBConvert.ParseString(this.productcategoryId));
        }

        /// <summary>
        /// btnCancel_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            CancelProduct();
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