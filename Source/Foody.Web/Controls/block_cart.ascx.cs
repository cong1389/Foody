// =============================================
// Author:		Congtt
// Create date: 22/09/2014
// Description:	block xem số lượng sản phẩm đã chọn
// =============================================

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Utility;
using Cb.Model.CardProduct;
using Cb.DBUtility;
using Cb.Localization;

namespace Cb.Web.Controls
{
    public partial class block_cart : DGCUserControl
    {
        #region Paramter



        #endregion

        #region Common

        private void InitPage()
        {
            hypCartView.HRef = LinkHelper.GetLink(Utils.RemoveUnicode(LocalizationUtility.GetText("ltrCartView", Ci)), LangId);
            //IList<PNK_CartProduct> lst = Session["Cart"] as IList<PNK_CartProduct>;
            //if (lst != null)
            //{
            //   // lblQuantity.Text = string.Format("{0} ({1})", LocalizationUtility.GetText(lblQuantity.ID, Ci), DBConvert.ParseString(lst.Count));
            //}
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