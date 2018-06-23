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
using Cb.Model.Products;
using Cb.Utility;

namespace Cb.BLL.Attribute
{
    [Serializable]
    public class AttributeBLL
    {
        private static IGeneric2C<PNK_Attribute, PNK_AttributeDesc> dal_2C;

        private string prefixParam;

        public AttributeBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic2C<PNK_Attribute, PNK_AttributeDesc>);
            dal_2C = DataAccessGeneric2C<PNK_Attribute, PNK_AttributeDesc>.CreateSession(t.FullName);

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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="langId"></param>
        /// <param name="name"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="total"></param>
        /// <returns></returns>
        public IList<PNK_Attribute> GetList(int langId, string name, int pageIndex, int pageSize, out int total)
        {
            return GetList(langId, name, string.Empty, int.MinValue, false, pageIndex, pageSize, out  total);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="langId"></param>
        /// <param name="name"></param>
        /// <param name="publish"></param>
        /// <param name="parentId"></param>
        /// <param name="isTree"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="total"></param>
        /// <returns></returns>
        public IList<PNK_Attribute> GetList(int langId, string name, string publish, int parentId, bool isTree, int pageIndex, int pageSize, out int total)
        {
            return GetList(langId, name, publish, parentId, isTree, string.Empty, pageIndex, pageSize, out  total);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="langId"></param>
        /// <param name="name"></param>
        /// <param name="publish"></param>
        /// <param name="parentId"></param>
        /// <param name="isTree"></param>
        /// <param name="field"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="total"></param>
        /// <returns></returns>
        public IList<PNK_Attribute> GetList(int langId, string name, string publish, int parentId, bool isTree, string field, int pageIndex, int pageSize, out int total)
        {
            return GetList(langId, name, publish, string.Empty, parentId, isTree, field, pageIndex, pageSize, out  total);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="langId"></param>
        /// <param name="name"></param>
        /// <param name="publish"></param>
        /// <param name="id"></param>
        /// <param name="parentId"></param>
        /// <param name="isTree"></param>
        /// <param name="field"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="total"></param>
        /// <returns></returns>
        public IList<PNK_Attribute> GetList(int langId, string name, string publish, string id, int parentId, bool isTree, string field, int pageIndex, int pageSize, out int total)
        {
            return GetList(langId, name, publish, id, parentId, int.MinValue, isTree, field, pageIndex, pageSize, out  total);
        }

        public IList<PNK_Attribute> GetList(int langId, string name, string publish, string id, int parentId, int uncludeMe, bool isTree, string field, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_Attribute> lst = new List<PNK_Attribute>();
            DGCParameter[] param = new DGCParameter[10];

            if (langId != int.MinValue)
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int32, langId);
            else
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int32, DBNull.Value);

            if (!string.IsNullOrEmpty(name))
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, name);
            else
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, DBNull.Value);

            if (parentId != int.MinValue)
                param[2] = new DGCParameter(string.Format("{0}parentid", prefixParam), DbType.Int32, parentId);
            else
                param[2] = new DGCParameter(string.Format("{0}parentid", prefixParam), DbType.Int32, DBNull.Value);

            param[3] = new DGCParameter(string.Format("{0}tree", prefixParam), DbType.Boolean, isTree);

            if (pageIndex != int.MinValue)
                param[4] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, pageIndex);
            else
                param[4] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, DBNull.Value);

            if (pageSize != int.MinValue)
                param[5] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, pageSize);
            else
                param[5] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, DBNull.Value);

            if (!string.IsNullOrEmpty(publish))
                param[6] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, publish);
            else
                param[6] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(field))
                param[7] = new DGCParameter(string.Format("{0}field", prefixParam), DbType.String, field);
            else
                param[7] = new DGCParameter(string.Format("{0}field", prefixParam), DbType.String, DBNull.Value);

            if (!string.IsNullOrEmpty(id))
                param[8] = new DGCParameter(string.Format("{0}id", prefixParam), DbType.String, id);
            else
                param[8] = new DGCParameter(string.Format("{0}id", prefixParam), DbType.String, DBNull.Value);

            if (uncludeMe != int.MinValue)
                param[9] = new DGCParameter(string.Format("{0}uncludeMe", prefixParam), DbType.Int32, uncludeMe);
            else
                param[9] = new DGCParameter(string.Format("{0}uncludeMe", prefixParam), DbType.Int32, DBNull.Value);

            string[] keyArr = param.Select(x => x.Value.ToString()).ToArray();
            string key = string.Format("Attribute_GetList_{0}_{1}", WebUtils.CurrentUserIP, string.Join("_", keyArr));
            total = 0;

            //Get cache
            //if (!CacheHelper.Get(key, out lst))
            //{
                lst = dal_2C.GetList("Attribute_Get", param, out total);
                CacheHelper.Add(lst, key);
            //}
            //else
            //{
            //    total = lst.Count();
            //}

            return lst;
        }

        public IList<PNK_Attribute> GetAllChild(int categoryId, bool includeMe)
        {
            int total;

            IList<PNK_Attribute> lst = new List<PNK_Attribute>();
            DGCParameter[] param = new DGCParameter[2];

            if (categoryId != int.MinValue)
                param[0] = new DGCParameter(string.Format("{0}IDCategory", prefixParam), DbType.Int32, categoryId);
            else
                param[0] = new DGCParameter(string.Format("{0}IDCategory", prefixParam), DbType.Int32, DBNull.Value);
            if (includeMe)
                param[1] = new DGCParameter(string.Format("{0}unclude_me", prefixParam), DbType.Int16, 1);
            else
                param[1] = new DGCParameter(string.Format("{0}unclude_me", prefixParam), DbType.Int16, 0);

            //string[] keyArr = param.Select(x => x.Value.ToString()).ToArray();
            //string key = string.Join("_", keyArr);


            //if (!CacheHelper.Get(key, out lst))
            //{
            lst = dal_2C.GetList("Attribute_GetChild", param, out total);
            //CacheHelper.Add(lst, key);
            //}
            //else
            //{
            //    total = lst.Count();
            //}

            return lst;
        }

        public IList<PNK_Attribute> GetListTree(int langId, string name, int pageIndex, int pageSize, out int total)
        {
            return GetListTree(langId, name, "1", int.MinValue, int.MinValue, string.Empty, 1, true, string.Empty, pageIndex, pageSize, out  total);
        }

        /// <summary>
        /// GetListTree
        /// </summary>
        /// <param name="langId"></param>
        /// <param name="name"></param>
        /// <param name="publish"></param>
        /// <param name="id"></param>
        /// <param name="parentId"></param>
        /// <param name="uncludeMe"></param>
        /// <param name="isTree"></param>
        /// <param name="field"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="total"></param>
        /// <returns></returns>
        public IList<PNK_Attribute> GetListTree(int langId, string name, string publish, int id, int parentId, string treeNameUrl
            , int uncludeMe, bool isTree, string field, int pageIndex, int pageSize, out int total)
        {
            IList<PNK_Attribute> lst = new List<PNK_Attribute>();
            DGCParameter[] param = new DGCParameter[11];

            if (langId != int.MinValue)
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int32, langId);
            else
                param[0] = new DGCParameter(string.Format("{0}langId", prefixParam), DbType.Int32, DBNull.Value);

            if (!string.IsNullOrEmpty(name))
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, name);
            else
                param[1] = new DGCParameter(string.Format("{0}name", prefixParam), DbType.String, DBNull.Value);

            if (parentId != int.MinValue)
                param[2] = new DGCParameter(string.Format("{0}parentid", prefixParam), DbType.Int32, parentId);
            else
                param[2] = new DGCParameter(string.Format("{0}parentid", prefixParam), DbType.Int32, DBNull.Value);

            param[3] = new DGCParameter(string.Format("{0}tree", prefixParam), DbType.Boolean, isTree);

            if (pageIndex != int.MinValue)
                param[4] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, pageIndex);
            else
                param[4] = new DGCParameter(string.Format("{0}pageIndex", prefixParam), DbType.Int32, DBNull.Value);

            if (pageSize != int.MinValue)
                param[5] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, pageSize);
            else
                param[5] = new DGCParameter(string.Format("{0}pageSize", prefixParam), DbType.Int32, DBNull.Value);

            if (!string.IsNullOrEmpty(publish))
                param[6] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, publish);
            else
                param[6] = new DGCParameter(string.Format("{0}published", prefixParam), DbType.AnsiString, DBNull.Value);

            if (!string.IsNullOrEmpty(field))
                param[7] = new DGCParameter(string.Format("{0}field", prefixParam), DbType.String, field);
            else
                param[7] = new DGCParameter(string.Format("{0}field", prefixParam), DbType.String, DBNull.Value);

            if (id != int.MinValue)
                param[8] = new DGCParameter(string.Format("{0}id", prefixParam), DbType.Int32, id);
            else
                param[8] = new DGCParameter(string.Format("{0}id", prefixParam), DbType.Int32, DBNull.Value);

            if (uncludeMe != int.MinValue)
                param[9] = new DGCParameter(string.Format("{0}uncludeMe", prefixParam), DbType.Int32, uncludeMe);
            else
                param[9] = new DGCParameter(string.Format("{0}uncludeMe", prefixParam), DbType.Int32, DBNull.Value);

            if (!string.IsNullOrEmpty(treeNameUrl))
                param[10] = new DGCParameter(string.Format("{0}treeNameUrl", prefixParam), DbType.String, treeNameUrl);
            else
                param[10] = new DGCParameter(string.Format("{0}treeNameUrl", prefixParam), DbType.String, DBNull.Value);

            string[] keyArr = param.Select(x => x.Value.ToString()).ToArray();
            string key = string.Format("Attribute_GetListTree_{0}_{1}", WebUtils.CurrentUserIP, string.Join("_", keyArr));
            total = 0;

            //Get cache
            if (!CacheHelper.Get(key, out lst))
            {
                lst = dal_2C.GetList("Attribute_Tree_Get", param, out total);
                CacheHelper.Add(lst, key);
            }
            else
            {
                total = lst.Count();
            }

            return lst;
        }


    }
}
