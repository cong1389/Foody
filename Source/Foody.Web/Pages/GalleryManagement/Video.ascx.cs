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
using Cb.BLL;
using Cb.Model;


namespace Cb.Web.Pages.GalleryManagement
{
    public partial class Video : DGCUserControl
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

            GetVideo();

        }

        private void GetVideo()
        {
            try
            {
                string categoryID = null;
                categoryID = GetProductCategory();
                ProductBLL pcBll = new ProductBLL();
                IList<PNK_Product> lst = null;

                DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + categoryID + ",1)", null);
                string[] array = dtb.AsEnumerable()
                                    .Select(row => row.Field<Int32>("id").ToString())
                                    .ToArray();
                string idFirst = string.Join(",", array);

                lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, string.Empty, "1", string.Empty, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);
                if (lst.Count > 0)
                {
                   // ifrTop.Attributes.Add("src", "//www.youtube.com/embed/" + UtilityLocal.GetVideoList(lst[0].Id) + "?rel=0&amp;autoplay=0");

                    this.records = DBConvert.ParseString(total);
                    this.pager.PageSize = DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]);
                    this.pager.ItemCount = total;
                    this.rptResult.DataSource = lst;
                    this.rptResult.DataBind();
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("GetVideo", "GetProduct", ex.Message);
            }
        }

        private string GetProductCategory()
        {
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lst = null;
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

                Dictionary<string, object> dic = UtilityLocal.GetHRefByLevel(data, LangInt, LangId, Ci);
                hypImg.HRef = string.Format("https://www.youtube.com/watch?v={0}", UtilityLocal.GetVideoList(data.Id));
                //  hypImg.HRef = dic["HRef"].ToString();                

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);
                img.Attributes.Add("data-lazysrc", WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image));

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = data.ProductDesc.Title;

                //GetVideoList(data.Id);
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