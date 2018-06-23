using Cb.BLL;
using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Localization;
using Cb.Model;
using Cb.Model.Products;
using Cb.Utility;
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
    public partial class block_categorypagetemplate : DGCUserControl
    {
        #region Parameter

        protected string template_path, pageName, cid, cidsub, id, records, hot = string.Empty, feature = string.Empty, categoryID = string.Empty;
        int total = 0;

        #endregion

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            cidsub = Utils.GetParameter("cidsub", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            ltrWebsite.Text = LocalizationUtility.GetText("ltrWebsite", Ci);
            ltrQuestion.Text = LocalizationUtility.GetText("ltrQuestion", Ci);
            ltrThemeOther.Text = LocalizationUtility.GetText("ltrThemeOther", Ci);

            ltrRegistration.Text = LocalizationUtility.GetText("ltrRegistration", Ci);
            hypRequest.HRef = LinkHelper.GetLink(Utils.RemoveUnicode(LocalizationUtility.GetText("ltrRequest", Ci)), LangId);

            GetProduct();
            GetConfig();
        }

        private void GetProduct()
        {
            try
            {
                ProductBLL pcBll = new ProductBLL();
                IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, string.Empty, string.Empty, id, null, string.Empty, 1, 9999, out total);
                if (total > 0)
                {
                    ltrTitle.Text = lst[0].ProductDesc.Title;
                    imgPC.Src = imgMobile.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], lst[0].Image);
                    hypViewTemplate.HRef = LinkHelper.GetLink(pageName, LangId, cid, lst[0].CategoryUrlDesc, lst[0].ProductDesc.TitleUrl);
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("block_categorypagetemplate", "GetProduct", ex.Message);
            }
        }

        private void GetConfig()
        {
            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Configuration item in lst)
                {
                    if (item.Key_name == Constant.Configuration.phone)
                    {
                        ltrPhoneValue.Text = item.Value_name;
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