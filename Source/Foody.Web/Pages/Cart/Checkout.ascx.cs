using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Model.CardProduct;
using Cb.Model.Products;
using Cb.Utility;
using Cb.Web.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Cb.Web.Pages.Cart
{
    public partial class Checkout : DGCUserControl
    {
        #region Paramter

        int total;

        #endregion

        #region Common

        private void InitPage()
        {
            GetProductCategory();
        }

        private void GetProductCategory()
        {
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            string treeNameUrl = UtilityLocal.RemoveLanguage(Request.RawUrl, LangId);
            IList<PNK_ProductCategory> lstAll = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, string.Empty, treeNameUrl, 1, true, string.Empty, 1, 9999, out total);
            if (lstAll.Count > 0)
            {
                ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lstAll[0], Request);
            }
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitPage();
            }
        }


        #endregion
    }
}