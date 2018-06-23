using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Model.Products;
using Cb.Utility;
using Cb.Web.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cb.Web.Pages.BlogManagement
{
    public partial class BlogDetail : DGCUserControl
    {
        #region Parameter

        protected string title, metaDescription, metaKeyword, h1, h2, h3, analytic, categoryID = string.Empty;
        protected string template_path, pageName, cid, id, cidsub, records;
        string lastUrl = string.Empty, forwardUrl = string.Empty;
        int total;

        ProductBLL pcBll = null;

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
            GetDetail();
        }

        private void GetDetail()
        {
            pcBll = new ProductBLL();
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
                lst = pcBll.GetList(LangInt, forwardUrl, string.Empty, string.Empty, lastUrl, null, string.Empty, 1, 9999, out total);
            }
            if (lst.Count > 0)
            {
                ltrTitle.Text = lst[0].ProductDesc.Title;
                ltrDetail.Text = lst[0].ProductDesc.Detail;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], lst[0].Image);

                ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0], Request);

                WebUtils.SeoPage(lst[0].ProductDesc.MetaTitle, lst[0].ProductDesc.Metadescription, lst[0].ProductDesc.MetaKeyword, this.Page);
                WebUtils.SeoTagH(lst[0].ProductDesc.H1, lst[0].ProductDesc.H2, lst[0].ProductDesc.H3, this.Controls);
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
                string treeNameUrl = (Session["level"] != null && DBConvert.ParseInt(Session["level"]) == 1) ? pageName : UtilityLocal.RemoveLanguage(Request.RawUrl, LangId);
                lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, string.Empty, treeNameUrl, 1, true, string.Empty, 1, 9999, out total);
                if (lst.Count > 0)
                {
                    categoryID = lst[0].Id.ToString();                   

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

        #endregion
    }
}