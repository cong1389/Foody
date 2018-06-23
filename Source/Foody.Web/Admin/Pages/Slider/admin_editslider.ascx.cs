using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Cb.DBUtility;
using Cb.Model;
using Cb.BLL;
using Cb.Localization;
using System.IO;
using System.Configuration;
using Cb.Utility;
using Cb.WebControls;

namespace Cb.Web.Admin.Pages.Slider
{
    public partial class admin_editslider : DGCUserControl
    {
        #region Parameter

        protected int productcategoryId = int.MinValue;
        protected string template_path;
        private BannerBLL pcBll;
        private Generic<PNK_Banner> genericBLL;
        private XMLConfigBLL xmlBll;

        #endregion

        #region Common

        private void ShowChkPage(string arrPage)
        {
            if (!string.IsNullOrEmpty(arrPage))
            {
                string[] arr = arrPage.Split(',');
                foreach (var item in arr)
                {
                    foreach (ListItem chk in chkPage.Items)
                    {
                        if (item == chk.Value)
                        {
                            chk.Selected = true;
                            break;
                        }
                    }
                }
            }
        }

        private void SaveChkPage(PNK_Banner obj)
        {
            string re = string.Empty;
            foreach (ListItem chk in chkPage.Items)
            {
                if (chk.Selected)
                {
                    re += string.Format("{0},", chk.Value);
                }
            }
            obj.ArrPageName = re.Length == 0 ? "tmp" : re.Remove(re.Length - 1);
        }

        private void BindPage()
        {
            xmlBll.getDataDropDownCategoryByAtt(chkPage, Constant.DSC.IdXmlPagePublish);
        }

        private void BindNewsCategory()
        {
            xmlBll.getDataDropDownCategory(drpCategory, Constant.DSC.IdXmlBannerPostion);
        }

        /// <summary>
        /// Init page
        /// </summary>
        private void InitPage()
        {
            txtName.EnterMode = txtDetail.EnterMode = EnterMode.DIV;
            txtName.Toolbar = txtDetail.Toolbar = "Basic";
            txtName.Toolbar = txtDetail.ToolbarBasic = "Source|Bold|Italic|Underline|Strike|-|Subscript|Superscript-|Styles|Format|Font|FontSize|TextColor|BGColor |";
            txtName.Height = txtDetail.Height = Unit.Pixel(100);
            txtName.FontDefaultLabel = txtDetail.FontDefaultLabel = "Arial";
          
            LocalizationUtility.SetValueControl(this);

            //this.ltrAminPublish.Text = Constant.UI.admin_publish;
            this.ltrAdminApply.Text = Constant.UI.admin_apply;
            this.ltrAdminCancel.Text = Constant.UI.admin_cancel;
            this.ltrAdminDelete.Text = Constant.UI.admin_delete;
            this.ltrAdminSave.Text = Constant.UI.admin_save;
            //this.ltrAminName.Text = Constant.UI.admin_name;
            this.ltrAminCategory.Text = Constant.UI.admin_Category;

            //load category
            BindNewsCategory();
            BindPage();

           
        }

        private void GetId()
        {
            #region Set thuoc tinh cho block_baseimage

            block_baseimage.ImagePath = ConfigurationManager.AppSettings["SliderUpload"];
            block_baseimage.MinWidth = ConfigurationManager.AppSettings["minwidthSlider"];
            block_baseimage.MinHeigh = ConfigurationManager.AppSettings["minheightSlider"];
            block_baseimage.MaxWidth = ConfigurationManager.AppSettings["maxwidthSlider"];
            block_baseimage.MaxHeight = ConfigurationManager.AppSettings["maxheightSlider"];
            block_baseimage.MaxWidthBox = ConfigurationManager.AppSettings["minwidthboxSlider"];
            block_baseimage.MaxHeightBox = ConfigurationManager.AppSettings["minheightboxSlider"];

            HtmlControl divImageFont = block_baseimage.FindControl("divImageFont") as HtmlControl;
            divImageFont.Style.Add("display", "none");
            HtmlControl divImage = block_baseimage.FindControl("divImage") as HtmlControl;
            divImage.Style.Add("display", "none");

            #endregion

            //get ID param 
            pcBll = new BannerBLL();
            genericBLL = new Generic<PNK_Banner>();
            xmlBll = new XMLConfigBLL();
            string strID = Utils.GetParameter("cid", string.Empty);
            this.productcategoryId = strID == string.Empty ? int.MinValue : DBConvert.ParseByte(strID);
            this.template_path = WebUtils.GetWebPath();
        }

        /// <summary>
        /// Show location
        /// </summary>
        private void ShowNewscategory()
        {
            if (this.productcategoryId != int.MinValue)
            {
                PNK_Banner productcatObj = new PNK_Banner();
                string[] fields = { "Id" };
                productcatObj.Id = this.productcategoryId;
                productcatObj = genericBLL.Load(productcatObj, fields);
                this.chkPublished.Checked = productcatObj.Published == "1" ? true : false;
                chkOutPage.Checked = productcatObj.OutPage == 1 ? true : false;
                this.drpCategory.SelectedValue = productcatObj.Position.ToString();
                block_baseimage.ImageName = productcatObj.Image;
                txtName.Text = productcatObj.Name;
                txtDetail.Text = productcatObj.Detail;
                txtLink.Text = productcatObj.LinkUrl;
                ShowChkPage(productcatObj.ArrPageName);
                txtButton1.Text = productcatObj.Button1;
                txtButton2.Text = productcatObj.Button2;
                txtButton3.Text = productcatObj.Button3;

                txtDataX.Text = productcatObj.DataX;
                txtDataY.Text = productcatObj.DataY;
                drpAlign.SelectedValue = productcatObj.Align.ToString();
            }
        }

        /// <summary>
        /// get data for insert update
        /// </summary>
        /// <param name="userObj"></param>
        /// <returns></returns>
        private PNK_Banner getDataObjectParent(PNK_Banner productcatObj)
        {
            productcatObj.Published = chkPublished.Checked ? "1" : "0";
            productcatObj.UpdateDate = DateTime.Now;
            productcatObj.Position = DBConvert.ParseByte(drpCategory.SelectedValue);
            productcatObj.Image = Session["ImageName"] != null ? Session["ImageName"].ToString() : block_baseimage.ImageName;
            productcatObj.Name = txtName.Text;
            productcatObj.Detail = txtDetail.Text;
            productcatObj.OutPage = chkOutPage.Checked ? 1 : 0;
            productcatObj.LinkUrl = txtLink.Text;
            productcatObj.Button1 = txtButton1.Text;
            productcatObj.Button2 = txtButton2.Text;
            productcatObj.Button3 = txtButton3.Text;

            productcatObj.DataX = txtDataX.Text;
            productcatObj.DataY = txtDataY.Text;
            productcatObj.Align = DBConvert.ParseInt(drpAlign.SelectedValue);
            SaveChkPage(productcatObj);

            return productcatObj;
        }

        /// <summary>
        /// Save location
        /// </summary>
        private void SaveNewsCategory()
        {
            PNK_Banner productcatObj = new PNK_Banner();
            if (this.productcategoryId == int.MinValue)
            {
                //get data insert
                productcatObj = this.getDataObjectParent(productcatObj);
                productcatObj.PostDate = DateTime.Now;
                productcatObj.Ordering = genericBLL.getOrdering();

                //excute
                this.productcategoryId = genericBLL.Insert(productcatObj);
            }
            else
            {
                string[] fields = { "Id" };
                productcatObj.Id = this.productcategoryId;
                productcatObj = genericBLL.Load(productcatObj, fields);
                string publisheddOld = productcatObj.Published;
                //get data update
                productcatObj = this.getDataObjectParent(productcatObj);
                //excute
                genericBLL.Update(productcatObj, productcatObj, fields);

            }

        }

        /// <summary>
        /// delete location
        /// </summary>
        /// <param name="cid"></param>
        private void deleteNewsCategory(string cid)
        {
            if (cid != null)
            {

                string link, url;

                if (genericBLL.Delete(cid))
                    link = LinkHelper.GetAdminMsgLink("slider", "delete");
                else
                    link = LinkHelper.GetAdminMsgLink("slider", "delfail");
                url = Utils.CombineUrl(template_path, link);
                Response.Redirect(url);

            }
        }

        /// <summary>
        /// Cancel content
        /// </summary>
        private void CancelNewsCategory()
        {
            string url = LinkHelper.GetAdminLink("slider");
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
                ShowNewscategory();
            }
        }

        /// <summary>
        /// btn_Save_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SaveNewsCategory();
                string url = LinkHelper.GetAdminMsgLink("slider", "save");
                Response.Redirect(url);
            }
        }

        /// <summary>
        /// btn_Apply_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnApply_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SaveNewsCategory();
                string url = LinkHelper.GetAdminLink("edit_slider", this.productcategoryId);
                Response.Redirect(url);
            }
        }

        /// <summary>
        /// btn_Delete_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            deleteNewsCategory(DBConvert.ParseString(this.productcategoryId));
        }

        /// <summary>
        /// btn_Cancel_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            CancelNewsCategory();
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

        #endregion
    }
}