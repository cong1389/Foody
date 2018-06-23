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

namespace Cb.Web.Admin.Pages.BookingPrice
{
    public partial class admin_bookingprice : DGCUserControl
    {
        #region Parameter

        BookingGroupBLL bllBookingGroup = new BookingGroupBLL();
        IList<PNK_BookingGroup> lstBookingGroup;
        IList<PNK_BookingPrice> lst;

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
            BookingPriceBLL bll = new BookingPriceBLL();
            lst = bll.GetList(DBConvert.ParseInt(ProductId));
            if (lst.Count() > 0)
            {
                grdBookingPrice.DataSource = lst;
                grdBookingPrice.DataBind();

                //grdBookingPrice.Columns[4].Visible = true;
            }
            else
            {
                PNK_BookingPrice pnk = new PNK_BookingPrice();
                DataTable dt = Common.UtilityLocal.ObjectToData(pnk);
                grdBookingPrice.DataSource = dt;
                grdBookingPrice.DataBind();

                //grdBookingPrice.Columns[4].Visible = false;
                foreach (GridViewRow row in grdBookingPrice.Rows)
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
        private int Save(string id, string priceClass, string name, string value, int min, int max, string groupType, bool published)
        {
            int priceId = DBConvert.ParseInt(id);
            PNK_BookingPrice productcatObj = new PNK_BookingPrice();
            Generic<PNK_BookingPrice> genericBLL = new Generic<PNK_BookingPrice>();

            if (priceId == int.MinValue)
            {
                productcatObj.Name = name;
                productcatObj.Value = DBConvert.ParseDouble(value);
                productcatObj.PriceClass = priceClass;
                productcatObj.ProductId = DBConvert.ParseInt(ProductId);
                productcatObj.Min = min;
                productcatObj.Max = max;
                productcatObj.GroupType = groupType;
                productcatObj.Published = published == true ? "1" : "0";
                productcatObj.Ordering = genericBLL.getOrdering();

                //excute             
                genericBLL.Insert(productcatObj);
            }
            else
            {
                productcatObj.Name = name;
                productcatObj.Value = DBConvert.ParseDouble(value);
                productcatObj.PriceClass = priceClass;
                productcatObj.ProductId = DBConvert.ParseInt(ProductId);
                productcatObj.ID = priceId;
                productcatObj.Min = min;
                productcatObj.Max = max;
                productcatObj.GroupType = groupType;
                productcatObj.Published = published == true ? "1" : "0";
                productcatObj.Ordering = genericBLL.getOrdering();

                //excute
                genericBLL.Update(productcatObj, productcatObj, new string[] { "Id" });
                grdBookingPrice.EditIndex = -1;
            }

            BindData();

            return priceId;
        }

        #endregion

        #region Event

        protected void AddNew(object sender, EventArgs e)
        {
            string priceClass = ((TextBox)grdBookingPrice.FooterRow.FindControl("txtPriceClass")).Text;
            string name = ((TextBox)grdBookingPrice.FooterRow.FindControl("txtName")).Text;
            string value = ((TextBox)grdBookingPrice.FooterRow.FindControl("txtValue")).Text;

            int min = DBConvert.ParseInt(((TextBox)grdBookingPrice.FooterRow.FindControl("txtMin")).Text);
            int max = DBConvert.ParseInt(((TextBox)grdBookingPrice.FooterRow.FindControl("txtMax")).Text);
            string groupType = ((DropDownList)grdBookingPrice.FooterRow.FindControl("drpGroupType")).SelectedValue;
            bool published = ((CheckBox)grdBookingPrice.FooterRow.FindControl("chkPublished")).Checked;

            Save(string.Empty, priceClass, name, value, min, max, groupType, published);
        }

        protected void grdBookingPrice_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            BindData();
            grdBookingPrice.PageIndex = e.NewPageIndex;
            grdBookingPrice.DataBind();
        }

        protected void grdBookingPrice_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdBookingPrice.EditIndex = e.NewEditIndex;
            BindData();

            TextBox txtPriceClass = (TextBox)grdBookingPrice.Rows[e.NewEditIndex].FindControl("txtPriceClass");
            TextBox txtName = (TextBox)grdBookingPrice.Rows[e.NewEditIndex].FindControl("txtName");
            if (txtPriceClass != null && (txtPriceClass.Text == "child" || txtPriceClass.Text == "infant"))
            {
                txtPriceClass.Enabled = false;
                txtName.Enabled = false;
            }
        }

        protected void grdBookingPrice_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdBookingPrice.EditIndex = -1;
            BindData();

        }

        protected void grdBookingPrice_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string priceId = ((Label)grdBookingPrice.Rows[e.RowIndex].FindControl("lbID")).Text;
            string priceClass = ((TextBox)grdBookingPrice.Rows[e.RowIndex].FindControl("txtPriceClass")).Text;
            string name = ((TextBox)grdBookingPrice.Rows[e.RowIndex].FindControl("txtName")).Text;
            string value = ((TextBox)grdBookingPrice.Rows[e.RowIndex].FindControl("txtValue")).Text;
            int min = DBConvert.ParseInt(((TextBox)grdBookingPrice.Rows[e.RowIndex].FindControl("txtMin")).Text);
            int max = DBConvert.ParseInt(((TextBox)grdBookingPrice.Rows[e.RowIndex].FindControl("txtMax")).Text);
            string groupType = ((DropDownList)grdBookingPrice.Rows[e.RowIndex].FindControl("drpGroupType")).SelectedValue;
            bool published = ((CheckBox)grdBookingPrice.Rows[e.RowIndex].FindControl("chkPublished")).Checked;

            Save(priceId, priceClass, name, value, min, max, groupType, published);
        }

        protected void grdBookingPrice_RowDeleted(object sender, GridViewDeleteEventArgs e)
        {
            string priceId = grdBookingPrice.DataKeys[e.RowIndex].Value.ToString();
            Generic<PNK_BookingPrice> genericBLL = new Generic<PNK_BookingPrice>();
            genericBLL.Delete(priceId);

            BindData();
        }

        protected void grdBookingPrice_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList drpGroupType = (DropDownList)e.Row.FindControl("drpGroupType");
                    if (drpGroupType != null)
                    {
                        lstBookingGroup = bllBookingGroup.GetList();
                        drpGroupType.DataSource = lstBookingGroup;
                        drpGroupType.DataTextField = "Name";
                        drpGroupType.DataValueField = "Name";
                        drpGroupType.DataBind();
                    }
                }
            }

            //if (e.Row.RowType == DataControlRowType.DataRow && grdBookingPrice.EditIndex == e.Row.RowIndex)
            //{
            //    DropDownList drpGroupType = (DropDownList)e.Row.FindControl("drpGroupType");


            //    drpGroupType.Items.FindByValue((e.Row.FindControl("lbGroupType") as Label).Text).Selected = true;
            //}
        }

        protected void grdBookingPrice_DataBound(object sender, EventArgs e)
        {
            Literal ltrSort = grdBookingPrice.FooterRow.FindControl("ltrSort") as Literal;
            string strOrder = string.Empty;
            string onclick = string.Empty;

            ////orderDown
            //if (indexItem < this.pager.ItemCount - 1)
            //{
            //    onclick = string.Format("onclick=\"listItemTask('cb{0}', 'orderdown')\"", e.Item.ItemIndex);
            //    strOrder += string.Format("<a title='{0}' {1} runat='server' class=\"center-block text-center\" style='cursor:pointer;color:#3C8DBC'><i class=\"fa fa-long-arrow-down\"></i></a> ", Constant.UI.admin_Down, onclick);
            //}
            ////orderUp
            //if (indexItem > 0)
            //{
            //    onclick = string.Format("onclick=\"listItemTask('cb{0}', 'orderup')\"", e.Item.ItemIndex);
            //    strOrder += string.Format("<a title='{0}' {1} runat='server' class=\"center-block text-center\" style='cursor:pointer;color:#3C8DBC'><i class=\"fa fa-long-arrow-up\"></i> </a> ", Constant.UI.admin_Up, onclick);
            //}
            //indexItem++;
            //ltr.Text = strOrder;

            DropDownList drpGroupType = grdBookingPrice.FooterRow.FindControl("drpGroupType") as DropDownList;
            if (drpGroupType != null)
            {
                lstBookingGroup = bllBookingGroup.GetList();
                drpGroupType.DataSource = lstBookingGroup;
                drpGroupType.DataTextField = "Name";
                drpGroupType.DataValueField = "Name";
                drpGroupType.DataBind();
            }
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