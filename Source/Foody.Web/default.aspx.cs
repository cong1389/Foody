using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.BLL;
using Cb.Model;
using Cb.DBUtility;
using Cb.Model.Products;
using Cb.BLL.Product;
using Cb.Localization;
using System.Configuration;
using Cb.Utility;
using Cb.Web.Common;
using System.Threading;
using System.Globalization;

namespace Cb.Web
{
    public partial class _default : DGCPage
    {
        #region Parameter

        protected string cid, cidsub, pageName, id, idsub, template_path = string.Empty, langId = string.Empty, pagePath = string.Empty, page = string.Empty;
        string lastUrl = string.Empty, forwardUrl = string.Empty;
        private int total;

        #endregion

        #region Common

        private void GetPageName(string pageName)
        {
            try
            {
                //cid = Utils.GetParameter("page", string.Empty);
                cid = Utils.GetParameter("cid", string.Empty);
                cidsub = Utils.GetParameter("cidsub", string.Empty);
                id = Utils.GetParameter("id", string.Empty);
                idsub = Utils.GetParameter("idsub", string.Empty);

                if (pageName == "booking")
                {
                    pageName = "Pages/BookingManagement/Booking.ascx";
                    Session["level"] = 1;
                }
                else
                {
                    ProductCategoryBLL pcBll = new ProductCategoryBLL();
                    IList<PNK_ProductCategory> lst = null;
                    string treeNameUrl = UtilityLocal.RemoveLanguage(Request.RawUrl, LangId);
                    if (pageName == "trang-chu" || pageName == "home")
                    {
                        lst = pcBll.GetList(LangInt, pageName, string.Empty, int.MinValue, false, "p.ordering", 1, 9999, out total);
                        if (lst.Count > 0)
                        {
                            pageName = lst[0].Page;
                            Session["level"] = lst[0].PathTree.Count(i => i.Equals('.'));
                        }
                    }
                    if (treeNameUrl != string.Empty && (pageName != "trang-chu" || pageName != "home"))
                    {
                        lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, string.Empty, treeNameUrl, 1, true, string.Empty, 1, 9999, out total);
                        if (lst.Count > 0)
                        {
                            pageName = lst[0].Page;
                            Session["level"] = lst[0].ProductCategoryDesc.TreeLevelDesc;
                        }
                        else
                        {
                            //Loại bỏ dấu ? để lấy link đúng
                            string url = Request.RawUrl.Split('?')[0];

                            //Cắt url, để lấy product name
                            string[] urlArr = url.Split('/').ToArray();
                            Array.Reverse(urlArr);
                            lastUrl = urlArr[0];
                            forwardUrl = urlArr[1] == LangId ? urlArr[2] : urlArr[1];
                            if (lastUrl != string.Empty && lastUrl != "default.aspx" && !string.IsNullOrEmpty(lastUrl))
                            {
                                ProductBLL pcBllProduct = new ProductBLL();
                                IList<PNK_Product> lstProduct = pcBllProduct.GetList(LangInt, forwardUrl, string.Empty, string.Empty, lastUrl, null, string.Empty, 1, 9999, out total);
                                if (total > 0)
                                {
                                    // lstProduct = lstProduct.Where(p => p.ProductDesc.TitleUrl == idsub).ToList();
                                    pageName = lstProduct[0].Page;
                                    Session["level"] = urlArr.Length;
                                    Session["maxLevel"] = true;
                                }
                            }
                        }
                    }
                }

                UserControl contentView = (UserControl)Page.LoadControl(pageName);
                phdContent.Controls.Add(contentView);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("default.aspx", "GetPageName", ex.Message);
            }

        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {


            //if (!Page.IsPostBack)
            //{
            pageName = Utils.GetParameter("page", "home");
            GetPageName(pageName);
            //}

            Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-US");
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
        }

        #endregion
    }
}