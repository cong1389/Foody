// =============================================
// Author:		Congtt
// Create date: 22/09/2014
// Description:	danh sach danh mục sản phẩm
// =============================================

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Cb.Model;
using Cb.DBUtility;
using Cb.BLL;
using Cb.Localization;
using Cb.Model.Products;
using Cb.BLL.Product;
using System.Configuration;
using Cb.Utility;

namespace Cb.Web.Admin.Pages.ProductCategory
{
    public partial class admin_productcategory : DGCUserControl
    {
        #region Parammter

        const int pageSize = 9000;

        private ProductCategoryBLL pcBll
        {
            get
            {
                if (ViewState["pcBll"] != null)
                    return (ProductCategoryBLL)ViewState["pcBll"];
                else return new ProductCategoryBLL();
            }
            set
            {
                ViewState["pcBll"] = value;
            }
        }
        private Generic<PNK_ProductCategory> genericBLL
        {
            get
            {
                if (ViewState["genericBLL"] != null)
                    return (Generic<PNK_ProductCategory>)ViewState["genericBLL"];
                else return new Generic<PNK_ProductCategory>();
            }
            set
            {
                ViewState["genericBLL"] = value;
            }
        }
        private Generic2C<PNK_ProductCategory, PNK_ProductCategoryDesc> generic2CBLL
        {
            get
            {
                if (ViewState["generic2CBLL"] != null)
                    return (Generic2C<PNK_ProductCategory, PNK_ProductCategoryDesc>)ViewState["generic2CBLL"];
                else return new Generic2C<PNK_ProductCategory, PNK_ProductCategoryDesc>();
            }
            set
            {
                ViewState["generic2CBLL"] = value;
            }
        }

        protected string template_path
        {
            get
            {
                if (ViewState["template_path"] != null)
                    return ViewState["template_path"].ToString();
                return string.Empty;
            }
            set
            {
                ViewState["template_path"] = value;
            }
        }
        protected string show_msg;
        protected string l_search;
        protected string records;
        protected string msg_no_selected_item;
        protected string msg_confirm_delete_item;
        private string action;

        #region Viewstate

        protected int currentPageIndex
        {
            get
            {
                if (ViewState["CurrentPageIndex"] != null)
                    return int.Parse(ViewState["CurrentPageIndex"].ToString());
                else
                    return 1;
            }
            set
            {
                ViewState["CurrentPageIndex"] = value;
            }
        }

        #endregion

        #endregion

        #region Common

        /// <summary>
        /// Init page
        /// </summary>
        private void InitPage()
        {
            pcBll = new ProductCategoryBLL();
            genericBLL = new Generic<PNK_ProductCategory>();
            generic2CBLL = new Generic2C<PNK_ProductCategory, PNK_ProductCategoryDesc>();
            this.template_path = WebUtils.GetWebPath();
            LocalizationUtility.SetValueControl(this);
            msg_confirm_delete_item = LocalizationUtility.GetText("mesConfirmDelete");
            msg_no_selected_item = LocalizationUtility.GetText("mesSelectItem");
            GetMessage();
            SetRoleMenu();
        }

        /// <summary>
        /// Phân quyền tài khoản Congtt full quyền, những tk còn lại k có quyền xóa và Edit
        /// </summary>
        private void SetRoleMenu()
        {
            PNK_User lst_user = (PNK_User)Session[Global.SESS_USER];
            //if (lst_user.Username != "congtt")
            //    tdEdit.Visible = tdDelete.Visible = false;
        }

        /// <summary>
        /// GetList
        /// </summary>
        /// <param name="begin"></param>
        /// <param name="end"></param>
        /// <returns></returns>
        private int GetList(byte langid, string content, int begin, int end)
        {
            int total;
            IList<PNK_ProductCategory> lst = pcBll.GetListTree(langid, content, null, int.MinValue, string.Empty,string.Empty, 1, true, string.Empty, begin, end, out total);
            //IList<PNK_ProductCategory> lst = pcBll.GetList(langid, content, null, int.MinValue, false, begin, end, out  total);

            this.records = DBConvert.ParseString(lst.Count);
            this.pager.PageSize = pageSize;
            this.pager.ItemCount = total;
            this.rptResult.DataSource = lst;
            this.rptResult.DataBind();
            return total;
        }

        /// <summary>
        /// action
        /// </summary>
        private void GetAction()
        {
            this.action = Request.Form["task"];
            string cid = Request.Form["cid[]"];
            switch (action)
            {
                case "new":
                    Add();
                    break;
                case "edit":
                    Edit(cid);
                    break;
                case "publish":
                    Change(cid, "1");
                    break;
                case "unpublish":
                    Change(cid, "0");
                    break;
                case "delete":
                    Delete(cid);
                    break;
                case "save":
                    SaveOrder();
                    string url = LinkHelper.GetAdminLink("productcategory");
                    Response.Redirect(url);
                    break;
                case "search":
                    pager.CurrentIndex = 1;
                    this.currentPageIndex = 1;
                    Search();
                    break;
                //default:
                //    show();
                //    break;
            }
        }

        private void Add()
        {
            string url = LinkHelper.GetAdminLink("edit_productcategory");
            Response.Redirect(url);
        }

        private void Edit(string cid)
        {
            if (cid == null) return;
            string link, url;
            string[] arrStr;
            if (cid.IndexOf(',') >= 0)
            {
                arrStr = cid.Split(',');
                link = LinkHelper.GetAdminLink("edit_productcategory", arrStr[0]);
                //link = string.Format(SiteNavigation.link_adminPage_editproductcategory, arrStr[0]);
            }
            else
                link = LinkHelper.GetAdminLink("edit_productcategory", cid);
            Response.Redirect(link);
        }

        /// <summary>
        /// change
        /// </summary>
        /// <param name="cid"></param>
        /// <param name="state"></param>
        private void Change(string cid, string state)
        {
            if (cid != null)
            {
                //Xoá cache trước khi lưu
                CacheHelper.ClearAll();

                genericBLL.ChangeWithTransaction(cid, state);
                Search();
            }
        }

        /// <summary>
        /// delete
        /// </summary>
        private void Delete(string cid)
        {
            if (cid != null)
            {
                //các category con của nó
                IList<PNK_ProductCategory> lst = pcBll.GetAllChild(DBConvert.ParseInt(cid), false);

                if (lst != null && lst.Count > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('{0}','Message');", Constant.UI.alert_invalid_delete_productcategory_exist_child), true);

                    //string script = string.Format("alert('{0}')", Constant.UI.alert_invalid_delete_productcategory_exist_child);
                    //ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), script, true);
                }
                else
                {
                    //Xoá cache trước khi lưu
                    CacheHelper.ClearAll();

                    string link, url;

                    if (generic2CBLL.Delete(cid))
                        link = LinkHelper.GetAdminMsgLink("productcategory", "delete");
                    else
                        link = LinkHelper.GetAdminMsgLink("productcategory", "delfail");
                    url = Utils.CombineUrl(template_path, link);
                    Response.Redirect(url);
                }
            }
        }

        /// <summary>
        /// saveOrder
        /// </summary>
        private void SaveOrder()
        {
            //Xoá cache trước khi lưu
            CacheHelper.ClearAll();

            foreach (RepeaterItem item in rptResult.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    HtmlInputButton btId = (HtmlInputButton)item.FindControl("btId");
                    PNK_ProductCategory productCat = new PNK_ProductCategory();
                    productCat.Id = DBConvert.ParseInt(btId.Value);
                    productCat = genericBLL.Load(productCat, new string[] { "Id" });
                    HtmlInputText txtOrder = (HtmlInputText)item.FindControl("txtOrder");
                    if (txtOrder != null)
                    {
                        try
                        {
                            productCat.Ordering = DBConvert.ParseInt(txtOrder.Value);
                            if (productCat.Ordering > 0)
                            {
                                genericBLL.Update(productCat, productCat, new string[] { "Id" });
                            }
                        }
                        catch { }
                    }
                }
            }
        }

        /// <summary>
        /// get msg
        /// </summary>
        private void GetMessage()
        {
            string msg = Utils.GetParameter("msg", string.Empty);
            if (msg == string.Empty) return;
            if (msg == "save")
            {
                this.show_msg = string.Format("<div id=\"Cb-msg\"><div class=\"message\">{0}</div></div>", Constant.UI.admin_msg_save_success);
            }
            else if (msg == "delete")
            {
                this.show_msg = string.Format("<div id=\"Cb-msg\"><div class=\"message\">{0}</div></div>", Constant.UI.admin_msg_delete_success);
            }
        }

        private void Search()
        {
            //Xoá cache trước khi lưu
            CacheHelper.ClearAll();

            string strSearch = Request.Form[search.ClientID.Replace('_', '$')];
            this.search.Value = strSearch;
            strSearch = strSearch == null ? string.Empty : Utils.RemoveUnicode(SanitizeHtml.Sanitize(strSearch)).ToLower();
            GetList(1, strSearch, 1, pageSize);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveOrder();
            string url = Utils.CombineUrl(template_path, LinkHelper.GetAdminLink("productcategory"));
            Response.Redirect(url);
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            GetAction();
            if (!IsPostBack)
            {
                InitializeComponent();
                Search();
            }
        }

        /// <summary>
        /// init component
        /// </summary>
        override protected void OnInit(EventArgs e)
        {
            //InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            InitPage();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Search();
        }

        /// <summary>
        /// ItemDataBound
        /// </summary>
        protected void rptResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string img, alt, publishedTask;
                HtmlTableRow tr = (HtmlTableRow)e.Item.FindControl("trList");
                HtmlInputText txt = null;
                if (e.Item.ItemIndex % 2 == 0)
                {
                    tr.Attributes.Add("class", "even");
                }
                else
                {
                    tr.Attributes.Add("class", "old");
                }

                try
                {
                    PNK_ProductCategory data = (PNK_ProductCategory)e.Item.DataItem;

                    //Role
                    Literal ltr = null;
                    ltr = (Literal)e.Item.FindControl("ltrchk");
                    ltr.Text = string.Format(@"<INPUT class='txt' TYPE='checkbox' ID='cb{0}' NAME='cid[]' value='{1}' onclick='isChecked(this.checked);' >",
                                                e.Item.ItemIndex, data.Id);

                    //Check
                    if (data.Published == "1")
                    {
                        img = "tick.png";
                        alt = LocalizationUtility.GetText(ltrAdminPublish.Text);
                        publishedTask = "unpublish";
                    }
                    else
                    {
                        img = "publish_x.png";
                        alt = LocalizationUtility.GetText(ltrAminUnPublish.Text);
                        publishedTask = "publish";
                    }

                    //Order
                    txt = (HtmlInputText)e.Item.FindControl("txtOrder");
                    txt.Value = DBConvert.ParseString(data.Ordering);

                    //Id
                    HtmlInputButton btId = (HtmlInputButton)e.Item.FindControl("btId");
                    btId.Value = DBConvert.ParseString(data.Id);

                    //Base img
                    HtmlImage baseImage = (HtmlImage)e.Item.FindControl("baseImage");
                    baseImage.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductCategoryUpload"], data.BaseImage);
                    HtmlAnchor hypBaseImage = (HtmlAnchor)e.Item.FindControl("hypBaseImage");

                    //set link
                    HyperLink hdflink = new HyperLink();
                    hdflink = (HyperLink)e.Item.FindControl("hdflink");
                    hypBaseImage.HRef = hdflink.NavigateUrl = template_path + LinkHelper.GetAdminLink("edit_productcategory", data.Id);

                    //HtmlTableCell td = (HtmlTableCell)e.Item.FindControl("tdName");
                    //td.Attributes.Add("onclick", string.Format("listItemTask('cb{0}', 'Edit')", e.Item.ItemIndex));
                    //td = (HtmlTableCell)e.Item.FindControl("trUpdateDate");
                    //td.Attributes.Add("onclick", string.Format("listItemTask('cb{0}', 'Edit')", e.Item.ItemIndex));
                    ImageButton imgctr = (ImageButton)e.Item.FindControl("btnPublish");
                    imgctr.ImageUrl = string.Format("/Admin/images/{0}", img);
                    imgctr.Attributes.Add("alt", alt);
                    HtmlTableCell btn = (HtmlTableCell)e.Item.FindControl("tdbtn");
                    btn.Attributes.Add("onclick", string.Format(" return listItemTask('cb{0}', '{1}')", e.Item.ItemIndex, publishedTask));

                    //Name
                    ltr = (Literal)e.Item.FindControl("ltrName");
                    hypBaseImage.Attributes["title"] = baseImage.Alt = baseImage.Attributes["title"] = ltr.Text = data.ProductCategoryDesc.TreeNameDesc;
                    // Utils.GetScmplitBySpace(data.ProductCategoryDesc.Name, data.PathTree);
                    //Server.HtmlDecode(getScmplit(data.Lvl) + "&bull; | " + data.Lvl + " | " + data.ProductCategoryDesc.Name);    

                }
                catch { }

            }
        }

        /// <summary>
        /// Pager
        /// <summary>
        public void pager_Command(object sender, CommandEventArgs e)
        {
            this.currentPageIndex = Convert.ToInt32(e.CommandArgument);
            pager.CurrentIndex = this.currentPageIndex;
            this.GetList(1, string.Empty, this.currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["PageSizeAdminCate"]));
        }

        #endregion
    }
}