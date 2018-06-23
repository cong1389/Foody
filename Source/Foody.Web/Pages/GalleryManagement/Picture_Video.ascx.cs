using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Localization;
using Cb.Model.Products;
using Cb.Utility;
using Cb.Web.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Cb.Web.Pages.GalleryManagement
{
    public partial class Picture_Video : DGCUserControl
    {
        #region Parameter

        private string title, metaDescription, metaKeyword, h1, h2, h3, analytic, background;
        protected string template_path, pageName, cid, id, records;
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
            id = Utils.GetParameter("id", string.Empty);

            GetProductCategory();
        }

        private void GetProductCategory()
        {
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            string treeNameUrl = UtilityLocal.RemoveLanguage(Request.RawUrl, LangId);
            IList<PNK_ProductCategory> lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, ConfigurationManager.AppSettings["parentIdPictureVideo"], string.Empty, 1, true, string.Empty, 1, 9999, out total);
            if (lst.Count > 0)
            {
                //Set category header
                ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0], Request);

                ltrCateName.Text = lst[0].ProductCategoryDesc.Name;
                ltrCateBrief.Text = lst[0].ProductCategoryDesc.Brief;

                this.rptResult.DataSource = lst.Where(m => m.ProductCategoryDesc.TreeLevelDesc > 1).ToList();
                this.rptResult.DataBind();
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
                PNK_ProductCategory data = e.Item.DataItem as PNK_ProductCategory;

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductCategoryUpload"], data.BaseImage);
                img.Attributes.Add("data-lazysrc", WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductCategoryUpload"], data.BaseImage));

                HtmlAnchor hypImg = e.Item.FindControl("hypImg") as HtmlAnchor;                
                hypImg.HRef = Utils.CombineUrl(Template_path, UtilityLocal.AppendLanguage(data.ProductCategoryDesc.TreeNameUrlDesc, LangId));

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                 hypImg.Title = ltrTitle.Text = DBHelper.getTruncate(data.ProductCategoryDesc.Name, 7);

                //Literal ltrBrief = e.Item.FindControl("ltrBrief") as Literal;
                //ltrBrief.Text = DBHelper.getTruncate(data.ProductCategoryDesc.Brief, 26);

                //Literal ltrMoreProduct = e.Item.FindControl("ltrMoreProduct") as Literal;
                //ltrMoreProduct.Text = LocalizationUtility.GetText("ltrContinus", Ci);
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