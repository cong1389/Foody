using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cb.Web.Pages.BookingManagement
{
    public partial class Booking : DGCUserControl
    {
        #region Parameter

        protected string template_path, pageName, cid, cidsub, id, records, hot = string.Empty, feature = string.Empty, categoryID = string.Empty, parentID = string.Empty;
        int total, level = 0;

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

        ProductCategoryBLL pcBll = new ProductCategoryBLL();
        IList<PNK_Product> _lstSearch;

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
        }

        private string GetProductCategory()
        {
            if (Session["booking_categoryID"] != null)
            {
                categoryID = Session["booking_categoryID"].ToString();
            }

            //IList<PNK_ProductCategory> lst = pcBll.GetList(LangInt, cid, string.Empty, int.MinValue, false, "p.ordering", 1, 1000, out  total);
            //if (lst.Count > 0)
            //{
            ProductBLL pcBllProduct = new ProductBLL();
            IList<PNK_Product> lst2 = pcBllProduct.GetList(LangInt, string.Empty, "1", categoryID, cid, string.Empty, string.Empty, string.Empty, string.Empty, 1, 10, out  total);
            if (lst2.Count > 0)
            {
                ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst2[0], Request);
                block_booking.Title = lst2[0].ProductDesc.Title;

                //set price                
                block_booking.ProductId = DBConvert.ParseInt(lst2[0].Id);

                WebUtils.SeoPage(lst2[0].ProductDesc.MetaTitle, lst2[0].ProductDesc.Metadescription, lst2[0].ProductDesc.MetaKeyword, this.Page);
                WebUtils.SeoTagH(lst2[0].ProductDesc.H1, lst2[0].ProductDesc.H2, lst2[0].ProductDesc.H3, Controls);
            }

            //}

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