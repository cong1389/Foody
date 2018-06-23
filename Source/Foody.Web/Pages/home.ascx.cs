using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.BLL;
using Cb.Model;
using Cb.Utility;
using Cb.BLL.Product;
using Cb.Model.Products;
using Cb.DBUtility;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Data;
using Cb.Web.Common;
using Cb.Localization;

namespace Cb.Web.Pages
{
    public partial class home : DGCUserControl
    {
        #region Parameter

        protected string categoryID, title, metaDescription, metaKeyword, h1, h2, h3, analytic, pageName, cid, cidsub, id;
        private string activeClass = "";
        int total;


        #endregion

        #region Common

        private void InitPage()
        {
            GetService();
            GetSEO();
            GetCommentCustomer();          
            GetLastBlog();
            GetPartner();

            //ltrLastWork.Text = LocalizationUtility.GetText(ltrLastWork.ID, Ci);
            ltrLastNews.Text = LocalizationUtility.GetText(ltrLastNews.ID, Ci);
            ltrPartnerHeader.Text = LocalizationUtility.GetText(ltrPartnerHeader.ID, Ci);

            //block_mostPopularDailyTour.CategoryNamePass = LocalizationUtility.GetText("block_mostPopularDailyTourName", Ci);
            block_mostPopularDailyTour.CategoryIdByPass = ConfigurationManager.AppSettings["parentIdMostDailyTour"];

            //block_otherTour.CategoryNamePass = LocalizationUtility.GetText("block_otherTour", Ci);
            block_otherTour.CategoryIdByPass = ConfigurationManager.AppSettings["parentIdOtherTour"];
        }

        /// <summary>
        /// Dịch vụ
        /// </summary>
        private void GetService()
        {
            ProductBLL pcBll = new ProductBLL();
            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + DBConvert.ParseInt(ConfigurationManager.AppSettings["parentIdService"]) + ",1)", null);
            string[] array = dtb.AsEnumerable()
                                .Select(row => row.Field<Int32>("id").ToString())
                                .ToArray();
            string idFirst = string.Join(",", array);
            IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, string.Empty, "1", 1,6, out total);
            if (total > 0)
            {
                this.rptServiceLeft.DataSource = lst;
                this.rptServiceLeft.DataBind();
            }

            total = 0;
            ProductCategoryBLL pcBllCate = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lstCate = pcBllCate.GetList(LangInt, string.Empty, null, DBConvert.ParseInt(ConfigurationManager.AppSettings["parentIdService"]), int.MinValue, false, string.Empty, 1, 1, out total);
            if (lst.Count > 0)
            {
                ltrServiceHeader.Text = lstCate[0].ProductCategoryDesc.Name;
            }
        }

        private void GetSEO()
        {
            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Configuration item in lst)
                {
                    if (item.Key_name == Constant.Configuration.config_title)
                    {
                        title = item.Value_name;
                    }
                    else if (item.Key_name == Constant.Configuration.config_metaDescription)
                    {
                        metaDescription = item.Value_name;
                    }
                    else if (item.Key_name == Constant.Configuration.config_metaKeyword)
                    {
                        metaKeyword = item.Value_name;
                    }

                    else if (item.Key_name == Constant.Configuration.config_h1)
                    {
                        h1 = item.Value_name;
                    }
                    else if (item.Key_name == Constant.Configuration.config_h2)
                    {
                        h2 = item.Value_name;
                    }
                    else if (item.Key_name == Constant.Configuration.config_h3)
                    {
                        h3 = item.Value_name;
                    }
                    else if (item.Key_name == Constant.Configuration.config_analytic)
                    {
                        analytic = item.Value_name;
                    }
                }

                WebUtils.SeoPage(title, metaDescription, metaKeyword, this.Page);
                //WebUtils.SeoTagH(h1, h2, h3, Controls);

                ////Google Analytic
                //WebUtils.IncludeJSScript(this.Page, analytic);
            }
        }
        
        /// <summary>
        /// Ý kiến khách hàng
        /// </summary>
        private void GetCommentCustomer()
        {
            ProductBLL pcBll = new ProductBLL();
            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + DBConvert.ParseInt(ConfigurationManager.AppSettings["parentIdCommentCustomer"]) + ",1)", null);
            string[] array = dtb.AsEnumerable()
                                .Select(row => row.Field<Int32>("id").ToString())
                                .ToArray();
            string idFirst = string.Join(",", array);
            IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, 1, 1000, out total);
            if (lst.Count > 0)
            {
                ltrCommentCusHeader.Text = lst[0].CategoryBriefDesc;
                this.rptCommentCustomer.DataSource = lst;
                this.rptCommentCustomer.DataBind();
            }
        }
                
        /// <summary>
        /// Blog cuối cùng
        /// </summary>
        private void GetLastBlog()
        {
            ProductBLL pcBll = new ProductBLL();
            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + DBConvert.ParseInt(ConfigurationManager.AppSettings["parentIdLastBlog"]) + ",1)", null);
            string[] array = dtb.AsEnumerable()
                                .Select(row => row.Field<Int32>("id").ToString())
                                .ToArray();
            string idFirst = string.Join(",", array);
            IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, string.Empty, string.Empty, 1, 3, out total);
            if (lst.Count > 0)
            {
                rptLastBlog.DataSource = lst.OrderByDescending(m => m.PostDate);
                rptLastBlog.DataBind();
            }
        }

        private void GetPartner()
        {
            BannerBLL bannerBLL = new BannerBLL();
            IList<PNK_Banner> lst = bannerBLL.GetList(DBConvert.ParseInt(ConfigurationManager.AppSettings["partnerId"]), string.Empty, "1", 1, 100, out total);
            if (lst.Count > 0)
            {
                this.rptResult.DataSource = lst;
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

        protected void rptCommentCustomer_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_Product data = e.Item.DataItem as PNK_Product;

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = img.Alt = img.Attributes["title"] = data.ProductDesc.Title;

                Literal ltrBrief = e.Item.FindControl("ltrBrief") as Literal;
                ltrBrief.Text = data.ProductDesc.Brief;

                Literal ltrDetail = e.Item.FindControl("ltrDetail") as Literal;
                ltrDetail.Text = DBHelper.getTruncate(data.ProductDesc.Detail, 20);// SanitizeHtml.Sanitize(data.ProductDesc.Detail);

                HtmlAnchor hypImg = e.Item.FindControl("hypImg") as HtmlAnchor;
                hypImg.HRef = data.ProductDesc.Position;

            }
        }
        
        protected void rptServiceLeft_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_Product data = e.Item.DataItem as PNK_Product;

                Literal ltrImge = e.Item.FindControl("ltrImge") as Literal;
                ltrImge.Text = Common.UtilityLocal.ImagePathByFont(data);

                HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;

                Dictionary<string, object> dic = UtilityLocal.GetHRefByLevel(data, LangInt, LangId, Ci);
                hypTitle.HRef = LinkHelper.GetLink(UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId), data.ProductDesc.TitleUrl);

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = hypTitle.Title = data.ProductDesc.Title;

                Literal ltrBrief = e.Item.FindControl("ltrBrief") as Literal;
                ltrBrief.Text = data.ProductDesc.Brief;

                //Literal ltrContinus = e.Item.FindControl("ltrContinus") as Literal;
                //ltrContinus.Text = LocalizationUtility.GetText(ltrContinus.ID);
            }
        }
        
        protected void rptLastBlog_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_Product data = e.Item.DataItem as PNK_Product;

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);

                HtmlAnchor hypImg = e.Item.FindControl("hypImg") as HtmlAnchor;
                HtmlAnchor hypContinus = e.Item.FindControl("hypContinus") as HtmlAnchor;
                HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;

                cid = Utils.GetParameter("cid", string.Empty);
                string link = UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId);
                int level = link.Count(i => i.Equals('/'));

                if (level == 3)
                {
                    hypTitle.HRef = hypContinus.HRef = hypImg.HRef = LinkHelper.GetLink(pageName, LangId, cid, data.CategoryUrlDesc, data.ProductDesc.TitleUrl);
                }
                else if (level == 2)
                {
                    hypTitle.HRef = hypContinus.HRef = hypImg.HRef = LinkHelper.GetLink(link, LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
                }
                else if (level == 1)
                {
                    hypTitle.HRef = hypContinus.HRef = hypImg.HRef = LinkHelper.GetLink(UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId), LocalizationUtility.GetText("linkCate", Ci), LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
                }

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                hypTitle.Title = hypContinus.Title = hypImg.Title = img.Alt = img.Attributes["title"] = ltrTitle.Text = hypImg.Title = data.ProductDesc.Title;

                Literal ltrBrief = e.Item.FindControl("ltrBrief") as Literal;
                ltrBrief.Text = hypImg.Title = data.ProductDesc.Brief;

                Literal ltrDate = e.Item.FindControl("ltrDate") as Literal;
                ltrDate.Text = data.PostDate.ToString("dd/MM/yyyy");

                Literal ltrUpdateBy = e.Item.FindControl("ltrUpdateBy") as Literal;
                ltrUpdateBy.Text = data.UpdateBy;

                Literal ltrContinus = e.Item.FindControl("ltrContinus") as Literal;
                ltrContinus.Text = LocalizationUtility.GetText(ltrContinus.ID);
            }
        }

        protected void rptResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_Banner data = e.Item.DataItem as PNK_Banner;

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["SliderUpload"], data.Image);

                if (data.OutPage == 1)
                {
                    HtmlAnchor hypImg = e.Item.FindControl("hypImg") as HtmlAnchor;
                    hypImg.HRef = data.LinkUrl;
                }
            }
        }

        #endregion
    }
}