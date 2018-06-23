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

namespace Cb.Web.Pages.SearchManagement
{
    public partial class search : DGCUserControl
    {
        #region Parameter

        protected string template_path, pageName, cid, cidsub, id, records, hot = string.Empty, feature = string.Empty, categoryID = string.Empty;
        int total;

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

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            cidsub = Utils.GetParameter("cidsub", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            //GetProductCategory();
            GetProduct();

        }

        private void GetProduct()
        {
            try
            {
                //string categoryID = null;
                //categoryID = GetProductCategory();

                ProductBLL pcBll = new ProductBLL();
                IList<PNK_Product> lst = null;
                if (cid != string.Empty)
                {
                    lst = pcBll.GetListSearch(LangInt, cid, "1", string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out  total);
                }


                if (total > 0)
                {
                    block_categorytemplate.lstSearch = lst;
                    block_categorytemplate.TotalSearch = total;
                    //this.records = DBConvert.ParseString(total);
                    //this.pager.PageSize = DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]);
                    //this.pager.ItemCount = total;

                    //this.rptResult.DataSource = lst;
                    //this.rptResult.DataBind();

                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("block_category", "GetProduct", ex.Message);
            }
        }

        //private string GetProductCategory()
        //{
        //    ProductCategoryBLL pcBll = new ProductCategoryBLL();
        //    IList<PNK_ProductCategory> lst = null;
        //    IList<PNK_ProductCategory> lst2 = null;

        //    if (cidsub != string.Empty && cid != string.Empty && id != string.Empty)
        //    {
        //        lst = pcBll.GetList(LangInt, cid, string.Empty, int.MinValue, true, "p.ordering", 1, 1000, out  total);
        //        ltrCateName.Text = lst[0].ProductCategoryDesc.Name;
        //        categoryID = lst[0].ProductCategoryDesc.Id.ToString();
        //        CategoryHtml(lst);
        //        WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
        //        WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);
        //    }
        //    else if (cidsub != string.Empty && cid != string.Empty)
        //    {
        //        lst = pcBll.GetList(LangInt, cid, string.Empty, int.MinValue, true, "p.ordering", 1, 1000, out  total);
        //        if (total > 0)
        //        {
        //            CategoryHtml(lst);

        //            //lần 2 truyền parentID vào để lấy ds con
        //            lst = pcBll.GetList(LangInt, string.Empty, string.Empty, lst[0].Id, false, "p.ordering", 1, 1000, out  total);
        //            WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
        //            WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);

        //            //Chỉ có 1 menu cha
        //            if (total > 0)
        //            {
        //                CategoryHtml(lst);

        //                //ltrCateNameTitle.Text = lst[0].ProductCategoryDesc.Name;
        //                categoryID = lst[0].ProductCategoryDesc.Id.ToString();
        //            }
        //            else
        //                categoryID = null;
        //        }
        //    }
        //    else if (cidsub == string.Empty && cid != string.Empty)
        //    {
        //        lst = pcBll.GetList(LangInt, cid, string.Empty, int.MinValue, true, "p.ordering", 1, 1000, out  total);
        //        if (total > 0)
        //        {
        //            WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
        //            WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);
        //            IList<PNK_ProductCategory> lstSub = pcBll.GetList(LangInt, string.Empty, string.Empty, lst[0].Id, false, "p.ordering", 1, 1000, out  total);

        //            if (lstSub.Count > 0)
        //            {
        //                CategoryHtml(lst);
        //                ltrCateNameTitle.Text = lst[0].ProductCategoryDesc.Name;
        //                categoryID = lst[0].ProductCategoryDesc.Id.ToString();

        //            }
        //            //else if (lst.Count > 1)
        //            //{
        //            //    CategoryHtml(lst);
        //            //    ltrCateNameTitle.Text = lst[0].ProductCategoryDesc.Name;
        //            //    categoryID = lst[0].ProductCategoryDesc.Id.ToString();
        //            //}
        //            else if (lst.Count == 1)
        //            {
        //                CategoryHtml(lst);
        //                ltrCateNameTitle.Text = lst[0].ProductCategoryDesc.Name;
        //                categoryID = lst[0].ProductCategoryDesc.Id.ToString();
        //            }
        //            else
        //                categoryID = null;
        //        }
        //    }
        //    else if (cid == string.Empty)
        //    {

        //        //lần đầu lấy parentID
        //        lst = pcBll.GetList(LangInt, pageName, string.Empty, int.MinValue, true, "p.ordering", 1, 1000, out  total);
        //        if (total > 0)
        //        {
        //            WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
        //            WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);

        //            //lần 2 truyền parentID vào để lấy ds con
        //            lst2 = pcBll.GetList(LangInt, string.Empty, string.Empty, lst[0].Id, false, "p.ordering", 1, 1000, out  total);
        //            //lst = lst2.Count > 0 ? lst2 : lst;
        //            if (lst.Count > 0)
        //            {
        //                CategoryHtml(lst2);
        //                ltrCateNameTitle.Text = lst[0].ProductCategoryDesc.Name;
        //                categoryID = lst[0].Id.ToString();
        //            }
        //            else
        //            {
        //                CategoryHtml(lst2);
        //                ltrCateNameTitle.Text = lst2[0].ProductCategoryDesc.Name;
        //                categoryID = lst2[0].ParentId.ToString();
        //            }
        //        }
        //    }

        //    return categoryID;
        //}

        //private void CategoryHtml(IList<PNK_ProductCategory> lst)
        //{
        //    if (lst.Count > 0)
        //    {
        //        rptCategory.DataSource = lst;
        //        rptCategory.DataBind();
        //        hypTitle1.HRef = lst[0].ProductCategoryDesc.NameUrl;
        //    }
        //}

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                InitPage();
            }
        }

        //protected void rptResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //    {
        //        PNK_Product data = e.Item.DataItem as PNK_Product;
        //        HtmlAnchor hypImg = e.Item.FindControl("hypImg") as HtmlAnchor;
        //        //HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;
        //        //HtmlAnchor hypBrief = e.Item.FindControl("hypBrief") as HtmlAnchor;
        //        cid = Utils.GetParameter("cid", string.Empty);
        //        string link = UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId);
        //        int level = link.Count(i => i.Equals('/'));

        //        if (level == 3)
        //        {
        //            hypImg.HRef = LinkHelper.GetLink(pageName, LangId, cid, data.CategoryUrlDesc, data.ProductDesc.TitleUrl);
        //        }
        //        else if (level == 2)
        //        {
        //            //link = link + "/" + LocalizationUtility.GetText("linktmp", Ci);
        //            hypImg.HRef = LinkHelper.GetLink(link, LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
        //        }
        //        else if (level == 1)
        //        {
        //            hypImg.HRef = LinkHelper.GetLink(UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId), LocalizationUtility.GetText("linkCate", Ci), LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
        //        }

        //        HtmlImage img = e.Item.FindControl("img") as HtmlImage;
        //        img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);
        //        img.Attributes.Add("data-lazysrc", WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image));

        //        Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
        //        hypImg.Title = ltrTitle.Text = img.Alt = img.Attributes["title"] = data.ProductDesc.Title;

        //        HtmlControl liTilte = e.Item.FindControl("liTilte") as HtmlControl;
        //        liTilte.Attributes.Add("data-title", "data.ProductDesc.Title");
        //        liTilte.Attributes.Add("class", string.Format("filterall filter-{0} eg-w_jason-wrapper eg-post-id-5874", data.CategoryUrlDesc));

        //    }
        //}

        //protected void rptCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //    {
        //        PNK_ProductCategory data = e.Item.DataItem as PNK_ProductCategory;

        //        Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
        //        ltrTitle.Text = data.ProductCategoryDesc.Name;

        //        HtmlControl divTitle = e.Item.FindControl("divTitle") as HtmlControl;
        //        divTitle.Attributes.Add("data-filter", string.Format("filter-{0}", data.ProductCategoryDesc.NameUrl));
        //    }
        //}

        //public void pager_Command(object sender, CommandEventArgs e)
        //{
        //    //this.currentPageIndex = Convert.ToInt32(e.CommandArgument);
        //    //pager.CurrentIndex = this.currentPageIndex;
        //    //InitPage();
        //}

        #endregion
    }
}