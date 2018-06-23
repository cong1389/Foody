using Cb.BLL;
using Cb.BLL.Product;
using Cb.Localization;
using Cb.Model;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Cb.Web.Controls
{
    public partial class block_like : System.Web.UI.UserControl
    {
        #region Parameter

        protected string template_path, pageName, cid, id, records;

        #endregion

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            GetConfig();
        }


        private void GetConfig()
        {
            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Configuration item in lst)
                {
                    if (item.Key_name == Constant.Configuration.config_fblike)
                    {
                        ltrFBLike.Text = string.Format(" <a href=\"javascript:void(0)\" class=\"facebook\" onclick=\"st_buildingx_PopupCenterDual('{0}','facebook',600,600);\"> <img src=\"/images/fb.png\"><span></span></a>", item.Value_name);
                    }
                    else if (item.Key_name == Constant.Configuration.config_twitter)
                    {
                        ltrTwiter.Text = string.Format(" <a href=\"javascript:void(0)\" class=\"twitter\" onclick=\"st_buildingx_PopupCenterDual('{0}','twitter',600,600);\"> <img src=\"/images/twitter.png\"> <span></span></a>", item.Value_name);
                    }
                    else if (item.Key_name == Constant.Configuration.config_pinterest)
                    {
                        ltrPinterest.Text = string.Format(" <a href=\"javascript:void(0)\" class=\"instagram\" onclick=\"st_buildingx_PopupCenterDual('{0}','pinterest',600,600);\"> <i class=\"fa fa-pinterest\"></i><span></span></a>", item.Value_name);
                    }
                    else if (item.Key_name == Constant.Configuration.config_googleplus)
                    {
                        ltrGooglePlus.Text = string.Format(" <a href=\"javascript:void(0)\" class=\"dribble\" onclick=\"st_buildingx_PopupCenterDual('{0}','google',600,600);\"> <img src=\"/images/googleplus.png\"><span></span></a>", item.Value_name);
                    }
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

        #endregion
    }
}