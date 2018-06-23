using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.BLL;
using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Model;
using Cb.Model.Products;
using Cb.Model.Xml;
using Cb.Utility;

namespace Cb.Web.Admin.Controls
{
    public partial class breakumb : DGCUserControl
    {
        #region Parameter

        protected string pageName = string.Empty, template_path = string.Empty, title = string.Empty;
        private int total = int.MinValue, cid = int.MinValue, id = int.MinValue;

        XMLConfigBLL xMLConfigBLL;
        XMLConfig xMLConfig;

        #endregion

        #region Common

        private void InitPage()
        {
            pageName = Utils.GetParameter("page", "home");
            cid = DBConvert.ParseInt(Utils.GetParameter("cid", string.Empty));
            id = DBConvert.ParseInt(Utils.GetParameter("id", string.Empty));

            xMLConfigBLL = new XMLConfigBLL();
            xMLConfig = new XMLConfig();

            hypHome.HRef = SiteNavigation.link_adminPage_rewrite;

            GetPageName();
        }

        private void GetPageName()
        {
            try
            {
                if (cid == int.MinValue)
                {
                    GetCategoryName();
                }
                else
                {
                    //Set tên danh mục
                    xMLConfig = GetCategoryName();

                    //Set tên sản phẩm
                    switch (pageName.Split('_')[1])
                    {
                        //Nếu là nhóm sản phẩm thì lấy tên nhóm sản phẩm cần chỉnh sửa
                        case "productcategory":
                            ProductCategoryBLL productCategoryBLL = new ProductCategoryBLL();
                            IList<PNK_ProductCategory> lst = productCategoryBLL.GetList(LangInt, string.Empty, string.Empty, cid, int.MinValue, false, string.Empty, 1, 100, out  total);
                            if (total > 0)
                            {
                                ltrHeader.Text = ltrProduct.Text = lst[0].ProductCategoryDesc.Name;

                                //Set SEO
                                title = string.Format("{0}-{1}", ltrCategory.Text, lst[0].ProductCategoryDesc.Name);
                                WebUtils.SeoPage(title, title, title, this.Page);
                            }
                            break;

                        //Nếu là sản phẩm thì lấy tên sản phẩm cần chỉnh sửa
                        case "product":
                            Generic<PNK_ProductDesc> genericProductDesc = new Generic<PNK_ProductDesc>();
                            IList<PNK_ProductDesc> lstProductDesc = genericProductDesc.GetAllBy(new PNK_ProductDesc(), string.Format(" where mainid = {0} AND LangId={1}", id, LangInt), null);
                            if (lstProductDesc != null && lstProductDesc.Count > 0)
                            {
                                ltrHeader.Text = ltrProduct.Text = lstProductDesc[0].Title;

                                //Set SEO
                                title = string.Format("{0}-{1}", ltrCategory.Text, lstProductDesc[0].Title);
                                WebUtils.SeoPage(title, title, title, this.Page);
                            }
                            break;

                        //Nếu là banner thì lấy tên sản phẩm cần chỉnh sửa
                        case "slider":
                            Generic<PNK_Banner> genericBanner = new Generic<PNK_Banner>();
                            IList<PNK_Banner> lstBanner = genericBanner.GetAllBy(new PNK_Banner(), string.Format(" where ID = {0}", cid), null);
                            if (lstBanner != null && lstBanner.Count > 0)
                            {
                                ltrHeader.Text = ltrProduct.Text = lstBanner[0].Name;

                                //Set SEO
                                title = string.Format("{0}-{1}", ltrCategory.Text, lstBanner[0].Name);
                                WebUtils.SeoPage(title, title, title, this.Page);
                            }
                            break;

                        //Nếu là user
                        case "user":
                            Generic<PNK_User> genericUser = new Generic<PNK_User>();
                            IList<PNK_User> lstUser = genericUser.GetAllBy(new PNK_User(), string.Format(" where ID = {0}", cid), null);
                            if (lstUser != null && lstUser.Count > 0)
                            {
                                ltrHeader.Text = ltrProduct.Text = lstUser[0].FullName;

                                //Set SEO
                                title = string.Format("{0}-{1}", ltrCategory.Text, lstUser[0].FullName);
                                WebUtils.SeoPage(title, title, title, this.Page);
                            }
                            break;

                        ////Nếu là user
                        //case "page":
                        //    Generic<PNK_Configuration> genericConfiguration = new Generic<PNK_Configuration>();
                        //    IList<PNK_Configuration> lstConfiguration = genericConfiguration.GetAllBy(new PNK_Configuration(), string.Format(" where ID = {0}", cid), null);
                        //    if (lstConfiguration != null && lstConfiguration.Count > 0)
                        //    {
                        //        ltrHeader.Text = ltrProduct.Text = lstConfiguration[0].FullName;
                        //    }
                        //    break;
                    }
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("GetPageName", "breakumb", ex.Message);
            }
        }

        private XMLConfig GetCategoryName()
        {
            xMLConfig = xMLConfigBLL.LoadPageByXml(pageName, Constant.DSC.IdXmlPageAdmin, id);
            if (xMLConfig.Att != "")
            {
                ltrHeader.Text = xMLConfig.Att;
                ltrCategory.Text = xMLConfig.Att;
                string category = xMLConfig.Value.Split('/')[1].ToLower();
                hypCategory.HRef = LinkHelper.GetAdminLink(category);

                //Set SEO
                WebUtils.SeoPage(xMLConfig.Att, xMLConfig.Att, xMLConfig.Att, this.Page);
            }

            return xMLConfig;
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