using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Model;
using System.Data;
using Cb.DBUtility;
using Cb.Localization;
using System.Globalization;
using Cb.BLL;
using Cb.Utility;
using Cb.BLL.Product;
using Cb.Model.Products;

namespace Cb.Web
{
    public partial class Template : System.Web.UI.MasterPage
    {
        #region Parameter

        protected string pageName, template_path = string.Empty, cid, cidsub, id;
        int total;

        #endregion

        #region Common

        private void InitPage()
        {
            try
            {
                this.template_path = WebUtils.GetWebPath();
                pageName = Utils.GetParameter("page", "home");
                cid = Utils.GetParameter("cid", string.Empty);
                cidsub = Utils.GetParameter("cidsub", string.Empty);
                id = Utils.GetParameter("id", string.Empty);

                //string pathUsc = pageName;
                //switch (pageName)
                //{
                //    case "home":
                //    case "trang-chu":
                //        pathUsc = "Pages/home.ascx";
                //        break;
                //    default:
                //        pathUsc = "Controls/block_breakumb.ascx";
                //        break;

                //}
                //UserControl contentView = (UserControl)Page.LoadControl(pathUsc);
                //childContent.Controls.Add(contentView);

                ProductCategoryBLL pcBllCate = new ProductCategoryBLL();
                IList<PNK_ProductCategory> lstCate = pcBllCate.GetList(1, pageName, string.Empty, int.MinValue, false, "p.ordering", 1, 9999, out  total);
                if (total > 0)
                {
                    string pagePath = lstCate[0].PageDetail.ToLower();
                    if (pagePath.Contains("template") && id != string.Empty && cidsub != "page")
                    {
                        top_menu.Visible = footer.Visible = main.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {


            }

            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Configuration item in lst)
                {
                    if (item.Key_name == Constant.Configuration.config_vchat)
                    {
                        // WebUtils.IncludeJSScript(this.Page, item.Value_name);
                    }
                }
            }
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            InitPage();
        }

        #endregion
    }
}