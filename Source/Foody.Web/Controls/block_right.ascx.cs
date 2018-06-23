using System;
using System.Collections.Generic;
using System.Web.UI;
using Cb.Utility;
using Cb.Model;
using System.Configuration;
using Cb.BLL;
using Cb.Model.ContentStatic;

namespace Cb.Web.Controls
{
    public partial class block_right : DGCUserControl
    {
        #region Parameter

        protected string template_path, pageName, nameurl, url, cid, cidsub, id;
        int total;

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
            GetHowToBook();
            GetCustomizeTours();
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
                        //if (item.Key_name == Constant.Configuration.config_address_vi)
                        //{
                        //    ltrAddressValue.Text = item.Value_name;
                        //}
                        if (item.Key_name == Constant.Configuration.phone)
                        {
                            ltrPhoneValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.email)
                        {
                            ltrEmail.Text = item.Value_name;
                            hypEmail.HRef = string.Format("mailto:{0}", item.Value_name);
                        }
                    }
                    else
                    {
                        if (item.Key_name == Constant.Configuration.phone)
                        {
                            ltrPhoneValue.Text = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.email)
                        {
                            ltrEmail.Text = item.Value_name;
                            hypEmail.HRef = string.Format("mailto:{0}", item.Value_name);
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Get count
        /// </summary>
        private void GetHowToBook()
        {
            ContentStaticBLL pcBll = new ContentStaticBLL();
            IList<PNK_ContentStatic> lst = pcBll.GetList(LangInt, string.Empty, ConfigurationManager.AppSettings["contentStatic_HowToBook"], string.Empty, 1, 1, out total);
            if (total > 0)
            {
                ltrHowToBook.Text = lst[0].ContentStaticDesc.Brief;
            }
        }

        /// <summary>
        /// Get count
        /// </summary>
        private void GetCustomizeTours()
        {
            ContentStaticBLL pcBll = new ContentStaticBLL();
            IList<PNK_ContentStatic> lst = pcBll.GetList(LangInt, string.Empty, ConfigurationManager.AppSettings["contentStatic_CustomTour"], string.Empty, 1, 1, out total);
            if (total > 0)
            {
                divCustomTour.Attributes.Add("style", "block");
                ltrCustomTours.Text = lst[0].ContentStaticDesc.Brief;
            }
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Page.IsPostBack)
            //{
                InitPage();
            //}
        }

        #endregion
    }
}