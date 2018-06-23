using Cb.BLL;
using Cb.Model;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Web.Admin.Pages
{
    public partial class home : System.Web.UI.UserControl
    {
        #region Parameter

        #endregion

        #region Common

        private void InitPage()
        {
            //Lượt truy cập
            //ltrTotal.Text = Application["AccessCount"].ToString();
            //ltrOnline.Text = Application["DangTruyCap"].ToString();
            //ltrToday.Text = Application["Today"].ToString();

            ////Đếm số lượng sản phẩm
            //Generic<PNK_Product> genProduct = new Generic<PNK_Product>();
            //IList<PNK_Product> lstPro = genProduct.GetAllBy(new PNK_Product(), null, null);
            //ltrProductCount.Text = lstPro.Count().ToString();

            ////Đếm số lượng người dùng
            //Generic<PNK_User> genUser = new Generic<PNK_User>();
            //IList<PNK_User> lstUser = genUser.GetAllBy(new PNK_User(), null, null);
            //ltrUserCount.Text = lstUser.Count().ToString();

            ////Get config
            //ConfigurationBLL pcBll = new ConfigurationBLL();
            //IList<PNK_Configuration> lst = pcBll.GetList();
            //foreach (PNK_Configuration item in lst)
            //{
            //    if (item.Key_name == Constant.Configuration.config_googleplus)
            //    {
            //        ltrLikeGooglePlus.Text = GetPlusOnes(item.Value_name);
            //    }
            //    else if (item.Key_name == Constant.Configuration.config_fbfanpage)
            //    {
            //        //ltrLikeFB.Text = GetFacebookLikes(item.Value_name);
            //    }
            //    else if (item.Key_name == Constant.Configuration.config_company_name_vi)
            //    {
            //        ltrCompany.Text = item.Value_name;
            //    }
            //}
        }

        private void SetLink()
        {
            //Category
            hypManageItem.HRef = LinkHelper.GetAdminLink("product");

            //User
            hypManageUser.HRef = LinkHelper.GetAdminLink("user");

            //Setting
            hypPageCompany.HRef = hypPageFB.HRef = hypPageGooglePlus.HRef = LinkHelper.GetAdminLink("page");
        }

        private string GetFacebookLikes(string FaceBookURL)
        {
            string FBLikes = string.Empty;
            try
            {
                string url = string.Format("https://api.facebook.com/method/fql.query?query=SELECT url, share_count, like_count, comment_count, total_count, click_count FROM link_stat where url='" + FaceBookURL + "'");

                XElement xdoc = null;
                XElement counts = null;
                xdoc = XElement.Load(url);

                IEnumerable<XElement> total_Like_count =
                    from elem in xdoc.Descendants()
                    where elem.Name.LocalName == "like_count"
                    select elem;

                counts = total_Like_count.First();
                FBLikes = Convert.ToString(counts.Value);
            }
            catch (Exception)
            {
            }
            return FBLikes;
        }

        private string GetPlusOnes(string url)
        {
            if (!string.IsNullOrEmpty(url))
            {
                // string fetchUrl =
                //"https://plusone.google.com/u/0/_/+1/fastbutton?url=" + HttpUtility.UrlEncode(url) + "&count=true";
                // HttpWebRequest request = (HttpWebRequest)WebRequest.Create(fetchUrl);
                // string response = new StreamReader(request.GetResponse().GetResponseStream()).ReadToEnd();
                // Match match = REGEX_GETURLCOUNT.Match(response);
                // if (match.Success)
                // {
                //     return match.Groups[1].Value;
                // }
            }
            return "0";
        }

        public static Regex REGEX_GETURLCOUNT = new Regex(@"<div[^>]+id=""aggregateCount""[^>]+>(\d*)</div>");

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                InitPage();
                SetLink();
            }
        }

        #endregion
    }
}