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
using System.Text;

namespace Cb.Web.Controls
{
    public partial class block_categorytemplate : DGCUserControl
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

        int totalSearch;
        public int TotalSearch { get; set; }

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

            ltrAll.Text = LocalizationUtility.GetText("ltrAll", Ci);

            BindCategory();

            //Show page pc, mobile            

            if (pageName == "tim-kiem" || pageName == "search")
            {
                this.records = DBConvert.ParseString(totalSearch);
                this.pager.PageSize = DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]);
                this.pager.ItemCount = totalSearch;

                this.rptResult.DataSource = lstSearch;
                this.rptResult.DataBind();

                //Set header
                ProductCategoryBLL pcBll = new ProductCategoryBLL();
                IList<PNK_ProductCategory> lst = pcBll.GetList(LangInt, string.Empty, "1", DBConvert.ParseInt(ConfigurationManager.AppSettings["parentIdTemplate"]), int.MinValue, false, string.Empty, 1, 1, out total);
                if (total > 0)
                {
                    //ltrCateNameTitle.Text = lst[0].ProductCategoryDesc.Name;
                    ltrCategoryBrief.Text = lst[0].ProductCategoryDesc.Brief;
                }
            }
            else
                GetProduct(string.Empty);


        }

        //Bind drop cate
        private void BindCategory()
        {
            string strTemp;
            drpCategory.Items.Clear();
            drpCategory.Items.Add(new ListItem(LocalizationUtility.GetText("ltrAll", Ci), ConfigurationManager.AppSettings["parentIdTemplate"]));
            ProductCategoryBLL ncBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lst = ncBll.GetList(LangInt, string.Empty, string.Empty, int.Parse(ConfigurationManager.AppSettings["parentIdTemplate"]), false, "p.ordering", 1, 1000, out total);
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_ProductCategory item in lst)
                {
                    strTemp = item.ProductCategoryDesc.Name;
                    drpCategory.Items.Add(new ListItem(strTemp, DBConvert.ParseString(item.Id)));
                }
            }
        }

        private void GetProduct(string categoryIDSelect)
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

                ////Lọc sản phẩm trang chủ
                //if (Session["level"] != null && DBConvert.ParseInt(Session["level"]) == 1)
                //{
                    lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, string.Empty, "1", string.Empty, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);
                    if (lst.Count > 0)
                    {
                        this.records = DBConvert.ParseString(total);
                        this.pager.PageSize = DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]);
                        this.pager.ItemCount = total;
                        this.rptResult.DataSource = lst;
                        this.rptResult.DataBind();
                    }
                //}
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
                    CategoryHtml(categoryID);
                    //ltrCateName.Text = lst[0].ProductCategoryDesc.Name;
                }
            }
            else
            {
                string treeNameUrl = (Session["level"] != null && DBConvert.ParseInt(Session["level"]) == 1)?pageName: UtilityLocal.RemoveLanguage(Request.RawUrl, LangId);
                lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, string.Empty, treeNameUrl, 1, true, string.Empty, 1, 9999, out total);
                if (lst.Count > 0)
                {
                    categoryID = lst[0].Id.ToString();
                    CategoryHtml(categoryID);
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

        private void CategoryHtml(string categoryId)
        {
            if (categoryId != string.Empty)
            {
                ProductCategoryBLL pcBll = new ProductCategoryBLL();
                IList<PNK_ProductCategory> lst = pcBll.GetList(LangInt, string.Empty, "1", DBConvert.ParseInt(categoryId), true, "p.ordering", 1, 1000, out total);
                if (total > 0)
                {
                    rptCategory.DataSource = lst;
                    rptCategory.DataBind();
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

        protected void rptResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_Product data = e.Item.DataItem as PNK_Product;
                HtmlAnchor hypImg = e.Item.FindControl("hypImg") as HtmlAnchor;                              

                Dictionary<string, object> dic = UtilityLocal.GetHRefByLevel(data, LangInt, LangId, Ci);
                 hypImg.HRef = dic["HRef"].ToString();

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);
                img.Attributes.Add("data-lazysrc", WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image));

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                hypImg.Title = ltrTitle.Text = img.Alt = img.Attributes["title"] = data.ProductDesc.Title;

                HtmlControl liTilte = e.Item.FindControl("liTilte") as HtmlControl;
                liTilte.Attributes.Add("data-title", "data.ProductDesc.Title");
                liTilte.Attributes.Add("class", string.Format("filterall filter-{0} eg-w_jason-wrapper eg-post-id-5874", data.CategoryUrlDesc));

                #region Price

                StringBuilder sbPrice = new StringBuilder();
                //Nếu không có giá giảm
                if (string.IsNullOrWhiteSpace(data.Post))
                {
                    string normalPrice = data.Website == "" ? "<ins><span class=\"amount\">Call</span></ins>" : string.Format("{0} USD", data.Website);
                    sbPrice.AppendFormat("<ins><span class=\"amount\">{0}</span></ins>", normalPrice);
                }
                //Nếu có giá giảm
                else
                {
                    string normalPrice = data.Website == "" ? "Call" : string.Format("$USD {0}", data.Website);
                    if (data.Website != "")
                    {
                        decimal discountPercent = ((DBConvert.ParseDecimal(data.Website) - DBConvert.ParseDecimal(data.Post)) / DBConvert.ParseDecimal(data.Website)) * 100;
                        sbPrice.AppendFormat("<ins><span class=\"amount\">{0} USD</span></ins>", data.Post);
                        sbPrice.AppendFormat("<del><span class=\"amount\">{0} USD</span></del>", data.Website);

                        //Show icon sale price
                        HtmlControl divIsSale = e.Item.FindControl("divIsSale") as HtmlControl;
                        divIsSale.Style.Add("display", "block");
                    }
                    else
                        sbPrice.Append("<ins><span class=\"amount\">Call</span></ins>");
                }
                Literal ltrPrice = e.Item.FindControl("ltrPrice") as Literal;
                ltrPrice.Text = sbPrice.ToString();

                #endregion

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

        protected void drpSort_onchange(object sender, EventArgs e)
        {
            string sortValue = drpSort.SelectedValue != "0" ? drpSort.SelectedValue : string.Empty;

            ProductBLL pcBll = new ProductBLL();

            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + ConfigurationManager.AppSettings["parentIdTemplate"] + ",1)", null);
            string[] array = dtb.AsEnumerable()
                                .Select(row => row.Field<Int32>("id").ToString())
                                .ToArray();
            string idFirst = string.Join(",", array);
            IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);

            if (total > 0)
            {
                this.records = DBConvert.ParseString(total);
                this.pager.PageSize = DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]);
                this.pager.ItemCount = total;

                //Sort
                switch (sortValue)
                {
                    //Sort a-z
                    case "1":
                        lst = lst.OrderBy(m => m.ProductDesc.TitleUrl).ToList();
                        break;
                    case "2":
                        lst = lst.OrderByDescending(m => m.ProductDesc.TitleUrl).ToList();
                        break;
                }

                this.rptResult.DataSource = lst;
                this.rptResult.DataBind();

            }
        }

        protected void drpCategory_onchange(object sender, EventArgs e)
        {
            string categoryID = drpCategory.SelectedValue != "0" ? drpCategory.SelectedValue : string.Empty;
            ProductBLL pcBll = new ProductBLL();
            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + categoryID + ",1)", null);
            string[] array = dtb.AsEnumerable()
                                .Select(row => row.Field<Int32>("id").ToString())
                                .ToArray();
            string idFirst = string.Join(",", array);

            IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);
            //if (total > 0)
            //{
            this.records = DBConvert.ParseString(total);
            this.pager.PageSize = DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]);
            this.pager.ItemCount = total;

            this.rptResult.DataSource = lst;
            this.rptResult.DataBind();

            //}
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