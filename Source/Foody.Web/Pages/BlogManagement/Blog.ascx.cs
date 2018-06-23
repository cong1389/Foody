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

namespace Cb.Web.Pages.BlogManagement
{
    public partial class Blog : DGCUserControl
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
                total = 0;
                ProductBLL pcBll = new ProductBLL();
                IList<PNK_Product> lst = null;

                DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + categoryID + ",1)", null);
                string[] array = dtb.AsEnumerable()
                                    .Select(row => row.Field<Int32>("id").ToString())
                                    .ToArray();
                string idFirst = string.Join(",", array);

                //Lọc sản phẩm trang chủ
                lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);
                if (lst.Count > 0)
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
            if (pageName == "home" || pageName == "trang-chu")
            {
                lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, ConfigurationManager.AppSettings["parentIdTemplate"], string.Empty, 1, true, string.Empty, 1, 9999, out total);
                if (lst.Count > 0)
                {
                    categoryID = lst[0].ProductCategoryDesc.Id.ToString();
                    
                    //ltrCateName.Text = lst[0].ProductCategoryDesc.Name;
                }
            }
            else
            {
                string treeNameUrl = (Session["level"] != null && DBConvert.ParseInt(Session["level"]) == 1) ? pageName : UtilityLocal.RemoveLanguage(Request.RawUrl, LangId);
                lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, string.Empty, treeNameUrl, 1, true, string.Empty, 1, 9999, out total);
                if (lst.Count > 0)
                {
                    categoryID = lst[0].Id.ToString();
                  
                    //ltrCateName.Text = lst[0].ProductCategoryDesc.Name;

                    //Set category header
                    ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0], Request);

                    //Set SEO
                    WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
                    WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);

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
                HtmlAnchor hypImg = e.Item.FindControl("hypImg") as HtmlAnchor;
                HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;
                HtmlAnchor hypContinus = e.Item.FindControl("hypContinus") as HtmlAnchor;
                
                Dictionary<string, object> dic = UtilityLocal.GetHRefByLevel(data, LangInt, LangId, Ci);
                hypContinus.HRef = hypTitle.HRef = hypImg.HRef = dic["HRef"].ToString();

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                hypImg.Title = ltrTitle.Text = img.Alt = img.Attributes["title"] = data.ProductDesc.Title;

                Literal ltrBrief = e.Item.FindControl("ltrBrief") as Literal;
                ltrBrief.Text = data.ProductDesc.Brief;

                Literal ltrDate = e.Item.FindControl("ltrDate") as Literal;
                ltrDate.Text = data.PostDate.ToString("dd/MM/yyyy");

                Literal ltrContinus = e.Item.FindControl("ltrContinus") as Literal;
                ltrContinus.Text = LocalizationUtility.GetText(ltrContinus.ID);

            }
        }

        protected void rptCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_ProductCategory data = e.Item.DataItem as PNK_ProductCategory;

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = data.ProductCategoryDesc.Name;

                HtmlControl divTitle = e.Item.FindControl("divTitle") as HtmlControl;
                divTitle.Attributes.Add("data-filter", string.Format("filter-{0}", data.ProductCategoryDesc.NameUrl));
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