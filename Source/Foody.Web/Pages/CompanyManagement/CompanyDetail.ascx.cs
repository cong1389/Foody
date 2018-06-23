using Cb.BLL.Product;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Web.UI;

namespace Cb.Web.Pages.CompanyManagement
{
    public partial class CompanyDetail : DGCUserControl
    {
        #region Parameter

        private string title, metaDescription, metaKeyword, h1, h2, h3, analytic, background;
        protected string template_path, pageName, cid, id, records;
        string lastUrl = string.Empty, forwardUrl = string.Empty;
        int total;

        #endregion

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            GetDetail();
        }

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

            if (Session["level"] != null)
            {
                string level = Session["level"].ToString();
                switch (level)
                {
                    case "1":
                        lst = pcBll.GetList(LangInt, pageName, string.Empty, string.Empty, string.Empty, null, string.Empty, 1, 9999, out total);
                        break;
                    case "2":
                        lst = pcBll.GetList(LangInt, cid, string.Empty, string.Empty, string.Empty, null, string.Empty, 1, 9999, out total);
                        break;
                    case "3":
                    case "4":
                    default:
                        lst = pcBll.GetList(LangInt, string.Empty, string.Empty, string.Empty, lastUrl, null, string.Empty, 1, 9999, out total);
                        break;
                }
            }

            if (total > 0)
            {
                ltrTitle.Text = lst[0].ProductDesc.Title;
                ltrDetail.Text = lst[0].ProductDesc.Detail;

                string strHtml = WebUtils.GetMailTemplate(Path.Combine(Request.PhysicalApplicationPath, "TemplateMail/CategoryHeader.txt"));
                ltrHeaderCategory.Text = string.Format(strHtml
                    , WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], lst[0].Image)//Image
                    , lst[0].ProductDesc.Title
                    );

                WebUtils.SeoPage(lst[0].ProductDesc.MetaTitle, lst[0].ProductDesc.Metadescription, lst[0].ProductDesc.MetaKeyword, this.Page);
                WebUtils.SeoTagH(lst[0].ProductDesc.H1, lst[0].ProductDesc.H2, lst[0].ProductDesc.H3, this.Controls);

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

        #endregion
    }
}