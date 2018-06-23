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
    public class VatGroupBLL
    {
        private static IGeneric<PNK_VatGroup> dal;
        private string prefixParam;
        public VatGroupBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<PNK_VatGroup>);
            dal = DataAccessGeneric<PNK_VatGroup>.CreateSession(t.FullName);

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

        public IList<PNK_VatGroup> GetVatGroupAll()
        {
            IList<PNK_VatGroup> lst = new List<PNK_VatGroup>();
            PNK_VatGroup obj = new PNK_VatGroup();
            lst = dal.GetAllBy(obj, string.Empty, null);
            return lst;
        }
    }
}
