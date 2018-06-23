// =============================================
// Author:		Congtt
// Create date: 22/09/2014
// Description:Edit	danh sach danh mục sản phẩm
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
using Cb.Model;
using Cb.BLL;
using Cb.Localization;
using Cb.Model.Products;
using Cb.BLL.Product;
using System.IO;
using Cb.Utility;
using Cb.BLL.Attribute;

namespace Cb.Web.Admin.Pages.ProductCategory
{
    public partial class admin_editproductcategory : DGCUserControl
    {
        #region Parameter

        private ProductCategoryBLL pcBll;
        private Generic<PNK_ProductCategory> genericBLL;
        private Generic<PNK_ProductCategoryDesc> genericDescBLL;
        private Generic2C<PNK_ProductCategory, PNK_ProductCategoryDesc> generic2CBLL;

        protected int productcategoryId = int.MinValue, total = int.MinValue;
        protected string template_path;

        private string attributeId
        {
            get
            {
                if (ViewState["attributeId"] != null)
                    return ViewState["attributeId"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["attributeId"] = value;
            }
        }

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

        protected void check_changed(object sender, TreeNodeEventArgs e)
        {
            ViewState["attributeId"] = ViewState["attributeId"] + e.Node.Value + ",";
            System.Diagnostics.Debugger.Break();
        }

        /// <summary>
        /// Init page
        /// </summary>
        private void InitPage()
        {
            // Add the onclick event handler so checking a parent node fires the OnTreeNodeCheckChanged event.
            TreeView1.Attributes.Add("onclick", "TreeNodeCheckChanged(event, this)");

            LocalizationUtility.SetValueControl(this);
            this.ltrAdminApply.Text = Constant.UI.admin_apply;
            this.ltrAdminCancel.Text = Constant.UI.admin_cancel;
            this.ltrAdminDelete.Text = Constant.UI.admin_delete;
            this.ltrAdminSave.Text = Constant.UI.admin_save;

            ltrPage.Text = LocalizationUtility.GetText(ltrPage.ID, Ci);
            ltrPageDetail.Text = LocalizationUtility.GetText(ltrPageDetail.ID);
            ltrAminCategory.Text = LocalizationUtility.GetText(ltrAminCategory.ID);
            //this.ltrAminName.Text = Constant.UI.admin_name;
            this.ltrAminLangVi.Text = Constant.UI.admin_lang_Vi;
            this.ltrAminLangEn.Text = Constant.UI.admin_lang_En;
            //this.ltrAminName_En.Text = Constant.UI.admin_name_en;

            reqv_txtNameVi.Text = Constant.UI.alert_empty_name_outsite;
            reqv_txtNameVi.ErrorMessage = Constant.UI.alert_empty_name;

            //Kiểm tra quyền
            SetRoleMenu();

            //load category
            GetDataDropDownCategory(this.drpCategory);

            //Get Attribute 
            GetAttribute();

            //Bind Page
            XMLConfigBLL xmlBll = new XMLConfigBLL();
            xmlBll.getDataDropDownPage(drpPage, Constant.DSC.IdXmlPagePublish);
            drpPage.SelectedIndex = 1;
            xmlBll.getDataDropDownPage(drpPageDetail, Constant.DSC.IdXmlPagePublish);
            drpPageDetail.SelectedIndex = 2;
        }

        /// <summary>
        /// Phân quyền tài khoản Congtt full quyền, những tk còn lại k có quyền xóa và edit
        /// </summary>
        private void SetRoleMenu()
        {
            PNK_User lst_user = (PNK_User)Session[Global.SESS_USER];
            //if (lst_user.Username != "congtt")
            //    trPage.Attributes.Add("class","hidden");
        }

        /// <summary>
        /// Show newscategory
        /// </summary>
        private void ShowProductcategory()
        {
            if (this.productcategoryId != int.MinValue)
            {
                PNK_ProductCategory productcatObj = new PNK_ProductCategory();
                string[] fields = { "Id" };
                productcatObj.Id = this.productcategoryId;
                productcatObj = generic2CBLL.Load(productcatObj, fields, Constant.DB.LangId);
                chkPublished.Checked = productcatObj.Published == "1" ? true : false;
                chkMenuFooter.Checked = productcatObj.SmallImage == "1" ? true : false;
                txtOrder.Value = productcatObj.Ordering.ToString();
                drpCategory.SelectedValue = productcatObj.ParentId.ToString();
                //block_baseimage.ImageName = productcatObj.BaseImage;

                #region Set Attribute

                string[] arr = productcatObj.ThumbnailImage.ToString().Split(',');
                for (int i = 0; i < arr.Count(); i++)
                {
                    foreach (TreeNode node in TreeView1.Nodes)
                    {
                        if (node.Value == arr[i])
                        {
                            node.Checked = true;
                        }
                        CheckTreeNodeRecursive(node, arr);
                        //foreach (TreeNode nodeChild in node.ChildNodes)
                        //{
                        //    if (nodeChild.Value == arr[i])
                        //    {
                        //        nodeChild.Checked = true;
                        //    }
                        //}

                    }
                }


                #endregion

                #region Set image

                block_baseimage.ImageName = productcatObj.BaseImage;

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

                #endregion

                drpPage.SelectedValue = productcatObj.Page;
                drpPageDetail.SelectedValue = productcatObj.PageDetail;

                IList<PNK_ProductCategoryDesc> lst = genericDescBLL.GetAllBy(new PNK_ProductCategoryDesc(), string.Format(" where mainid = {0}", this.productcategoryId), null);
                foreach (PNK_ProductCategoryDesc item in lst)
                {
                    switch (item.LangId)
                    {
                        case 1:
                            txtName.Value = item.Name;
                            txtIntro.Text = item.Brief;
                            txtMetaTitle.Text = item.MetaTitle;
                            txtMetaKeyword.Text = item.MetaKeyword;
                            txtMetaDescription.Text = item.MetaDecription;
                            txtH1.Text = item.H1;
                            txtH2.Text = item.H2;
                            txtH3.Text = item.H3;
                            txtDetail.Text = item.Detail;
                            break;
                        case 2:
                            txtNameEng.Value = item.Name;
                            txtIntroEng.Text = item.Brief;
                            txtMetaTitleEng.Text = item.MetaTitle;
                            txtMetaKeywordEng.Text = item.MetaKeyword;
                            txtMetaDescriptionEng.Text = item.MetaDecription;
                            txtH1Eng.Text = item.H1;
                            txtH2Eng.Text = item.H2;
                            txtH3Eng.Text = item.H3;
                            txtDetailEng.Text = item.Detail;
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
        private PNK_ProductCategory GetDataObjectParent(PNK_ProductCategory productcatObj)
        {
            try
            {
                productcatObj.Published = chkPublished.Checked ? "1" : "0";
                productcatObj.Ordering = DBConvert.ParseInt(txtOrder.Value);
                productcatObj.UpdateDate = DateTime.Now;
                productcatObj.ParentId = DBConvert.ParseInt(drpCategory.SelectedValue);
                productcatObj.SmallImage = chkMenuFooter.Checked ? "1" : "0";
                productcatObj.ThumbnailImage = ViewState["attributeId"] == null ? string.Empty : ViewState["attributeId"].ToString();
                productcatObj.Page = drpPage.SelectedValue;
                productcatObj.PageDetail = drpPageDetail.SelectedValue;

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
                    productcatObj.BaseImage = hddImageName.Attributes["value"].ToString();
                }
                else
                {
                    productcatObj.BaseImage = "";
                }

                #endregion
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("GetDataObjectParent", "admin_editproductcategory", ex.Message);
            }
            return productcatObj;
        }

        /// <summary>
        /// get data child for insert update
        /// </summary>
        /// <param name="contdescObj"></param>
        /// <returns></returns>
        private PNK_ProductCategoryDesc GetDataObjectChild(PNK_ProductCategoryDesc productcatdescObj, int lang)
        {
            switch (lang)
            {
                case 1:
                    productcatdescObj.MainId = this.productcategoryId;
                    productcatdescObj.LangId = Constant.DB.LangId;
                    productcatdescObj.Name = SanitizeHtml.Sanitize(txtName.Value);
                    productcatdescObj.NameUrl = Utils.RemoveUnicode(SanitizeHtml.Sanitize(txtName.Value));
                    productcatdescObj.Brief = SanitizeHtml.Sanitize(txtIntro.Text);
                    productcatdescObj.MetaTitle = txtMetaTitle.Text.Trim();
                    productcatdescObj.MetaKeyword = txtMetaKeyword.Text.Trim();
                    productcatdescObj.MetaDecription = txtMetaDescription.Text.Trim();
                    productcatdescObj.H1 = txtH1.Text.Trim();
                    productcatdescObj.H2 = txtH2.Text.Trim();
                    productcatdescObj.H3 = txtH3.Text.Trim();
                    productcatdescObj.Detail = SanitizeHtml.Sanitize(txtDetail.Text);

                    break;
                case 2:
                    productcatdescObj.MainId = this.productcategoryId;
                    productcatdescObj.LangId = Constant.DB.LangId_En;
                    string name = !string.IsNullOrEmpty(txtNameEng.Value) ? SanitizeHtml.Sanitize(txtNameEng.Value) : SanitizeHtml.Sanitize(txtName.Value);
                    productcatdescObj.Name = name;
                    productcatdescObj.NameUrl = Utils.RemoveUnicode(SanitizeHtml.Sanitize(name));
                    productcatdescObj.Brief = SanitizeHtml.Sanitize(txtIntroEng.Text);
                    productcatdescObj.MetaTitle = txtMetaTitleEng.Text.Trim();
                    productcatdescObj.MetaKeyword = txtMetaKeywordEng.Text.Trim();
                    productcatdescObj.MetaDecription = txtMetaDescriptionEng.Text.Trim();
                    productcatdescObj.H1 = txtH1Eng.Text.Trim();
                    productcatdescObj.H2 = txtH2Eng.Text.Trim();
                    productcatdescObj.H3 = txtH3Eng.Text.Trim();
                    productcatdescObj.Detail = SanitizeHtml.Sanitize(txtDetailEng.Text);

                    break;
            }
            return productcatdescObj;
        }

        /// <summary>
        /// Save newscategory
        /// </summary>
        private void SaveProduct()
        {
            TreeNodeCollection nodes = TreeView1.Nodes;
            foreach (TreeNode n in nodes)
            {
                GetNodeRecursive(n);
            }

            //Xoá cache trước khi lưu
            CacheHelper.ClearContains("Product");

            PNK_ProductCategory productcatObj = new PNK_ProductCategory();
            PNK_ProductCategoryDesc productcatObjVn = new PNK_ProductCategoryDesc();
            PNK_ProductCategoryDesc productcatObjEn = new PNK_ProductCategoryDesc();

            if (this.productcategoryId == int.MinValue)
            {
                //get data insert
                productcatObj = this.GetDataObjectParent(productcatObj);
                productcatObj.PostDate = DateTime.Now;
                productcatObj.PathTree = "1";
                productcatObjVn = this.GetDataObjectChild(productcatObjVn, Constant.DB.LangId);
                productcatObjEn = this.GetDataObjectChild(productcatObjEn, Constant.DB.LangId_En);

                List<PNK_ProductCategoryDesc> lst = new List<PNK_ProductCategoryDesc>();
                lst.Add(productcatObjVn);
                lst.Add(productcatObjEn);

                //excute
                this.productcategoryId = generic2CBLL.Insert(productcatObj, lst);

                //update pathtree sau khi insert
                DGCParameter[] param = new DGCParameter[2];
                param[0] = new DGCParameter("@parentId", DbType.Int32, productcatObj.ParentId);
                param[1] = new DGCParameter("@productCategoryId", DbType.Int32, productcategoryId);
                DBHelper.ExcuteFromStoreNonQuery("ProductCategory_UpdatePathTree", param);
            }
            else
            {
                string[] fields = { "Id" };
                productcatObj.Id = this.productcategoryId;
                productcatObj = genericBLL.Load(productcatObj, fields);
                string publisheddOld = productcatObj.Published;
                //get data update
                productcatObj = this.GetDataObjectParent(productcatObj);
                productcatObjVn = this.GetDataObjectChild(productcatObjVn, Constant.DB.LangId);
                productcatObjEn = this.GetDataObjectChild(productcatObjEn, Constant.DB.LangId_En);
                List<PNK_ProductCategoryDesc> lst = new List<PNK_ProductCategoryDesc>();
                lst.Add(productcatObjVn);
                lst.Add(productcatObjEn);

                //excute
                generic2CBLL.Update(productcatObj, lst, fields);

                //update pathtree sau khi edit
                DGCParameter[] param = new DGCParameter[2];
                param[0] = new DGCParameter("@parentId", DbType.Int32, productcatObj.ParentId);
                param[1] = new DGCParameter("@productCategoryId", DbType.Int32, productcategoryId);
                DBHelper.ExcuteFromStoreNonQuery("ProductCategory_UpdatePathTree", param);

                //update tất cả Page của danh mục con sau khi edit
                param = new DGCParameter[2];
                param[0] = new DGCParameter("@productCategoryId", DbType.Int32, productcategoryId);
                param[1] = new DGCParameter("@page", DbType.String, productcatObj.PageDetail);
                DBHelper.ExcuteFromStoreNonQuery("Product_UpdatePage", param);
            }
        }

        /// <summary>
        /// delete newscategory
        /// </summary>
        /// <param name="cid"></param>
        private void DeleteProduct(string cid)
        {
            if (cid != null)
            {
                //IList<PNK_ProductCategory> lst = pcBll.GetAllChild(DBConvert.ParseInt(cid), false);

                //if (lst != null && lst.Count > 0)
                //{
                //    string script = string.Format("alert('{0}')", Constant.UI.alert_invalid_delete_productcategory_exist_child);
                //    ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), script, true);
                //}
                //else
                //{
                string link, url;

                if (generic2CBLL.Delete(cid))
                    link = LinkHelper.GetAdminLink("productcategory", "delete");//string.Format(SiteNavigation.link_adminPage_productcategory_msg, "delete");
                else
                    link = LinkHelper.GetAdminLink("productcategory", "delfail");
                url = Utils.CombineUrl(template_path, link);
                Response.Redirect(url);
                //}
            }
        }

        /// <summary>
        /// Cancel content
        /// </summary>
        private void CancelProductCategory()
        {
            string url = LinkHelper.GetAdminLink("productcategory");
            Response.Redirect(url);
        }

        /// <summary>
        /// getDataDropDownCategory
        /// </summary>
        /// <param name="_drp"></param>
        private void GetDataDropDownCategory(DropDownList _drp)
        {
            int total;
            string strTemp;
            _drp.Items.Clear();
            _drp.Items.Add(new ListItem(Constant.UI.admin_Category, Constant.DSC.IdRootProductCategory.ToString()));
            IList<PNK_ProductCategory> lst = pcBll.GetList(Constant.DB.LangId, string.Empty, 1, 300, out total);
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_ProductCategory item in lst)
                {
                    strTemp = Utils.GetScmplit(item.ProductCategoryDesc.Name, item.PathTree);
                    _drp.Items.Add(new ListItem(strTemp, DBConvert.ParseString(item.Id)));
                }
            }
        }

        private void GetId()
        {
            #region Set thuoc tinh cho block_baseimage

            block_baseimage.ImagePath = ConfigurationManager.AppSettings["ProductCategoryUpload"];
            block_baseimage.MinWidth = ConfigurationManager.AppSettings["minWidthCategory"];
            block_baseimage.MinHeigh = ConfigurationManager.AppSettings["minHeightCategory"];
            block_baseimage.MaxWidth = ConfigurationManager.AppSettings["maxWidthCategory"];
            block_baseimage.MaxHeight = ConfigurationManager.AppSettings["maxHeightCategory"];
            block_baseimage.MaxWidthBox = ConfigurationManager.AppSettings["maxWidthBoxCategory"];
            block_baseimage.MaxHeightBox = ConfigurationManager.AppSettings["maxHeightBoxCategory"];

            #endregion

            //get ID param 
            pcBll = new ProductCategoryBLL();
            genericBLL = new Generic<PNK_ProductCategory>();
            generic2CBLL = new Generic2C<PNK_ProductCategory, PNK_ProductCategoryDesc>();
            genericDescBLL = new Generic<PNK_ProductCategoryDesc>();
            string strID = Utils.GetParameter("cid", string.Empty);
            this.productcategoryId = strID == string.Empty ? int.MinValue : DBConvert.ParseInt(strID);
            this.template_path = WebUtils.GetWebPath();

            //Set default value order
            if (productcategoryId == int.MinValue) txtOrder.Value = genericBLL.getOrdering().ToString();
        }

        private void GetNodeRecursive(TreeNode treeNode)
        {
            if (treeNode.Checked == true)
            {
                ViewState["attributeId"] = ViewState["attributeId"] + treeNode.Value + ",";
            }
            foreach (TreeNode tn in treeNode.ChildNodes)
            {
                GetNodeRecursive(tn);
            }

        }

        private void CheckTreeNodeRecursive(TreeNode parent, string[] arr)
        {
            foreach (TreeNode child in parent.ChildNodes)
            {
                for (int i = 0; i < arr.Count(); i++)
                {
                    if (child.Value == arr[i])
                    {
                        child.Checked = true;
                    }
                }
                if (child.ChildNodes.Count > 0)
                {
                    CheckTreeNodeRecursive(child, arr);
                }
            }
        }

        private void GetAttribute()
        {
            AttributeBLL pcBll = new AttributeBLL();
            IList<PNK_Attribute> lstAll = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, int.MinValue, string.Empty, 1, true, string.Empty, 1, 9999, out total);
            IList<PNK_Attribute> lst = lstAll.Where(m => m.ParentId == 0).ToList();
            PopulateTreeView(lstAll, lst, 0, null);
        }

        private void PopulateTreeView(IList<PNK_Attribute> lstAll, IList<PNK_Attribute> lst, int parentId, TreeNode treeNode)
        {
            foreach (PNK_Attribute row in lst)
            {

                if (parentId == 0)
                {
                    TreeNode child = new TreeNode
                    {
                        Text = row.AttributeDesc.Name,
                        Value = row.Id.ToString()
                    };

                    TreeView1.Nodes.Add(child);
                    IList<PNK_Attribute> lstChild = lstAll.Where(m => m.ParentId.ToString() == child.Value).ToList();
                    PopulateTreeView(lstAll, lstChild, int.Parse(child.Value), child);
                }
                else
                {
                    TreeNode child = new TreeNode
                    {
                        Text = row.AttributeDesc.Name,
                        Value = row.Id.ToString()
                    };
                    treeNode.ChildNodes.Add(child);
                }
            }
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
                SaveProduct();
                string url = LinkHelper.GetAdminLink("productcategory");
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
                string url = LinkHelper.GetAdminLink("edit_productcategory", this.productcategoryId);
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
            DeleteProduct(DBConvert.ParseString(this.productcategoryId));
        }

        /// <summary>
        /// btnCancel_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            CancelProductCategory();
        }

        private bool CheckParentIsThisOrChild()
        {
            IList<PNK_ProductCategory> lst = pcBll.GetAllChild(productcategoryId, true);
            if (lst != null && lst.Count > 0)
                foreach (PNK_ProductCategory item in lst)
                {
                    if (item.Id == DBConvert.ParseInt(drpCategory.SelectedValue))
                        return true;
                }
            return false;
        }

        private void Alert(string alert)
        {
            string script = string.Format("alert('{0}')", alert);
            ScriptManager.RegisterStartupScript(this, GetType(), "alertproductcategory", script, true);
        }

        protected void csv_drpCategory_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !CheckParentIsThisOrChild();
            if (!args.IsValid)
                Alert(Constant.UI.alert_invalid_parent_productcategory);
        }

        #endregion
    }
}