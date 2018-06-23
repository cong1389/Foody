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
    public class BookingGroupBLL
    {
        private static IGeneric<PNK_BookingGroup> dal;
        private string prefixParam;
        public BookingGroupBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<PNK_BookingGroup>);
            dal = DataAccessGeneric<PNK_BookingGroup>.CreateSession(t.FullName);

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

        public IList<PNK_BookingGroup> GetList()
        {
            IList<PNK_BookingGroup> lst = new List<PNK_BookingGroup>();
            PNK_BookingGroup bookingPrice = new PNK_BookingGroup();
            lst = dal.GetAllBy(bookingPrice, "where 1=1", null);

            return lst;
        }
    }
}
