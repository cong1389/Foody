using Cb.BLL;
using Cb.DBUtility;
using Cb.Model;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Net;
using System.Text;
using System.Xml.XPath;

namespace Cb.Web.Pages.BookingManagement
{
    public partial class BookingResutl : System.Web.UI.UserControl
    {
        #region Parameter

        private string sessionID = string.Empty, orderID = string.Empty, result = string.Empty;
        int bookingId = int.MinValue;

        #endregion

        #region Common

        private int SaveBooking(string paymentStatus)
        {
            //Get obj từ form booking
            PNK_Booking objBooking = Session["objBooking"] != null ? (PNK_Booking)Session["objBooking"] : null;
            objBooking.PaymentStatus = paymentStatus != string.Empty ? paymentStatus : string.Empty;

            List<PNK_BookingDesc> lstBookingDesc = Session["objBooking"] != null ? (List<PNK_BookingDesc>)Session["lstBookingDesc"] : null;

            //excute
            Generic2C<PNK_Booking, PNK_BookingDesc> generic2CBLL = new Generic2C<PNK_Booking, PNK_BookingDesc>();
            bookingId = generic2CBLL.Insert(objBooking, lstBookingDesc);

            //Send email đến KH
            if (bookingId != int.MinValue)
            {
                SendEmailTempate(objBooking);
            }
            return bookingId;
        }

        private void SendEmailTempate(PNK_Booking obj)
        {
            string companyName = string.Empty, companyEmail = string.Empty, companyPhone = string.Empty, companyAddress = string.Empty
                , companyWebsite = string.Empty, companyFax = string.Empty;

            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Configuration item in lst)
                {
                    if (item.Key_name == Constant.Configuration.config_company_name_vi)
                    {
                        companyName = item.Value_name;
                    }
                    if (item.Key_name == Constant.Configuration.email)
                    {
                        companyEmail = item.Value_name;
                    }
                    if (item.Key_name == Constant.Configuration.phone)
                    {
                        companyPhone = item.Value_name;
                    }
                    if (item.Key_name == Constant.Configuration.config_address_vi)
                    {
                        companyAddress = item.Value_name;
                    }
                    if (item.Key_name == Constant.Configuration.sitename)
                    {
                        companyWebsite = item.Value_name;
                    }
                    if (item.Key_name == Constant.Configuration.fax)
                    {
                        companyFax = item.Value_name;
                    }
                }
            }

            string path = Request.PhysicalApplicationPath;
            string strHtml = WebUtils.GetMailTemplate(Path.Combine(path, "TemplateMail/Booking.html"));
            string body = string.Format(strHtml,
                        companyName,//0
                        obj.FirstName,//1
                        obj.LastName,//2
                        obj.Country,//3
                        obj.City,//4
                        obj.PhoneNumber,//5
                        obj.Email,//6
                        obj.PickUpLocation,//7
                        DateTime.Now,//8
                        obj.RequestTour,//9
                        obj.ExpectedDepartureDate,//10
                        obj.NumberOfAduts,//11                  
                        obj.NumberOfChildren,//12
                        obj.NumberOfInfant,//13
                        obj.Total,//14
                        obj.PaymentMethod,//15
                        companyAddress,//16
                        companyEmail,//17
                        companyWebsite,//18
                        companyPhone,//19
                        companyFax,//20
                        obj.PaymentStatus//21
               );
            WebUtils.SendEmail("Contact", obj.Email, string.Empty, body);
        }

        public string POSTRequest(string URL, string postData)
        {
            string responseData = "", orderID = string.Empty, orderIDEncry = string.Empty, sessionID = string.Empty;

            try
            {
                HttpWebRequest hwrequest = (HttpWebRequest)WebRequest.Create(URL);
                hwrequest.Timeout = 60000;
                hwrequest.Method = "POST";
                hwrequest.KeepAlive = false;

                hwrequest.ContentType = "application/x-www-form-urlencoded";

                UTF8Encoding encoding = new UTF8Encoding();
                byte[] postByteArray = encoding.GetBytes(postData);
                hwrequest.ContentLength = postByteArray.Length;
                Stream postStream = hwrequest.GetRequestStream();
                postStream.Write(postByteArray, 0, postByteArray.Length);
                postStream.Close();


                // Attempt to receive the WebResponse to the WebRequest.
                using (HttpWebResponse hwresponse = (HttpWebResponse)hwrequest.GetResponse())
                {
                    if (hwresponse != null)
                    { // If we have valid WebResponse then read it.
                        using (StreamReader reader = new StreamReader(hwresponse.GetResponseStream()))
                        {
                            XPathDocument doc = new XPathDocument(reader);
                            XPathNavigator xml = doc.CreateNavigator();
                            XPathNodeIterator nodes = xml.Select("/TKKPG/Response/Order/row/OrderParams/row");
                            foreach (XPathNavigator item in nodes)
                            {
                                //responseData = item.Value;
                                string sPARAMNAME = item.SelectSingleNode("PARAMNAME").Value;
                                string sVal = item.SelectSingleNode("VAL").Value;
                                if (sPARAMNAME.Equals("TWOResponseCode"))
                                {
                                    responseData = sVal;
                                }

                            }
                            reader.Close();
                        }
                    }

                    hwresponse.Close();
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("block_booking", "POSTRequest", ex.Message);
            }

            return responseData;
        }

        private string GetOrder()
        {
            sessionID_booking.Text = sessionID = Session["sessionID_booking"] != null ? string.Format("sessionID_booking: {0}", Session["sessionID_booking"].ToString()) : string.Empty;

            orderID_booking.Text = orderID = Session["orderID_booking"] != null ? string.Format("orderID_booking: {0}", Session["orderID_booking"].ToString()) : string.Empty;
            price_booking.Text = Session["price_booking"] != null ? string.Format("price_booking: {0}", Session["price_booking"].ToString()) : string.Empty;

            if (sessionID != null && orderID != null)
            {
                string URL = "https://pgcard.agribank.com.vn:8380/Exec";
                string postData = string.Format("<TKKPG>\n" +
                        "  <Request>\n" +
                        "   <Operation>GetOrderInformation</Operation>\n" +
                        "   <Language>EN</Language>\n" +
                        "   <Order>\n" +
                        "       <OrderType>Purchase</OrderType>\n" +
                        "       <Merchant>VBAPGMER07</Merchant>\n" +
                        "       <OrderID>{0}</OrderID>\n" +
                        "    </Order>\n" +
                        "   <SessionID>{1}</SessionID>\n" +
                        "   <ShowParams>true</ShowParams>\n" +
                        "   <ShowOperations>true</ShowOperations>\n" +
                        "   <ClassicView>true</ClassicView>\n" +
                        " </Request>\n" +
                        "</TKKPG>", orderID, sessionID);
                string responseData = POSTRequest(URL, postData);
                switch (responseData)
                {
                    case "msg_051":
                        result = "The wrong credential cards";//Sai thông tin xác thực thẻ
                        break;
                    case "msg_05":
                        result = "Authentication Error 3D";//Lỗi xác thực giao dịch 3D
                        break;
                    case "msg_210":
                        result = "You enter the wrong credentials CAVV";//Bạn nhập sai thông tin xác thực CAVV
                        break;
                    case "msg_055":
                    default:
                        result = "Invalid Transactions";//Giao dịch không hợp lệ
                        break;
                    case "msg_99":
                        result = "The error occurred during processing. Please perform the following";//Có lỗi xảy ra trong quá trình xử lý. Quý khách vui lòng thực hiện lại sau
                        break;
                    case "msg_082":
                        result = "Transactions exceeding the limit allowed by the bank";//Giao dịch vượt hạn mức cho phép của ngân hàng
                        break;
                    case "msg_050":
                        result = "You enter the wrong customer information";//Bạn nhập sai thông tin khách hàng
                        break;
                    case "msg_076":
                        result = "TCustomer account is not sufficient to carry out the transaction";//ài khoản của khách hàng không đủ số dư để thực hiện giao dịch
                        break;
                    case "msg_verify_99":
                        result = "The error occurred during processing.";//Có lỗi xảy ra trong quá trình xử lý.
                        break;
                    case "msg_211":
                        result = "You enter the wrong code CVV2";//Bạn nhập sai mã CVV2
                        break;
                    case "00":
                        result = "You enter the wrong code CVV2";//Bạn nhập sai mã CVV2
                        break;
                    case "msg_001":
                        result = "Successful transaction";//Giao dịch thành công
                        break;
                }

                ltrResult.Text = string.Format("<h3>{0}</h3>", result); ;
                //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('" + responseData + "','Message',function(r) {{window.location='{0}'}});", Request.RawUrl), true);
                ltrResponseData.Text = responseData;

                //Cập nhật statusMessage sau khi thanh toán

                //DGCParameter[] param = new DGCParameter[2];
                //param[0] = new DGCParameter("@id", DbType.Int32, Session["bookingId_booking"].ToString());
                //param[1] = new DGCParameter("@paymentStatus", DbType.String, result);
                //DBHelper.ExcuteNonQuery("UPDATE PNK_Booking SET PaymentStatus = @paymentStatus WHERE ID = @id", param);
            }
            else
                Response.Redirect(WebUtils.RedirectHomePage());

            return result;
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            hypHome.HRef = WebUtils.RedirectHomePage();

            if (Session["paymentType_booking"] != null)
            {
                string paymentType = Session["paymentType_booking"].ToString();
                switch (paymentType)
                {
                    case "2":
                    case "3":
                        string result = GetOrder();
                        SaveBooking(result);
                        break;
                    case "1":
                        SaveBooking("You have registered successfully");
                        ltrResult.Text = string.Format("<h3>You have registered successfully!</h3><p>{0}</p>", "Congratulations, your information has been accepted.");
                        break;
                }
            }

            WebUtils.SeoPage("Booking result", "Booking result", "Booking result", this.Page);
            WebUtils.SeoTagH("Booking result", "Booking result", "Booking result", Controls);

        }

        #endregion
    }
}