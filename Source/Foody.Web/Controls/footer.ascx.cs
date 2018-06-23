using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Localization;
using Cb.Model;
using System.Globalization;
using Cb.BLL;
using System.IO;
using Cb.Utility;
using Cb.BLL.Product;
using Cb.Model.Products;
using Cb.DBUtility;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Data;
using System.Web.UI.HtmlControls;
using Cb.Web.Common;

namespace Cb.Web.Controls
{
    public partial class footer : DGCUserControl
    {
        #region Parameter

        protected string pageName, template_path = string.Empty;

        private int id, total;

        #endregion

        #region Common

        private void InitPage()
        {
            //ltrAboutUs.Text = LocalizationUtility.GetText("ltrAboutUs", Ci);
            ltrAddressName.Text = ltrAddressHeader.Text = LocalizationUtility.GetText("ltrAddressName", Ci);
            ltrPhoneName.Text = LocalizationUtility.GetText("ltrPhoneName", Ci);
            ltrContactSocial.Text = LocalizationUtility.GetText("ltrContactSocial", Ci);
            //ltrReciveEmail.Text = LocalizationUtility.GetText("ltrReciveEmail", Ci);
            ltrLastNews.Text = LocalizationUtility.GetText("ltrLastNews", Ci);

            GetContact();
            GetConfig();
            GetLastBlog();
        }

        /// <summary>
        /// Blog cuối cùng
        /// </summary>
        private void GetLastBlog()
        {
            ProductBLL pcBll = new ProductBLL();
            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + DBConvert.ParseInt(ConfigurationManager.AppSettings["parentIdLastBlog"]) + ",1)", null);
            string[] array = dtb.AsEnumerable()
                                .Select(row => row.Field<Int32>("id").ToString())
                                .ToArray();
            string idFirst = string.Join(",", array);
            IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, string.Empty, string.Empty, 1, 3, out  total);
            if (total > 0)
            {
                rptLastBlog.DataSource = lst.OrderByDescending(m => m.PostDate);
                rptLastBlog.DataBind();
            }
        }

        private void GetContact()
        {
            //ProductBLL pcBll = new ProductBLL();
            //IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, "1", ConfigurationManager.AppSettings["parentIdContact"], string.Empty, 1, 100, out total);
            //if (total > 0)
            //{
            //    //ltrContactDetail.Text = Regex.Replace(lst[0].ProductDesc.Detail.Substring(0, 700), @"<[^>]*(>|$)|&nbsp;|&zwnj;|&raquo;|&laquo;", string.Empty).Trim();
            //}
        }

        private void GetConfig()
        {
            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Configuration item in lst)
                {
                    if (LangInt == 1)
                    {
                        if (item.Key_name == Constant.Configuration.config_address_vi)
                        {
                            ltrAddressValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.phone)
                        {
                            ltrPhoneValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.fax)
                        {
                            ltrFax.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.yahooid)
                        {
                            ltrFooterContact.Text = DBHelper.getTruncate(item.Value_name, 40);
                        }
                        //else if (item.Key_name == Constant.Configuration.config_googleplus)
                        //{
                        //    hypGooglePlus.HRef = item.Value_name;
                        //}
                       
                        else if (item.Key_name == Constant.Configuration.email)
                        {
                            ltrEmail.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.config_logoFooter)
                        {
                            logoFooter.Src = WebUtils.GetUrlImage(Constant.DSC.AdvUploadFolder, item.Value_name);
                            hypLogoFooter.HRef = WebUtils.RedirectHomePage();
                        }
                        else if (item.Key_name == Constant.Configuration.config_footer)
                        {
                            ltrConfig_footer.Text = item.Value_name;
                        }
                    }
                    else
                    {
                        if (item.Key_name == Constant.Configuration.config_address1_vi)
                        {
                            ltrAddressValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.phone)
                        {
                            ltrPhoneValue.Text = item.Value_name;
                        }
                        //else if (item.Key_name == Constant.Configuration.config_fbfanpage)
                        //{
                        //    hypFBFP.HRef = item.Value_name;
                        //}
                        else if (item.Key_name == Constant.Configuration.yahooid)
                        {
                            ltrFooterContact.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.fax)
                        {
                            ltrFax.Text = item.Value_name;
                        }

                        else if (item.Key_name == Constant.Configuration.email)
                        {
                            ltrEmail.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.config_logoFooter)
                        {
                            logoFooter.Src = WebUtils.GetUrlImage(Constant.DSC.AdvUploadFolder, item.Value_name);
                            hypLogoFooter.HRef = WebUtils.RedirectHomePage();
                        }
                        else if (item.Key_name == Constant.Configuration.config_footer)
                        {
                            ltrConfig_footer.Text = item.Value_name;
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

        protected void rptLastBlog_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_Product data = e.Item.DataItem as PNK_Product;

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);

                HtmlAnchor hypImg = e.Item.FindControl("hypImg") as HtmlAnchor;
                HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;

                //string cid = Utils.GetParameter("cid", string.Empty);
                //string link = UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId);
                //int level = link.Count(i => i.Equals('/'));

                //if (level == 3)
                //{
                //    hypTitle.HRef = hypImg.HRef = LinkHelper.GetLink(pageName, LangId, cid, data.CategoryUrlDesc, data.ProductDesc.TitleUrl);
                //}
                //else if (level == 2)
                //{
                //    hypTitle.HRef = hypImg.HRef = LinkHelper.GetLink(link, LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
                //}
                //else if (level == 1)
                //{
                //    hypTitle.HRef = hypImg.HRef = LinkHelper.GetLink(UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId), LocalizationUtility.GetText("linkCate", Ci), LocalizationUtility.GetText("linktmp", Ci), data.ProductDesc.TitleUrl);
                //}

                Dictionary<string, object> dic = UtilityLocal.GetHRefByLevel(data, LangInt, LangId, Ci);
                hypTitle.HRef = hypImg.HRef = dic["HRef"].ToString();

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                hypTitle.Title = hypImg.Title = img.Alt = img.Attributes["title"] = ltrTitle.Text = hypImg.Title = data.ProductDesc.Title;

                Literal ltrDate = e.Item.FindControl("ltrDate") as Literal;
                ltrDate.Text = data.PostDate.ToString("dd/MM/yyyy");

            }
        }

        #endregion
    }
}