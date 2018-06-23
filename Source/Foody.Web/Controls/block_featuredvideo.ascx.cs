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
using System.Text;

namespace Cb.Web.Controls
{
    public partial class block_featuredvideo : DGCUserControl
    {
        #region Parameter

        protected string template_path, pageName, cid, cidsub, id, records, hot = string.Empty, feature = string.Empty, categoryID = string.Empty,bgImage="fdasfdsa";
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

            GetProductCategory();
            GetVideo();
        }

        private void GetVideo()
        {
            try
            {
                ProductBLL pcBll = new ProductBLL();

                DataTable dtbHot = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + ConfigurationManager.AppSettings["parentIdVideo"] + ",1)", null);
                string[] arrayHot = dtbHot.AsEnumerable()
                                    .Select(row => row.Field<Int32>("id").ToString())
                                    .ToArray();
                string idFirstHot = string.Join(",", arrayHot);
                if (idFirstHot != "" && idFirstHot != null)
                {
                    IList<PNK_Product> lstHot = pcBll.GetList(LangInt, string.Empty, "1", idFirstHot, string.Empty, string.Empty, string.Empty, 1, 9999, out total);
                    lstHot = lstHot.Where(m => m.Feature == "1").ToList();
                    if (lstHot.Count() > 0)
                    {
                        if (total > 0)
                        {
                            rptVideoTop.DataSource = lstHot;
                            rptVideoTop.DataBind();

                            rptVideo.DataSource = lstHot;
                            rptVideo.DataBind();
                            ifrTop.Attributes.Add("src", "//www.youtube.com/embed/" + UtilityLocal.GetVideoList(lstHot[0].Id) + "?rel=0&amp;autoplay=0");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("block_featuredvideo", "GetVideo", ex.Message);
            }
        }

        private string GetProductCategory()
        {
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lst = null;
            //if (pageName == "home" || pageName == "trang-chu")
            //{
            lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, ConfigurationManager.AppSettings["parentIdVideo"], string.Empty, 1, true, string.Empty, 1, 9999, out total);
            if (lst.Count > 0)
            {
                categoryID = lst[0].ProductCategoryDesc.Id.ToString();
                secCategory.Attributes.Add("style", string.Format("padding-top: 10px; padding-bottom: 20px; background: url('{0}') 50% -80.7422px/cover no-repeat;", WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductCategoryUpload"], lst[0].BaseImage)));

                //bgImage = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductCategoryUpload"], lst[0].BaseImage);
            }
            //}
            //else
            //{
            //    string treeNameUrl = (Session["level"] != null && DBConvert.ParseInt(Session["level"]) == 1) ? pageName : UtilityLocal.RemoveLanguage(Request.RawUrl, LangId);
            //    lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, string.Empty, treeNameUrl, 1, true, string.Empty, 1, 9999, out total);
            //    if (lst.Count > 0)
            //    {
            //        categoryID = lst[0].Id.ToString();

            //        //Set category header
            //        ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0], Request);

            //        ////Set SEO
            //        //WebUtils.SeoPage(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaDecription, lst[0].ProductCategoryDesc.MetaKeyword, this.Page);
            //        //WebUtils.SeoTagH(lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, lst[0].ProductCategoryDesc.MetaTitle, Controls);

            //    }
            //}
            return categoryID;
        }

        //private void GetBlog()
        //{
        //    try
        //    {
        //        string categoryID = null;
        //        categoryID = ConfigurationManager.AppSettings["parentIdLastBlog"];

        //        ProductBLL pcBll = new ProductBLL();
        //        IList<PNK_Product> lst = null;
        //        if (cidsub != string.Empty && cid != string.Empty)
        //        {
        //            lst = pcBll.GetList(LangInt, cidsub, "1", string.Empty, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);
        //        }
        //        else if (cidsub == string.Empty && cid != string.Empty && categoryID != string.Empty)
        //        {
        //            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + categoryID + ",1)", null);
        //            string[] array = dtb.AsEnumerable()
        //                                .Select(row => row.Field<Int32>("id").ToString())
        //                                .ToArray();
        //            string idFirst = string.Join(",", array);
        //            lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);

        //        }
        //        else if (cid == string.Empty && categoryID != string.Empty)
        //        {
        //            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + categoryID + ",1)", null);
        //            string[] array = dtb.AsEnumerable()
        //                                .Select(row => row.Field<Int32>("id").ToString())
        //                                .ToArray();
        //            string idFirst = string.Join(",", array);
        //            if (dtb != null && dtb.Rows.Count > 0)
        //            {
        //                lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["pageSizeCate"]), out total);
        //            }
        //        }

        //        //total = lst.Count;
        //        if (total > 0)
        //        {
        //            this.rptBlog.DataSource = lst;
        //            this.rptBlog.DataBind();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Write2Log.WriteLogs("block_category", "GetProduct", ex.Message);
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

        protected void rptVideoTop_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_Product data = e.Item.DataItem as PNK_Product;

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = img.Alt = img.Attributes["title"] = DBHelper.getTruncate(data.ProductDesc.Title, 10);

                Literal ltrBrief = e.Item.FindControl("ltrBrief") as Literal;
                ltrBrief.Text = DBHelper.getTruncate(data.ProductDesc.Brief, 30);

                HtmlAnchor hypVideo = e.Item.FindControl("hypVideo") as HtmlAnchor;
                hypVideo.HRef = string.Format("https://www.youtube.com/watch?v={0}", UtilityLocal.GetVideoList(data.Id));

                //HtmlControl ifrVideo = e.Item.FindControl("ifrVideo") as HtmlControl;
                //ifrVideo.Attributes.Add("src", "//www.youtube.com/embed/" + UtilityLocal.GetVideoList(data.Id) + "?rel=0&amp;autoplay=0");
            }
        }

        //protected void rptVideo_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //    {
        //        PNK_Product data = e.Item.DataItem as PNK_Product;
        //        HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;

        //        cid = Utils.GetParameter("cid", string.Empty);
        //        string link = UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId);
        //        int level = link.Count(i => i.Equals('/'));

        //        if (level == 3)
        //        {
        //            hypTitle.HRef = LinkHelper.GetLink(pageName, LangId, cid, data.CategoryUrlDesc, data.ProductDesc.TitleUrl);
        //        }
        //        else if (level == 2)
        //        {
        //            hypTitle.HRef = LinkHelper.GetLink(link, LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
        //        }
        //        else if (level == 1)
        //        {
        //            hypTitle.HRef = LinkHelper.GetLink(UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId), LocalizationUtility.GetText("linkCate", Ci), LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
        //        }

        //        Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
        //        ltrTitle.Text = data.ProductDesc.Title;

        //    }
        //}

        //protected void rptBlog_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //    {
        //        PNK_Product data = e.Item.DataItem as PNK_Product;
        //        HtmlAnchor hypImg = e.Item.FindControl("hypImg") as HtmlAnchor;
        //        HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;
        //        HtmlAnchor hypDate = e.Item.FindControl("hypDate") as HtmlAnchor;

        //        cid = Utils.GetParameter("cid", string.Empty);
        //        string link = UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId);
        //        int level = link.Count(i => i.Equals('/'));

        //        if (level == 3)
        //        {
        //            hypDate.HRef = hypTitle.HRef = hypImg.HRef = LinkHelper.GetLink(pageName, LangId, cid, data.CategoryUrlDesc, data.ProductDesc.TitleUrl);
        //        }
        //        else if (level == 2)
        //        {
        //            hypDate.HRef = hypTitle.HRef = hypImg.HRef = LinkHelper.GetLink(link, LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
        //        }
        //        else if (level == 1)
        //        {
        //            hypDate.HRef = hypTitle.HRef = hypImg.HRef = LinkHelper.GetLink(UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId), LocalizationUtility.GetText("linkCate", Ci), LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
        //        }

        //        HtmlImage img = e.Item.FindControl("img") as HtmlImage;
        //        img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);

        //        Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
        //        hypImg.Title = ltrTitle.Text = img.Alt = img.Attributes["title"] = data.ProductDesc.Title;

        //        Literal ltrDate = e.Item.FindControl("ltrDate") as Literal;
        //        ltrDate.Text = data.PostDate.ToString("dd/MM/yyyy");
        //    }
        //}

        #endregion
    }
}