using Cb.BLL;
using Cb.DBUtility;
using Cb.Model;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cb.Web.Admin.Pages.BookingGroup
{
    public partial class admin_bookinggroup : DGCUserControl
    {
        #region Parameter

        IList<PNK_BookingGroup> lst;

        public string ProductId
        {
            get
            {
                if (ViewState["CategoryId"] != null)
                    return ViewState["CategoryId"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["CategoryId"] = value;
            }
        }
        int total;


        #endregion

        #region Common

        private void InitPage()
        {

            BindData();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="productId"></param>
        /// <param name="type">==NULL mặc định hình</param>
        /// <param name="type">==1:map</param>
        private void BindData()
        {
            BookingGroupBLL bll = new BookingGroupBLL();
            lst = bll.GetList();
            if (lst.Count() > 0)
            {
                grdBookingGroup.DataSource = lst;
                grdBookingGroup.DataBind();

                //grdBookingGroup.Columns[4].Visible = true;
            }
            else
            {
                PNK_BookingGroup pnk = new PNK_BookingGroup();
                DataTable dt = Common.UtilityLocal.ObjectToData(pnk);
                grdBookingGroup.DataSource = dt;
                grdBookingGroup.DataBind();

                //grdBookingGroup.Columns[4].Visible = false;
                foreach (GridViewRow row in grdBookingGroup.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        LinkButton lb = ((LinkButton)row.FindControl("lnkRemove"));
                        if (lb != null)
                        {
                            lb.Visible = false;
                        }
                    }
                }
            }
        }


        /// <summary>
        /// Save location
        /// </summary>
        private int Save(string id, string name)
        {
            int priceId = DBConvert.ParseInt(id);
            PNK_BookingGroup productcatObj = new PNK_BookingGroup();
            Generic<PNK_BookingGroup> genericBLL = new Generic<PNK_BookingGroup>();

            if (priceId == int.MinValue)
            {
                productcatObj.Name = name;   

                //excute             
                genericBLL.Insert(productcatObj);
            }
            else
            {
                productcatObj.Name = name;              
                productcatObj.ID = priceId;      

                //excute
                genericBLL.Update(productcatObj, productcatObj, new string[] { "Id" });
                grdBookingGroup.EditIndex = -1;
            }

            BindData();

            return priceId;
        }

        #endregion

        #region Event

        protected void AddNewCustomer(object sender, EventArgs e)
        {
            string name = ((TextBox)grdBookingGroup.FooterRow.FindControl("txtName")).Text;     
            Save(string.Empty, name);
        }

        protected void grdBookingGroup_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            BindData();
            grdBookingGroup.PageIndex = e.NewPageIndex;
            grdBookingGroup.DataBind();
        }

        protected void grdBookingGroup_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdBookingGroup.EditIndex = e.NewEditIndex;
            BindData();
        }

        protected void grdBookingGroup_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdBookingGroup.EditIndex = -1;
            BindData();
        }

        protected void grdBookingGroup_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string priceId = ((Label)grdBookingGroup.Rows[e.RowIndex].FindControl("lbID")).Text;          
            string name = ((TextBox)grdBookingGroup.Rows[e.RowIndex].FindControl("txtName")).Text;           

            Save(priceId, name);
        }

        protected void grdBookingGroup_RowDeleted(object sender, GridViewDeleteEventArgs e)
        {
            string priceId = grdBookingGroup.DataKeys[e.RowIndex].Value.ToString();
            Generic<PNK_BookingGroup> genericBLL = new Generic<PNK_BookingGroup>();
            genericBLL.Delete(priceId);

            BindData();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitPage();
            }
        }

        #endregion
        
    }
}