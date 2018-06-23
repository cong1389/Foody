using Cb.BLL;
using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Localization;
using Cb.Model;
using Cb.Model.Products;
using Cb.Utility;
using Cb.Web.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Cb.Web.Pages.CategoryManagement
{
    public partial class CategoryDetail : DGCUserControl
    {
        #region Parameter

        private string title, metaDescription, metaKeyword, h1, h2, h3, analytic, background, categoryID = string.Empty;
        protected string template_path, pageName, cid, id, idsub, cidsub, records;
        string lastUrl = string.Empty, forwardUrl = string.Empty;

        int total, productId;
        Dictionary<string, object> dic = new Dictionary<string, object>();

        ProductBLL pcBll = null;

        protected int currentPageIndex
        {
            get
            {
                if (ViewState["CurrentPageIndex"] != null)
                    return int.Parse(ViewState["CurrentPageIndex"].ToString());
                else
                    return 1;
            }
            set
            {
                ViewState["CurrentPageIndex"] = value;
            }
        }

        #endregion

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            cidsub = Utils.GetParameter("cidsub", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            //ltrAdminIntro.Text = LocalizationUtility.GetText("ltrAdminIntro", Ci);

            GetDetail();
            GetProductCategory();
            GetProductSale();
        }

        private void GetDetail()
        {
            pcBll = new ProductBLL();
            IList<PNK_Product> lst = null;
            
            //Loại bỏ dấu ? để lấy link đúng
            string url = Request.RawUrl.Split('?')[0];

            //Cắt url, để lấy product name
            string[] urlArr = url.Split('/').ToArray();
            Array.Reverse(urlArr);
            lastUrl = urlArr[0];
            forwardUrl = urlArr[1];
            if (lastUrl != string.Empty && lastUrl != "default.aspx" && !string.IsNullOrEmpty(lastUrl))
            {
                lst = pcBll.GetList(LangInt, forwardUrl, string.Empty, string.Empty, lastUrl, null, string.Empty, 1, 9999, out total);
            }

            if (total > 0)
            {
                ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lst[0], Request);

                ltrTitle.Text = lst[0].ProductDesc.Title;
                ltrBrief.Text = lst[0].ProductDesc.Brief;
                ltrDetail.Text = lst[0].ProductDesc.Detail;

                ltrTourCode.Text = lst[0].Status;
                ltrLength.Text = lst[0].Area;
                ltrStartFrom.Text = lst[0].Bedroom;
                ltrTourType.Text = lst[0].Province;

                #region Price

                StringBuilder sbPrice = new StringBuilder();
                //Nếu không có giá giảm
                if (string.IsNullOrWhiteSpace(lst[0].Post))
                {
                    string normalPrice = lst[0].Website == "" ? "<ins><span class=\"amount\">Call</span></ins>" : string.Format("{0} USD", lst[0].Website);
                    sbPrice.AppendFormat("<ins><span class=\"amount\">Price from {0}</span></ins>", normalPrice);
                }
                //Nếu có giá giảm
                else
                {
                    string normalPrice = lst[0].Website == "" ? "Call" : string.Format("$USD {0}", lst[0].Website);
                    if (lst[0].Website != "")
                    {
                        decimal discountPercent = ((DBConvert.ParseDecimal(lst[0].Website) - DBConvert.ParseDecimal(lst[0].Post)) / DBConvert.ParseDecimal(lst[0].Website)) * 100;
                        sbPrice.AppendFormat("<ins><span class=\"amount\">Price from {0} USD</span></ins>", lst[0].Post);
                        sbPrice.AppendFormat("<del><span class=\"amount\">{0} USD</span></del>", lst[0].Website);

                        //Show/hidden div Sale alert
                        divIsSale.Style.Add("display", "block");
                        udpAddToCard.Visible = true;
                        imgBuy.Attributes.Add("onclick", string.Format("javascript:return BuyProduct({0},{1})", lst[0].Id, lst[0].Website));

                    }
                    else
                        sbPrice.Append("<ins><span class=\"amount\">Call</span></ins>");
                }
                ltrPrice.Text = sbPrice.ToString();

                #endregion

                Session["booking_categoryID"] = lst[0].CategoryId;

                string linkPage = Common.UtilityLocal.GetCateNameByLevel(pageName, cid, cidsub, id);
                hypBookingNow.HRef = LinkHelper.GetLink("booking", LangId, linkPage);

                //set programtour
                block_programtour.ProductId = lst[0].Id.ToString();

                //set price                
                block_bookingprice.ProductId = DBConvert.ParseInt(lst[0].Id);

                //Get img slide
                GetListImage(lst[0].Id.ToString());

                #region Get Count review

                string oldCount = string.IsNullOrEmpty(lst[0].District) == true ? "0" : lst[0].District;
                ltrViewCount.Text = string.Format("{0} Reviews", oldCount);

                //Update count view after user forcus detail                
                int intOldCount = DBConvert.ParseInt(oldCount);
                int intNewCount = intOldCount + 1;
                Generic<PNK_Product> genericBLL = new Generic<PNK_Product>();
                PNK_Product productCat = new PNK_Product();
                productCat.Id = DBConvert.ParseInt(lst[0].Id);
                productCat = genericBLL.Load(productCat, new string[] { "Id" });
                productCat.Ordering = DBConvert.ParseInt(lst[0].Ordering);
                productCat.District = intNewCount.ToString();
                if (productCat.Ordering > 0)
                {
                    genericBLL.Update(productCat, productCat, new string[] { "Id" });
                }

                #endregion
                

                WebUtils.SeoPage(lst[0].ProductDesc.MetaTitle, lst[0].ProductDesc.Metadescription, lst[0].ProductDesc.MetaKeyword, this.Page);
                WebUtils.SeoTagH(lst[0].ProductDesc.H1, lst[0].ProductDesc.H2, lst[0].ProductDesc.H3, this.Controls);
            }
        }

        private void GetListImage(string productID)
        {
            UploadImageBLL bll = new UploadImageBLL();
            IList<PNK_UploadImage> lst = bll.GetList(string.Empty, productID, "1", 1, 100, out total);
            if (lst.Count > 0)
            {
                rptResult.DataSource = lst;
                rptResult.DataBind();

                ltrImgFirst.Text = string.Format(" <img  id=\"zoom_03\" src=\"{0}\" data-zoom-image=\"{0}\" />"
                  , WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], lst[0].Name));
            }
        }

        private void GetProductSale()
        {
            try
            {
                DataTable dtb = DBHelper.ExcuteFromCmd("SELECT * FROM dbo.fc_GetAllChildProductCategory(" + categoryID + ",1)", null);
                string[] array = dtb.AsEnumerable()
                                    .Select(row => row.Field<Int32>("id").ToString())
                                    .ToArray();
                string idFirst = string.Join(",", array);

                pcBll = new ProductBLL();
                IList<PNK_Product> lstAll = pcBll.GetList(LangInt, string.Empty, "1", idFirst, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, currentPageIndex, 9999, out total);
                if (lstAll.Count > 0)
                {
                    //lst = lst.Where(m => m.Promotion == "1").ToList();
                    rptProductHot.DataSource = lstAll.Where(m => m.Hot == "1").ToList();
                    rptProductHot.DataBind();

                    rptProductSale.DataSource = lstAll.Where(m => m.Promotion == "1").ToList();
                    rptProductSale.DataBind();
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("GetProductHot", "GetProduct", ex.Message);
            }
        }

        private string GetProductCategory()
        {
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lst = null;
            if (pageName == "home" || pageName == "trang-chu")
            {
                lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, ConfigurationManager.AppSettings["parentIdTemplate"], string.Empty, 1, true, string.Empty, 1, 9999, out total);
                if (lst.Count > 0)
                {
                    categoryID = lst[0].ProductCategoryDesc.Id.ToString();
                }
            }
            else
            {
                string treeNameUrl = UtilityLocal.RemoveLanguage(Request.RawUrl, LangId);
                lst = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, string.Empty, treeNameUrl, 1, true, string.Empty, 1, 9999, out total);
                if (lst.Count > 0)
                {
                    categoryID = lst[0].Id.ToString();

                }
            }
            return categoryID;
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
                PNK_UploadImage data = e.Item.DataItem as PNK_UploadImage;
                StringBuilder sb = new StringBuilder();

                string src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Name);

                sb.AppendFormat("<a  href=\"#\" data-image=\"{0}\" data-zoom-image=\"{0}\">", src);
                sb.AppendFormat("<img id=\"zoom_03\" src=\"{0}\"/>", src);
                sb.Append(" </a>");

                Literal ltrResutl = e.Item.FindControl("ltrResutl") as Literal;
                ltrResutl.Text = sb.ToString();
            }
        }

        protected void rptProductHot_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_Product data = e.Item.DataItem as PNK_Product;

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                img.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image);
                img.Attributes.Add("srcset", string.Format("{0} 225w, {0} 120w, {0} 450w", WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image)));

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = img.Alt = img.Attributes["title"] = data.ProductDesc.Title;

                HtmlAnchor hypTitle = e.Item.FindControl("hypTitle") as HtmlAnchor;
                Dictionary<string, object> dic = UtilityLocal.GetHRefByLevel(data, LangInt, LangId, Ci);
                hypTitle.HRef = dic["HRef"].ToString();

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
                    string normalPrice = data.Website == "" ? "Call" : string.Format("USD {0}", data.Website);
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

            }
        }

        #endregion
    }
}