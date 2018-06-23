using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using Cb.BLL;
using Cb.Model;
using Cb.Utility;
using Cb.BLL.Product;
using Cb.Model.Products;
using Cb.DBUtility;
using System.Text;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Globalization;

namespace Cb.Web.Common
{
    public static class UtilityLocal
    {
        #region Parameter

        static int total = int.MinValue;

        #endregion

        public enum List
        {
            ProductDivision = 1,//Ngành hàng
            ProductType = 2,//Loại hàng
            ProductGroup = 3,//Nhóm hàng
            Brand = 4,//Hãng sản xuất
            Province = 5,//Tỉnh
            UnitMeasure = 6,//Đơn vị đo lường
            SalesPriceType = 7,//Loại giá
            VatGroup = 8//Loại giá
        }

        /// <summary>
        /// Get Image theo sản phẩm
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string ImagePathByFont(PNK_Product data)
        {
            string result = string.Empty;
            int imageType = data.ImageType;
            switch (imageType)
            {
                case 2:
                    result = data.ImageFont;
                    break;
            }

            return result;
        }

        /// <summary>
        /// Get Image theo danh mục PNK_ProductCategory        
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string ImagePathByFont(PNK_ProductCategory data)
        {
            string result = string.Empty;
            string imagePath = data.BaseImage == "" ? "breadcrumb-bg.jpg" : data.BaseImage;
            int imageType = data.ImageType;
            switch (imageType)
            {
                case 1:
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<section runat=\"server\" id=\"sectionCategory\" class=\"parallax-sec dark blox aligncenter page-title-x w-animate\"");
                    sb.AppendFormat("style=\"background: url('{0}') no-repeat center; background-size: cover; min-height: px;\" data-stellar-background-ratio=\"0.7\">", WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductCategoryUpload"], imagePath));
                    sb.AppendLine("    <div class=\"max-overlay\" style=\"background-color: \"></div>");
                    sb.AppendLine("    <div data-stellar-ratio=\"1\" class=\"wpb_row vc_row-fluid \">");
                    sb.AppendLine("  <div class=\"container\">");
                    sb.AppendLine("<div class=\"wpb_column vc_column_container vc_col-sm-12\">");
                    sb.AppendLine("<div class=\"vc_column-inner \">");
                    sb.AppendLine("<div class=\"wpb_wrapper\">");
                    sb.AppendLine(" <hr class=\"vertical-space5\">");
                    sb.AppendLine("<hr class=\"vertical-space5\">");
                    sb.AppendLine("<hr class=\"vertical-space1\">");
                    sb.AppendLine("<div class=\"max-title max-title1\">");
                    sb.AppendFormat("<h2 style='font-size: 30px !important'>{0}</h2>", data.ProductCategoryDesc.Name);
                    sb.AppendLine("</div><hr class=\"vertical-space2\" />");
                    sb.AppendLine("</div> </div></div></div> </div></section>");
                    result = sb.ToString();
                    break;
                case 2:
                    result = data.ImageFont;
                    break;
            }

            return result.ToString();
        }

        /// <summary>
        /// Đọc các loại file
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="Request"></param>
        /// <param name="Response"></param>
        /// <param name="Page"></param>
        public static void ReadFile(string fileName, HttpRequest Request, HttpResponse Response, Page Page)
        {
            try
            {
                string path = Request.PhysicalApplicationPath;
                string url = Path.Combine("Resource", "Upload", "Products", fileName);
                url = Path.Combine(path, url);
                //url = Utils.CombineUrl(path, url);

                if (File.Exists(url))
                {
                    WebClient wc = new WebClient();
                    Byte[] buffer = wc.DownloadData(url);
                    if (buffer != null)
                    {
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.Cache.SetCacheability(HttpCacheability.NoCache);
                        switch (WebUtils.GetFileExtension(fileName))
                        {
                            case "xls":
                                Response.ContentType = "application/vnd.ms-excel";
                                break;
                            case "xlsx":
                                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                                break;
                            case "pdf":
                                Response.ContentType = "application/pdf";
                                break;
                        }
                        Response.BinaryWrite(buffer);
                        Response.Flush();
                        Response.End();
                    }
                }
            }
            catch (Exception ex)
            {
                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('Không có file !','Message',function(r) {{window.location='{0}'}});", Request.RawUrl), true);
            }
        }

        /// <summary>
        /// Get tên file trong bảng PNK_UploadImage
        /// </summary>
        /// <param name="productID"></param>
        /// <returns></returns>
        public static string GetFileNameByID(int productID)
        {
            string result = string.Empty;
            UploadImageBLL bll = new UploadImageBLL();
            IList<PNK_UploadImage> lst = bll.GetList(string.Empty, productID.ToString(), "1", 1, 100, out total);
            if (total > 0)
            {
                result = lst[0].Name;
            }

            return result;
        }

        public static string GetPathTreeNameUrl(int categoryID, int langInt, string langId)
        {
            string result = string.Empty, id = string.Empty, pathTreeSub = string.Empty;

            try
            {
                ProductCategoryBLL pcBll = new ProductCategoryBLL();
                IList<PNK_ProductCategory> lst = pcBll.GetList(langInt, string.Empty, string.Empty, categoryID, int.MinValue, false, string.Empty, 1, 9999, out total);
                if (total > 0)
                {
                    string pathTree = lst[0].PathTree;
                    int level = pathTree.Count(i => i.Equals('.'));
                    for (int i = 1; i <= level; i++)
                    {
                        pathTreeSub = pathTree.Split('.')[i];
                        id = pathTreeSub.Split('-')[1];
                        lst = pcBll.GetList(langInt, string.Empty, string.Empty, int.Parse(id), int.MinValue, false, string.Empty, 1, 9999, out total);

                        result = result + (total > 0 ? lst[0].ProductCategoryDesc.NameUrl : string.Empty) + "/";

                        if (i == 1)
                        {
                            result = result + langId + "/";
                        }
                    }
                    result = result == "" ? "" : result.Remove(result.LastIndexOf('/'), 1);
                }
            }
            catch (Exception ex)
            {

                Write2Log.WriteLogs("Home Page", "GetPathTreeNameUrl", ex.Message);
            }

            return result;
        }

        public static string GetVideoList(int productID)
        {
            string result = string.Empty;
            UploadImageBLL bll = new UploadImageBLL();
            IList<PNK_UploadImage> lst = bll.GetList(string.Empty, productID.ToString(), "1", 1, 100, out total);
            if (total > 0)
            {
                result = lst[0].ImagePath;
            }
            return result;
        }

        public static DataTable ObjectToData(object o)
        {
            DataTable dt = new DataTable("OutputData");

            DataRow dr = dt.NewRow();
            dt.Rows.Add(dr);

            o.GetType().GetProperties().ToList().ForEach(f =>
            {
                try
                {
                    f.GetValue(o, null);
                    dt.Columns.Add(f.Name, f.PropertyType);
                    dt.Rows[0][f.Name] = f.GetValue(o, null);
                }
                catch { }
            });
            return dt;
        }

        public static void PrintWebControl(Control ctrl, string Script)
        {
            StringWriter stringWrite = new StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new System.Web.UI.HtmlTextWriter(stringWrite);
            if (ctrl is WebControl)
            {
                Unit w = new Unit(100, UnitType.Percentage); ((WebControl)ctrl).Width = w;
            }
            Page pg = new Page();
            pg.EnableEventValidation = false;
            if (Script != string.Empty)
            {
                pg.ClientScript.RegisterStartupScript(pg.GetType(), "PrintJavaScript", Script);
            }
            HtmlForm frm = new HtmlForm();
            pg.Controls.Add(frm);
            frm.Attributes.Add("runat", "server");
            frm.Controls.Add(ctrl);
            pg.DesignerInitialize();
            pg.RenderControl(htmlWrite);
            string strHTML = stringWrite.ToString();
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.Write(strHTML);
            HttpContext.Current.Response.Write("<script>window.print();</script>");
            HttpContext.Current.Response.End();
        }

        public static string GetCateNameByLevel(string pageName, string cid, string cidsub, string id)
        {
            string name = string.Empty;

            //level 1
            if ((cid == string.Empty && id == string.Empty) || (pageName == "tim-kiem" || pageName == "search"))
            {
                name = pageName;
            }
            //level 2
            else if (cid != string.Empty && cidsub == string.Empty && id == string.Empty)
            {
                name = cid;
            }
            //level 3
            else if (cid != string.Empty && cidsub != string.Empty && id == string.Empty)
            {
                name = cidsub;
            }
            //level 4
            else if (cid != string.Empty && cidsub != string.Empty && id != string.Empty)
            {
                name = id;
            }

            return name;
        }

        public static Dictionary<string, object> GeSalePriceAll(string productId, string brandId, DateTime fromDate, DateTime toDate)
        {
            Dictionary<string, object> dic = new Dictionary<string, object>();

            SalesPriceBLL pcBll = new SalesPriceBLL();
            IList<PNK_SalesPrice> lst = pcBll.GetList(productId, brandId, fromDate, toDate, 1, 1, out total);
            if (lst.Count > 0)
            {
                dic.Add("OriginPrice", lst[0].OriginPrice);
                dic.Add("DealPrice", lst[0].DealPrice);
                dic.Add("UnitPrice", lst[0].UnitPrice);
            }
            //Lấy giá theo khu vực tỉnh thành
            else
            {
                lst = pcBll.GetList(productId, brandId, DateTime.MinValue, DateTime.MinValue, 1, 1, out total);
                if (lst.Count > 0)
                {
                    dic.Add("OriginPrice", lst[0].OriginPrice);
                    dic.Add("DealPrice", lst[0].DealPrice);
                    dic.Add("UnitPrice", lst[0].UnitPrice);
                }
                else
                {
                    Generic<PNK_Product> genericBLL = new Generic<PNK_Product>();
                    IList<PNK_Product> lstProduct = genericBLL.GetAllBy(new PNK_Product(), "WHERE ID=" + productId + "", null);
                }
            }

            return dic;
        }


        public static Dictionary<string, object> GetProductPrice(string productId, string brandId, DateTime fromDate, DateTime toDate, CultureInfo Ci)
        {
            Dictionary<string, object> dic = new Dictionary<string, object>();

            string result = string.Empty;
            SalesPriceBLL pcBll = new SalesPriceBLL();
            IList<PNK_SalesPrice> lst = pcBll.GetList(productId, string.Empty, fromDate, toDate, 1, 9999, out total);
            StringBuilder sb = new StringBuilder();
            if (total > 0)
            {
                sb.Append("<span class=\"price text-left center-block\">");
                sb.Append(" <ins><span class=\"woocommerce-Price-amount amount amountdis\">");
                sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0}", FormatHelper.FormatDonviTinh(DBConvert.ParseDouble(lst[0].DealPrice), enuCostId.dong, Ci));
                //sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0}", lst[0].DealPrice.ToString("#,###") + " đ");
                sb.Append("</ins>");
                sb.Append("<del>");
                sb.Append("<span class=\"woocommerce-Price-amount amount amountdis\">");
                sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0}", FormatHelper.FormatDonviTinh(DBConvert.ParseDouble(lst[0].OriginPrice), enuCostId.dong, Ci));
                //sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0}", lst[0].OriginPrice.ToString("#,###" + " đ"));
                sb.Append("</span>");
                sb.Append("</del>");

                sb.Append("<ins>");
                sb.Append("<span class=\"woocommerce-Price-amount amount amountper\">");
                sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0} %", Convert.ToInt32(((lst[0].OriginPrice - lst[0].DealPrice) / lst[0].OriginPrice) * 100));
                sb.Append("</span>");
                sb.Append("</ins>");
                sb.Append(" </span>");

                dic.Add("isPrice", true);
                dic.Add("isSale", true);
                dic.Add("OriginPrice", lst[0].OriginPrice);
                dic.Add("DealPrice", lst[0].DealPrice);
                dic.Add("UnitPrice", lst[0].UnitPrice);
                //result = string.Format("<div><span>Giá gốc: </span><span style='font-size:11pt;font-weight:bold; text-decoration: line-through;'> {0} VND </span></div><span>Tiết kiệm: </span> <span style='font-size:11pt;font-weight:bold'>{1}%</span>", lst[0].OriginPrice.ToString("#,###"), Convert.ToInt32(((lst[0].OriginPrice - lst[0].DealPrice) / lst[0].OriginPrice) * 100));
            }
            //Lấy giá theo khu vực tỉnh thành
            else
            {
                lst = pcBll.GetList(productId, brandId, DateTime.MinValue, DateTime.MinValue, 1, 1, out total);
                if (lst.Count > 0)
                {
                    sb.Append("<span class=\"price text-left center-block\">");
                    sb.Append(" <ins><span class=\"woocommerce-Price-amount amount amountdis\">");
                    sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0}", FormatHelper.FormatDonviTinh(DBConvert.ParseDouble(lst[0].DealPrice), enuCostId.dong, Ci));
                    //sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0}", lst[0].DealPrice.ToString("#,###") + " đ");
                    sb.Append("</ins>");
                    sb.Append("<del>");
                    sb.Append("<span class=\"woocommerce-Price-amount amount amountdis\">");
                    sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0}", FormatHelper.FormatDonviTinh(DBConvert.ParseDouble(lst[0].OriginPrice), enuCostId.dong, Ci));
                    //sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0}", lst[0].OriginPrice.ToString("#,###" + " đ"));
                    sb.Append("</span>");
                    sb.Append("</del>");
                    sb.Append("<ins>");
                    sb.Append("<span class=\"woocommerce-Price-amount amount amountper\">");
                    sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0} %", Convert.ToInt32(((lst[0].OriginPrice - lst[0].DealPrice) / lst[0].OriginPrice) * 100));
                    sb.Append("</span>");
                    sb.Append("</ins>");
                    sb.Append(" </span>");

                    dic.Add("isPrice", true);
                    dic.Add("isSale", true);
                    dic.Add("OriginPrice", lst[0].OriginPrice);
                    dic.Add("DealPrice", lst[0].DealPrice);
                    dic.Add("UnitPrice", lst[0].UnitPrice);
                }
                else
                {
                    Generic<PNK_Product> genericBLL = new Generic<PNK_Product>();
                    IList<PNK_Product> lstProduct = genericBLL.GetAllBy(new PNK_Product(), "WHERE ID=" + productId + "", null);
                    if (lstProduct.Count > 0)
                    {
                        string price = (lstProduct[0].Price == "0" || lstProduct[0].Price == "" || lstProduct[0].Price == null) ? "Call" : FormatHelper.FormatDonviTinh(DBConvert.ParseDouble(lstProduct[0].Price), enuCostId.dong, Ci);

                        sb.Append("<span class=\"price text-center center-block\">");
                        sb.Append(" <ins>");
                        sb.Append("<span class=\"woocommerce-Price-amount amount amountdis\">");
                        sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0}", price);
                        sb.Append("</ins>");
                        sb.Append("</span>");
                            
                        dic.Add("isPrice", false);
                        dic.Add("isSale", false);
                    }
                    else
                    {
                        sb.Append("<span class=\"woocommerce-Price-amount amount amountper\">");
                        sb.AppendFormat("<span class=\"woocommerce-Price-currencySymbol\"></span>{0}", "Call");
                        sb.Append("</span>");

                        dic.Add("isPrice", true);
                        dic.Add("isSale", true);
                    }
                }
            }

            dic.Add("Price", sb.ToString());

            return dic;
        }

        /// <summary>
        /// Get HReft theo từng level của Product
        /// </summary>
        /// <param name="data"></param>
        /// <param name="LangInt"></param>
        /// <param name="LangId"></param>
        /// <returns>ArrayList</returns>
        ///  item 0: HRef
        public static Dictionary<string, object> GetHRefByLevel(PNK_Product data, int LangInt, string LangId, CultureInfo Ci)
        {
            Dictionary<string, object> dic = new Dictionary<string, object>();
            try
            {
                //string link = UtilityLocal.GetPathTreeNameUrl(data.CategoryId, LangInt, LangId);
                string link = string.Empty;
                ProductCategoryBLL pcBll = new ProductCategoryBLL();
                IList<PNK_ProductCategory> lst = pcBll.GetListTree(LangInt, string.Empty, string.Empty, int.MinValue, data.CategoryId.ToString(), string.Empty, 1, true, string.Empty, 1, 9999, out total);
                if (lst.Count > 0)
                {
                    link = AppendLanguage(lst[0].ProductCategoryDesc.TreeNameUrlDesc, LangId);
                    dic.Add("HRef", LinkHelper.GetLink(link, data.ProductDesc.TitleUrl));
                }
            }
            catch (Exception ex)
            {

            }

            return dic;
        }

        public static string AppendLanguage(string treeNameUrl, string langId)
        {
            string result = string.Empty;

            int firstFlag = treeNameUrl.IndexOf('/', 0);
            result = firstFlag > -1 ? treeNameUrl.Insert(firstFlag, string.Format("/{0}", langId)) : string.Format("{0}/{1}", treeNameUrl, langId);

            return result;
        }

        public static string RemoveLanguage(string treeNameUrl, string langId)
        {
            string result = string.Empty;            
            //Loại bỏ dấu ? để lấy link đúng
            string url = treeNameUrl.Split('?')[0];
            url = url.Replace(string.Format("/{0}", langId), "");
            url = url.Remove(0, 1);

            return url;
        }

        /// <summary>
        /// Get Image theo sản phẩm
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string ImagePathByFont(PNK_Product data, HttpRequest request)
        {
            string result = string.Empty, id = string.Empty, pathTreeSub = string.Empty, LangId = data.ProductDesc.LangId == 1 ? "vn" : "eng";

            string imagePath = data.Image == "" ? "breadcrumb-bg.jpg" : data.Image;
            int imageType = data.ImageType;
            switch (imageType)
            {
                case 1:
                    string strHtml = WebUtils.GetMailTemplate(Path.Combine(request.PhysicalApplicationPath, "TemplateMail/CategoryHeader.txt"));
                    result = string.Format(strHtml
                        , WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.Image)//Image
                        , data.ProductDesc.Title
                        );
                    break;
                case 2:
                    result = data.ImageFont;
                    break;
            }

            return result;
        }

        /// <summary>
        /// Get Image theo danh mục PNK_ProductCategory        
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string ImagePathByFont(PNK_ProductCategory data, HttpRequest request)
        {
            string result = string.Empty, id = string.Empty, pathTreeSub = string.Empty, LangId = data.ProductCategoryDesc.LangId == 1 ? "vn" : "eng";
            ProductCategoryBLL pcBll = new ProductCategoryBLL();

            string imagePath = data.BaseImage == "" ? "breadcrumb-bg.jpg" : data.BaseImage;
            int imageType = data.ImageType;
            switch (imageType)
            {
                case 1:
                    string strHtml = WebUtils.GetMailTemplate(Path.Combine(request.PhysicalApplicationPath, "TemplateMail/CategoryHeader.txt"));
                    result = string.Format(strHtml
                        , WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductCategoryUpload"], data.BaseImage)//Image
                        , data.ProductCategoryDesc.Name
                        );

                    break;
                case 2:
                    result = data.ImageFont;
                    break;
            }

            return result.ToString();
        }
    }
}