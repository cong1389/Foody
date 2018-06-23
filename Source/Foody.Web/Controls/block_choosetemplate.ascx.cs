using Cb.BLL;
using Cb.Model;
using Cb.Model.ContentStatic;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.UI;

namespace Cb.Web.Controls
{
    public partial class block_choosetemplate : DGCUserControl
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

            GetWebsiteHot();

        }

        /// <summary>
        /// Get website tiêu biểu
        /// </summary>
        private void GetWebsiteHot()
        {
            ContentStaticBLL pcBll = new ContentStaticBLL();
            IList<PNK_ContentStatic> lst = pcBll.GetList(LangInt, string.Empty, ConfigurationManager.AppSettings["contentStatic_WebsiteHot"], string.Empty, 1, 1, out total);
            if (total > 0)
            {
                ltrWebsiteHot.Text = lst[0].ContentStaticDesc.Detail;
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