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

namespace Cb.BLL
{
    [Serializable]
    public class ProvinceBLL
    {
        private static IGeneric<PNK_Province> dal;
        private string prefixParam;
        public ProvinceBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<PNK_Province>);
            dal = DataAccessGeneric<PNK_Province>.CreateSession(t.FullName);

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

        public IList<PNK_Province> GetProvinceAll()
        {
            IList<PNK_Province> lst = new List<PNK_Province>();
            PNK_Province province = new PNK_Province();
            lst = dal.GetAllBy(province, "WHERE Type = 0 ", null);
            return lst;
        }
    }
}
