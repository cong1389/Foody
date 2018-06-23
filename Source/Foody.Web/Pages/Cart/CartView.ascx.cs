using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Model.CardProduct;
using Cb.Model.Products;
using Cb.Utility;
using Cb.Web.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Cb.Web.Pages.Cart
{
    public partial class CartView : DGCUserControl
    {
        #region Paramter

        int total;

        #endregion

        #region Common

        private void InitPage()
        {
            //LocalizationUtility.SetValueControl(this, Ci);

            //reqValidatorEmail.ToolTip = Constant.UI.alert_empty_email;
            //reqExpressionValidatorEmail.ToolTip = Constant.UI.alert_invalid_email;
            //reqExpressionValidatorEmail.ValidationExpression = Constant.RegularExpressionString.validateEmail;

            //RegularExpressionValidatorPhone.ToolTip = Constant.UI.alert_invalid_phone;
            //RegularExpressionValidatorPhone.ValidationExpression = Constant.RegularExpressionString.validatePhone;

            BindRepeater();
            GetProductCategory();
        }

        private void BindRepeater()
        {
            IList<PNK_CartProduct> lst = Session["Cart"] as IList<PNK_CartProduct>;
            if (lst != null)
            {
                double total = lst.Sum(i => (i.Price * i.Quantity));
                ltrTotal.Text = FormatHelper.FormatDonviTinh(total, enuCostId.dong);
                rptResult.DataSource = lst;
                rptResult.DataBind();
            }
        }

        private void GetProductCategory()
        {
            ProductCategoryBLL pcBll = new ProductCategoryBLL();
            string treeNameUrl = UtilityLocal.RemoveLanguage(Request.RawUrl, LangId);
            IList<PNK_ProductCategory> lstAll = pcBll.GetListTree(LangInt, string.Empty, null, int.MinValue, string.Empty, treeNameUrl, 1, true, string.Empty, 1, 9999, out total);
            if (lstAll.Count > 0)
            {
                ltrHeaderCategory.Text = Common.UtilityLocal.ImagePathByFont(lstAll[0], Request);
            }
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitPage();
            }
        }

        protected void rptResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_CartProduct data = e.Item.DataItem as PNK_CartProduct;

                HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                string imgSrc = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], data.ImageDesc);
                img.Src = imgSrc;
                img.Attributes.Add("srcset", imgSrc);

                Literal ltr = e.Item.FindControl("ltrName") as Literal;
                ltr.Text = data.NameDesc;

                ltr = e.Item.FindControl("ltrSTT") as Literal;
                ltr.Text = (e.Item.ItemIndex + 1).ToString();

                ltr = e.Item.FindControl("ltrPrice") as Literal;
                ltr.Text = FormatHelper.FormatDonviTinh(data.Price, enuCostId.dong, Ci);

                double amount = data.Price * data.Quantity;
                ltr = e.Item.FindControl("ltrAmount") as Literal;
                ltr.Text = FormatHelper.FormatDonviTinh(amount, enuCostId.dong, Ci);

                HtmlInputText txtQuantity = e.Item.FindControl("txtQuantity") as HtmlInputText;
                txtQuantity.Value = DBConvert.ParseString(data.Quantity);

                HtmlAnchor hypDelete = e.Item.FindControl("hypDelete") as HtmlAnchor;
                hypDelete.Title = data.ProductId.ToString();
            }
        }

        protected void hypDelete_OnClick(object sender, EventArgs e)
        {
            HtmlAnchor hypDelete = (HtmlAnchor)sender;
            string productId = hypDelete.Title;

            IList<PNK_CartProduct> lst = Session["Cart"] as IList<PNK_CartProduct>;
            PNK_CartProduct obj;

            List<int> lstRemove = new List<int>();
            foreach (RepeaterItem item in rptResult.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    obj = lst[item.ItemIndex];
                    if (obj.ProductId.ToString() == productId)
                    {
                        lst.RemoveAt(item.ItemIndex);
                        break;
                    }
                }
            }

            Session["Cart"] = lst;
            BindRepeater();

            string link = LinkHelper.GetLink(Utils.GetParameter("page", "cartview"), LangId);
            Response.Redirect(Utils.CombineUrl(Template_path, link));
        }

        protected void hypUpdate_OnClick(object sender, EventArgs e)
        {
            IList<PNK_CartProduct> lst = Session["Cart"] as IList<PNK_CartProduct>;
            PNK_CartProduct obj;
            List<int> lstRemove = new List<int>();
            foreach (RepeaterItem item in rptResult.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    obj = lst[item.ItemIndex];
                    HtmlInputText txtQuantity = item.FindControl("txtQuantity") as HtmlInputText;
                    obj.Quantity = DBConvert.ParseInt(txtQuantity.Value);

                    HiddenField hdfDelete = item.FindControl("hdfDelete") as HiddenField;
                    if (!string.IsNullOrEmpty(hdfDelete.Value))
                    {
                        lstRemove.Add(item.ItemIndex);
                    }
                }
            }

            foreach (var i in lstRemove)
            {
                lst.RemoveAt(i);
            }
            Session["Cart"] = lst;
            BindRepeater();
        }

        protected void hypCheckOut_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect(Utils.CombineUrl(Template_path,LinkHelper.GetLink( "checkout", LangId)));
        }

        //protected void btnSendEmail_OnClick(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        if (Page.IsValid)
        //        {
        //            IList<PNK_CartProduct> lst = Session["Cart"] as IList<PNK_CartProduct>;
        //            if (lst != null)
        //            {
        //                bool result = false;
        //                string path = Request.PhysicalApplicationPath;
        //                string strHtml = WebUtils.GetMailTemplate(Path.Combine(path, "TemplateMail/GioHang.txt"));
        //                string body = string.Empty, content = string.Empty;

        //                StringBuilder sbRow = new StringBuilder();
        //                for (int i = 0; i < lst.Count; i++)
        //                {
        //                    sbRow.AppendLine("<tr>");
        //                    sbRow.AppendLine(string.Format("<td>{0}</td>", i + 1));
        //                    sbRow.AppendLine(string.Format("<td>{0}</td>", lst[i].NameDesc));
        //                    sbRow.AppendLine(string.Format("<td>{0}</td>", lst[i].Quantity));
        //                    sbRow.AppendLine("</tr>");
        //                }

        //                StringBuilder sbTable = new StringBuilder();
        //                sbTable.AppendLine("<table style=" + '"' + "border:thin solid #000000; text-align: center;" + '"' + ">");
        //                sbTable.AppendLine("<tr style=" + '"' + "background-color:Silver" + '"' + ">");
        //                sbTable.AppendLine("<td><b>STT</b></td>");
        //                sbTable.AppendLine("<td><b>Tên sản phẩm</b></td>");
        //                sbTable.AppendLine("<td><b>Số lượng</b></td>");
        //                sbTable.AppendLine(sbRow.ToString());
        //                sbTable.AppendLine("</tr></table>");

        //                content = sbTable.ToString();
        //                body = string.Format(strHtml, "VPPVinhHung", txtName.Value, txtEmail.Value, content);
        //                result = WebUtils.SendEmail("DatHang", txtEmail.Value, string.Empty, body);
        //                if (result == true)
        //                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('Gửi Liên hệ thành công','Message',function(r) {{window.location='{0}'}});", Request.RawUrl), true);
        //                else
        //                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('Gửi Liên hệ thất baị','Message',function(r) {{window.location='{0}'}});", Request.RawUrl), true);
        //                txtEmail.Value = txtPhone.Value = txtMessage.Value = txtName.Value = "";
        //            }
        //            else
        //            {
        //                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('Không có sản phẩm để gửi.','Message',function(r) {{window.location='{0}'}});", Request.RawUrl), true);
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Write2Log.WriteLogs(ConfigurationManager.AppSettings["UserMail"], ConfigurationManager.AppSettings["PassMail"], ex.ToString());
        //    }
        //}

        #endregion


    }
}