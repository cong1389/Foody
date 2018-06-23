using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Web.Common;
using System.Web.UI.HtmlControls;

namespace Cb.Web.Pages.TestimonialManagement
{
    public partial class Testimonial : DGCUserControl
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

            GetProductCategory();
            GetProduct();
        }

        private void GetProduct()
        {
            ProductBLL pcBll = new ProductBLL();
            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + DBConvert.ParseInt(categoryID) + ",1)", null);
            string[] array = dtb.AsEnumerable()
                                .Select(row => row.Field<Int32>("id").ToString())
                                .ToArray();
            string idFirst = string.Join(",", array);
            IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, string.Empty, string.Empty, 1, 9999, out total);
            if (total > 0)
            {
                rptResult.DataSource = lst.OrderByDescending(m => m.PostDate);
                rptResult.DataBind();
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

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text =  data.ProductDesc.Title;

                Literal ltrTourCode = e.Item.FindControl("ltrTourCode") as Literal;
                ltrTourCode.Text = data.Status;
              
                Literal ltrBrief = e.Item.FindControl("ltrBrief") as Literal;
                ltrBrief.Text = data.ProductDesc.Brief;

                Literal ltrDate = e.Item.FindControl("ltrDate") as Literal;
                ltrDate.Text = data.PostDate.ToString("dd/MM/yyyy");

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);

                HtmlAnchor hypContinus = e.Item.FindControl("hypContinus") as HtmlAnchor;
                Dictionary<string, object> dic = UtilityLocal.GetHRefByLevel(data, LangInt, LangId, Ci);
                hypContinus.HRef = dic["HRef"].ToString();
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