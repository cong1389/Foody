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
    public class UnitMeasureBLL
    {
        private static IGeneric<PNK_UnitMeasure> dal;
        private string prefixParam;
        public UnitMeasureBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<PNK_UnitMeasure>);
            dal = DataAccessGeneric<PNK_UnitMeasure>.CreateSession(t.FullName);

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

        public IList<PNK_UnitMeasure> GetUnitMeasureAll()
        {
            IList<PNK_UnitMeasure> lst = new List<PNK_UnitMeasure>();
            PNK_UnitMeasure province = new PNK_UnitMeasure();
            lst = dal.GetAllBy(province,string.Empty, null);
            return lst;
        }
    }
}
