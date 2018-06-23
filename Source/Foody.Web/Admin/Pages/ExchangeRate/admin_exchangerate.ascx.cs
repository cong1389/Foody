// =============================================
// Author:		Congtt
// Create date: 22/09/2014
// Description:	danh sach exchangerate
// =============================================

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Cb.Utility;
using Cb.DBUtility;
using Cb.BLL;
using Cb.Localization;
using System.Configuration;
using Cb.Model;

namespace Cb.Web.Admin.Pages.ExchangeRate
{
    public partial class admin_exchangerate : System.Web.UI.UserControl
    {
        #region Fields

        protected string template_path
        {
            get
            {
                if (ViewState["template_path"] != null)
                    return ViewState["template_path"].ToString();
                else
                    return null;
            }
            set
            {
                ViewState["template_path"] = value;
            }
        }
        protected string show_msg;
        protected string l_search;
        protected string records;
        protected string msg_no_selected_item;
        protected string msg_confirm_delete_item;
        private string action;

        private ExchangeRateBLL pcBll
        {
            get
            {
                if (ViewState["pcBll"] != null)
                    return (ExchangeRateBLL)ViewState["pcBll"];
                else return new ExchangeRateBLL();
            }
            set
            {
                ViewState["pcBll"] = value;
            }
        }

        private Generic<PNK_ExchangeRate> genericBLL
        {
            get
            {
                if (ViewState["genericBLLget"] != null)
                    return (Generic<PNK_ExchangeRate>)ViewState["genericBLLget"];
                else return new Generic<PNK_ExchangeRate>();
            }
            set
            {
                ViewState["genericBLLget"] = value;
            }
        }

        private Generic2C<PNK_ExchangeRate, PNK_ExchangeRateDesc> generic2CBLL
        {
            get
            {
                if (ViewState["generic2CBLL"] != null)
                    return (Generic2C<PNK_ExchangeRate, PNK_ExchangeRateDesc>)ViewState["generic2CBLL"];
                else return new Generic2C<PNK_ExchangeRate, PNK_ExchangeRateDesc>();
            }
            set
            {
                ViewState["generic2CBLL"] = value;
            }
        }

        #region Viewstate

        protected int currentPageIndex
        {
            get
            {
                if (ViewState["CurrentPageIndex"] != null)
                    return int.Parse(ViewState["CurrentPageIndex"].ToString());
                else
                    return 1;
            }
            set
            {
                ViewState["CurrentPageIndex"] = value;
            }
        }

        #endregion

        #endregion

        #region Common

        /// <summary>
        /// Init page
        /// </summary>
        private void InitPage()
        {
            pcBll = new ExchangeRateBLL();
            genericBLL = new Generic<PNK_ExchangeRate>();
            generic2CBLL = new Generic2C<PNK_ExchangeRate, PNK_ExchangeRateDesc>();
            this.template_path = WebUtils.GetWebPath();
            msg_confirm_delete_item = LocalizationUtility.GetText("mesConfirmDelete");
            msg_no_selected_item = LocalizationUtility.GetText("mesSelectItem");
            LocalizationUtility.SetValueControl(this);

            GetMessage();
        }

        /// <summary>
        /// GetList
        /// </summary>
        /// <param name="begin"></param>
        /// <param name="end"></param>
        /// <returns></returns>
        private int GetList(byte langid, string content, string cateId, int begin, int end)
        {
            int total;
            IList<PNK_ExchangeRate> lst = pcBll.GetList(langid, content, string.Empty, cateId, begin, end, out total);
            this.records = DBConvert.ParseString(lst.Count);
            this.pager.PageSize = DBConvert.ParseInt(ConfigurationManager.AppSettings["PageSizeAdminCate"]);
            this.pager.ItemCount = total;
            this.rptResult.DataSource = lst;
            this.rptResult.DataBind();
            return total;
        }

        /// <summary>
        /// action
        /// </summary>
        private void GetAction()
        {
            this.action = Request.Form["task"];
            string cid = Request.Form["cid[]"];
            switch (action)
            {
                case "new":
                    Add();
                    break;
                case "edit":
                    Edit(cid);
                    break;
                case "publish":
                    Change(cid, "1");
                    break;
                case "unpublish":
                    Change(cid, "0");
                    break;
                case "delete":
                    Delete(cid);
                    break;
                case "save":
                    SaveOrder();
                    string url = LinkHelper.GetAdminLink("news");
                    Response.Redirect(url);
                    break;
                case "search":
                    pager.CurrentIndex = 1;
                    this.currentPageIndex = 1;
                    Search();
                    break;
                //default:
                //    show();
                //    break;
            }
        }

        private void Add()
        {
            string url = LinkHelper.GetAdminLink("edit_exchangerate");
            Response.Redirect(url);
        }

        private void Edit(string cid)
        {
            if (cid == null) return;
            string link, url;
            string[] arrStr;
            if (cid.IndexOf(',') >= 0)
            {
                arrStr = cid.Split(',');
                link = LinkHelper.GetAdminLink("edit_exchangerate", arrStr[0]);
                //link = string.Format(SiteNavigation.link_adminPage_editproductcategory, arrStr[0]);
            }
            else
                link = LinkHelper.GetAdminLink("edit_exchangerate", cid);
            Response.Redirect(link);
        }

        /// <summary>
        /// change
        /// </summary>
        /// <param name="cid"></param>
        /// <param name="state"></param>
        private void Change(string cid, string state)
        {
            if (cid != null)
            {
                genericBLL.ChangeWithTransaction(cid, state);
                Search();
            }
        }

        /// <summary>
        /// delete
        /// </summary>
        private void Delete(string cid)
        {
            if (cid != null)
            {

                string link, url;

                if (generic2CBLL.Delete(cid))
                    link = LinkHelper.GetAdminMsgLink("exchangerate", "delete");
                else
                    link = LinkHelper.GetAdminMsgLink("exchangerate", "delfail");
                url = Utils.CombineUrl(template_path, link);
                Response.Redirect(url);

            }
        }

        /// <summary>
        /// saveOrder
        /// </summary>
        private void SaveOrder()
        {
            foreach (RepeaterItem item in rptResult.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    HtmlInputButton btId = (HtmlInputButton)item.FindControl("btId");
                    PNK_ExchangeRate productCat = new PNK_ExchangeRate();
                    productCat.Id = DBConvert.ParseInt(btId.Value);
                    productCat = genericBLL.Load(productCat, new string[] { "Id" });
                    HtmlInputText txtOrder = (HtmlInputText)item.FindControl("txtOrder");
                    if (txtOrder != null)
                    {
                        try
                        {
                            productCat.Ordering = DBConvert.ParseInt(txtOrder.Value);
                            if (productCat.Ordering > 0)
                            {
                                genericBLL.Update(productCat, productCat, new string[] { "Id" });
                            }
                        }
                        catch { }
                    }
                }
            }
        }

        /// <summary>
        /// get msg
        /// </summary>
        private void GetMessage()
        {
            string msg = Utils.GetParameter("msg", string.Empty);
            if (msg == string.Empty) return;
            if (msg == "save")
            {
                this.show_msg = string.Format("<div id=\"Cb-msg\"><div class=\"message\">{0}</div></div>", Constant.UI.admin_msg_save_success);
            }
            else if (msg == "delete")
            {
                this.show_msg = string.Format("<div id=\"Cb-msg\"><div class=\"message\">{0}</div></div>", Constant.UI.admin_msg_delete_success);
            }
        }

        private void Search()
        {
            GetList(1, string.Empty, string.Empty, this.currentPageIndex, DBConvert.ParseInt(ConfigurationManager.AppSettings["PageSizeAdminCate"]));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveOrder();
            string url = Utils.CombineUrl(template_path, LinkHelper.GetAdminLink("exchangerate"));
            Response.Redirect(url);
        }

        private string GetAllChildCategory()
        {
            string arrId = "";
            //ExchangeRateCategoryBLL newsCateBll = new ExchangeRateCategoryBLL();
            //IList<PNK_ExchangeRateCategory> lst = newsCateBll.GetAllChild(DBConvert.ParseInt(drpNewsCategory.SelectedValue), true);
            ////if (lst != null && lst.Count > 0)
            ////{
            ////    foreach (sd_NewsCategory obj in lst)
            ////    {
            ////        arrId += obj.Id + ",";
            ////    }
            ////}
            ////arrId = arrId.EndsWith(",") ? arrId.Remove(arrId.Length - 1, 1) : arrId;
            ////return arrId;
            //arrId = Utils.ArrayToString<PNK_ExchangeRateCategory>((List<PNK_ExchangeRateCategory>)lst, "Id", ",");
            return arrId;// !string.IsNullOrEmpty(arrId) ? arrId : "-1011";
        }

        #endregion

        #region Event

        /// <summary>
        /// init component
        /// </summary>
        override protected void OnInit(EventArgs e)
        {
            //InitializeComponent();
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            GetAction();
            if (!IsPostBack)
            {
                InitializeComponent();
                Search();
            }
        }

        private void InitializeComponent()
        {
            InitPage();
            //this.rptResult.ItemDataBound += new RepeaterItemEventHandler(rptResult_ItemDataBound);
            //search.
        }
        /// <summary>
        /// ItemDataBound
        /// </summary>
        protected void rptResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string img, alt, publishedTask;
                HtmlTableRow tr = (HtmlTableRow)e.Item.FindControl("trList");
                HtmlInputText txt = null;
                if (e.Item.ItemIndex % 2 == 0)
                {

                    tr.Attributes.Add("class", "even");
                }
                else
                {
                    tr.Attributes.Add("class", "old");
                }

                try
                {
                    PNK_ExchangeRate data = (PNK_ExchangeRate)e.Item.DataItem;

                    //Role
                    Literal ltr = null;
                    ltr = (Literal)e.Item.FindControl("ltrchk");
                    ltr.Text = string.Format(@"<INPUT class='txt' TYPE='checkbox' ID='cb{0}' NAME='cid[]' value='{1}' onclick='isChecked(this.checked);' >",
                                                e.Item.ItemIndex, data.Id);

                    //ltrNewsCategory
                    ltr = (Literal)e.Item.FindControl("ltrNewsCategory");


                    //image
                    if (data.Published == "1")
                    {
                        img = "tick.png";
                        alt = LocalizationUtility.GetText(ltrAdminPublish.Text);
                        publishedTask = "unpublish";
                    }
                    else
                    {
                        img = "publish_x.png";
                        alt = LocalizationUtility.GetText(ltrAdminPublish.Text);
                        publishedTask = "publish";
                    }

                    //Order
                    txt = (HtmlInputText)e.Item.FindControl("txtOrder");
                    txt.Value = DBConvert.ParseString(data.Ordering);

                    //Id
                    HtmlInputButton btId = (HtmlInputButton)e.Item.FindControl("btId");
                    btId.Value = DBConvert.ParseString(data.Id);

                    //Base img
                    HtmlImage Image = (HtmlImage)e.Item.FindControl("Image");
                    Image.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ExchangeRateUpload"], data.Image);
                    HtmlAnchor hypImage = (HtmlAnchor)e.Item.FindControl("hypImage");

                    //set link
                    HyperLink hdflink = new HyperLink();
                    hdflink = (HyperLink)e.Item.FindControl("hdflink");
                    hypImage.HRef = hdflink.NavigateUrl = template_path + LinkHelper.GetAdminLink("edit_exchangerate", data.Id);
                    ImageButton imgctr = (ImageButton)e.Item.FindControl("btnPublish");
                    imgctr.ImageUrl = string.Format("/Admin/images/{0}", img);
                    imgctr.Attributes.Add("alt", alt);
                    HtmlTableCell btn = (HtmlTableCell)e.Item.FindControl("tdbtn");
                    btn.Attributes.Add("onclick", string.Format(" return listItemTask('cb{0}', '{1}')", e.Item.ItemIndex, publishedTask));

                    //Name
                    ltr = (Literal)e.Item.FindControl("ltrName");
                    hypImage.Title = ltr.Text = data.ExchangeRateDesc.Title;
                }
                catch { }

            }
        }

        /// <summary>
        /// Pager
        /// <summary>
        public void pager_Command(object sender, CommandEventArgs e)
        {
            this.currentPageIndex = Convert.ToInt32(e.CommandArgument);
            pager.CurrentIndex = this.currentPageIndex;
            Search();
            //this.GetList(1, string.Empty, this.currentPageIndex, Constant.DSC.PageSize);
        }

        #endregion
    }
}