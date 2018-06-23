using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.IDAL;
using Cb.DALFactory;
using Cb.Model;
using Cb.DBUtility;
using System.Data;
using System.Configuration;
using Cb.BLL;
using Cb.Model.Products;
using Cb.Utility;

namespace Cb.BLL.Product
{
    [Serializable]
    public class ProductBLL
    {
        private static IGeneric2C<PNK_Product, PNK_ProductDesc> dal_2C;

        private string prefixParam;

        public ProductBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic2C<PNK_Product, PNK_ProductDesc>);
            dal_2C = DataAccessGeneric2C<PNK_Product, PNK_ProductDesc>.CreateSession(t.FullName);

            switch (ConfigurationManager.AppSettings["Database"])
            {
                case "SQLServer":
                    prefixParam = "@";
                    break;
                case "MySQL":
                    prefixParam = "v_";
                    break;
            }
        }

        public IList<PNK_Product> GetList(int langId, string name, string publish, string newsCateId, string id, int pageIndex, int pageSize, out int total)
        {
            return GetList(langId, name, publish, newsCateId, id, null, null, pageIndex, pageSize, out  total);
        }

        public IList<PNK_Product> GetList(int langId, string name, string publish, string newsCateId, string id, string hot, string feature, int pageIndex, int pageSize, out int total)
        {
            return GetList(langId, name, publish, newsCateId, id, hot, feature, null, null, pageIndex, pageSize, out  total);
        }

        public IList<PNK_Product> GetList(int langId, string name, string publish, string newsCateId, string id, string hot, string feature, string post, string tag, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_Product> lst = new List<PNK_Product>();
            DGCParameter[] param = new DGCParameter[11];
            if (langId != int.MinValue)
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int16, langId);
            else
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int16, DBNull.Value);

            if (!string.IsNullOrEmpty(name))
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, name);
            else
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, DBNull.Value);

            if (pageIndex != int.MinValue)
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, pageIndex);
            else
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, DBNull.Value);

            if (pageSize != int.MinValue)
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, pageSize);
            else
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, DBNull.Value);

            if (!string.IsNullOrEmpty(newsCateId))
                param[4] = new DGCParameter(string.Format("{0}cateId", prefixParam), DbType.String, newsCateId);
            else
                param[4] = new DGCParameter(string.Format("{0}cateId", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(id))
                param[5] = new DGCParameter(string.Format("{0}id", prefixParam), DbType.String, id);
            else
                param[5] = new DGCParameter(string.Format("{0}id", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(publish))
                param[6] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, publish);
            else
                param[6] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(hot))
                param[7] = new DGCParameter(string.Format("{0}hot", prefixParam), DbType.AnsiString, hot);
            else
                param[7] = new DGCParameter(string.Format("{0}hot", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(feature))
                param[8] = new DGCParameter(string.Format("{0}feature", prefixParam), DbType.AnsiString, feature);
            else
                param[8] = new DGCParameter(string.Format("{0}feature", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(post))
                param[9] = new DGCParameter(string.Format("{0}post", prefixParam), DbType.AnsiString, post);
            else
                param[9] = new DGCParameter(string.Format("{0}post", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(tag))
                param[10] = new DGCParameter(string.Format("{0}tag", prefixParam), DbType.String, tag);
            else
                param[10] = new DGCParameter(string.Format("{0}tag", prefixParam), DbType.String, DBNull.Value);

            string[] keyArr = param.Select(x => x.Value.ToString()).ToArray();
            string key = string.Format("Product_GetList_{0}_{1}", WebUtils.CurrentUserIP, string.Join("_", keyArr));
            total = 0;

            //Get cache
            //if (!CacheHelper.Get(key, out lst))
            //{
                lst = dal_2C.GetList("Product_Get", param, out total);
                CacheHelper.Add(lst, key);
            //}
            //else
            //{
            //    total = lst.Count();
            //}

            return lst;
        }

        public IList<PNK_Product> GetListSearch(int langId, string name, string publish, string newsCateId, string id, string hot, string feature, string post, string tag, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_Product> lst = new List<PNK_Product>();
            DGCParameter[] param = new DGCParameter[11];
            if (langId != int.MinValue)
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int16, langId);
            else
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int16, DBNull.Value);

            if (!string.IsNullOrEmpty(name))
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, name);
            else
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, DBNull.Value);

            if (pageIndex != int.MinValue)
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, pageIndex);
            else
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, DBNull.Value);

            if (pageSize != int.MinValue)
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, pageSize);
            else
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, DBNull.Value);

            if (!string.IsNullOrEmpty(newsCateId))
                param[4] = new DGCParameter(string.Format("{0}cateId", prefixParam), DbType.String, newsCateId);
            else
                param[4] = new DGCParameter(string.Format("{0}cateId", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(id))
                param[5] = new DGCParameter(string.Format("{0}id", prefixParam), DbType.String, id);
            else
                param[5] = new DGCParameter(string.Format("{0}id", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(publish))
                param[6] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, publish);
            else
                param[6] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(hot))
                param[7] = new DGCParameter(string.Format("{0}hot", prefixParam), DbType.AnsiString, hot);
            else
                param[7] = new DGCParameter(string.Format("{0}hot", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(feature))
                param[8] = new DGCParameter(string.Format("{0}feature", prefixParam), DbType.AnsiString, feature);
            else
                param[8] = new DGCParameter(string.Format("{0}feature", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(post))
                param[9] = new DGCParameter(string.Format("{0}post", prefixParam), DbType.AnsiString, post);
            else
                param[9] = new DGCParameter(string.Format("{0}post", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(tag))
                param[10] = new DGCParameter(string.Format("{0}tag", prefixParam), DbType.String, tag);
            else
                param[10] = new DGCParameter(string.Format("{0}tag", prefixParam), DbType.String, DBNull.Value);


            //total = 0;
            //if (!CacheHelper.Get("Product_GetList_" + WebUtils.CurrentUserIP + langId + name + publish + newsCateId + id + hot + feature + post + tag + pageIndex + pageSize, out lst))
            //{
            lst = dal_2C.GetList("Product_GetSearch", param, out total);
            //    total = total;
            //    CacheHelper.Add(lst, "Product_GetList_" + WebUtils.CurrentUserIP + langId + name + publish + newsCateId + id + hot + feature + post + tag + pageIndex + pageSize);
            //}
            //total = lst.Count();
            return lst;
        }

        public IList<PNK_Product> GetListRelate(int langId, string name, string newsCateId, string Id, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_Product> lst = new List<PNK_Product>();
            DGCParameter[] param = new DGCParameter[6];
            if (langId != int.MinValue)
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int16, langId);
            else
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int16, DBNull.Value);

            if (!string.IsNullOrEmpty(name))
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, name);
            else
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, DBNull.Value);

            if (pageIndex != int.MinValue)
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int16, pageIndex);
            else
                param[2] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int16, DBNull.Value);

            if (pageSize != int.MinValue)
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int16, pageSize);
            else
                param[3] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int16, DBNull.Value);

            if (!string.IsNullOrEmpty(newsCateId))
                param[4] = new DGCParameter(string.Format("{0}cateId", prefixParam), DbType.String, newsCateId);
            else
                param[4] = new DGCParameter(string.Format("{0}cateId", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(Id))
                param[5] = new DGCParameter(string.Format("{0}Id", prefixParam), DbType.String, Id);
            else
                param[5] = new DGCParameter(string.Format("{0}Id", prefixParam), DbType.String, DBNull.Value);

            lst = dal_2C.GetList("Product_GetRelate", param, out total);
            return lst;
        }
    }
}
