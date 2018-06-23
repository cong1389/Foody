using Cb.BLL;
using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Model;
using Cb.Model.Products;
using Cb.Utility;
using Cb.Web.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Cb.Web.Controls
{
    public partial class blog_left : DGCUserControl
    {
        #region Parameter

        protected string template_path, pageName, cid, cidsub, id, records, hot = string.Empty, feature = string.Empty, categoryID = string.Empty;
        int total;

        int totalSearch;

        IList<PNK_Product> _lstSearch;
        public IList<PNK_Product> lstSearch { set; get; }

        #endregion

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            cidsub = Utils.GetParameter("cidsub", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            GetConfig();
            GetProductCategory();

        }

        private void GetProductCategory()
        {
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lst = pcBll.GetListTree(LangInt, string.Empty, "1", int.MinValue, ConfigurationManager.AppSettings["parentIdLastBlog"], string.Empty, 0, true, string.Empty, 1, 9999, out total);
            //pcBll.GetList(LangInt, string.Empty, string.Empty, DBConvert.ParseInt(ConfigurationManager.AppSettings["parentIdLastBlog"]), false, "p.ordering", 1, 1000, out  total);
            if (total > 0)
            {
                rptCategory.DataSource = lst;
                rptCategory.DataBind();
            }


        }

        private void GetConfig()
        {
            //ConfigurationBLL pcBll = new ConfigurationBLL();
            //IList<PNK_Configuration> lst = pcBll.GetList();
            //if (lst != null && lst.Count > 0)
            //{
            //    foreach (PNK_Configuration item in lst)
            //    {
            //        if (LangInt == 1)
            //        {
            //            if (item.Key_name == Constant.Configuration.config_fbfanpage)
            //            {
            //                hypFBFP.HRef = item.Value_name;
            //            }
            //            else if (item.Key_name == Constant.Configuration.config_googleplus)
            //            {
            //                hypGooglePlus.HRef = item.Value_name;
            //            }
            //        }
            //        else
            //        {
            //            if (item.Key_name == Constant.Configuration.config_fbfanpage)
            //            {
            //                hypFBFP.HRef = item.Value_name;
            //            }

            //            else if (item.Key_name == Constant.Configuration.config_googleplus)
            //            {
            //                hypGooglePlus.HRef = item.Value_name;
            //            }
            //        }
            //    }
            //}
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

        protected void rptCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_ProductCategory data = e.Item.DataItem as PNK_ProductCategory;

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = data.ProductCategoryDesc.Name;

                HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;
                hypTitle.HRef = Utils.CombineUrl(Template_path, UtilityLocal.AppendLanguage(data.ProductCategoryDesc.TreeNameUrlDesc, LangId));
            }
        }

        #endregion
    }
}