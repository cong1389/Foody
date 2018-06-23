using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.BLL.Product;
using Cb.Model.Products;
using Cb.Utility;
using System.Configuration;
using Cb.Web.Common;
using System.Web.UI.HtmlControls;
using System.Text;
using Cb.DBUtility;

namespace Cb.Web.Controls
{
    public partial class block_breakumb : DGCUserControl
    {
        #region Parameter

        protected string cid, cidSub, pageName, id, cidsub, template_path = string.Empty;
        private int total;
        Dictionary<string, object> dic = new Dictionary<string, object>();
        #endregion

        #region Common

        private void InitPage()
        {
            GetPageName();

            hypHome.HRef = WebUtils.RedirectHomePage();
        }

        private void GetPageName()
        {
            if (PageName == "trang-chu" || PageName == "home")
            {
                divBreakcrumb.Visible = false;
            }           
            StringBuilder sb = new StringBuilder();

            if (Session["maxLevel"] != null)
            {
                if (DBConvert.ParseBool(Session["maxLevel"]) == true)
                {
                    //Loại bỏ dấu ? để lấy link đúng
                    string url = Request.RawUrl.Split('?')[0];

                    //Cắt url, để lấy product name
                    string[] urlArr = url.Split('/').ToArray();
                    Array.Reverse(urlArr);
                    string lastUrl = urlArr[0];
                    if (lastUrl != string.Empty && lastUrl != "default.aspx" && !string.IsNullOrEmpty(lastUrl))
                    {
                        //Lấy url product
                        string urlCate = url.Substring(0, url.Length - lastUrl.Length - 1);                      

                        //Lấy url productCategory
                        dic = GetProductCategory(urlCate);
                    }
                }
            }
            else
            {
                dic = GetProductCategory(Request.RawUrl);
            }

            if (dic != null)
            {
                ltrResult.Text =dic["TreeNameUrl"].ToString();
            }
          
        }

        private Dictionary<string, object> GetProductCategory(string treeNameUrl)
        {
            Dictionary<string, object> dicCate = new Dictionary<string, object>();
            string result_TreeNameUrl = string.Empty, result_TreeName = string.Empty;
            treeNameUrl = UtilityLocal.RemoveLanguage(treeNameUrl, LangId);
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lstCate = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, string.Empty, treeNameUrl, 1, true, string.Empty, 1, 9999, out total);
            StringBuilder sb = new StringBuilder();
            if (lstCate.Count > 0)
            {
                string[] arrTreeNameUrlUnicodeDesc = lstCate[0].ProductCategoryDesc.TreeNameUrlUnicodeDesc.Split('/');
                string[] arrTreeNameUrl = lstCate[0].ProductCategoryDesc.TreeNameUrlDesc.Split('/');

                if (arrTreeNameUrlUnicodeDesc != null)
                {

                    for (int i = 0; i < arrTreeNameUrlUnicodeDesc.Length; i++)
                    {
                        result_TreeNameUrl = i == 0 ? LinkHelper.GetLink(PageName, LangId) : string.Format("{0}/{1}", result_TreeNameUrl, arrTreeNameUrl[i]);
                        result_TreeName = result_TreeName + arrTreeNameUrlUnicodeDesc[i];
                        sb.AppendFormat("<li><a href='{0}'>{1}</a></li>", result_TreeNameUrl, arrTreeNameUrlUnicodeDesc[i]);
                    }
                }
            }
            dicCate.Add("TreeNameUrl", sb);
            //dicCate.Add("TreeName", result_TreeName);
            return dicCate;
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