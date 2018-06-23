using Cb.BLL;
using Cb.DBUtility;
using Cb.Model;
using Cb.Utility;
using Cb.Web.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cb.Web.Admin.Controls
{
    public partial class block_salesprice : DGCUserControl
    {
        #region Parameter

        IList<PNK_SalesPrice> lst;

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
            SalesPriceBLL bll = new SalesPriceBLL();
            lst = bll.GetList(ProductId, string.Empty, DateTime.MinValue, DateTime.MinValue, 1, 1000, out total);
            if (lst.Count() > 0)
            {
                grdSalesPrice.DataSource = lst;
                grdSalesPrice.DataBind();
            }
            else
            {
                PNK_SalesPrice pnk = new PNK_SalesPrice();
                DataTable dt = Common.UtilityLocal.ObjectToData(pnk);
                grdSalesPrice.DataSource = dt;
                grdSalesPrice.DataBind();

                //grdSalesPrice.Columns[4].Visible = false;
                //foreach (GridViewRow row in grdSalesPrice.Rows)
                //{
                //    if (row.RowType == DataControlRowType.DataRow)
                //    {
                //        LinkButton lb = ((LinkButton)row.FindControl("lnkRemove"));
                //        if (lb != null)
                //        {
                //            lb.Visible = false;
                //        }
                //    }
                //}
            }
        }

        /// <summary>
        /// Save location
        /// </summary>
        private int Save(PNK_SalesPrice productcatObj)
        {
            int priceId = productcatObj.Id;
            Generic<PNK_SalesPrice> genericBLL = new Generic<PNK_SalesPrice>();

            if (priceId == int.MinValue)
            {
                genericBLL.Insert(productcatObj);
            }
            else
            {
                PNK_SalesPrice productcatObjCurrent = new PNK_SalesPrice();
                string[] fields = { "Id" };
                productcatObjCurrent.Id = priceId;
                productcatObjCurrent = genericBLL.Load(productcatObj, fields);

                genericBLL.Update(productcatObjCurrent, productcatObj, fields);
            }

            BindData();

            return priceId;
        }

        #endregion

        #region Event

        protected void AddNew(object sender, EventArgs e)
        {
            PNK_SalesPrice productcatObj = new PNK_SalesPrice();
            productcatObj.ProductId = ProductId;
            productcatObj.StoreGroup = ((DropDownList)grdSalesPrice.FooterRow.FindControl("drpStoreGroup")).SelectedValue;
            productcatObj.SalesPriceId = ((DropDownList)grdSalesPrice.FooterRow.FindControl("drpSalesPriceType")).SelectedValue;
            productcatObj.UnitOfMeasureId = ((DropDownList)grdSalesPrice.FooterRow.FindControl("drpUnit")).SelectedValue;

            string startingDate = ((TextBox)grdSalesPrice.FooterRow.FindControl("txtStartingDate")).Text;
            productcatObj.StartingDate = startingDate != "" ? DateTime.Parse(startingDate, new CultureInfo("en-US")) : DateTime.MinValue;

            string endingDate = ((TextBox)grdSalesPrice.FooterRow.FindControl("txtEndingDate")).Text;
            productcatObj.EndingDate = endingDate != "" ? DateTime.Parse(endingDate, new CultureInfo("en-US")) : DateTime.MinValue;

            string unitPrice = ((TextBox)grdSalesPrice.FooterRow.FindControl("txtUnitPrice")).Text;
            productcatObj.UnitPrice = DBConvert.ParseDecimal(unitPrice);
            productcatObj.OriginPrice = DBConvert.ParseDecimal(unitPrice);

            string dealPrice = ((TextBox)grdSalesPrice.FooterRow.FindControl("txtDealPrice")).Text;
            productcatObj.DealPrice = dealPrice == "" ? DBConvert.ParseDecimal(unitPrice) : DBConvert.ParseDecimal(((TextBox)grdSalesPrice.FooterRow.FindControl("txtDealPrice")).Text);

            Save(productcatObj);
        }

        protected void grdSalesPrice_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            BindData();
            grdSalesPrice.PageIndex = e.NewPageIndex;
            grdSalesPrice.DataBind();
        }

        protected void grdSalesPrice_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdSalesPrice.EditIndex = e.NewEditIndex;
            BindData();
        }

        protected void grdSalesPrice_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdSalesPrice.EditIndex = -1;
            BindData();
        }

        protected void grdSalesPrice_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            PNK_SalesPrice productcatObj = new PNK_SalesPrice();
            productcatObj.Id = DBConvert.ParseInt(((Label)grdSalesPrice.Rows[e.RowIndex].FindControl("lbID")).Text);
            productcatObj.ProductId = ProductId;
            productcatObj.StoreGroup = ((DropDownList)grdSalesPrice.Rows[e.RowIndex].FindControl("drpStoreGroup")).SelectedValue;
            productcatObj.SalesPriceId = ((DropDownList)grdSalesPrice.Rows[e.RowIndex].FindControl("drpSalesPriceType")).SelectedValue;
            productcatObj.UnitOfMeasureId = ((DropDownList)grdSalesPrice.Rows[e.RowIndex].FindControl("drpUnit")).SelectedValue;
            string startingDate = ((TextBox)grdSalesPrice.Rows[e.RowIndex].FindControl("txtStartingDate")).Text;
            productcatObj.StartingDate = startingDate != "" ? DateTime.ParseExact(startingDate, "dd/MM/yyyy", CultureInfo.InvariantCulture) : DateTime.MinValue;

            string endingDate = ((TextBox)grdSalesPrice.Rows[e.RowIndex].FindControl("txtEndingDate")).Text;
            productcatObj.EndingDate = endingDate != "" ? DateTime.ParseExact(endingDate, "dd/MM/yyyy", CultureInfo.InvariantCulture) : DateTime.MinValue;

            string unitPrice = ((TextBox)grdSalesPrice.Rows[e.RowIndex].FindControl("txtUnitPrice")).Text;
            productcatObj.UnitPrice = DBConvert.ParseDecimal(unitPrice);
            productcatObj.OriginPrice = DBConvert.ParseDecimal(unitPrice);

            string dealPrice = ((TextBox)grdSalesPrice.Rows[e.RowIndex].FindControl("txtDealPrice")).Text;
            productcatObj.DealPrice = dealPrice == "" ? DBConvert.ParseDecimal(unitPrice) : DBConvert.ParseDecimal(dealPrice);


            //productcatObj.UnitPrice = DBConvert.ParseDecimal(((TextBox)grdSalesPrice.Rows[e.RowIndex].FindControl("txtUnitPrice")).Text);
            //productcatObj.DealPrice = DBConvert.ParseDecimal(((TextBox)grdSalesPrice.Rows[e.RowIndex].FindControl("txtDealPrice")).Text);

            grdSalesPrice.EditIndex = -1;
            Save(productcatObj);

        }

        protected void grdSalesPrice_RowDeleted(object sender, GridViewDeleteEventArgs e)
        {
            string priceId = grdSalesPrice.DataKeys[e.RowIndex].Value.ToString();
            Generic<PNK_SalesPrice> genericBLL = new Generic<PNK_SalesPrice>();
            genericBLL.Delete(priceId);

            BindData();
        }

        protected void grdSalesPrice_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    //Khu vực
                    DropDownList drpStoreGroup = (DropDownList)e.Row.FindControl("drpStoreGroup");
                    if (drpStoreGroup != null)
                    {
                        BuildControl.BuildDropDownList(LangInt, drpStoreGroup, UtilityLocal.List.Province, false, string.Empty, string.Empty);

                        //Set old value selected
                        Label lbStoreGroup = (Label)e.Row.FindControl("lbStoreGroup");
                        drpStoreGroup.SelectedValue = lbStoreGroup.Text;
                    }

                    //Loại giá
                    DropDownList drpSalesPriceType = (DropDownList)e.Row.FindControl("drpSalesPriceType");
                    if (drpSalesPriceType != null)
                    {
                        BuildControl.BuildDropDownList(LangInt, drpSalesPriceType, UtilityLocal.List.SalesPriceType, false, string.Empty, string.Empty);

                        //Set old value selected
                        Label lbSalesPriceType = (Label)e.Row.FindControl("lbSalesPriceType");
                        drpSalesPriceType.SelectedValue = lbSalesPriceType.Text;
                    }

                    //Đơn vị
                    DropDownList drpUnit = (DropDownList)e.Row.FindControl("drpUnit");
                    if (drpUnit != null)
                    {
                        BuildControl.BuildDropDownList(LangInt, drpUnit, UtilityLocal.List.UnitMeasure, false, string.Empty, string.Empty);

                        //Set old value selected
                        Label lbUnit = (Label)e.Row.FindControl("lbUnit");
                        drpUnit.SelectedValue = lbUnit.Text;
                    }

                    Label lbStartingDate = (Label)e.Row.FindControl("lbStartingDate");
                    TextBox txtStartingDate = (TextBox)e.Row.FindControl("txtStartingDate");
                    txtStartingDate.Text = lbStartingDate.Text;

                    Label lbEndingDate = (Label)e.Row.FindControl("lbEndingDate");
                    TextBox txtEndingDate = (TextBox)e.Row.FindControl("txtEndingDate");
                    txtEndingDate.Text = lbEndingDate.Text;

                    Label lbUnitPrice = (Label)e.Row.FindControl("lbUnitPrice");
                    TextBox txtUnitPrice = (TextBox)e.Row.FindControl("txtUnitPrice");
                    txtUnitPrice.Text = lbUnitPrice.Text;
                        // lbUnitPrice.Text;

                    Label lbDealPrice = (Label)e.Row.FindControl("lbDealPrice");
                    TextBox txtDealPrice = (TextBox)e.Row.FindControl("txtDealPrice");
                    txtDealPrice.Text = lbDealPrice.Text;
                }             
            }
        }

        protected void grdSalesPrice_DataBound(object sender, EventArgs e)
        {
            //Khu vực
            DropDownList drpStoreGroup = grdSalesPrice.FooterRow.FindControl("drpStoreGroup") as DropDownList;
            if (drpStoreGroup != null)
            {
                BuildControl.BuildDropDownList(LangInt, drpStoreGroup, UtilityLocal.List.Province, false, string.Empty, string.Empty);
            }

            //Loại giá
            DropDownList drpSalesPriceType = grdSalesPrice.FooterRow.FindControl("drpSalesPriceType") as DropDownList;
            if (drpSalesPriceType != null)
            {
                BuildControl.BuildDropDownList(LangInt, drpSalesPriceType, UtilityLocal.List.SalesPriceType, false, string.Empty, string.Empty);
            }

            //Đơn vị
            DropDownList drpUnit = grdSalesPrice.FooterRow.FindControl("drpUnit") as DropDownList;
            if (drpUnit != null)
            {
                BuildControl.BuildDropDownList(LangInt, drpUnit, UtilityLocal.List.UnitMeasure, false, string.Empty, string.Empty);
            }

            //Label lbUnitPrice = (Label)grdSalesPrice.FooterRow.FindControl("lbUnitPrice");
            //lbUnitPrice.Text = FormatHelper.FormatDonviTinh(DBConvert.ParseDouble(lbUnitPrice.Text), enuCostId.dong, Ci);

            //TextBox txtStartingDate = grdSalesPrice.FooterRow.FindControl("txtStartingDate") as TextBox;
            //TextBox txtEndingDate = grdSalesPrice.FooterRow.FindControl("txtEndingDate") as TextBox;
            //txtStartingDate.Text = txtEndingDate.Text = DateTime.Now.ToString();
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