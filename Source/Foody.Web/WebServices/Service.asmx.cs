using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Cb.Model;
using System.Globalization;
using Cb.DBUtility;
using Cb.BLL;
using System.Text;
using System.Web.Script.Serialization;
using System.Collections;
using Cb.Model.Products;
using Cb.BLL.Product;
using System.Web.UI.WebControls;
using System.Data;
using Newtonsoft.Json;
using Cb.Utility;
using System.Net;

namespace Cb.Web.WebServices
{
    /// <summary>
    /// Summary description for Service
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 

    [System.Web.Script.Services.ScriptService]
    public class Service : System.Web.Services.WebService
    {
        /// <summary>
        /// Lấy giá booking
        /// </summary>
        /// <param name="id">id sản phẩm</param>
        /// <returns>VD: Page/CategoryManagement/Category.ascx</returns>
        [WebMethod]
        public object[] GetBooking_Person(string productId, string priceClass, string groupType, string adults, string child, string infant)
        {
            //List<Dictionary<string, object>> lst = new List<Dictionary<string, object>>();
            //ArrayList arr = new ArrayList();
            string result = "Call";
            //DataTable dtb = new DataTable();
            object[] o = new object[4];

            try
            {
                DGCParameter[] param = new DGCParameter[6];
                param[0] = new DGCParameter("@productId", DbType.Int32, DBConvert.ParseInt(productId));
                param[1] = new DGCParameter("@priceClass", DbType.String, priceClass);
                param[2] = new DGCParameter("@groupType", DbType.String, groupType);
                param[3] = new DGCParameter("@adults", DbType.Int32, DBConvert.ParseInt(adults));
                param[4] = new DGCParameter("@child", DbType.Int32, DBConvert.ParseInt(child));
                param[5] = new DGCParameter("@infant", DbType.Int32, DBConvert.ParseInt(infant));

                DataSet ds = DBHelper.ExcuteDataSetFromStore("BookingPrice_PersonGet", param);

                if (ds != null && ds.Tables.Count > 0)
                {
                    result = ds.Tables[0].Rows[0][0].ToString();
                    decimal cost, tax, finalCost, exchangeCost;
                    cost = DBConvert.ParseDecimal(result);
                    tax = (15 * DBConvert.ParseDecimal(result)) / 100;
                    finalCost = cost + tax;

                    o[0] = cost;
                    o[1] = tax;
                    o[2] = finalCost;

                    //Đổi từ USD --> VNĐ
                    exchangeCost = GetExchangeRate();
                    o[3] = finalCost * exchangeCost;
                }
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            return o;
        }

        [WebMethod]
        public List<ListItem> GetCity(string phoneCode)
        {
            List<ListItem> customers = new List<ListItem>();
            string result = string.Empty;
            DataTable dtb = DBHelper.ExcuteFromCmd(" select distinct ID,City from pnk_countries_cities where PhoneCode='" + phoneCode + "' ", null);
            if (dtb != null && dtb.Rows.Count > 0)
            {
                foreach (DataRow item in dtb.Rows)
                {
                    customers.Add(new ListItem
                    {
                        Value = item["City"].ToString(),
                        Text = item["City"].ToString()
                    });
                }
            }
            return customers;
        }

        [WebMethod]
        public string UploadBaseImage()
        {
            return "success";
        }

        /// <summary>
        /// Lấy địa chỉ Path Page
        /// </summary>
        /// <param name="id">id sản phẩm</param>
        /// <returns>VD: Page/CategoryManagement/Category.ascx</returns>
        [WebMethod]
        public string GetCategoryPageDetail(int id)
        {
            int total;
            string result = string.Empty;
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            IList<PNK_ProductCategory> lst = pcBll.GetList(1, string.Empty, string.Empty, id, int.MinValue, false, string.Empty, 1, 100, out total);
            if (total > 0)
                result = lst[0].PageDetail;
            return result;
        }

        /// <summary>
        /// Get quy đổi tiền tệ
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public decimal GetExchangeRate()
        {
            int total;
            decimal amount = decimal.MinValue;
            ExchangeRateBLL pcBll = new ExchangeRateBLL();
            IList<PNK_ExchangeRate> lst = pcBll.GetList(1, string.Empty, string.Empty, string.Empty, 1, 1, out total);
            if (total > 0)
                amount = lst[0].ExchangeRateDesc.Amount;
            return amount;
        }
    }
}
