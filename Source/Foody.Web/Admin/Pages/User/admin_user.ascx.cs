using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Cb.Model;
using Cb.DBUtility;
using Cb.BLL;
using Cb.Localization;
using Cb.Utility;
using System.Configuration;

namespace Cb.Web.Admin.Pages.User
{
    public partial class admin_user : System.Web.UI.UserControl
    {
        #region Prameter

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
        private Cb.BLL.UserBLL pcBll
        {
            get
            {
                if (ViewState["pcBll"] != null)
                    return (UserBLL)ViewState["pcBll"];
                else return new UserBLL();
            }
            set
            {
                ViewState["pcBll"] = value;
            }
        }
        private Generic<PNK_User> genericBLL
        {
            get
            {
                if (ViewState["genericBLLget"] != null)
                    return (Generic<PNK_User>)ViewState["genericBLLget"];
                else return new Generic<PNK_User>();
            }
            set
            {
                ViewState["genericBLLget"] = value;
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
            pcBll = new UserBLL();
            genericBLL = new Generic<PNK_User>();
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
        private int GetList(byte langid, string content, int begin, int end)
        {
            int total;
            IList<PNK_User> lst = pcBll.GetList(content, string.Empty, begin, end, out total);
            this.records = DBConvert.ParseString(lst.Count);
            this.pager.PageSize = 50;
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
            string url = LinkHelper.GetAdminLink("edit_user");
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
                link = LinkHelper.GetAdminLink("edit_user", arrStr[0]);
                //link = string.Format(SiteNavigation.link_adminPage_editproductcategory, arrStr[0]);
            }
            else
                link = LinkHelper.GetAdminLink("edit_user", cid);
            Response.Redirect(link);
        }

        /// <summary>
        /// Change
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
        /// Delete
        /// </summary>
        private void Delete(string cid)
        {
            if (cid != null)
            {
                string link, url;
                if (genericBLL.Delete(cid))
                    link = LinkHelper.GetAdminMsgLink("user", "Delete");
                else
                    link = LinkHelper.GetAdminMsgLink("user", "delfail");
                url = Utils.CombineUrl(template_path, link);
                Response.Redirect(url);
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
                this.show_msg = string.Format("<div id=\"dgc-msg\"><div class=\"message\">{0}</div></div>", Constant.UI.admin_msg_save_success);
            }
            else if (msg == "Delete")
            {
                this.show_msg = string.Format("<div id=\"dgc-msg\"><div class=\"message\">{0}</div></div>", Constant.UI.admin_msg_delete_success);
            }
        }

        private void Search()
        {
            string strSearch = Request.Form[search.ClientID.Replace('_', '$')];
            this.search.Value = strSearch;
            this.search.Value = strSearch;
            strSearch = strSearch == null ? string.Empty : Utils.RemoveUnicode(SanitizeHtml.Sanitize(strSearch)).ToLower();
            GetList(1, strSearch, this.currentPageIndex, 50);
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            GetAction();
            if (!IsPostBack)
            {
                InitializeComponent();
                Search();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string url = Utils.CombineUrl(template_path, LinkHelper.GetAdminLink("user"));
            Response.Redirect(url);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Search();
            //rptResult.DataBind();
        }
        /// <summary>
        /// init component
        /// </summary>
        override protected void OnInit(EventArgs e)
        {
            //InitializeComponent();
            base.OnInit(e);
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
                    PNK_User data = (PNK_User)e.Item.DataItem;

                    //Role
                    Literal ltr = null;
                    ltr = (Literal)e.Item.FindControl("ltrchk");
                    ltr.Text = string.Format(@"<INPUT class='txt' TYPE='checkbox' ID='cb{0}' NAME='cid[]' value='{1}' onclick='isChecked(this.checked);' >",
                                                e.Item.ItemIndex, data.Id);
                    //Name
                    ltr = (Literal)e.Item.FindControl("ltrUserName");
                    ltr.Text = data.Username; //Server.HtmlDecode(getScmplit(data.Lvl) + "&bull; | " + data.Lvl + " | " + data.ProductCategoryDesc.Name);
                    //ltr.Text=
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
                        alt = LocalizationUtility.GetText(ltrAminUnPublish.Text);
                        publishedTask = "publish";
                    }

                    //Id
                    HtmlInputButton btId = (HtmlInputButton)e.Item.FindControl("btId");
                    btId.Value = DBConvert.ParseString(data.Id);

                    //Base img
                    HtmlImage baseImage = (HtmlImage)e.Item.FindControl("baseImage");
                    baseImage.Src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["UserUpload"], data.Image);
                    HtmlAnchor hypBaseImage = (HtmlAnchor)e.Item.FindControl("hypBaseImage");

                    //set link
                    string listItemTask = string.Format("listItemTask('cb{0}', 'edit')", e.Item.ItemIndex);
                    HtmlTableCell td = (HtmlTableCell)e.Item.FindControl("tdName");
                    td.Attributes.Add("onclick", listItemTask);
                    td = (HtmlTableCell)e.Item.FindControl("trUpdateDate");
                    td.Attributes.Add("onclick", listItemTask);
                    td = (HtmlTableCell)e.Item.FindControl("trBaseImage");
                    td.Attributes.Add("onclick", listItemTask);


                    ImageButton imgctr = (ImageButton)e.Item.FindControl("btnPublish");
                    imgctr.ImageUrl = string.Format("/Admin/images/{0}", img);
                    imgctr.Attributes.Add("alt", alt);

                    HtmlTableCell btn = (HtmlTableCell)e.Item.FindControl("tdbtn");
                    btn.Attributes.Add("onclick", string.Format(" return listItemTask('cb{0}', '{1}')", data.Id, publishedTask));

                    //Fullname
                    ltr = (Literal)e.Item.FindControl("ltrFullName");
                    ltr.Text = data.FullName;

                    //phone
                    ltr = (Literal)e.Item.FindControl("ltrPhone");
                    ltr.Text = data.Phone;

                    //address
                    ltr = (Literal)e.Item.FindControl("ltrAddress");
                    ltr.Text = data.Address;

                    //location
                    ltr = (Literal)e.Item.FindControl("ltrLocation");
                    ltr.Text = data.LocationDesc;

                    //role
                    ltr = (Literal)e.Item.FindControl("ltrRole");
                    ltr.Text = UserBLL.GetRoleName(data.Role);


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
            this.GetList(1, string.Empty, this.currentPageIndex, 50);
        }

        #endregion
    }
}