using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using Cb.DBUtility;
using System.IO;
using System.Text;
using System.Security.Cryptography;
using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Configuration;
using System.Reflection;
using Cb.Web.Properties;
using System.Configuration;

namespace Cb.Web
{
    public class Global : System.Web.HttpApplication
    {

        public static string SESS_SECURITY_CODE = "SESS_SECURITY_CODE";
        public static string SESS_USER = "SESS_USER";



        protected void Application_Start(object sender, EventArgs e)
        {
           
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Application["AccessCount"] = this.GetNumberAccessFromFile();
            Application["AccessCount"] = long.Parse(Application["AccessCount"].ToString()) + 1;
            this.SetNumberAccessFromFile(long.Parse(Application["AccessCount"].ToString()));
            if (Application["DangTruyCap"] == null)
                Application["DangTruyCap"] = 1;
            else
                Application["DangTruyCap"] = (int)Application["DangTruyCap"] + 1;

            //Today
            string txt = this.GetTodayFromFile();
            if (!string.IsNullOrEmpty(txt))
            {
                string[] arr = txt.Split('\t');
                DateTime dt = DBConvert.ParseDateTime(arr[1], "dd/MM/yyyy");
                if (!dt.Date.Equals(DateTime.Now.Date))
                {
                    txt = string.Format("1\t{0}", DBConvert.ParseString(DateTime.Now, "dd/MM/yyyy"));
                    Application["Today"] = 1;
                }
                else
                {
                    int count = DBConvert.ParseInt(arr[0]) + 1;
                    txt = string.Format("{0}\t{1}", count, DBConvert.ParseString(DateTime.Now, "dd/MM/yyyy"));
                    Application["Today"] = count;
                }
            }
            else
            {
                txt = string.Format("1\t{0}", DBConvert.ParseString(DateTime.Now, "dd/MM/yyyy"));
                Application["Today"] = 1;
            }
            this.SetTodayFromFile(txt);
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            // For Web service to work for Jquery Ajax &&
            // !Request.Path.EndsWith(".asmx")
            //if (Request.Path.IndexOf(".asmx") != -1 && !Request.Path.EndsWith(".asmx"))
            //{
            //    IgnoreWebServiceCall(HttpContext.Current);
            //    return;
            //}

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            Application["DangTruyCap"] = (int)Application["DangTruyCap"] - 1;
        }

        protected void Application_End(object sender, EventArgs e)
        {
           ;
        }

        private void IgnoreWebServiceCall(HttpContext context)
        {
            int dotasmx = context.Request.Path.IndexOf(".asmx");
            string path = context.Request.Path.Substring(0, dotasmx + 5);
            string pathInfo = context.Request.Path.Substring(dotasmx + 5);
            context.RewritePath(path, pathInfo, context.Request.Url.Query);
        }

        /// <summary>
        /// Encode a ecoded string value
        /// </summary>
        /// <param name="encodedvalue"></param>
        /// <returns></returns>
        public static string ToEncoding(string value)
        {
            return Encryption64.Encrypt(value, "1A2B3C4D").ToLower();
        }

        /// <summary>
        /// Decode a ecoded string value
        /// </summary>
        /// <param name="encodedvalue"></param>
        /// <returns></returns>
        public static string ToDecoding(string encodedvalue)
        {
            return Encryption64.Decrypt(encodedvalue, "1A2B3C4D");
        }

        public static string StrEnCode(string str)
        {
            UnicodeEncoding encoder = new UnicodeEncoding();
            SHA256Managed sha256hasher = new SHA256Managed();
            byte[] hashedDataBytes = sha256hasher.ComputeHash(encoder.GetBytes(str));
            return Convert.ToBase64String(hashedDataBytes);
        }


        #region AccessNumber
        private long GetNumberAccessFromFile()
        {
            string path = Server.MapPath("Security/AccessNumber.txt");
            if (File.Exists(path))
            {
                StreamReader srReadLine = new StreamReader(path);
                srReadLine.BaseStream.Seek(0, SeekOrigin.Begin);

                while (true)
                {
                    string str = srReadLine.ReadLine();
                    if (str == null)
                        break;
                    try
                    {
                        srReadLine.Close();
                        return long.Parse(str);
                    }
                    catch
                    {
                    }
                }
                srReadLine.Close();
            }
            return 0;
        }

        private void SetNumberAccessFromFile(long number)
        {
            string path = Server.MapPath("Security/AccessNumber.txt");
            if (File.Exists(path))
            {
                try
                {
                    FileStream file = new FileStream(path, FileMode.Open, FileAccess.Write);
                    StreamWriter srWrite = new StreamWriter(file);
                    srWrite.Write(number.ToString());
                    srWrite.Close();
                }
                catch { }
            }
        }
        #endregion

        #region Today

        private string GetTodayFromFile()
        {
            string path = Server.MapPath("Security/Today.txt");
            if (File.Exists(path))
            {
                StreamReader srReadLine = new StreamReader(path);
                srReadLine.BaseStream.Seek(0, SeekOrigin.Begin);

                while (true)
                {
                    string str = srReadLine.ReadLine();
                    if (str == null)
                        break;
                    try
                    {
                        srReadLine.Close();
                        return str;
                    }
                    catch
                    {
                    }
                }
                srReadLine.Close();
            }
            return string.Empty;
        }

        private void SetTodayFromFile(string txt)
        {
            string path = Server.MapPath("Security/Today.txt");
            if (File.Exists(path))
            {
                try
                {
                    FileStream file = new FileStream(path, FileMode.Open, FileAccess.Write);
                    StreamWriter srWrite = new StreamWriter(file);
                    srWrite.Write(txt);
                    srWrite.Close();
                }
                catch { }
            }
        }
        #endregion

        private Assembly CurrentDomain_AssemblyResolve(object sender, ResolveEventArgs args)
        {
            //var assemblyName = args.Name.Split(',')[0];

            //if (providersPath == null)
            //    providersPath = Server.MapPath(Settings.Default.ProvidersPath);

            //var assembly = Assembly.LoadFrom(Path.Combine(providersPath, assemblyName + ".dll"));
            //return assembly;
            return null;
        }
    }
}