using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Cb.Web.Common;
using Cb.Localization;


namespace Cb.Web.Pages.ServiceManagement
{
    public partial class Service : DGCUserControl
    {
        #region Parameter

        protected string template_path, pageName, cid, cidsub, id, records, hot = string.Empty, feature = string.Empty, categoryID = string.Empty;
        int total;

        int totalSearch;
        public int TotalSearch { get; set; }

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

        IList<PNK_Product> _lstSearch;
        public IList<PNK_Product> lstSearch { set; get; }

        #endregion

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            cidsub = Utils.GetParameter("cidsub", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            GetProduct();

        }

        private void GetProduct()
        {
            try
            {
                string categoryID = null;
                categoryID = GetProductCategory();

                ProductBLL pcBll = new ProductBLL();
                IList<PNK_Product> lst = null;
                if (cidsub != string.Empty && cid != string.Empty)
                {
                    lst = pcBll.GetList(LangInt, cidsub, "1", string.Empty, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);
                }
                else if (cidsub == string.Empty && cid != string.Empty && categoryID != string.Empty)
                {
                    DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + categoryID + ",1)", null);
                    string[] array = dtb.AsEnumerable()
                                        .Select(row => row.Field<Int32>("id").ToString())
                                        .ToArray();
                    string idFirst = string.Join(",", array);
                    lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);

                }
                else if (cid == string.Empty && categoryID != string.Empty)
                {
                    DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + categoryID + ",1)", null);
                    string[] array = dtb.AsEnumerable()
                                        .Select(row => row.Field<Int32>("id").ToString())
                                        .ToArray();
                    string idFirst = string.Join(",", array);
                    if (dtb != null && dtb.Rows.Count > 0)
                    {
                        lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);
                    }
                }

                total = lst.Count;
                if (total > 0)
                {
                    this.records = DBConvert.ParseString(total);
                    this.pager.PageSize = DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]);
                    this.pager.ItemCount = total;

                    this.rptResult.DataSource = lst;
                    this.rptResult.DataBind();

                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("block_category", "GetProduct", ex.Message);
            }
        }

        private string GetProductCategory()
        {
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lst = null;
            IList<PNK_ProductCategory> lst2 = null;

            if (cidsub != string.Empty && cid != string.Empty && id != string.Empty)
            {
                lst = pcBll.GetList(LangInt, cid, string.Empty, int.MinValue, true, "p.ordering", 1, 1000, out  total);
                //ltrCateName.Text = lst[0].ProductCategoryDesc.Name;
                categoryID = lst[0].ProductCategoryDesc.Id.ToString();

                WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
                WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);

                //Gen html image category
                ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0]);
            }
            else if (cidsub != string.Empty && cid != string.Empty)
            {
                lst = pcBll.GetList(LangInt, cid, string.Empty, int.MinValue, true, "p.ordering", 1, 1000, out  total);
                if (total > 0)
                {
                    //lần 2 truyền parentID vào để lấy ds con
                    lst = pcBll.GetList(LangInt, string.Empty, string.Empty, lst[0].Id, false, "p.ordering", 1, 1000, out  total);
                    WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
                    WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);

                    //Gen html image category
                    ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0]);

                    //Chỉ có 1 menu cha
                    if (total > 0)
                    {
                        categoryID = lst[0].ProductCategoryDesc.Id.ToString();
                    }
                    else
                        categoryID = null;
                }
            }
            else if (cidsub == string.Empty && cid != string.Empty)
            {
                lst = pcBll.GetList(LangInt, cid, string.Empty, int.MinValue, true, "p.ordering", 1, 1000, out  total);
                if (total > 0)
                {
                    WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
                    WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);
                    //IList<PNK_ProductCategory> lstSub = pcBll.GetList(LangInt, string.Empty, string.Empty, lst[0].Id, false, "p.ordering", 1, 1000, out  total);

                    //Gen html image category
                    ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0]);

                    if (lst.Count > 1)
                    {
                        //ltrCateNameTitle.Text = lst[0].ProductCategoryDesc.Name;
                        categoryID = lst[0].ProductCategoryDesc.Id.ToString();
                    }
                    else if (lst.Count == 1)
                    {
                        //ltrCateNameTitle.Text = lst[0].ProductCategoryDesc.Name;
                        categoryID = lst[0].ProductCategoryDesc.Id.ToString();
                    }
                    else
                        categoryID = null;
                }
            }
            else if (cid == string.Empty)
            {
                //lần đầu lấy parentID
                lst = pcBll.GetList(LangInt, pageName, string.Empty, int.MinValue, true, "p.ordering", 1, 1000, out  total);
                if (total > 0)
                {
                    WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
                    WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);

                    //Gen html image category
                    ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0]);

                    if (lst.Count > 0)
                    {  //lần 2 truyền parentID vào để lấy ds con
                        lst2 = pcBll.GetList(LangInt, string.Empty, string.Empty, lst[0].Id, false, "p.ordering", 1, 1000, out  total);

                        //ltrCateNameTitle.Text = lst[0].ProductCategoryDesc.Name;
                        //ltrCategoryBrief.Text = lst[0].ProductCategoryDesc.Brief;
                        categoryID = lst[0].Id.ToString();
                    }
                    else
                    {
                        //lần 2 truyền parentID vào để lấy ds con
                        lst2 = pcBll.GetList(LangInt, string.Empty, string.Empty, lst[0].Id, false, "p.ordering", 1, 1000, out  total);

                        //ltrCateNameTitle.Text = lst2[0].ProductCategoryDesc.Name;
                        //ltrCategoryBrief.Text = lst[0].ProductCategoryDesc.Brief;
                        categoryID = lst2[0].ParentId.ToString();
                    }
                }
            }

            return categoryID;
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

        protected void rptResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_Product data = e.Item.DataItem as PNK_Product;

                Literal ltrImge = e.Item.FindControl("ltrImge") as Literal;
                ltrImge.Text = Common.UtilityLocal.ImagePathByFont(data);

                HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;
                HtmlAnchor hypContinus = e.Item.FindControl("hypContinus") as HtmlAnchor;

                cid = Utils.GetParameter("cid", string.Empty);
                string link = UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId);
                int level = link.Count(i => i.Equals('/'));

                if (level == 3)
                {
                    hypContinus.HRef = LinkHelper.GetLink(pageName, LangId, cid, data.CategoryUrlDesc, data.ProductDesc.TitleUrl);
                }
                else if (level == 2)
                {
                    hypContinus.HRef = LinkHelper.GetLink(link, LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
                }
                else if (level == 1)
                {
                    hypContinus.HRef = LinkHelper.GetLink(UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId), LocalizationUtility.GetText("linkCate", Ci), LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
                }

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = hypTitle.Title = data.ProductDesc.Title;

                Literal ltrBrief = e.Item.FindControl("ltrBrief") as Literal;
                ltrBrief.Text = data.ProductDesc.Brief;

                Literal ltrContinus = e.Item.FindControl("ltrContinus") as Literal;
                ltrContinus.Text = LocalizationUtility.GetText(ltrContinus.ID);

            }
        }

        public void pager_Command(object sender, CommandEventArgs e)
        {
            this.currentPageIndex = Convert.ToInt32(e.CommandArgument);
            pager.CurrentIndex = this.currentPageIndex;
            InitPage();
        }

        #endregion
    }
}