using Cb.BLL;
using Cb.DBUtility;
using Cb.Model;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cb.Web.Controls
{
    public partial class block_bookingprice : DGCUserControl
    {
        #region Parameter
        /// <summary>
        /// Type default của Standart price=1;
        /// </summary>
        static int type = 1;

        protected string template_path, pageName, cid, cidsub, id;
        int total;

        private int productId = int.MinValue;
        public int ProductId
        {
            get
            {
                if (productId != int.MinValue)
                    return productId;
                else
                    return int.MinValue;
            }
            set
            {
                productId = value;
            }
        }

        #endregion

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            cidsub = Utils.GetParameter("cidsub", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            BindData();
        }

        private void BindData()
        {
            StringBuilder sbHeader = new StringBuilder();
            StringBuilder sbRow = new StringBuilder();
            StringBuilder sbRows = new StringBuilder();
            int i = 0;

            DGCParameter[] param = new DGCParameter[2];
            param[0] = new DGCParameter("@productId", DbType.Int32, ProductId); ;
            param[1] = new DGCParameter("@total", DbType.Int32, total); ;
            DataTable dtb = DBHelper.ExcuteFromStore("BookingPrice_Get", param);

            if (dtb != null && dtb.Rows.Count > 0)
            {
                foreach (DataRow row in dtb.Rows)
                {
                    foreach (DataColumn column in dtb.Columns)
                    {
                        sbHeader.AppendFormat("<th class='text-center'>{0}</th>", column.ColumnName);
                        string dola = i > 0 ? string.Format("<td class='text-center'>$ {0}</td>", row[column].ToString()) : string.Format("<td class='text-center'>{0}</td>", row[column].ToString());
                        sbRow.AppendFormat(dola);
                        i++;
                    }
                    sbRows.Append(sbRow);
                }
            }

            ltrHeader.Text = sbHeader.ToString();
            ltrRows.Text = sbRows.ToString();
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                InitPage();
            }
        }

        #endregion
    }
}