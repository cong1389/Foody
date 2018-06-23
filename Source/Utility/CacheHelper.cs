/**
 * @version $Id:
 * @package Cybervn.NET
 * @author Cybervn Dev <dev@dgc.vn>
 * @copyright Copyright (C) 2009 by Cybervn. All rights reserved.
 * @link http://www.Cybervn.com
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace Cb.Utility
{
    public static class CacheHelper
    {
        /// <summary>
        /// Insert value into the cache using
        /// appropriate name/value pairs
        /// </summary>
        /// <typeparam name="T">Type of cached item</typeparam>
        /// <param name="o">Item to be cached</param>
        /// <param name="key">Name of item</param>
        public static void Add<T>(T o, string key)
        {
            HttpRuntime.Cache.Insert(
                key,
                o,
                null,
                DateTime.Now.AddMinutes(1440),
                System.Web.Caching.Cache.NoSlidingExpiration); 
        }

        /// <summary>
        /// Remove item from cache
        /// </summary>
        /// <param name="key">Name of cached item</param>
        public static void Clear(string key)
        {
            HttpRuntime.Cache.Remove(key);
        }

        /// <summary>
        /// Remove All item from cache
        /// </summary>        
        public static void ClearAll()
        {
            IDictionaryEnumerator enumerator = HttpContext.Current.Cache.GetEnumerator();
            while (enumerator.MoveNext())
            {
                HttpContext.Current.Cache.Remove((string)enumerator.Key);
            }
        }

        /// <summary>
        /// Remove item from cache
        /// </summary>
        /// <param name="key">Name of cached item</param>
        public static void ClearContains(string key)
        {
            var enumerator = HttpRuntime.Cache.GetEnumerator();
            Dictionary<string, object> cacheItems = new Dictionary<string, object>();

            while (enumerator.MoveNext())
                cacheItems.Add(enumerator.Key.ToString(), enumerator.Value);

            foreach (string item in cacheItems.Keys)
            {
                if (item.Contains(key))
                {
                    HttpRuntime.Cache.Remove(item);
                }
            }
        }

        /// <summary>
        /// Check for item in cache
        /// </summary>
        /// <param name="key">Name of cached item</param>
        /// <returns></returns>
        public static bool Exists(string key)
        {
            return HttpRuntime.Cache[key] != null;
        }

        public static List<string> GetAllKeys()
        {
            List<string> lst = new List<string>();

            foreach (var key in HttpRuntime.Cache)
            {
                lst.Add(key as string);
            }

            return lst;
        }

        /// <summary>
        /// Retrieve cached item
        /// </summary>
        /// <typeparam name="T">Type of cached item</typeparam>
        /// <param name="key">Name of cached item</param>
        /// <param name="value">Cached value. Default(T) if
        /// item doesn't exist.</param>
        /// <returns>Cached item as type</returns>
        public static bool Get<T>(string key, out T value)
        {
            try
            {
                if (!Exists(key))
                {
                    value = default(T);
                    return false;
                }

                value = (T)HttpRuntime.Cache[key];
            }
            catch
            {
                value = default(T);
                return false;
            }

            return true;
        }
        
    }
}
