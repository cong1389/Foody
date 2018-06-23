using Cb.BLL.Product;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cb.Web.Pages.TemplateManagement
{
    public partial class TemplateDetail : DGCUserControl
    {
        #region Parameter

        protected string title, metaDescription, metaKeyword, h1, h2, h3, analytic;
        protected string template_path, pageName, cid, cidsub, id, records;
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

            hypBack.HRef = WebUtils.RedirectHomePage();

            previewFrame.Attributes.Add("src", string.Format("/Resource/Source_Demo/{0}/{1}/index.html", cid, id));

            GetDetail();
        }

        private void GetDetail()
        {
            ProductBLL pcBll = new ProductBLL();           
            IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, string.Empty, string.Empty, id, null, string.Empty, 1, 9999, out total);
            if (total > 0)
            {
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