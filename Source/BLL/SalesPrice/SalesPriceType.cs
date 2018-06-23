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
    public class SalesPriceTypeBLL
    {
        private static IGeneric<PNK_SalesPriceType> dal;
        private string prefixParam;
        public SalesPriceTypeBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<PNK_SalesPriceType>);
            dal = DataAccessGeneric<PNK_SalesPriceType>.CreateSession(t.FullName);

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

        public IList<PNK_SalesPriceType> GetSalesPriceTypeAll()
        {
            IList<PNK_SalesPriceType> lst = new List<PNK_SalesPriceType>();
            PNK_SalesPriceType province = new PNK_SalesPriceType();
            lst = dal.GetAllBy(province,string.Empty, null);
            return lst;
        }
    }
}
