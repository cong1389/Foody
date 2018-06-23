using Cb.BLL;
using Cb.DBUtility;
using Cb.Model;
using Cb.Utility;
using Cb.Web.Pages.BookingManagement;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Xml.XPath;

namespace Cb.Web.Controls
{
    public partial class block_booking : DGCUserControl
    {
        #region Parameter

        Generic<PNK_BookingPrice> genericBLL = new Generic<PNK_BookingPrice>();
        protected string template_path, pageName, cid, cidsub, id;

        int bookingId = int.MinValue;

        private string title = string.Empty;
        public string Title
        {
            get
            {
                if (title != string.Empty)
                    return title;
                else
                    return string.Empty;
            }
            set
            {
                title = value;
            }
        }

        private int productId = int.MinValue;
        public int ProductId
        {
            get
            {
                if (productId != int.MinValue)
                    return productId;
                else
                    return int.MinValue;
            }
            set
            {
                productId = value;
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

            txtExpectedDepartureDate.Value = DateTime.Now.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);

            txtRequestTour.Value = spanTourName.InnerHtml= Title;
            hddProductId.Value = ProductId.ToString();

            block_bookingprice.ProductId = ProductId;

            IsTourByTime();
            BindPriceClass();
            BindBookingGroup();
            BindCountries();
        }

        /// <summary>
        /// get data for insert update
        /// </summary>
        /// <param name="userObj"></param>
        /// <returns></returns>
        private PNK_Booking GetDataObjectParent(PNK_Booking obj)
        {
            obj.ParentId = 1;
            obj.FirstName = txtFirstName.Value.Trim();
            obj.LastName = txtLastName.Value.Trim();
            obj.PhoneNumber = txtPhoneNumber.Text.Trim();
            obj.RequestTour = txtRequestTour.Value.Trim();
            obj.ExpectedDepartureDate = txtExpectedDepartureDate.Value;
            obj.NumberOfAduts = txtNumberAduts.Value.Trim();
            obj.NumberOfChildren = txtNumberChild.Value.Trim();
            obj.NumberOfInfant = txtNumberInfant.Value.Trim();
            obj.Published = "1";
            obj.Email = txtEmail.Text.Trim();
            obj.RequestTour = txtRequestTour.Value.Trim();

            obj.HotelType = drpHotel.Items[drpHotel.SelectedIndex].Text;
            obj.ArrivalPort = drpArrival.Items[drpArrival.SelectedIndex].Text;
            obj.RoomType = drpRoomType.Items[drpRoomType.SelectedIndex].Text;
            obj.RoomOther = txtRoomOther.Value.Trim();
            obj.BedType = drpBedType.Items[drpBedType.SelectedIndex].Text;
            obj.BedOther = txtBedOther.Value.Trim();
            obj.VisaOfNeed = rdVisaYes.Checked == true ? "Yes" : "No";
            //obj.KnowThrough = drpKnow.Items[drpKnow.SelectedIndex].Text;
            //obj.PaymentMethod = drpPayment.Items[drpPayment.SelectedIndex].Text;
            obj.Distance = drpDistance.Items[drpDistance.SelectedIndex].Text;
            obj.FlightArrivalNo = txtFlightArrivalNo.Text.Trim();
            obj.FlightArrivaTime = txtFlightArrialTime.Text.Trim();
            obj.FlightDepartureTime = txtFlightDepartureTime.Text.Trim();
            obj.FlightArrivalDate = txtFlightArrivalDate.Text.Trim();
            obj.FlightDepartureDate = txtFlightDepartureDate.Text.Trim();

            obj.CustomerHeight = txtCustomerHeight.Text.Trim();
            obj.HotelName = txtHotelName.Text.Trim();
            obj.CustomerAge = txtCustomerAge.Text.Trim();
            obj.HotelAddress = txtHotelAddress.Text.Trim();
            obj.Country = drpCountry.Items[drpCountry.SelectedIndex].Text;
            obj.City = hddDrpCityValue.Value;
            obj.SpecialRequest = txtSpecialRequest.Text;
            obj.PickUpLocation = txtPickUpLocation.Text;

            obj.UpdateDate = DateTime.Now;
            obj.PostDate = DateTime.Now;
            obj.Total = hddPriceSumValue.Value;
            obj.PaymentMethod = drpPaymentType.Items[drpPaymentType.SelectedIndex].Text;

            return obj;
        }

        /// <summary>
        /// get data child for insert update
        /// </summary>
        /// <param name="contdescObj"></param>
        /// <returns></returns>
        private PNK_BookingDesc GetDataObjectChild(PNK_BookingDesc productcatdescObj, int lang)
        {
            switch (lang)
            {
                case 1:
                    productcatdescObj.MainId = 1;
                    productcatdescObj.LangId = Constant.DB.LangId;
                    productcatdescObj.Name = SanitizeHtml.Sanitize(string.Format("{0} {1}", txtFirstName.Value, txtLastName.Value));
                    break;
                case 2:
                    productcatdescObj.MainId = 1;
                    productcatdescObj.LangId = Constant.DB.LangId_En;
                    productcatdescObj.Name = SanitizeHtml.Sanitize(string.Format("{0} {1}", txtFirstName.Value, txtLastName.Value));
                    break;
            }
            return productcatdescObj;
        }

        /// <summary>
        /// Save location
        /// </summary>
        private int SaveBooking()
        {
            Generic<PNK_Booking> genericBLL = new Generic<PNK_Booking>();
            Generic2C<PNK_Booking, PNK_BookingDesc> generic2CBLL = new Generic2C<PNK_Booking, PNK_BookingDesc>();
            PNK_Booking objBooking = new PNK_Booking();
            PNK_BookingDesc bookingObjVn = new PNK_BookingDesc();
            PNK_BookingDesc bookingObjEn = new PNK_BookingDesc();
            //if (this.productcategoryId == int.MinValue)
            //{
            //get data insert
            objBooking = this.GetDataObjectParent(objBooking);
            objBooking.Ordering = genericBLL.getOrdering();
            bookingObjVn = this.GetDataObjectChild(bookingObjVn, Constant.DB.LangId);
            bookingObjEn = this.GetDataObjectChild(bookingObjEn, Constant.DB.LangId_En);

            List<PNK_BookingDesc> lst = new List<PNK_BookingDesc>();
            lst.Add(bookingObjVn);
            lst.Add(bookingObjEn);

            //Giữ lại để chuyển qua form bookingresult
            Session["objBooking"] = objBooking;
            Session["lstBookingDesc"] = lst;

            //excute
            //bookingId = generic2CBLL.Insert(objBooking, lst);

            //Send email đến KH
            //if (bookingId != int.MinValue)
            //{
            //    SendEmailTempate(objBooking);
            //}
            return bookingId;
        }

        private void BindPriceClass()
        {
            //string whereClause = " where PriceClass is not null";
            DataTable dtb = DBHelper.ExcuteFromCmd("SELECT PriceClass,ProductId FROM PNK_BookingPrice WHERE ProductID=" + hddProductId.Value + " AND  PriceClass IS NOT NULL and PriceClass not in ('infant','child') GROUP BY PriceClass,ProductId", null);
            //IList<PNK_BookingPrice> lst =DBHelper.ExcuteFromCmd genericBLL.GetAllBy(new PNK_BookingPrice(), whereClause, null);
            if (dtb != null && dtb.Rows.Count > 0)
            {
                drpPriceClass.DataValueField = "PriceClass";
                drpPriceClass.DataTextField = "PriceClass";
                drpPriceClass.DataSource = dtb;
                drpPriceClass.DataBind();
            }
        }

        private void BindBookingGroup()
        {
            BookingGroupBLL bllBookingGroup = new BookingGroupBLL();
            IList<PNK_BookingGroup> lstBookingGroup = bllBookingGroup.GetList();
            drpTourGroup.DataSource = lstBookingGroup;
            drpTourGroup.DataTextField = "Name";
            drpTourGroup.DataValueField = "Name";
            drpTourGroup.DataBind();

            DataTable dtb = DBHelper.ExcuteFromCmd(string.Format("select * from PNK_BookingPrice where ProductId={0} ", productId), null);
            if (dtb != null && dtb.Rows.Count > 0)
            {
                string d = dtb.Rows[0]["GroupType"].ToString();
                drpTourGroup.SelectedValue = drpTourGroup.Items.FindByText(d).Value;
            }
        }

        private void BindCountries()
        {
            DataTable dtb = DBHelper.ExcuteFromCmd(" SELECT distinct Country,PhoneCode FROM pnk_countries_cities ", null);
            if (dtb != null && dtb.Rows.Count > 0)
            {
                drpCountry.DataSource = dtb;
                drpCountry.DataTextField = "Country";
                drpCountry.DataValueField = "PhoneCode";
                drpCountry.DataBind();

                //drpCity.DataSource = dtb;
                //drpCity.DataTextField = "Country";
                //drpCity.DataValueField = "PhoneCode";
                //drpCity.DataBind();
            }
        }

        #region Booking

        //private void SendEmailTempate(PNK_Booking obj)
        //{
        //    string companyName = string.Empty, companyEmail = string.Empty, companyPhone = string.Empty, companyAddress = string.Empty
        //        , companyWebsite = string.Empty, companyFax = string.Empty;

        //    ConfigurationBLL pcBll = new ConfigurationBLL();
        //    IList<PNK_Configuration> lst = pcBll.GetList();
        //    if (lst != null && lst.Count > 0)
        //    {
        //        foreach (PNK_Configuration item in lst)
        //        {
        //            if (item.Key_name == Constant.Configuration.config_company_name_vi)
        //            {
        //                companyName = item.Value_name;
        //            }
        //            if (item.Key_name == Constant.Configuration.email)
        //            {
        //                companyEmail = item.Value_name;
        //            }
        //            if (item.Key_name == Constant.Configuration.phone)
        //            {
        //                companyPhone = item.Value_name;
        //            }
        //            if (item.Key_name == Constant.Configuration.config_address_vi)
        //            {
        //                companyAddress = item.Value_name;
        //            }
        //            if (item.Key_name == Constant.Configuration.sitename)
        //            {
        //                companyWebsite = item.Value_name;
        //            }
        //            if (item.Key_name == Constant.Configuration.fax)
        //            {
        //                companyFax = item.Value_name;
        //            }
        //        }
        //    }

        //    string path = Request.PhysicalApplicationPath;
        //    string strHtml = WebUtils.GetMailTemplate(Path.Combine(path, "TemplateMail/Booking.html"));
        //    string body = string.Format(strHtml,
        //                companyName,//0
        //                obj.FirstName,//1
        //                obj.LastName,//2
        //                obj.Country,//3
        //                obj.City,//4
        //                obj.PhoneNumber,//5
        //                obj.Email,//6
        //                obj.PickUpLocation,//7
        //                DateTime.Now,//8
        //                obj.RequestTour,//9
        //                obj.ExpectedDepartureDate,//10
        //                obj.NumberOfAduts,//11                  
        //                obj.NumberOfChildren,//12
        //                obj.NumberOfInfant,//13
        //                obj.Total,//14
        //                obj.PaymentMethod,//15
        //                companyAddress,//16
        //                companyEmail,//17
        //                companyWebsite,//18
        //                companyPhone,//19
        //                companyFax//20
        //       );
        //    WebUtils.SendEmail("Contact", txtEmail.Text, string.Empty, body);

        //    //// Create a Document object
        //    //Document document = new Document(PageSize.A4, 25, 10, 25, 10);
        //    //var output = new FileStream(Server.MapPath("MyFirstPDF.pdf"), FileMode.Create);
        //    //PdfWriter pdfWriter = PdfWriter.GetInstance(document, output);
        //    //document.Open();

        //    //var parsedHtmlElements = HTMLWorker.ParseToList(new StringReader(body), null);
        //    //// Enumerate the elements, adding each one to the Document...
        //    //foreach (var htmlElement in parsedHtmlElements)
        //    //    document.Add(htmlElement as IElement);

        //    ////Paragraph Text = new Paragraph(body);
        //    ////pdfDoc.Add(Text);
        //    ////pdfWriter.CloseStream = false;
        //    //document.Close();
        //    ////Response.Buffer = true;
        //    ////Response.ContentType = "application/pdf";
        //    ////Response.AddHeader("content-disposition", "attachment;filename=Example.pdf");
        //    ////Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    ////Response.Write(pdfDoc);
        //    //// Response.End();
        //}

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

                //Session["orderID_booking"] = 1;
                //Session["sessionID_booking"] = 2;
              
                // Attempt to receive the WebResponse to the WebRequest.
                using (HttpWebResponse hwresponse = (HttpWebResponse)hwrequest.GetResponse())
                {                  
                    if (hwresponse != null)
                    { // If we have valid WebResponse then read it.
                        using (StreamReader reader = new StreamReader(hwresponse.GetResponseStream()))
                        {
                            XPathDocument doc = new XPathDocument(reader);
                            XPathNavigator xml = doc.CreateNavigator();

                            XPathNodeIterator nodes = xml.Select("/TKKPG/Response/Order/OrderID");
                          
                            foreach (XPathNavigator item in nodes)
                            {
                                Session["orderID_booking"] = orderID = item.Value;
                                BookingResutl bookingResutl = new BookingResutl();
                                Cookie e = new Cookie();
                                WebUtils.SetCookie(bookingResutl, "orderID_booking", item.Value);
                            }

                            XPathNodeIterator nodesSession = xml.Select("/TKKPG/Response/Order/SessionID");
                            foreach (XPathNavigator item in nodesSession)
                            {
                                Session["sessionID_booking"] = sessionID = item.Value;
                            }
                            reader.Close();
                        }
                    }

                    hwresponse.Close();
                }
              
                // Goi ham ma hoa
                orderIDEncry = EncryptData(orderID, "E9VQzPF1P6zt3gHN");
                string urlRedirect = string.Format("https://pgcard.agribank.com.vn/index.jsp?ORDERID={0}&SESSIONID={1}&MERCHANTID=VBAPGMER07&ResponseData={2}", orderIDEncry, sessionID, orderID);
                Response.Redirect(urlRedirect, false);

                // Response.Redirect("http://localhost:5235/booking-result/vn", false);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs(URL, "POSTRequest", ex.Message);
            }
            
            return responseData;
        }

        public static string GetOrder8(string orderId)
        {
            string result = orderId + "        ".Substring(0, 8 - ((ToHex(orderId).Length % 16) >> 1));
            return result;
        }
        public static string ToHex(string input)
        {
            if (!string.IsNullOrEmpty(input))
            {
                byte[] data = Encoding.UTF8.GetBytes(input);
                string hexData = BitConverter.ToString(data);
                return hexData.Replace("-", "");
            }
            else
            {
                return string.Empty;
            }
        }
        public static byte[] HexToByte(string hexString)
        {
            int numberChars = hexString.Length;
            byte[] bytes = new byte[numberChars / 2];
            for (int i = 0; i < numberChars; i += 2)
            {
                int high;
                try
                {
                    high = Convert.ToInt32(((char)hexString[i]).ToString(), 16);
                }
                catch (Exception ex)
                {
                    high = -1;
                }
                int low;
                try
                {
                    low = Convert.ToInt32(((char)hexString[i + 1]).ToString(), 16);
                }
                catch (Exception ex)
                {
                    low = -1;
                }
                int value = high << 4 | low;
                if (value > 127)
                {
                    value -= 256;
                }
                bytes[i / 2] = ((byte)value);
            }
            return bytes;
        }

        public static string EncryptData(string orderId, string key)
        {
            try
            {
                string order8 = GetOrder8(orderId);
                string hexData = ToHex(order8);
                var des = new DESCryptoServiceProvider();
                des.Padding = PaddingMode.None;
                des.Mode = CipherMode.ECB;
                var keyarr = HexToByte(key);
                des.Key = keyarr;
                des.IV = new byte[des.BlockSize / 8];
                ICryptoTransform ct = des.CreateEncryptor();
                byte[] input = HexToByte(hexData);
                var result = ct.TransformFinalBlock(input, 0, input.Length);
                return BitConverter.ToString(result).Replace("-", "");
            }
            catch (Exception)
            {
                return string.Empty;
            }
        }

        #endregion

        //Ẩn tour thuộc by time
        private void IsTourByTime()
        {
            DataTable dtb = DBHelper.ExcuteFromCmd(string.Format("SELECT Area FROM PNK_Product WHERE id = {0} ", productId), null);
            if (dtb != null && dtb.Rows.Count > 0)
            {
                string tourByHour = dtb.Rows[0]["Area"].ToString();
                switch (tourByHour)
                {
                    case "Half Day":
                    case "By Hour":
                        divTourByHour.Visible = divTourByHour_Arrival.Visible = divTourByHour_Departure.Visible = divTourByHour_TypeHotel.Visible =
                            divTourByHour_TypeRoom.Visible = divTourByHour_BedType.Visible = false;
                        break;
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

        protected void btnSend_ServerClick(object sender, EventArgs e)
        {
            string responseData = "Success ";
            try
            {
                if (Page.IsValid)
                {
                    //Save booking
                    SaveBooking();
                    //Write2Log.WriteLogs("block_booking", "a", "fdas");

                    //Thanh toán
                    Session["paymentType_booking"] = drpPaymentType.Items[drpPaymentType.SelectedIndex].Value;
                    switch (drpPaymentType.Items[drpPaymentType.SelectedIndex].Value)
                    {
                        case "2":
                        case "3":
                            Session["price_booking"] = hddPriceSumValue.Value;
                            string URL = "https://pgcard.agribank.com.vn:8380/Exec";
                            string postData = "<TKKPG>\n" +
                                    "  <Request>\n" +
                                    "   <Operation>CreateOrder</Operation>\n" +
                                    "   <Language>EN</Language>\n" +
                                    "   <Order>\n" +
                                    "     <OrderType>Purchase</OrderType>\n" +
                                    "     <Merchant>VBAPGMER07</Merchant>\n" +
                                    "     <Amount>" + hddPriceSumValue.Value + "</Amount>\n" +
                                    "     <Currency>704</Currency>\n" +
                                    "     <email>" + txtEmail.Text + "</email>\n" +
                                      "   <phone>" + txtPhoneNumber.Text + "</phone>\n" +
                                    "     <Description>" + string.Format("Tour name:{0} - Email:{1} - Phone:{2}", txtRequestTour.Value, txtEmail.Text, txtPhoneNumber.Text) + "</Description>\n" +
                                    "     <ApproveURL>http://cuchitunnels.vn/booking-result/vn</ApproveURL> " +
                                    "     <CancelURL>http://cuchitunnels.vn/booking-result/vn</CancelURL>\n" +
                                    "     <DeclineURL>http://cuchitunnels.vn/booking-result/vn</DeclineURL>\n" +
                                    "    </Order>\n" +
                                    " </Request>\n" +
                                    "</TKKPG>";
                         
                            responseData = POSTRequest(URL, postData);
                            break;
                        case "1":
                            Response.Redirect(Utils.CombineUrl(Template_path, "/booking-result/vn"));
                            break;
                    }

                    //if (bookingId != int.MinValue)
                    //{
                    //    ////Gửi email đến KH
                    //    //string path = Request.PhysicalApplicationPath;
                    //    //string strHtml = WebUtils.GetMailTemplate(Path.Combine(path, "TemplateMail/Booking.txt"));
                    //    //string body = string.Format(strHtml, "admin", txtFullName.Value, txtEmail.Text, "fasfasf");
                    //    //WebUtils.SendEmail("Contact", txtEmail.Text, string.Empty, body);

                    //    ////Gửi email admin                       
                    //    //strHtml = WebUtils.GetMailTemplate(Path.Combine(path, "TemplateMail/Booking.txt"));
                    //    //body = string.Format(strHtml, "admin", txtFullName.Value, "inbound@vietnamtravelgroup.com", "fasfasf");
                    //    //WebUtils.SendEmail("Contact", "inbound@vietnamtravelgroup.com", string.Empty, body);

                    //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('Your message has been sent successfully. As soon as we receive your request, we will confirm your reservation. Thank you!','Message',function(r) {{window.location='{0}'}});", Request.RawUrl), true);
                    //}
                    //else
                    //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('Send fail.','Message',function(r) {{window.location='{0}'}});", Request.RawUrl), true);
                }
            }
            catch (Exception ex)
            {
                // ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('" + ex.Message + "','Message',function(r) {{window.location='{0}'}});", Request.RawUrl), true);
                Write2Log.WriteLogs("block_booking.aspx", "btnSend_ServerClick", ex.Message);

            }
        }

        #endregion

    }
}