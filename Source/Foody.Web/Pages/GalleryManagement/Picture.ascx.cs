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
using System.Collections;


namespace Cb.Web.Pages.GalleryManagement
{
    public partial class Picture : DGCUserControl
    {
        #region Parameter

        string template_path, pageName, cid, cidsub, id, records, hot = string.Empty, feature = string.Empty, categoryID = string.Empty;
        string lastUrl = string.Empty, forwardUrl = string.Empty;
        string level = string.Empty;
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
            if (Session["level"] != null)
            {
                level = Session["level"].ToString();
                //GetProductCategory();
                GetProduct();
            } 
        }

        private void GetProduct()
        {
            try
            {
                ProductBLL pcBll = new ProductBLL();
                IList<PNK_Product> lst2 = null, lst3 = null;

                //Loại bỏ dấu ? để lấy link đúng
                string url = Request.RawUrl.Split('?')[0];

                //Cắt url, để lấy product name
                string[] urlArr = url.Split('/').ToArray();
                Array.Reverse(urlArr);
                lastUrl = urlArr[0];
                forwardUrl = urlArr[1];

                switch (level)
                {
                    case "1":
                        lst2 = pcBll.GetList(LangInt, pageName, string.Empty, string.Empty, string.Empty, null, string.Empty, 1, 9999, out total);
                        break;
                    case "2":
                        lst2 = pcBll.GetList(LangInt, cid, string.Empty, string.Empty, string.Empty, null, string.Empty, 1, 9999, out total);

                        GetListImage(lst2[0].Id.ToString(), rptImg);
                        ltrHeader.Text = lst2[0].ProductDesc.Title;
                        ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst2[0], Request);
                        break;
                    case "3":
                    default:
                        lst2 = pcBll.GetList(LangInt, cid, string.Empty, string.Empty, string.Empty, null, string.Empty, 1, 9999, out total);
                        lst3 = lst2.Where(m => m.ProductDesc.TitleUrl == lastUrl).ToList();

                        GetListImage(lst3[0].Id.ToString(), rptImg);
                        ltrHeader.Text = lst3[0].ProductDesc.Title;
                        ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst3[0], Request);
                        break;
                }

                if (lst2.Count > 0)
                {
                   

                    this.records = DBConvert.ParseString(total);
                    this.pager.PageSize = DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]);
                    this.pager.ItemCount = total;
                    this.rptResult.DataSource = lst2;
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
                }
            }
            else
            {
                string treeNameUrl = (Session["level"] != null && DBConvert.ParseInt(Session["level"]) == 2) ? UtilityLocal.RemoveLanguage(Request.RawUrl, LangId) :string.Format("{0/{1}",PageName,UrlCid);
                lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, string.Empty, treeNameUrl, 1, true, string.Empty, 1, 9999, out total);
                if (lst.Count > 0)
                {
                    categoryID = lst[0].Id.ToString();

                    //Set category header
                    ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0], Request);

                    //Set SEO
                    WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
                    WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);

                }
            }
            return categoryID;
        }

        private void GetListImage(string productID, Repeater rptImg)
        {
            UploadImageBLL bll = new UploadImageBLL();
            IList<PNK_UploadImage> lst = bll.GetList(string.Empty, productID, "1", 1, 100, out total);
            if (total > 0)
            {
                rptImg.DataSource = lst;
                rptImg.DataBind();
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
                //HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;

                Dictionary<string, object> dic = UtilityLocal.GetHRefByLevel(data, LangInt, LangId, Ci);
                hypImg.HRef = dic["HRef"].ToString();               

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);
                img.Attributes.Add("data-lazysrc", WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image));

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = data.ProductDesc.Title;
            }
        }

        protected void rptImg_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_UploadImage data = e.Item.DataItem as PNK_UploadImage;

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                HtmlImage imgThumb = e.Item.FindControl("imgThumb") as HtmlImage;
                HtmlAnchor hypImgThumb = e.Item.FindControl("hypImgThumb") as HtmlAnchor;

                string src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Name);
                hypImgThumb.HRef = img.Src = imgThumb.Src = src;

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                img.Alt = img.Attributes["title"] = imgThumb.Alt = imgThumb.Attributes["title"] = hypImgThumb.Title = ltrTitle.Text = WebUtils.GetFileName(data.Name);
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