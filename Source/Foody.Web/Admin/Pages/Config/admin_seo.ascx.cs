using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Model;
using Cb.DBUtility;
using Cb.BLL;
using Cb.Localization;
using System.Data;
using System.IO;
using System.Configuration;
using System.Xml;
using System.Xml.Linq;
using System.Text;
using Cb.Utility;

namespace Cb.Web.Admin.Pages.Config
{
    public partial class admin_seo : System.Web.UI.UserControl
    {
        #region Parameter

        protected string template_path;
        private XMLConfigBLL xmlBll;

        #endregion

        #region Common

        /// <summary>
        /// Init page
        /// </summary>
        private void InitPage()
        {
            xmlBll = new XMLConfigBLL();

            BindPage();
        }

        private void BindPage()
        {
            xmlBll.getDataPageRobots(chkPage, Constant.DSC.IdXmlPageRobots);
        }

        public string WritePage(string agent)
        {
            StringBuilder sb = new StringBuilder();
            try
            {
                sb.AppendLine("User-agent: " + agent);
                foreach (ListItem chk in chkPage.Items)
                {
                    if (chk.Selected)
                    {
                        sb.AppendLine("Disallow: " + chk.Text + "/");
                    }
                }
            }
            catch (Exception ex)
            {
                //throw;
            }
            return sb.ToString();
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

        /// <summary>
        /// btnGenerateRobots_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnGenerateRobots_Click(object sender, EventArgs e)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                foreach (ListItem chkitem in chkChoice.Items)
                {
                    if (chkitem.Selected == true && chkitem.Text == "Google") sb.Append(WritePage("Googlebot"));
                    else if (chkitem.Selected == true && chkitem.Text == "Yahoo") sb.Append(WritePage("Slurp"));
                    else if (chkitem.Selected == true && chkitem.Text == "Bing") sb.Append(WritePage("bingbot"));
                    else if (chkitem.Selected == true && chkitem.Text == "Msn") sb.Append(WritePage("msnbot"));
                }

                System.IO.StreamWriter objStreamWriter = new System.IO.StreamWriter(HttpRuntime.AppDomainAppPath + "\\robots.txt");
                objStreamWriter.Write(sb.ToString());
                objStreamWriter.Close();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('{0}','Message');", Constant.UI.admin_msg_save_success), true);
            }
            catch (Exception ex)
            {
                //throw;
            }

        }

        #endregion
    }
}