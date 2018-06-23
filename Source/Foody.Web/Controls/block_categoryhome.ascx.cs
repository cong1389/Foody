using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Cb.Web.Common;
using Cb.Localization;
using System.Text;

namespace Cb.Web.Controls
{
    public partial class block_categoryhome : DGCUserControl
    {
        #region Parameter

        protected string categoryID, title, metaDescription, metaKeyword, h1, h2, h3, analytic, pageName, cid, cidsub, id;
        int total = 0;

        string categoryIdByPass = string.Empty;
        public string CategoryIdByPass
        {
            get
            {
                if (CategoryIdByPass != string.Empty)
                    return categoryIdByPass;
                else
                    return string.Empty;
            }
            set
            {
                categoryIdByPass = value;
            }
        }

        string categoryNamePass = string.Empty;
        public string CategoryNamePass
        {
            get
            {
                if (categoryNamePass != string.Empty)
                    return categoryIdByPass;
                else
                    return string.Empty;
            }
            set
            {
                categoryNamePass = value;
            }
        }

        #endregion

        #region Common
        private void InitPage()
        {
            GetProductCategory();
            GetLastWork();
        }

        private void GetLastWork()
        {
            ProductBLL pcBll = new ProductBLL();
            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + DBConvert.ParseInt(categoryIdByPass) + ",1)", null);
            string[] array = dtb.AsEnumerable()
                                .Select(row => row.Field<Int32>("id").ToString())
                                .ToArray();
            string idFirst = string.Join(",", array);
            IList<PNK_Product> lst = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, string.Empty, "1", 1, 8, out total);
            if (total > 0)
            {
                ltrLastWork.Text = lst[0].CategoryNameDesc;
                rptResult.DataSource = lst.OrderByDescending(m => m.PostDate);
                rptResult.DataBind();
            }
        }

        private void GetProductCategory()
        {
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lst = null;
            //if (pageName == "home" || pageName == "trang-chu")
            //{
            lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, categoryIdByPass, string.Empty, 1, true, string.Empty, 1, 9999, out total);
            if (lst.Count > 0)
            {
                secCategory.Attributes.Add("style", string.Format("padding-top: 10px; padding-bottom: 20px; background: url('{0}') 50% -80.7422px/cover no-repeat;", WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductCategoryUpload"], lst[0].BaseImage)));                                
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
                PNK_Product data = e.Item.DataItem as PNK_Product;

                string src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);
                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = src;
                string srcset = string.Format("{0} 300w, {1} 420w, {2} 690w", src, src, src);
                img.Attributes.Add("srcset", srcset);

                HtmlAnchor hypImg = e.Item.FindControl("hypImg") as HtmlAnchor;

                //Dictionary<string, object> dic = UtilityLocal.GetHRefByLevel(data, LangInt, LangId, Ci);
                hypImg.HRef = LinkHelper.GetLink(UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId), data.ProductDesc.TitleUrl);

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = hypImg.Title = data.ProductDesc.Title;

                #region Price

                StringBuilder sbPrice = new StringBuilder();
                //Nếu không có giá giảm
                if (string.IsNullOrWhiteSpace(data.Post))
                {
                    string normalPrice = data.Website == "" ? "<ins><span class=\"amount\">Call</span></ins>" : string.Format("{0} USD", data.Website);
                    sbPrice.AppendFormat("<ins><span class=\"amount\">{0}</span></ins>", normalPrice);
                }
                //Nếu có giá giảm
                else
                {
                    string normalPrice = data.Website == "" ? "Call" : string.Format("{0} USD", data.Website);
                    if (data.Website != "")
                    {
                        decimal discountPercent = ((DBConvert.ParseDecimal(data.Website) - DBConvert.ParseDecimal(data.Post)) / DBConvert.ParseDecimal(data.Website)) * 100;
                        sbPrice.AppendFormat("<ins><span class=\"amount\">{0} USD</span></ins>", data.Post);
                        sbPrice.AppendFormat("<del><span class=\"amount\">{0} USD</span></del>", data.Website);

                        //Show icon sale price
                        HtmlControl divIsSale = e.Item.FindControl("divIsSale") as HtmlControl;
                        divIsSale.Style.Add("display", "block");
                    }
                    else
                        sbPrice.Append("<ins><span class=\"amount\">Call</span></ins>");
                }
                Literal ltrPrice = e.Item.FindControl("ltrPrice") as Literal;
                ltrPrice.Text = sbPrice.ToString();

                #endregion

                Literal ltrDate = e.Item.FindControl("ltrDate") as Literal;
                ltrDate.Text = data.Bedroom;

                Literal ltrBrief = e.Item.FindControl("ltrBrief") as Literal;
                ltrBrief.Text = DBHelper.getTruncate(data.ProductDesc.Brief, 20);
            }
        }

        #endregion
    }
}