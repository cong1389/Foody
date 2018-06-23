using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using Cb.Model;
using Cb.Localization;
using Cb.BLL;
using System.IO;
using Cb.Model.Products;
using Cb.BLL.Product;
using Cb.DBUtility;
using System.Configuration;
using System.Web.UI.HtmlControls;
using Cb.Utility;

namespace Cb.Web.Controls
{
    public partial class top_menu : DGCUserControl
    {
        #region Parameter

        protected string pageName, template_path = string.Empty;

        private int id, total;

        IList<PNK_ProductCategory> lstAll;
        IList<PNK_ProductCategory> lstParent;
        private ProductCategoryBLL pcBll
        {
            get
            {
                if (ViewState["pcBll"] != null)
                    return (ProductCategoryBLL)ViewState["pcBll"];
                else return new ProductCategoryBLL();
            }
            set
            {
                ViewState["pcBll"] = value;
            }
        }

        #endregion

        #region Common

        private void InitPage()
        {
            GetMenu();
            GetLogo();

            //ltrRequest.Text = LocalizationUtility.GetText("ltrRequest", Ci);
            //hypRequest.HRef = LinkHelper.GetLink(Utils.RemoveUnicode(LocalizationUtility.GetText("ltrRequest", Ci)), LangId);

            //ltrService.Text = "Email";
            //hypService.HRef = LinkHelper.GetLink(Utils.RemoveUnicode(LocalizationUtility.GetText("ltrService", Ci)), LangId);

            //ltrPricing.Text = "Phone";
            //hypPricing.HRef = LinkHelper.GetLink(Utils.RemoveUnicode(LocalizationUtility.GetText("ltrPricing", Ci)), LangId);
        }

        /// <summary>
        /// Get menu voi ParentID=0
        /// </summary>
        private void GetMenu()
        {
            //Lấy danh sách tổng bao gồm danh mục cha và cả danh mục con
            lstAll = pcBll.GetList(LangInt, string.Empty, "1", int.MinValue, true, "p.ordering", 1, 1000, out total);

            //Lấy danh sách danh mục cha có ParentID==0 gán vào menu cha
            lstParent = lstAll.Where(m => m.ParentId == 0).ToList();
            if (total > 0)
            {
                rptResult.DataSource = lstParent;
                rptResult.DataBind();
            }
        }

        private void GetLogo()
        {
            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Configuration item in lst)
                {
                    if (item.Key_name == Constant.Configuration.config_logoHeader)
                    {
                        imgLogoSticky.Src = imgLogo.Src = WebUtils.GetUrlImage(Constant.DSC.AdvUploadFolder, item.Value_name);
                        hypImgHomePage.HRef = hypImgHomePagesticky.HRef = WebUtils.RedirectHomePage();

                    }
                    else if (item.Key_name == Constant.Configuration.phone)
                    {
                        ltrPhoneValue.Text = item.Value_name;
                    }
                    else if (item.Key_name == Constant.Configuration.email)
                    {
                       // ltrEmail.Text = item.Value_name;
                    }
                    if (LangInt == 1)
                    {
                        if (item.Key_name == Constant.Configuration.config_address_vi)
                        {
                            //ltrAddressValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.phone)
                        {
                            ltrPhoneValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.email)
                        {
                            //ltrEmail.Text = item.Value_name;
                        }
                        
                    }
                    else
                    {
                        if (item.Key_name == Constant.Configuration.config_address1_vi)
                        {
                           // ltrAddressValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.phone)
                        {
                            ltrPhoneValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.email)
                        {
                           // ltrEmail.Text = item.Value_name;
                        }                       
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

        protected void rptResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_ProductCategory data = e.Item.DataItem as PNK_ProductCategory;

                HtmlAnchor hypName = e.Item.FindControl("hypName") as HtmlAnchor;
                hddParentNameUrl.Value = hypName.HRef = LinkHelper.GetLink(data.ProductCategoryDesc.NameUrl, LangId);

                Literal ltrName = e.Item.FindControl("ltrName") as Literal;
                hypName.Title = hypName.Title = ltrName.Text = data.ProductCategoryDesc.Name;

                //Set menu Icon Home 
                if (data.ProductCategoryDesc.Id == DBConvert.ParseInt(ConfigurationManager.AppSettings["parentIdHome"]))
                {

                    //Literal ltrIconHome = e.Item.FindControl("ltrIconHome") as Literal;
                    //ltrIconHome.Text = "<span class=\"icon-homeChurch\"></span>";
                }

                //Sub menu con
                //Lấy danh sách danh mục con có ParentID > 0 gán vào menu con
                IList<PNK_ProductCategory> lstSub = lstAll.Where(m => m.ParentId == data.Id).ToList();
                if (lstSub.Count() > 0)
                {
                    HtmlGenericControl ulSub = (HtmlGenericControl)e.Item.FindControl("ulSub");
                    ulSub.Visible = true;

                    hddParentNameUrl.Value = data.ProductCategoryDesc.NameUrl;
                    //hypName.Attributes.Add("data-toggle", "dropdown");

                    //Set Icon menu con
                    HtmlGenericControl liDown = (HtmlGenericControl)e.Item.FindControl("liDown");
                    liDown.Attributes["class"] = "menu-item menu-item-has-children";

                    Repeater rptResultSub = e.Item.FindControl("rptResultSub2") as Repeater;
                    rptResultSub.DataSource = lstSub;
                    rptResultSub.DataBind();
                }
            }
        }

        protected void rptResultSub2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater dataParent = (Repeater)e.Item.Parent;

                PNK_ProductCategory data = e.Item.DataItem as PNK_ProductCategory;

                HtmlAnchor hypNameSub2 = e.Item.FindControl("hypNameSub2") as HtmlAnchor;
                //hypNameSub2.HRef = LinkHelper.GetLink(data.ProductCategoryDesc.NameUrl, LangId);
                hypNameSub2.HRef = LinkHelper.GetLink(hddParentNameUrl.Value, LangId, data.ProductCategoryDesc.NameUrl);

                Literal ltrNameSub2 = e.Item.FindControl("ltrNameSub2") as Literal;
                hypNameSub2.Title = hypNameSub2.Title = ltrNameSub2.Text = data.ProductCategoryDesc.Name;
            }
        }

        #endregion
    }
}