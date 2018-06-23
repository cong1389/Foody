/**
 * @version $Id:
 * @package Cybervn.NET
 * @author Cybervn Dev <dev@dgc.vn>
 * @copyright Copyright (C) 2009 by Cybervn. All rights reserved.
 * @link http://www.Cybervn.com
 */
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace Cb.Utility
{
    public class SiteNavigation
    {

        private const string slash = @"/";
        //link menu
        public const string link_home = "default.aspx";
        public const string link_login = "/Admin/LoginAdmin.aspx";
        //link admin
        public const string link_adminPage_rewrite = "/admin";
        public const string link_adminPage = "admin/default.aspx";
        public const string link_logout = "/admin/logout";

        public const string LoginPage_rewrite = "/login/{0}";
        public const string link_trang_chu_rewrite = "/trang-chu/{0}";
        public const string link_home_rewrite = "/home/{0}";

        private static string GetApplicationPath()
        {
            if (@"/" == HttpContext.Current.Request.ApplicationPath) //root
                return "";
            return HttpContext.Current.Request.ApplicationPath;
        }

        public static string ResolveUrl(string relativePathToApplicationRoot)
        {
            return GetApplicationPath() + @"/" + relativePathToApplicationRoot;
        }

        public static string GetRelativePathToApplicatonRoot(string fullPath)
        {
            string applicationPath = GetApplicationPath();
            if (0 == applicationPath.Length) //application path is root
                return RemoveHeadingSlash(fullPath);

            Match m = Regex.Match(fullPath, "^\\/?" + applicationPath + "(.*)$", RegexOptions.IgnoreCase);
            if (m.Success)
            {
                return RemoveHeadingSlash(m.Groups[1].Value);
            }
            return fullPath;
        }

        public static string RemoveHostFromUrl(string fullPathWithHost)
        {
            Match m = Regex.Match(fullPathWithHost, "^https?:\\/\\/[^\\/]+(.*)$", RegexOptions.IgnoreCase);
            if (m.Success)
            {
                return m.Groups[1].Value;
            }
            return fullPathWithHost;
        }

        private static string RemoveHeadingSlash(string path)
        {
            if (path.StartsWith(@"/"))
                return path.Substring(1);
            return path;
        }


        public static string AppendQueryString(string url, string queryString)
        {
            return string.Format("{0}{1}{2}", url,
                url.IndexOf('?') >= 0 ? "&" : "?",
                queryString);
        }

        public static string UnMapPath(string filespec)
        { //opposite of Server.MapPath
            string appPath = HttpContext.Current.Request.PhysicalApplicationPath;
            if (!filespec.StartsWith(appPath, StringComparison.OrdinalIgnoreCase))
                throw new ApplicationException(string.Format("{0} is not inside application path {1}.", filespec, appPath));
            string relativePath = RemoveHeadingSlash(filespec.Substring(appPath.Length).Replace('\\', '/'));
            return ResolveUrl(relativePath);
        }



        private static string MigrateRewriteUrl(string page)
        {
            if (page.Equals("product", StringComparison.OrdinalIgnoreCase) ||
                page.Equals("category", StringComparison.OrdinalIgnoreCase))
                return string.Format("Store/{0}", page);
            return page;
        }

        public static string ConcatenatePartsToUrl(params string[] names)
        {
            StringBuilder sb = new StringBuilder();
            foreach (string name in names)
            {
                if (!string.IsNullOrEmpty(name))
                {
                    if (0 == sb.Length)
                    {
                        sb.Append(name);
                    }
                    else
                    {
                        sb.Append("/").Append(name);
                    }
                }
            }
            return sb.ToString();
        }

        private static string GetStore(string urlPath)
        {
            return GetFirstPath(urlPath);
        }

        public static string GetFirstPath(string urlPath)
        {
            Match m = Regex.Match(urlPath, @"^\/?(?<firstPath>[^\/]+)\/");
            if (m.Success)
                return m.Groups["firstPath"].Value;
            return string.Empty;
        }

        public static string Combine(string path1, string path2)
        {
            return path1 + slash + path2;
        }

        public static string CompleteHttpUrl(bool isSSL, params string[] partialUrls)
        {
            int port = HttpContext.Current.Request.Url.Port;

            if ((80 != port) && (443 != port))
                partialUrls[0] = string.Format("{0}:{1}", partialUrls[0], port);

            string path = string.Join(slash, partialUrls);
            path = Regex.Replace(path, @"\/+", @"/");

            //remove most right slash
            path = Regex.Replace(path, @"\/$", @"");

            return "http" + (isSSL ? "s" : "") + "://" + path;
        }

        public static string ResolveUrlInText(string text)
        {
            return text.Replace(@"~", GetApplicationPath());
        }

        public static string UpdateUrl(string url, Dictionary<string, string> queryStringReplacement, ICollection<string> queryStringRemoval)
        {
            string header, queryString;
            int index = url.IndexOf('?');
            if (-1 == index)
            { // not found
                header = url;
                queryString = string.Empty;
            }
            else
            {
                header = url.Substring(0, index);
                queryString = url.Substring(index + 1);
            }
            Dictionary<string, bool> replaced = new Dictionary<string, bool>(StringComparer.OrdinalIgnoreCase);
            Dictionary<string, string> newQueryString = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            foreach (string pair in queryString.Split('&'))
            {
                if (!string.IsNullOrEmpty(pair))
                {
                    string[] parts = pair.Split('=');
                    if (parts.Length > 0)
                    {
                        string key = parts[0];
                        if (queryStringReplacement.ContainsKey(key))
                        {
                            newQueryString[key] = queryStringReplacement[key];
                            replaced[key] = true;
                        }
                        else
                            newQueryString[key] = parts.Length > 1 ? parts[1] : string.Empty;
                    }
                }
            }
            //add non replaced query string
            foreach (string key in queryStringReplacement.Keys)
            {
                if (!replaced.ContainsKey(key))
                {
                    newQueryString[key] = queryStringReplacement[key];
                }
            }
            Dictionary<string, bool> removalKeys = new Dictionary<string, bool>(StringComparer.OrdinalIgnoreCase);
            if (null != queryStringRemoval)
            {
                foreach (string key in queryStringRemoval)
                {
                    removalKeys[key] = true;
                }
            }

            StringBuilder sb = new StringBuilder(header);
            bool first = true;
            foreach (string key in newQueryString.Keys)
            {
                if (!removalKeys.ContainsKey(key))
                {
                    if (first)
                    {
                        sb.Append("?");
                        first = false;
                    }
                    else
                        sb.Append("&");
                    sb.Append(key);
                    if (!string.IsNullOrEmpty(newQueryString[key]))
                        sb.Append("=").Append(newQueryString[key]);
                }
            }
            return sb.ToString();
        }

    }
}
