/**
 * @version $Id:
 * @package Cybervn.NET
 * @author Cybervn Dev <dev@dgc.vn>
 * @copyright Copyright (C) 2009 by Cybervn. All rights reserved.
 * @link http://www.Cybervn.com
 */
using System;
using System.Collections.Generic;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.Caching;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using System.IO;
using System.Text;
using System.Configuration;
using System.Reflection;
using System.Xml;
using System.Net.Mail;
using System.Globalization;
using System.Security.Principal;
using System.Web.Profile;
using System.Net;
using Cb.DBUtility;

namespace Cb.Utility
{

    public static class WebUtils
    {
        private static Dictionary<string, string> knownMimes;

        static WebUtils()
        {
            knownMimes = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            knownMimes.Add(".jpg", "image/pjpeg");
            knownMimes.Add(".png", "image/x-png");
            knownMimes.Add(".gif", "image/gif");
            knownMimes.Add(".ico", "image/x-icon");
            knownMimes.Add(".bmp", "image/bmp");
            knownMimes.Add(".wmv", "video/x-ms-wmv");
        }

        public static string GetKnownMime(string filespec)
        {
            string extension = Path.GetExtension(filespec);
            if (knownMimes.ContainsKey(extension))
                return knownMimes[extension];
            return null;
        }

        public static string GetUniqueKey(UserControl control)
        {
            if (null == control)
                return HttpContext.Current.Request.FilePath;
            return string.Format("{0}_{1}", HttpContext.Current.Request.FilePath, control.ClientID);
        }

        public static string GetCookie(UserControl control, string key)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[GetUniqueKey(control)];
            if (null != cookie)
                return cookie[key];
            return null;
        }

        public static void SetCookie(UserControl control, string key, string value)
        {
            HttpContext.Current.Response.Cookies[GetUniqueKey(control)][key] = value;
        }

        public static void ReloadPage()
        {
            string url = Path.Combine(WebUtils.GetWebPath(), HttpContext.Current.Request.RawUrl);
            HttpContext.Current.Response.Redirect(url);
        }

        public static bool IsCurrentPage(string pageUrl)
        {
            return HttpContext.Current.Request.Url.AbsoluteUri.StartsWith(pageUrl, StringComparison.OrdinalIgnoreCase);
        }

        public static void IncludeJS(Page page, string jsfile)
        {
            HtmlGenericControl include = new HtmlGenericControl("script");
            include.Attributes.Add("type", "text/javascript");
            include.Attributes.Add("src", jsfile);
            page.Header.Controls.Add(include);
        }

        public static void IncludeJSScript(Page page, string script)
        {
            HtmlGenericControl child = new HtmlGenericControl("script");
            child.Attributes.Add("type", "text/javascript");
            child.InnerHtml = script;
            page.Header.Controls.Add(child);
        }

        public static void IncludeCSS(Page page, string cssfile)
        {
            HtmlGenericControl include = new HtmlGenericControl("link");
            include.Attributes.Add("rel", "stylesheet");
            include.Attributes.Add("type", "text/css");
            include.Attributes.Add("href", cssfile);
            page.Header.Controls.Add(include);
        }

        public static string GetWebPath()
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            int t = path.LastIndexOf('/');
            path = path.Substring(0, t);
            return path;
        }

        public static string GetHostPath()
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            int t = path.LastIndexOf('/');
            path = path.Substring(0, t);
            t = path.LastIndexOf('/');
            path = path.Substring(0, t);
            return path;
        }

        public static string GetBaseUrl()
        {
            return HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);
        }

        /// <summary>
        /// Set link redirect to home page
        /// </summary>
        /// <returns></returns>
        public static string RedirectHomePage()
        {
            string result;
            //Set link redirect to home page
            if (GetWebPath().Contains("localhost"))
                result = string.Format("{0}/{1}", GetBaseUrl(), "default.aspx"); //LinkHelper.GetLink("home", LangId);
            else
                result = GetWebPath();
            return result;
        }

        /// <summary>
        /// Lay Duong dan hinh ảnh,
        /// neu ko co hinh thi lay hinh SrcNoImage </summary> <param
        /// name="imageUploadFolder">Thư mục chứa hình ảnh</param> <param
        /// name="fileName"></param>Tên file hình ảnh <returns></returns>
        public static string GetUrlImage(string imageUploadFolder, string fileName)
        {
            string src, url;
            string template_path = GetBaseUrl();
            if (!string.IsNullOrEmpty(fileName))
            {
                src = Path.Combine(imageUploadFolder, fileName);
                url = HttpContext.Current.Server.MapPath(src);
                if (File.Exists(url))
                    url = Utils.CombineUrl(template_path, src);
                else
                    url = Utils.CombineUrl(template_path, ConfigurationManager.AppSettings["SrcNoImage"]);
            }
            else
                url = Path.Combine(template_path, ConfigurationManager.AppSettings["SrcNoImage"]);
            return url;
        }

        /// <summary>
        /// Lay Duong dan hinh ảnh, có hình thay thế
        /// neu ko co hinh thi lay hinh SrcNoImage </summary> <param
        /// name="configAppSetting">Đường lấy từ Webconfig</param> <param
        /// name="fileName"></param> Tên file hình ảnh <returns></returns>
        /// name="fileName"></param> Tên file hình thay thể khi không có hình ảnh(fileName) <returns></returns>
        public static string GetUrlImage(string configAppSetting, string fileName, string fileReplaceIfNotLoad)
        {
            string src, url;
            string template_path = GetBaseUrl();
            if (!string.IsNullOrEmpty(fileName))
            {
                src = Path.Combine(ConfigurationManager.AppSettings[configAppSetting], fileName);
                url = HttpContext.Current.Server.MapPath(src);
                if (File.Exists(url))
                    url = Utils.CombineUrl(template_path, src);
                else
                    url = GetUrlImage(configAppSetting, fileReplaceIfNotLoad);
            }
            else
                url = GetUrlImage(configAppSetting, fileReplaceIfNotLoad);
            return url;
        }

        public static string GetThemesTemplateRoot()
        {
            return HttpContext.Current.Request.PhysicalApplicationPath + Path.Combine("App_Data", "Themes_Template");
        }

        public static string GetThemesTemplatePath(string theme)
        {
            return Path.Combine(GetThemesTemplateRoot(), theme);
        }

        public static string RenderControl(string path, string propertyName, object propertyValue)
        {
            Page pageHolder = new Page();
            UserControl viewControl = (UserControl)pageHolder.LoadControl(path);

            if (null != propertyValue)
            {
                Type viewControlType = viewControl.GetType();
                PropertyInfo property = viewControlType.GetProperty(propertyName);

                if (null != property)
                {
                    property.SetValue(viewControl, propertyValue, null);
                }
                else
                {
                    throw new ApplicationException(string.Format("Control {0} does not have {1} property", path, propertyValue));
                }
            }

            pageHolder.Controls.Add(viewControl);

            StringWriter output = new StringWriter();
            HttpContext.Current.Server.Execute(pageHolder, output, false);

            return output.ToString();
        }

        private static string RenderControl(Control control)
        {
            StringBuilder htmlBuilder = new StringBuilder();
            using (StringWriter stringWriter = new StringWriter(htmlBuilder))
            {
                using (HtmlTextWriter writer = new HtmlTextWriter(stringWriter))
                {
                    control.RenderControl(writer);
                }
            }
            return htmlBuilder.ToString();
        }

        public static XmlDocument LoadThemeConfigXml(string theme)
        {
            XmlDocument themeConfig = new XmlDocument();
            themeConfig.Load(GetThemeConfigXmlFilespec(theme));
            return themeConfig;
        }

        public static string GetThemeConfigXmlFilespec(string theme)
        {
            return Path.Combine(GetThemesTemplatePath(theme), "config.xml");
        }

        public static void Redirect301(string url)
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", url);
            HttpContext.Current.Response.End();
        }

        public static string SetBuild(string url)
        {
            return GetWebPath() + "/" + url;
        }

        /// <summary>
        /// get file ext
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public static string GetFileExtension(string fileName)
        {
            string fileExt = string.Empty;
            //Getting the file extension 
            string strFileExt = System.IO.Path.GetExtension(fileName);
            //Validating it
            if (strFileExt.ToUpper() == ".EXE")
            {
                return string.Empty;
            }
            int extPos = fileName.LastIndexOf('.');
            if ((extPos + 1) > 1)
            {
                fileExt = fileName.Substring(extPos + 1);
            }
            return fileExt;
        }

        public static string GetFileName(string fileName)
        {
            if (fileName == string.Empty) return string.Empty;
            string fileExt = string.Empty;
            //Getting the file extension 
            string strFileExt = System.IO.Path.GetFileNameWithoutExtension(fileName);
            //Validating it
            if (strFileExt.ToUpper() == ".EXE")
            {
                return string.Empty;
            }
            return System.IO.Path.GetFileName(fileName);
        }

        public static string GetFileImageExtension(string fileName)
        {
            string fileExt = string.Empty;
            //Getting the file extension 
            string strFileExt = System.IO.Path.GetExtension(fileName);
            //Validating it
            if (strFileExt.ToUpper() == ".JPG" || strFileExt.ToUpper() == ".GIF" || strFileExt.ToUpper() == ".PNG")
            {
                int extPos = fileName.LastIndexOf('.');
                if ((extPos + 1) > 1)
                {
                    fileExt = fileName.Substring(extPos + 1);
                }
            }
            return fileExt;

        }

        public static string GetInfoFileName(string fileName)
        {
            if (fileName == string.Empty) return string.Empty;
            string fileExt = string.Empty;
            //Getting the file extension 
            string strFileExt = System.IO.Path.GetFileNameWithoutExtension(fileName);

            return strFileExt;
        }

        public static string GetMimeType(string fileName)
        {
            string mimeType = "application/unknown";
            string ext = System.IO.Path.GetExtension(fileName).ToLower();
            Microsoft.Win32.RegistryKey regKey = Microsoft.Win32.Registry.ClassesRoot.OpenSubKey(ext);
            if (regKey != null && regKey.GetValue("Content Type") != null)
                mimeType = regKey.GetValue("Content Type").ToString();
            return mimeType;
        }

        /// <summary>
        /// Get Content of template mail
        /// </summary>
        /// <param name="filePath">Full path of file template</param>
        /// <returns>Content of mail</returns>
        public static string GetMailTemplate(string filePath)
        {
            string body = string.Empty;
            if (File.Exists(filePath))
            {
                StreamReader srReadLine = new StreamReader(filePath, System.Text.Encoding.GetEncoding("UTF-8"));
                srReadLine.BaseStream.Seek(0, SeekOrigin.Begin);

                while (true)
                {
                    string str = srReadLine.ReadLine();
                    if (str == null)
                        break;
                    else
                        body += str + "\r\n";
                }
                srReadLine.Close();
            }
            return body;
        }

        /// <summary>
        /// Sử dụng host email để send email 
        /// </summary>
        /// <param name="subject"></param>
        /// <param name="from"></param>
        /// <param name="to"></param>
        /// <param name="header"></param>
        /// <param name="body"></param>
        /// <returns></returns>
        public static bool SendEmail(string subject, string from, string header, string body)
        {
            bool result = false;

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(ConfigurationManager.AppSettings["MailTo"]);
            mail.To.Add(ConfigurationManager.AppSettings["MailTo"]);
            mail.Subject = subject;
            mail.IsBodyHtml = true;
            mail.Body = body;
            mail.BodyEncoding = Encoding.UTF8;

            MailAddress copy = new MailAddress(from);
            mail.CC.Add(copy);

            //Configure an SmtpClient to send the mail.
            SmtpClient client = new SmtpClient();
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.EnableSsl = DBConvert.ParseBool(ConfigurationManager.AppSettings["EnableSsl"]);
            client.Host = ConfigurationManager.AppSettings["SmtpServer"];
            client.Port = DBConvert.ParseInt(ConfigurationManager.AppSettings["Port"]);

            NetworkCredential credentials = new NetworkCredential(ConfigurationManager.AppSettings["UserMail"], ConfigurationManager.AppSettings["PassMail"]);
            client.UseDefaultCredentials = false;
            client.Credentials = credentials;

            try
            {
                //Send the msg
                client.Send(mail);
                result = true;
            }
            catch (Exception ex)
            {
                result = false;
                Write2Log.WriteLogs(ConfigurationManager.AppSettings["UserMail"] + "1", ConfigurationManager.AppSettings["PassMail"], ex.ToString());
            }
            return result;
        }

        /// <summary>
        /// Sử dụng gmail để send email
        /// </summary>
        /// <param name="subject"></param>
        /// <param name="from"></param>
        /// <param name="to"></param>
        /// <param name="header"></param>
        /// <param name="body"></param>
        /// <returns></returns>
        public static bool SendEmailGmail(string subject, string from, string header, string body)
        {
            bool result = false;

            //Create the msg object to be sent
            MailMessage msg = new MailMessage();
            //Add your email address to the recipients
            msg.To.Add("ddemo9698@gmail.com");
            //Configure the address we are sending the mail from
            MailAddress address = new MailAddress("ddemo9698@gmail.com");
            msg.From = address;
            msg.Subject = "test";
            msg.Body = body;
            msg.IsBodyHtml = true;
            //Configure an SmtpClient to send the mail.            
            SmtpClient client = new SmtpClient();
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.EnableSsl = true;
            client.Host = "smtp.gmail.com";
            client.Port = 25;

            //Setup credentials to login to our sender email address ("UserName", "Password")
            NetworkCredential credentials = new NetworkCredential("ddemo9698@gmail.com", "abc@12345");
            client.UseDefaultCredentials = true;
            client.Credentials = credentials;

            //Send the msg
            try
            {
                client.Send(msg);
                result = true;
            }
            catch (Exception ex)
            {
                result = false;
                Write2Log.WriteLogs(ConfigurationManager.AppSettings["UserMail"], ConfigurationManager.AppSettings["PassMail"], ex.ToString());
            }

            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="langId"></param>
        /// <returns></returns>
        public static CultureInfo getResource(string langId)
        {
            CultureInfo ci = null;
            switch (langId)
            {
                case Constant.DB.langVn:
                    ci = new CultureInfo("vi-VN");
                    break;
                case Constant.DB.langEng:
                    ci = new CultureInfo("en-US");
                    break;
            }
            return ci;
        }

        /// <summary>
        /// Kiểm tra Browser có phải thiết bị di động không ?
        /// </summary>
        /// <returns></returns>
        public static bool IsMobileBrowser()
        {
            //GETS THE CURRENT USER CONTEXT
            HttpContext context = HttpContext.Current;

            //FIRST TRY BUILT IN ASP.NT CHECK
            if (context.Request.Browser.IsMobileDevice)
            {
                return true;
            }
            //THEN TRY CHECKING FOR THE HTTP_X_WAP_PROFILE HEADER
            if (context.Request.ServerVariables["HTTP_X_WAP_PROFILE"] != null)
            {
                return true;
            }
            //THEN TRY CHECKING THAT HTTP_ACCEPT EXISTS AND CONTAINS WAP
            if (context.Request.ServerVariables["HTTP_ACCEPT"] != null &&
                context.Request.ServerVariables["HTTP_ACCEPT"].ToLower().Contains("wap"))
            {
                return true;
            }
            //AND FINALLY CHECK THE HTTP_USER_AGENT 
            //HEADER VARIABLE FOR ANY ONE OF THE FOLLOWING
            if (context.Request.ServerVariables["HTTP_USER_AGENT"] != null)
            {
                //Create a list of all mobile types
                string[] mobiles =
                    new[]
                {
                    "midp", "j2me", "avant", "docomo", 
                    "novarra", "palmos", "palmsource", 
                    "240x320", "opwv", "chtml",
                    "pda", "windows ce", "mmp/", 
                    "blackberry", "mib/", "symbian", 
                    "wireless", "nokia", "hand", "mobi",
                    "phone", "cdm", "up.b", "audio", 
                    "SIE-", "SEC-", "samsung", "HTC", 
                    "mot-", "mitsu", "sagem", "sony"
                    , "alcatel", "lg", "eric", "vx", 
                    "NEC", "philips", "mmm", "xx", 
                    "panasonic", "sharp", "wap", "sch",
                    "rover", "pocket", "benq", "java", 
                    "pt", "pg", "vox", "amoi", 
                    "bird", "compal", "kg", "voda",
                    "sany", "kdd", "dbt", "sendo", 
                    "sgh", "gradi", "jb", "dddi", 
                    "moto", "iphone"
                };

                //Loop through each item in the list created above 
                //and check if the header contains that text
                foreach (string s in mobiles)
                {
                    if (context.Request.ServerVariables["HTTP_USER_AGENT"].
                                                        ToLower().Contains(s.ToLower()))
                    {
                        return true;
                    }
                }
            }

            return false;
        }

        /// <summary>
        /// Seo Title, Description, keysword
        /// </summary>
        /// <param name="title">title</param>
        /// <param name="desciption">desciption</param>
        /// <param name="keyswork">keysword</param>
        /// <param name="page">page</param>
        public static void SeoPage(string title, string desciption, string keysword, Page page)
        {
            if (page != null)
            {
                //Add Page Title
                page.Title = title;

                //Add Keywords Meta Tag
                HtmlMeta keywords = new HtmlMeta();
                keywords.HttpEquiv = "keywords";
                keywords.Name = "keywords";
                keywords.Content = keysword;
                page.Header.Controls.Add(keywords);

                //Add Description Meta Tag
                HtmlMeta description = new HtmlMeta();
                description.HttpEquiv = "description";
                description.Name = "description";
                description.Content = desciption;
                page.Header.Controls.Add(description);
            }
        }

        /// <summary>
        /// Seo HTML H Tab
        /// </summary>
        /// <param name="title">title</param>
        /// <param name="desciption">desciption</param>
        /// <param name="keyswork">keysword</param>
        /// <param name="page">page</param>
        public static void SeoTagH(string h1, string h2, string h3, ControlCollection control)
        {
            if (control != null)
            {
                HtmlGenericControl h1Tag = new HtmlGenericControl("h1");
                h1Tag.InnerHtml = h1;
                h1Tag.Style.Add("display", "none");
                control.Add(h1Tag);

                HtmlGenericControl h2Tag = new HtmlGenericControl("h2");
                h2Tag.InnerHtml = h2;
                h2Tag.Style.Add("display", "none");
                control.Add(h2Tag);

                HtmlGenericControl h3Tag = new HtmlGenericControl("h3");
                h3Tag.InnerHtml = h3;
                h3Tag.Style.Add("display", "none");
                control.Add(h3Tag);
            }
        }

        #region Alert

        public static void Alert(Page page, string alert)
        {
            string script = string.Format("jAlert('{0}','Message');", alert);
            page.ClientScript.RegisterStartupScript(page.GetType(), Guid.NewGuid().ToString(), script, true);
        }

        public static void AlertWithRedirect(Page page, string alert, string link)
        {
            string script = string.Format("jAlert('{0}','Message',function(r) {{window.location='{1}'}});", alert, link);
            page.ClientScript.RegisterStartupScript(page.GetType(), Guid.NewGuid().ToString(), script, true);
        }
        #endregion

        #region Cache tang BLL

        /// <summary>
        /// Đối tượng người dùng hiện tại (đã đăng nhập hoặc chưa đăng nhập (anonymous))
        /// 15/10/2012  - DinhNN1   - Created.
        /// </summary>
        public static IPrincipal CurrentUser
        {
            get { return HttpContext.Current.User; }
        }

        /// <summary>
        /// Tên của người dùng hiện tại (đã đăng nhập: tên (không có phần @fpt.com.vn), chưa đăng nhập: khoảng trắng)
        /// 15/10/2012  - DinhNN1   - Created.
        /// </summary>
        public static string CurrentUserName
        {
            get
            {
                string userName = string.Empty;
                if (CurrentUser.Identity.IsAuthenticated)
                {
                    userName = RemoveDomainName(CurrentUser.Identity.Name);
                }
                return userName;
            }
        }

        /// <summary>
        /// Converts the input plain-text to HTML version, replacing carriage returns
        /// and spaces with <br /> and &nbsp;
        /// </summary>
        public static string ConvertToHtml(string content)
        {
            content = HttpUtility.HtmlEncode(content);
            content = content.Replace("  ", "&nbsp;&nbsp;").Replace(
               "\t", "&nbsp;&nbsp;&nbsp;").Replace("\n", "<br>");
            return content;
        }

        /// <summary>
        /// Khi chứng thực dựa trên Domain Controller
        /// - Tên tài khoản là tên e-mail fpt có dạng username@fpt.com.vn
        /// Trừ khi bật thuộc tính attributeMapUsername="sAMAccountName" thì khi đăng nhập sẽ không bắt buộc nhập @fpt.com.vn
        /// 15/10/2012  - DinhNN1   - Created.
        /// </summary>
        public static string RemoveDomainName(string userName)
        {
            return userName.Split('@')[0];
        }

        /// <summary>
        /// Đối tượng Cache đại diện cho vùng nhớ RAM để lưu đệm các đối tượng thường truy xuất
        /// 15/10/2012  - DinhNN1   - Created.
        /// </summary>
        public static Cache Cache
        {
            get { return HttpContext.Current.Cache; }
        }

        /// <summary>
        /// Mỗi đối tượng được lưu trong vùng nhớ Cache đều phải có key để phân biệt và truy xuất khi cần.
        /// Xóa một đối tượng trong vùng nhớ Cache theo prefix = start with (cache key)
        /// 15/10/2012  - DinhNN1   - Created.
        /// </summary>
        public static void PurgeCacheItems(string prefix)
        {
            prefix = prefix.ToLower();
            List<string> itemsToRemove = new List<string>();

            IDictionaryEnumerator enumerator = Cache.GetEnumerator();
            while (enumerator.MoveNext())
            {
                if (enumerator.Key.ToString().ToLower().StartsWith(prefix))
                    itemsToRemove.Add(enumerator.Key.ToString());
            }

            foreach (string itemToRemove in itemsToRemove)
                Cache.Remove(itemToRemove);
        }

        /// <summary>
        /// Get from the ASP.NET cache all items whose key starts with the input prefix
        /// 15/10/2012  - DinhNN1   - Created.
        /// </summary>
        public static List<Caching> GetCacheItemNames(string prefix)
        {
            if (!string.IsNullOrEmpty(prefix))
                prefix = prefix.ToLower();
            List<Caching> items = new List<Caching>();

            IDictionaryEnumerator enumerator = Cache.GetEnumerator();
            while (enumerator.MoveNext())
            {
                string[] keyParts = enumerator.Key.ToString().Split('_');

                Caching caching = new Caching();

                for (int i = 0; i < keyParts.Length; i++)
                {
                    if (i == 0)
                        caching.KeyPart1 = keyParts[i];
                    else if (i == 1)
                        caching.KeyPart2 = keyParts[i];
                    else if (i == 2)
                        caching.KeyPart3 = keyParts[i];
                    else if (i == 3)
                        caching.KeyPart4 = keyParts[i];
                    else if (i == 4)
                        caching.KeyPart5 = keyParts[i];
                }

                if (string.IsNullOrEmpty(prefix) || enumerator.Key.ToString().ToLower().StartsWith(prefix))
                {
                    caching.prefix = enumerator.Key.ToString();
                    caching.Item = enumerator.Key.ToString();
                    items.Add(caching);
                }
            }

            return items;
        }

        /// <summary>
        /// Hàm clear cache theo key truyền vào
        /// 04/03/2013 - quanvq - Create
        /// </summary>
        /// <param name="key"></param>
        public static void ClearCache(string key)
        {
            Cache.Remove(key);
        }

        /// <summary>
        /// Đối tượng Caching lưu thông tin về Cache, phục vụ màn hình System/ManageCache.aspx
        /// 15/10/2012  - DinhNN1   - Created.
        /// </summary>
        public class Caching
        {
            public string prefix { get; set; }
            public string Item { get; set; }

            public string KeyPart1 { get; set; }
            public string KeyPart2 { get; set; }
            public string KeyPart3 { get; set; }
            public string KeyPart4 { get; set; }
            public string KeyPart5 { get; set; }
        }

        //Lay IP hien tai
        public static string CurrentUserIP
        {
            get
            {
                return HttpContext.Current.Request.UserHostAddress;
            }
        }

        /// <summary>
        /// Tìm đối tượng control (có id) nằm sâu bên trong 1 đối tượng control (parent)
        /// 10/08/2011  - DinhNN1   - Created.
        /// </summary>
        public static Control FindControlRecursive(string id, Control parent)
        {
            // If parent is the control we're looking for, return it
            if (string.Compare(parent.ID, id, true) == 0)
                return parent;

            // Search through children
            foreach (Control child in parent.Controls)
            {
                Control match = FindControlRecursive(id, child);

                if (match != null)
                    return match;
            }

            // If we reach here then no control with id was found
            return null;
        }

        #region Membership Methods

        public static string ConvertProviderUserKeyToUserID(string providerUserKey)
        {
            Guid g = new Guid(providerUserKey);
            byte[] b = g.ToByteArray();
            string UserID = BitConverter.ToString(b, 0).Replace("-", string.Empty);
            return UserID;
        }

        #endregion

        #region Profile Methods

        public static ProfileBase GetUserProfile()
        {
            return ProfileBase.Create(CurrentUserName, CurrentUser.Identity.IsAuthenticated);
        }

        public static ProfileBase GetUserProfile(string vUserName)
        {
            return ProfileBase.Create(vUserName, CurrentUser.Identity.IsAuthenticated);
        }

        public static ProfileBase GetUserProfile(string vUserName, bool isAuthenticated)
        {
            return ProfileBase.Create(vUserName, isAuthenticated);
        }
        public static string GetProfileCTheme(ProfileBase profile)
        {
            return profile.GetPropertyValue("CTheme").ToString();
        }
        public static int GetProfileCCompany(ProfileBase profile)
        {
            return int.Parse(profile.GetPropertyValue("CCompany").ToString());
        }

        #endregion

        #region Modify  Web.config

        public static string GetWebConfigKey(string key)
        {
            return ConfigurationSettings.AppSettings[key];
        }

        public static void SetWebConfigKey(string key, string value)
        {
            // load config document for current assembly
            XmlDocument doc = LoadWebConfig();

            // retrieve appSettings node
            XmlNode node = doc.SelectSingleNode("//appSettings");

            if (node == null)
                throw new InvalidOperationException("appSettings section not found in config file.");

            try
            {
                // select the 'add' element that contains the key
                XmlElement elem = (XmlElement)node.SelectSingleNode(string.Format("//add[@key='{0}']", key));

                if (elem != null)
                {
                    // add value for key
                    elem.SetAttribute("value", value);
                }
                else
                {
                    // key was not found so create the 'add' element 
                    // and set it's key/value attributes 
                    elem = doc.CreateElement("add");
                    elem.SetAttribute("key", key);
                    elem.SetAttribute("value", value);
                    node.AppendChild(elem);
                }
                doc.Save(GetWebConfigFilePath());
            }
            catch
            {
                throw;
            }
        }

        public static void RemoveWebConfigKey(string key)
        {
            // load config document for current assembly
            XmlDocument doc = LoadWebConfig();

            // retrieve appSettings node
            XmlNode node = doc.SelectSingleNode("//appSettings");

            try
            {
                if (node == null)
                    throw new InvalidOperationException("appSettings section not found in config file.");
                else
                {
                    // remove 'add' element with coresponding key
                    node.RemoveChild(node.SelectSingleNode(string.Format("//add[@key='{0}']", key)));
                    doc.Save(GetWebConfigFilePath());
                }
            }
            catch (NullReferenceException e)
            {
                throw new Exception(string.Format("The key {0} does not exist.", key), e);
            }
        }

        public static XmlDocument LoadWebConfig()
        {
            XmlDocument doc = null;
            try
            {
                doc = new XmlDocument();
                doc.Load(GetWebConfigFilePath());
                return doc;
            }
            catch (System.IO.FileNotFoundException e)
            {
                throw new Exception("No configuration file found.", e);
            }
        }

        public static string GetWebConfigFilePath()
        {
            return HttpContext.Current.Server.MapPath("/Web.config");
        }

        #endregion


        #endregion
    }
}
