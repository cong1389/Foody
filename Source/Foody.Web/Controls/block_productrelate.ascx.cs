using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Utility;
using Cb.Model;
using System.Web.UI.HtmlControls;
using Cb.BLL.Product;
using Cb.Model.Products;
using Cb.DBUtility;
using System.Configuration;
using Cb.BLL;
using Cb.Localization;
using Cb.Web.Common;
using System.Data;

namespace Cb.Web.Controls
{
    public partial class block_productrelate : DGCUserControl
    {
        #region Parameter

        protected string template_path, pageName, nameurl, url, cid, cidsub, id, idsub, hypLinkCommentFB;
        string lastUrl = string.Empty, forwardUrl = string.Empty;
        int total;

        #endregion

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            cidsub = Utils.GetParameter("cidsub", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            GetDetail();
            ShowConfig();
        }

        /// <summary>
        /// ishHot=true,cateid=sanphamID
        /// </summary>
        private void GetDetail()
        {
            ProductBLL pcBll = new ProductBLL();
            IList<PNK_Product> lst = null;           
            //Loại bỏ dấu ? để lấy link đúng
            string url = Request.RawUrl.Split('?')[0];

            //Cắt url, để lấy product name
            string[] urlArr = url.Split('/').ToArray();
            Array.Reverse(urlArr);
            lastUrl = urlArr[0];
            forwardUrl = urlArr[1];
            if (lastUrl != string.Empty && lastUrl != "default.aspx" && !string.IsNullOrEmpty(lastUrl))
            {
                lst = pcBll.GetListRelate(LangInt, forwardUrl, string.Empty, lastUrl, 1, 9999, out total);
                //lst = pcBll.GetList(LangInt, forwardUrl, string.Empty, string.Empty, lastUrl, null, string.Empty, 1, 9999, out total);
            }

            //if (Session["level"] != null)
            //{
            //    string level = Session["level"].ToString();
            //    switch (level)
            //    {
            //        case "1":
            //          lst = pcBll.GetListRelate(LangInt, pageName, string.Empty, id, 1, 9999, out total);
            //            //lst = pcBll.GetList(LangInt, pageName, string.Empty, string.Empty, string.Empty, null, string.Empty, 1, 9999, out total);
            //            break;
            //        case "2":
            //            lst = pcBll.GetListRelate(LangInt, cid, string.Empty, id, 1, 9999, out total);
            //            //lst = pcBll.GetList(LangInt, cid, string.Empty, string.Empty, string.Empty, null, string.Empty, 1, 9999, out total);
            //            break;
            //        case "3":
            //            lst = pcBll.GetListRelate(LangInt, string.Empty, string.Empty, id, 1, 9999, out total);
            //            //lst = pcBll.GetList(LangInt, string.Empty, string.Empty, string.Empty, id, null, string.Empty, 1, 9999, out total);
            //            break;
            //        case "4":
            //        default:
            //            lst = pcBll.GetListRelate(LangInt, string.Empty, string.Empty, idsub, 1, 9999, out total);
            //            //lst = pcBll.GetList(LangInt, string.Empty, string.Empty, string.Empty, idsub, null, string.Empty, 1, 9999, out total);
            //            break;
            //    }
            //}           

            if (total > 0)
            {
                this.rptResult.DataSource = lst;
                this.rptResult.DataBind();

                ltrProductRelate.Text = string.Format("{0} {1}", lst[0].CategoryNameDesc, LocalizationUtility.GetText("ltrProductRelate", Ci));
                hypAll.HRef = LinkHelper.GetLink(lst[0].CategoryUrlDesc, LangId);
                hypLinkCommentFB = Utils.CombineUrl(Template_path, Request.RawUrl);
            }
            else
            {
                divProductRelease.Attributes.Add("class","hidden");
            }
        }

        private void ShowConfig()
        {
            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            foreach (PNK_Configuration item in lst)
            {
                if (item.Key_name == Constant.Configuration.config_fbfanpage)
                {
                    this.hypFB.HRef = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_googleplus)
                {
                    this.hypGooglePlus.HRef = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_twitter)
                {
                    this.hypTwitter.HRef = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_linkedIn)
                {
                    this.hypLinkedIn.HRef = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_pinterest)
                {
                    this.hypPinTerest.HRef = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_reddit)
                {
                    this.hypReddit.HRef = item.Value_name;
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
                HtmlAnchor hypContinus = e.Item.FindControl("hypContinus") as HtmlAnchor;

                Dictionary<string, object> dic = UtilityLocal.GetHRefByLevel(data, LangInt, LangId, Ci);
                hypContinus.HRef = dic["HRef"].ToString();

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);
                img.Attributes.Add("srcset", WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image));

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = hypContinus.Title = data.ProductDesc.Title;

                Literal ltrContinus = e.Item.FindControl("ltrContinus") as Literal;
                ltrContinus.Text = LocalizationUtility.GetText("ltrContinus", Ci);
            }
        }

        #endregion
    }
}