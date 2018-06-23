using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Cb.DBUtility;
using Cb.Model;
using Cb.BLL;
using Cb.Localization;
using Cb.Web;
using Cb.Utility;

namespace Web.Admin.Pages.User
{
    public partial class admin_edituser : System.Web.UI.UserControl
    {
        #region Parameter

        protected string template_path;
        protected string l_btn_save;
        protected string l_btn_apply;
        protected string l_btn_delete;
        protected string l_btn_cancel;
        protected string show_msg;
        //protected string header_name;
        protected string l_publish;
        protected string l_username;
        protected string l_password;
        protected string l_confirmpassword;
        protected string l_name;
        protected string l_email;
        protected string l_phone;
        protected string l_address;
        protected string l_permission;
        protected string l_dept;
        //alert
        protected string msg_confirm_delete_item;

        protected int id = int.MinValue;

        #endregion

        #region Common

        private void LoadDataDropdownlist(DropDownList _drp)
        {
            int total;
            LocationBLL pcBll = new LocationBLL();
            string strTemp;
            _drp.Items.Clear();
            _drp.Items.Add(new ListItem(LocalizationUtility.GetText("enuChat_All_none"), int.MinValue.ToString()));
            IList<PNK_Location> lst = pcBll.GetList(Constant.DB.LangId, string.Empty, 1, 300, out total);
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Location item in lst)
                {
                    strTemp = item.ObjLocDesc.Name;
                    _drp.Items.Add(new ListItem(strTemp, DBConvert.ParseString(item.Id)));
                }
            }
        }

        /// <summary>
        /// InitPage
        /// </summary>
        private void InitPage()
        {
            this.template_path = WebUtils.GetWebPath();

            LocalizationUtility.SetValueControl(this);

            //this.header_name = Constant.UI.admin_users_header_title_edit;
            this.l_btn_apply = Constant.UI.admin_apply;
            this.l_btn_save = Constant.UI.admin_save;
            this.l_btn_delete = Constant.UI.admin_delete;
            this.l_btn_cancel = Constant.UI.admin_cancel;
            //this.l_publish = Constant.UI.admin_publish;
            //this.l_username = Constant.UI.admin_user_username;
            //this.l_password = Constant.UI.admin_user_password;
            //this.l_confirmpassword = Constant.UI.admin_user_confirmpassword;
            //this.l_name = Constant.UI.admin_name;
            //this.l_email = Constant.UI.admin_user_email;
            this.l_phone = Constant.UI.admin_user_phone;
            //this.ltr_Mobile.Text = Constant.UI.admin_user_mobile;
            //this.l_address = Constant.UI.admin_user_address;
            //this.ltr_city.Text = Constant.UI.admin_user_city;
            //this.l_permission = Constant.UI.admin_user_permission_label;
            //this.l_dept = Constant.UI.admin_user_dept;

            //this.ltrNoteUsername.Text = Constant.UI.admin_user_note_username;
            //this.ltrNotePassword.Text = Constant.UI.admin_user_note_psaaword;
            //alert
            this.msg_confirm_delete_item = Constant.UI.admin_msg_confirm_delete_item;
            this.reqv_txtUsername.Text = Constant.UI.alert_empty_username;
            this.reqv_txtPassword.Text = Constant.UI.alert_empty_password;
            this.reqvc_txtConfirmpassword.Text = Constant.UI.alert_empty_password2;
            this.comv_Password.Text = Constant.UI.alert_invalid_password2;
            this.cusv_txtUsername.Text = Constant.UI.alert_empty_username;
            this.reqvc_txtEmail.Text = Constant.UI.alert_empty_email;
            this.regv_Email.Text = Constant.UI.alert_invalid_email;
            this.btn_Delete.Attributes.Add(" OnClientClick", "javascript:return confirmDelete('" + msg_confirm_delete_item + "');");
            this.reqvc_txtFullName.Text = Constant.UI.alert_empty_name_outsite;
            regv_txtPhone.Text = Constant.UI.alert_invalid_phone;
            regv_txtMobile.Text = Constant.UI.alert_invalid_mobile;

            //load data drop down list
            LoadDataDropdownlist(drpCity);
            UserBLL.BindRoleName(drpPermission);

            //Init Validate string
            regv_txtPhone.ValidationExpression = Constant.RegularExpressionString.validatePhone;
            regv_txtMobile.ValidationExpression = Constant.RegularExpressionString.validatePhone;
            regv_Email.ValidationExpression = Constant.RegularExpressionString.validateEmail;

            //Event server validate
            cusv_txtUsername.ServerValidate += new ServerValidateEventHandler(cusv_txtUsername_ServerValidate);
            this.cus_checkPassWord.Text = Constant.UI.msg_account_password_short;

            this.ltrAdminApply.Text = Constant.UI.admin_apply;
            this.ltrAdminCancel.Text = Constant.UI.admin_cancel;
            this.ltrAdminDelete.Text = Constant.UI.admin_delete;
            this.ltrAdminSave.Text = Constant.UI.admin_save;

        }

        private void GetId()
        {
            //get ID param 
            string strID = Utils.GetParameter("cid", string.Empty);
            this.id = strID == string.Empty ? int.MinValue : DBConvert.ParseInt(strID);

            #region Set thuoc tinh cho block_baseimage

            block_baseimage.ImagePath = ConfigurationManager.AppSettings["UserUpload"];
            block_baseimage.MinWidth = ConfigurationManager.AppSettings["minWidthCategory"];
            block_baseimage.MinHeigh = ConfigurationManager.AppSettings["minHeightCategory"];
            block_baseimage.MaxWidth = ConfigurationManager.AppSettings["maxWidthCategory"];
            block_baseimage.MaxHeight = ConfigurationManager.AppSettings["maxHeightCategory"];
            block_baseimage.MaxWidthBox = ConfigurationManager.AppSettings["maxWidthBoxCategory"];
            block_baseimage.MaxHeightBox = ConfigurationManager.AppSettings["maxHeightBoxCategory"];

            #endregion
        }

        /// <summary>
        /// get data for insert update
        /// </summary>
        /// <param name="userObj"></param>
        /// <returns></returns>
        private PNK_User GetDataObject(PNK_User userObj)
        {
            userObj.Published = chkPublished.Checked ? "1" : "0";
            userObj.Username = txtUsername.Value;
            if (txtPassword.Value.Length > 0)
            {
                userObj.Password = Global.ToEncoding(txtPassword.Value);
            }
            userObj.FullName = Server.HtmlEncode(txtFullName.Value);
            userObj.Address = Server.HtmlEncode(txtAddress.Value);
            userObj.Email = txtEmail.Value;
            userObj.Phone = txtPhone.Value;
            userObj.Mobile = txtMobile.Value;
            if (drpCity.SelectedValue != string.Empty)
            {
                userObj.LocationId = DBConvert.ParseInt(drpCity.SelectedValue);
            }
            //Set Role = 3 when no select
            if (drpPermission.SelectedValue != "0")
                userObj.Role = byte.Parse(drpPermission.SelectedValue);
            else
                userObj.Role = 3;
            //if (!string.IsNullOrEmpty(drpDept.SelectedValue))
            //    userObj.DeptId = DBConvert.ParseInt(drpDept.SelectedValue);
            userObj.IsNewsletter = cbxNewsPromo.Checked ? "1" : "0";
            userObj.Image = Session["ImageName"] != null ? Session["ImageName"].ToString() : block_baseimage.ImageName;
            return userObj;
        }

        /// <summary>
        /// Save user
        /// </summary>
        private void SaveUser(int userID)
        {
            PNK_User userObj = new PNK_User();
            Generic<PNK_User> sdUser = new Generic<PNK_User>();
            //truong hop insert
            if (this.id == int.MinValue)
            {
                GetDataObject(userObj);
                userObj.PostDate = DateTime.Now;
                userObj.UpdateDate = DateTime.Now;
                userObj.IsNewsletter = "0";
                //execute
                this.id = sdUser.Insert(userObj);
                //this.id = PNK_User.Insert(userObj);
            }
            else
            {
                string[] fields = { "Id" };
                userObj.Id = this.id;
                userObj = sdUser.Load(userObj, fields);
                GetDataObject(userObj);
                userObj.UpdateDate = DateTime.Now;
                sdUser.Update(userObj, userObj, fields);
            }
        }

        /// <summary>
        /// Show user
        /// </summary>
        private void ShowUser()
        {
            if (this.id != int.MinValue)
            {
                PNK_User userObj = new PNK_User();
                Generic<PNK_User> sdUser = new Generic<PNK_User>();
                string[] fields = { "Id" };
                userObj.Id = this.id;
                userObj = sdUser.Load(userObj, fields);
                this.chkPublished.Checked = userObj.Published == "1" ? true : false;
                this.txtFullName.Value = Server.HtmlDecode(userObj.FullName);
                this.txtUsername.Value = Server.HtmlDecode(userObj.Username);
                this.txtPassword.Value = Global.ToDecoding(Server.HtmlEncode(userObj.Password));
                this.txtConfirmpassword.Value = Global.ToDecoding(Server.HtmlEncode(userObj.Password));
                this.txtEmail.Value = userObj.Email;
                this.txtPhone.Value = userObj.Phone;
                this.txtMobile.Value = userObj.Mobile;
                this.txtAddress.Value = Server.HtmlDecode(userObj.Address);
                this.drpPermission.SelectedValue = userObj.Role.ToString();
                this.drpCity.SelectedValue = userObj.LocationId.ToString();
                //this.drpDept.SelectedValue = userObj.DeptId.ToString();
                this.reqv_txtPassword.Visible = false;
                this.reqvc_txtConfirmpassword.Visible = false;
                this.cusv_txtUsername.Visible = false;

                cbxNewsPromo.Checked = userObj.IsNewsletter == "1" ? true : false;
                block_baseimage.ImageName = userObj.Image;
            }
            else
            {
                this.reqv_txtPassword.Visible = true;
                this.reqvc_txtConfirmpassword.Visible = true;
                this.cusv_txtUsername.Visible = true;
            }
        }

        /// <summary>
        /// Apply user
        /// </summary>
        private void ApplyUser()
        {
            SaveUser(this.id);
        }

        /// <summary>
        /// delete user
        /// </summary>
        /// <param name="cid"></param>
        private void DeleteUser(string cid)
        {
            if (cid != null)
            {
                string link, url;
                Generic<PNK_User> sdUser = new Generic<PNK_User>();
                if (sdUser.Delete(cid))
                    link = LinkHelper.GetAdminMsgLink("user", "delete");
                else
                    link = LinkHelper.GetAdminMsgLink("user", "delfail");
                url = Utils.CombineUrl(template_path, link);
                Response.Redirect(url);
            }
        }

        /// <summary>
        /// Cancel user
        /// </summary>
        private void CancelUser()
        {
            Response.Redirect(LinkHelper.GetAdminLink("user"));

        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            btn_Delete.Attributes["onclick"] = string.Format("javascript:return confirm('{0}');", Constant.UI.admin_msg_confirm_delete_item);

            //check role
            PNK_User user = (PNK_User)Session[Global.SESS_USER];
            if (user != null && user.Role != DBConvert.ParseInt(Constant.Security.AdminRoleValue))
            {
                Response.Redirect(LinkHelper.GetAdminLink("home"));
            }
            //end
            GetId();
            InitPage();
            if (!IsPostBack)
            {
                LocalizationUtility.SetValueControl(this);
                ShowUser();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                ApplyUser();
                Response.Redirect(LinkHelper.GetAdminMsgLink("user", "save"));
            }
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                ApplyUser();
                Response.Redirect(LinkHelper.GetAdminLink("edit_user", this.id));
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            DeleteUser(DBConvert.ParseString(this.id));
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            CancelUser();
        }

        void cusv_txtUsername_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!UserBLL.CheckValidUsername(txtUsername.Value))
            {
                args.IsValid = false;
                ((CustomValidator)source).Text = Constant.UI.alert_invalid_username;
            }
        }

        #endregion
    }
}