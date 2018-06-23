using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Model;
using Cb.Utility;

namespace Cb.Web.Admin.Controls
{
    public partial class leftmenu : DGCUserControl
    {
        #region Parameter


        #endregion

        #region Common

        private void InitPage()
        {
            SetLink();
            GetUserInfo();
        }

        private void GetUserInfo()
        {
            PNK_User lstUser = (PNK_User)Session[Global.SESS_USER];
            switch (lstUser.Username)
            {
                case "congtt":
                    hypSeo.Visible = true;
                    break;
            }
        }

        private void SetLink()
        {
            //Category
            hypManageCategories.HRef = LinkHelper.GetAdminLink("productcategory");
            hypManageItem.HRef = LinkHelper.GetAdminLink("product");
            hypSlide.HRef = LinkHelper.GetAdminLink("slider");

            hypManageBooking.HRef = LinkHelper.GetAdminLink("booking");

            //User
            hypManageUser.HRef = LinkHelper.GetAdminLink("user");

            //Setting
            hypPage.HRef = LinkHelper.GetAdminLink("page");
            hypConfiguration.HRef = LinkHelper.GetAdminLink("config");
            hypSeo.HRef = LinkHelper.GetAdminLink("seo");

            //Logo
            hypLogo.HRef = Utils.CombineUrl(Template_path, "admin");

            //ContentStatic
            hypContentStatic.HRef = LinkHelper.GetAdminLink("contentstatic");

            //Booking Price
            hypManageBookingPrice.HRef = LinkHelper.GetAdminLink("bookingprice");

            //Booking Group
            hypManageBookingGroup.HRef = LinkHelper.GetAdminLink("bookinggroup");

            hypManageCountry.HRef = LinkHelper.GetAdminLink("country");

            hypExchageRate.HRef = LinkHelper.GetAdminLink("exchangerate");

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

        protected void hypClearCache_ServerClick(object sender, EventArgs e)
        {
            CacheHelper.ClearAll();
        }
    }
}