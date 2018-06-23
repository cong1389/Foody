/**
 * @version $Id:
 * @package Cybervn.NET
 * @author Cybervn Dev <dev@dgc.vn>
 * @copyright Copyright (C) 2009 by Cybervn. All rights reserved.
 * @link http://www.Cybervn.com
 */

using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Web.Caching;
using System.Xml.Serialization;
using System.Xml.Linq;
using System.Collections;
using System.Reflection;
using System.Linq;
using Microsoft.Win32;

namespace Cb.Utility
{
    public static class Utils
    {
        public static string GetParameter(string param, string defaultValue)
        {
            string stringValue = HttpContext.Current.Request.QueryString[param];
            if (null != stringValue)
            {
                stringValue = stringValue.Contains("?") ? stringValue.Split('?')[0] : stringValue;
                return stringValue;
            }
            else
            {
                return defaultValue;
            }
        }

        public static string GetParameter(string param)
        {
            string stringValue = HttpContext.Current.Request.QueryString[param];
            if (null == stringValue)
            {
                throw new ApplicationException(string.Format("{0} is required parameter", param));
            }
            return stringValue;
        }

        public static bool CheckParameterExist(string param)
        {
            return null != HttpContext.Current.Request.QueryString[param];
        }

        public static int GetIntParameter(string param, int defaultValue)
        {
            int value = defaultValue;
            string stringValue = HttpContext.Current.Request.QueryString[param];
            if (!string.IsNullOrEmpty(stringValue))
            {
                int.TryParse(stringValue, out value);
            }
            return value;
        }

        public static int GetIntParameter(string param)
        {
            string stringValue = HttpContext.Current.Request.QueryString[param];
            if (string.IsNullOrEmpty(stringValue))
            {
                throw new ApplicationException(string.Format("{0} is required parameter", param));
            }
            return int.Parse(stringValue);
        }

        public static DateTime GetDateTimeParameter(string param, DateTime defaultValue)
        {
            DateTime value = defaultValue;
            string stringValue = HttpContext.Current.Request.QueryString[param];
            if (!string.IsNullOrEmpty(stringValue))
            {
                DateTime.TryParse(HttpUtility.UrlDecode(stringValue), out value);
            }
            return value;
        }

        public static decimal? GetNullableDecimalParameter(string param)
        {
            string stringValue = HttpContext.Current.Request.QueryString[param];
            if (string.IsNullOrEmpty(stringValue))
            {
                return null;
            }
            decimal value;
            if (decimal.TryParse(stringValue, out value))
                return value;
            return null;
        }

        public static int? GetNullableIntParameter(string param)
        {
            string stringValue = HttpContext.Current.Request.QueryString[param];
            if (string.IsNullOrEmpty(stringValue))
            {
                return null;
            }
            int value;
            if (int.TryParse(stringValue, out value))
                return value;
            return null;
        }

        public static string StringChangeEmptyToNull(string param)
        {
            return string.IsNullOrEmpty(param) ? null : param;
        }

        public static T ConvertNullableFromString<T>(string param)
        {
            NullableConverter converter = new NullableConverter(typeof(T));
            return (T)converter.ConvertFromString(param);
        }

        public static int ChangeBadConversionToDefault(string param, int defaultValue)
        {
            int result = defaultValue;
            int.TryParse(param, out result);
            return result;
        }

        public static decimal ChangeBadConversionToDefault(string param, decimal defaultValue)
        {
            decimal result = defaultValue;
            decimal.TryParse(param, out result);
            return result;
        }

        public static int[] ParseIds(string idsString)
        {
            return ParseIds(idsString, Constant.DB.ListSeparator);
        }

        public static int[] ParseIds(string idsString, params char[] separator)
        {
            string[] ids = idsString.Split(separator);
            int[] idsConverted = new int[ids.Length];
            for (int i = 0; i < ids.Length; i++)
            {
                idsConverted[i] = int.Parse(ids[i]);
            }
            return idsConverted;
        }

        public static string ToDBNullString(string param)
        {
            if (string.IsNullOrEmpty(param))
                return Constant.DB.NullString;
            return param;
        }

        public static string ToDBNullString(object param)
        {
            if (null == param)
                return Constant.DB.NullString;
            return param.ToString();
        }

        public static string EscapeSeparators(string param)
        {
            return EscapeSeparators(param, '\\', Constant.DB.ListSeparator, Constant.DB.FieldSeparator);
        }

        public static string EscapeSeparators(string param, params char[] separators)
        {
            if (string.IsNullOrEmpty(param))
                return param;
            foreach (char c in separators)
            {
                param = param.Replace(c.ToString(), string.Format(@"\{0}", c));
            }
            return param;
        }

        public class NameValueContainer
        {
            private string name, value;

            public string Name
            {
                get { return name; }
            }
            public string Value
            {
                get { return value; }
            }

            public NameValueContainer(string name, string value)
            {
                this.name = name;
                this.value = value;
            }
        }

        public static List<NameValueContainer> GetNumbers(int from, int to)
        {
            List<NameValueContainer> numbers = new List<NameValueContainer>();
            for (int i = from; i <= to; i++)
            {
                numbers.Add(new NameValueContainer(i.ToString(), i.ToString()));
            }
            return numbers;
        }

        public static string GetUserName()
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                return HttpContext.Current.User.Identity.Name;
            }
            return HttpContext.Current.Session.SessionID;
        }

        public static string GetSorted(List<int> values)
        {
            values.Sort();
            StringBuilder sb = new StringBuilder();
            foreach (int i in values)
            {
                if (sb.Length > 0)
                    sb.Append(Constant.DB.ListSeparator);
                sb.Append(i);
            }
            return sb.ToString();
        }

        public static byte[] GetData(Stream fs)
        {
            byte[] data = new byte[fs.Length];
            fs.Read(data, 0, (int)fs.Length);
            return data;
        }

        public static List<Type> GetProviders(string searchPatch, Type providerType)
        {
            List<Type> providers = new List<Type>();
            string binPath = HttpContext.Current.Server.MapPath("~/bin");
            foreach (string fileName in Directory.GetFiles(binPath, searchPatch, SearchOption.TopDirectoryOnly))
            {
                string assemblyName = Path.GetFileNameWithoutExtension(fileName);
                System.Reflection.Assembly assembly = System.Reflection.Assembly.Load(assemblyName);
                foreach (Type t in assembly.GetTypes())
                {
                    if (t.IsSubclassOf(providerType))
                    {
                        providers.Add(t);
                    }
                }
            }
            return providers;
        }

        public static List<KeyValuePair<string, int>> GetEnumNameValueList(Type enumType)
        {
            List<KeyValuePair<string, int>> list = new List<KeyValuePair<string, int>>();
            foreach (int value in Enum.GetValues(enumType))
            {
                list.Add(new KeyValuePair<string, int>(Enum.GetName(enumType, value), value));
            }
            return list;
        }

        public static string ConvertToFullTextSearchString(string search)
        {
            if (string.IsNullOrEmpty(search))
                return search;
            search = search.Replace("'", "").Replace("-", "").Replace(",", "").Replace("*", ""); // disallow single quote and dash for security reason although sproc has another level of defense
            List<string> keywords = new List<string>();
            int firstQuotePosition = -1;
            int wordStartPostion = 0;
            for (int i = 0; i < search.Length; i++)
            {
                switch (search[i])
                {
                    case '\"':
                        if (firstQuotePosition >= 0)
                        {
                            keywords.Add(search.Substring(firstQuotePosition, i - firstQuotePosition + 1));
                            firstQuotePosition = -1;
                            wordStartPostion = i + 1;
                        }
                        else
                        {
                            //word break with quote
                            if (wordStartPostion < i)
                                keywords.Add(search.Substring(wordStartPostion, i - wordStartPostion));
                            firstQuotePosition = i;
                        }
                        break;
                    case ' ':
                        if (-1 == firstQuotePosition)
                        {
                            //word break with space
                            if (wordStartPostion < i)
                                keywords.Add(search.Substring(wordStartPostion, i - wordStartPostion));
                            wordStartPostion = i + 1;
                        }
                        break;
                    default:
                        break;
                }
            }
            if (firstQuotePosition >= 0)
                keywords.Add(search.Substring(firstQuotePosition) + "\"");
            else if (wordStartPostion < search.Length)
                keywords.Add(search.Substring(wordStartPostion));
            return string.Join(",", keywords.ToArray());
        }

        /// <summary>
        /// Chuyển chuỗi sang không dấu tiếng việt 
        /// Thay thế khoảng trắng bằng '-'
        /// Xóa ký tự đặc biệt
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        /// 14/10/2014--Congtt@fpt.com.vn
        public static string RemoveUnicode(string text)
        {
            for (int i = 33; i < 48; i++)
            {
                text = text.Replace(((char)i).ToString(), "");
            }

            for (int i = 58; i < 65; i++)
            {
                text = text.Replace(((char)i).ToString(), "");
            }

            for (int i = 91; i < 97; i++)
            {
                text = text.Replace(((char)i).ToString(), "");
            }
            for (int i = 123; i < 127; i++)
            {
                text = text.Replace(((char)i).ToString(), "");
            }

            text = text.Replace(" ", "-");
            Regex regex = new Regex(@"\p{IsCombiningDiacriticalMarks}+");
            string strFormD = text.Normalize(System.Text.NormalizationForm.FormD).ToLower();

            return regex.Replace(strFormD, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D');
        }

        public static string ConvertIdsToSting(List<int> ids)
        {
            StringBuilder sb = new StringBuilder();
            if (null != ids)
            {
                foreach (int id in ids)
                {
                    if (sb.Length > 0)
                        sb.Append(Constant.DB.ListSeparator);
                    sb.Append(id.ToString());
                }
            }
            return sb.ToString();
        }

        public static string GetInstallPath()
        {
            string[] args = Environment.GetCommandLineArgs();
            string path = Path.GetDirectoryName(args[0]);
            if (string.IsNullOrEmpty(path))
                return Directory.GetCurrentDirectory();
            return path;
        }

        public static string GetAppName()
        {
            string[] args = Environment.GetCommandLineArgs();
            return (Path.GetFileNameWithoutExtension(args[0]));
        }

        public static Cache Cache
        {
            get
            {
                HttpContext ctx = HttpContext.Current;
                if (null == ctx)
                    return HttpRuntime.Cache;
                else
                    return ctx.Cache;
            }
        }

        public static string ReplaceTokens(string template, NameValueCollection tokens)
        {
            foreach (string token in tokens.Keys)
            {
                string replacement = tokens[token];
                template = template.Replace(string.Format(@"%{0}%", token), replacement);
            }
            return template;
        }

        public static bool IsAdmin()
        {
            return HttpContext.Current.User.IsInRole("Administrator");
        }

        public static string FormatTimeSpan(TimeSpan ts)
        {
            return string.Format("{0}{1:00}:{2:00}:{3:00}", ts.Days == 0 ? "" : ts.Days.ToString() + ".", ts.Hours, ts.Minutes, ts.Seconds);
        }

        public static bool IsValidateDBTime(DateTime time)
        {
            return (Constant.DB.DBDateTimeMinValue < time) && (time < Constant.DB.DBDateTimeMaxValue);
        }

        public static string FormatPhoneForDisplay(string phone)
        {
            if (string.IsNullOrEmpty(phone))
                return phone;
            // remove non digits
            phone = Regex.Replace(phone, @"[^\d]", "");
            //change to the mask format (999)999-9999999
            phone = phone.Insert(0, "(");
            if (phone.Length > 4)
            {
                phone = phone.Insert(4, ")");
                if (phone.Length > 8)
                {
                    phone = phone.Insert(8, "-");
                }
            }
            return phone;
        }

        public static byte[] GetBitsFromSteam(Stream fs, int size)
        {
            byte[] img = new byte[size];
            fs.Read(img, 0, size);
            return img;
        }

        public static void EnsurePathExist(string path)
        {
            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);
        }

        public static decimal Round(decimal d)
        {
            return decimal.Round(d, Constant.Calculation.percision);
        }

        public static decimal? Round(decimal? d)
        {
            if (null == d)
                return null;
            return Round((decimal)d);
        }

        public static string GetUrlableString(string s)
        {
            return Regex.Replace(s, "[^\\w- ,]", " ");
        }

        public static T FromXml<T>(string xml)
        {
            XmlSerializer serializer = new XmlSerializer(typeof(T));
            StringReader sr = new StringReader(xml);
            T o = (T)serializer.Deserialize(sr);
            return o;
        }

        public static object FromXml(Type type, string xml)
        {
            XmlSerializer serializer = new XmlSerializer(type);
            StringReader sr = new StringReader(xml);
            return serializer.Deserialize(sr);
        }

        #region Extension methods

        public static string ToXml(this object o)
        {
            XmlSerializer serializer = new XmlSerializer(o.GetType());
            StringWriter sw = new StringWriter();
            serializer.Serialize(sw, o);
            return sw.ToString();
        }

        public static XElement ToXElement(this object o)
        {
            return ConverToXElement(o.ToXml());
        }

        public static XElement ConverToXElement(string xml)
        {
            XElement x;
            using (StringReader sr = new StringReader(xml))
            {
                x = XElement.Load(sr);
            }
            return x;
        }

        #endregion

        #region Url

        public static string CombineUrl(string baseUrl, string relativeUrl)
        {
            UriBuilder baseUri = new UriBuilder(baseUrl);
            Uri newUri = null;

            if (Uri.TryCreate(baseUri.Uri, relativeUrl, out newUri))
                return newUri.ToString();
            else
                throw new ArgumentException("Unable to combine specified url values");
        }

        public static string CombineUrlOriginal(string baseUrl, string relativeUrl)
        {
            UriBuilder baseUri = new UriBuilder(baseUrl);
            Uri newUri = null;

            if (Uri.TryCreate(baseUri.Uri, relativeUrl, out newUri))
                return newUri.OriginalString;
            else
                throw new ArgumentException("Unable to combine specified url values");
        }

        #endregion

        #region ArraytoString
        public static string ArrayToString(IList array, string delimeter)
        {
            string outputString = "";

            for (int i = 0; i < array.Count; i++)
            {
                if (array[i] is IList)
                {
                    outputString += ArrayToString((IList)array[i], delimeter);
                }
                else
                {
                    outputString += array[i];
                }

                if (i != array.Count - 1)
                    outputString += delimeter;
            }

            return outputString;
        }

        public static string ArrayToString<T>(List<T> array, string properties, string delimeter)
        {
            string outputString = "";

            for (int i = 0; i < array.Count; i++)
            {
                Type t = typeof(T);
                outputString += t.GetProperty(properties).GetValue(array[i], null).ToString();

                if (i != array.Count - 1)
                    outputString += delimeter;
            }

            return outputString;
        }
        #endregion

        #region Core

        /// <summary>
        /// Lấy ten property cua 1 objngon tgu trong objchinh </summary>
        /// <returns>VD: ContentDesc</returns>
        public static string GetPropertyDescName(Type t)
        {
            int index = t.Name.IndexOf("_");
            return t.Name.Substring(index + 1);
        }

        #endregion

        #region Type

        public static object GetValueProperties(object o, string property)
        {
            object re = null;
            PropertyInfo pro = o.GetType().GetProperty(property);
            if (pro != null)
            {
                re = pro.GetValue(o, null);
            }
            return re;
        }

        public static void SetValueProperties(object o, string property, object value)
        {
            PropertyInfo pro = o.GetType().GetProperty(property);
            if (pro != null)
            {
                pro.SetValue(o, value, null);
            }
        }

        #endregion

        #region
        /// <summary>
        /// getScmplit
        /// </summary>
        /// <param name="lvl"></param>
        /// <returns></returns>
        public static string GetScmplit(string name, string pathTree)
        {
            string re = string.Empty;
            int count = pathTree.Count(i => i.Equals('.')) - 1;
            for (int i = 0; i < count; i++)
            {
                re += ".   ";
            }
            re += " |" + count + "| " + name;
            return re;
        }

        public static bool GetRegisteredApplication(string ParamFileName, out string AppName, out string ShellAppName)
        {
            //
            // Return registered application by file's extension
            //
            AppName = string.Empty;
            ShellAppName = string.Empty;
            string StrExt = Path.GetExtension(ParamFileName);
            string StrProgID = null;
            string StrExe = null;
            RegistryKey oHKCR = default(RegistryKey);
            // HKEY_CLASSES_ROOT
            RegistryKey oProgID = default(RegistryKey);
            RegistryKey oOpenCmd = default(RegistryKey);
            int TempPos = 0;

            try
            {
                // Get Programmatic Identifier for this extension
                try
                {
                    oHKCR = Registry.ClassesRoot;
                    oProgID = oHKCR.OpenSubKey(StrExt);
                    StrProgID = oProgID.GetValue(null).ToString();
                    oProgID.Close();
                }
                catch
                {
                    // No ProgID, return false
                    return false;
                }
                // Get associated application
                try
                {
                    oOpenCmd = oHKCR.OpenSubKey(StrProgID + "\\shell\\open\\command");
                    StrExe = oOpenCmd.GetValue(null).ToString();
                    oOpenCmd.Close();
                }
                catch
                {
                    // Missing default application
                    return false;
                }
                TempPos = StrExe.IndexOf(" %1");
                if (TempPos > 0)
                {
                    // Replace %1 placeholder with ParamFileName
                    StrExe = StrExe.Substring(0, TempPos);
                    AppName = StrExe;
                    StrExe = StrExe + " " + Convert.ToChar(34) + ParamFileName + Convert.ToChar(34);
                    ShellAppName = StrExe;
                }
                else
                {
                    // No %1 placeholder found, append ParamFileName
                    AppName = StrExe;
                    ShellAppName = StrExe + " " + Convert.ToChar(34) + ParamFileName + Convert.ToChar(34);
                }
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

        }

        #endregion

    }
}
