using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Model;
using Cb.DBUtility;
using Cb.BLL;
using Cb.Localization;
using System.Data;
using System.IO;
using System.Configuration;
using Cb.Utility;
using Cb.BLL.GenControl;
using System.Web.UI.HtmlControls;

namespace Cb.Web.Admin.Pages.Config
{
    public partial class admin_page : System.Web.UI.UserControl
    {
        #region Parameter

        protected string template_path;

        private string filenameUploadHeader
        {
            get
            {
                if (ViewState["filenameUploadHeader"] != null)
                    return ViewState["filenameUploadHeader"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["filenameUploadHeader"] = value;
            }
        }

        private string filenameUploadFooter
        {
            get
            {
                if (ViewState["filenameUploadFooter"] != null)
                    return ViewState["filenameUploadFooter"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["filenameUploadFooter"] = value;
            }
        }

        private string filenameUploadLocation
        {
            get
            {
                if (ViewState["filenameUploadLocation"] != null)
                    return ViewState["filenameUploadLocation"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["filenameUploadLocation"] = value;
            }
        }

        int total;

        #endregion

        #region Common

        private void InitPage()
        {
            LocalizationUtility.SetValueControl(this);

            this.template_path = WebUtils.GetWebPath();
            this.regv_Email.ErrorMessage = Constant.UI.alert_invalid_email;

            //Init Validate string
            regv_Email.ValidationExpression = Constant.RegularExpressionString.validateEmail;

            ShowConfig();
            GetLoopControl();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="isShowUplImg"></param>
        /// <param name="filename"></param>
        private void SetVisibleImg(bool isShowUplImg, string filename, FileUpload fuImage, Button btnUploadImage, LinkButton lbnView, LinkButton lbnDelete)
        {
            if (isShowUplImg)
            {
                fuImage.Visible = true;
                btnUploadImage.Visible = true;
                lbnView.Visible = false;
                lbnDelete.Visible = false;
            }
            else
            {
                fuImage.Visible = false;
                btnUploadImage.Visible = false;
                lbnView.Attributes["href"] = filename;
                lbnView.Visible = true;
                lbnDelete.Visible = true;
            }
        }

        /// <summary>
        /// ShowConfig
        /// </summary>
        /// 
        private void ShowConfig()
        {
            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            foreach (PNK_Configuration item in lst)
            {
                if (item.Key_name == Constant.Configuration.sitename)
                {
                    this.txt_config_sitename.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.email)
                {
                    this.txt_config_email.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.phone)
                {
                    this.txt_config_phone.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.fax)
                {
                    this.txtFax.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.skypeid)
                {
                    this.txtSkype.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.yahooid)
                {
                    this.editContact.Text = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_address_vi)
                {
                    this.txtAddress.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_address1_vi)
                {
                    this.txtAddress1.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_company_name_vi)
                {
                    this.txtCompanyName.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_company_name_en)
                {
                    this.txtCompanyNameEng.Value = item.Value_name;
                }

                else if (item.Key_name == Constant.Configuration.config_title)
                {
                    this.txtTitle.Value = item.Value_name;
                }

                else if (item.Key_name == Constant.Configuration.config_metaDescription)
                {
                    this.txtMetaDescription.Value = item.Value_name;
                }

                else if (item.Key_name == Constant.Configuration.config_metaKeyword)
                {
                    this.txtMetaKeyword.Value = item.Value_name;
                }

                else if (item.Key_name == Constant.Configuration.config_fbfanpage)
                {
                    this.txtFacebook.Value = item.Value_name;
                }

                else if (item.Key_name == Constant.Configuration.config_googleplus)
                {
                    this.txtGooglePlus.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_twitter)
                {
                    this.txtTwitter.Value = item.Value_name;
                }

                else if (item.Key_name == Constant.Configuration.config_h1)
                {
                    this.txtH1.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_h2)
                {
                    this.txtH2.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_h3)
                {
                    this.txtH3.Value = item.Value_name;
                }

                else if (item.Key_name == Constant.Configuration.config_analytic)
                {
                    this.txtAnalytic.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_fblike)
                {
                    this.txtLikePage.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_vchat)
                {
                    this.txtVChat.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_linkedIn)
                {
                    this.txtLinkedIn.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_pinterest)
                {
                    this.txtPinterest.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_reddit)
                {
                    this.txtreddit.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_fbfanpageLarge)
                {
                    this.txtFBFooter.Value = item.Value_name;
                }

                else if (item.Key_name == Constant.Configuration.config_logoHeader)
                {
                    filenameUploadHeader = item.Value_name;
                    if (!string.IsNullOrEmpty(filenameUploadHeader))
                        SetVisibleImg(false, string.Format("{0}/{1}", ConfigurationManager.AppSettings["LogoUpload"], filenameUploadHeader), fuImageHeader, btnUploadImageHeader, lbnViewHeader, lbnDeleteHeader);
                    else
                        SetVisibleImg(true, string.Empty, fuImageHeader, btnUploadImageHeader, lbnViewHeader, lbnDeleteHeader);
                }

                else if (item.Key_name == Constant.Configuration.config_logoFooter)
                {
                    filenameUploadFooter = item.Value_name;
                    if (!string.IsNullOrEmpty(filenameUploadFooter))
                        SetVisibleImg(false, string.Format("{0}/{1}", ConfigurationManager.AppSettings["LogoUpload"], filenameUploadFooter), fuImageFooter, btnUploadImageFooter, lbnViewFooter, lbnDeleteFooter);
                    else
                        SetVisibleImg(true, string.Empty, fuImageFooter, btnUploadImageFooter, lbnViewFooter, lbnDeleteFooter);
                }

                else if (item.Key_name == "config_location")
                {
                    filenameUploadLocation = item.Value_name;
                    if (!string.IsNullOrEmpty(filenameUploadLocation))
                        SetVisibleImg(false, string.Format("{0}/{1}", ConfigurationManager.AppSettings["LogoUpload"], filenameUploadLocation), fuLocation, btnUploadLocation, lbnViewLocation, lbnDeleteLocation);
                    else
                        SetVisibleImg(true, string.Empty, fuLocation, btnUploadLocation, lbnViewLocation, lbnDeleteLocation);
                }

                else if (item.Key_name == Constant.Configuration.config_latitude)//Vĩ độ
                {
                    this.txtLatitude.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_longitude)//Kinh độ
                {
                    this.txtLongitude.Value = item.Value_name;
                }
                else if (item.Key_name == Constant.Configuration.config_footer)//footer
                {
                    this.editFooter.Text = item.Value_name;
                }
            }
        }

        /// <summary>
        /// SaveConfig
        /// </summary>
        private void SaveConfig()
        {
            //Xoá cache trước khi lưu
            CacheHelper.ClearContains("Configuration");

            ConfigurationBLL cgBLL = new ConfigurationBLL();
            cgBLL.SaveConfig(
                txt_config_email.Value.Trim(), txt_config_phone.Value.Trim(), txt_config_sitename.Value.Trim(), txtFax.Value.Trim(), txtSkype.Value.Trim()
                , editContact.Text, txtCompanyName.Value.Trim(), txtCompanyNameEng.Value.Trim(), txtAddress.Value.Trim(), txtAddress1.Value.Trim(), filenameUploadHeader, filenameUploadFooter
                , filenameUploadLocation, txtTitle.Value.Trim(), txtMetaDescription.Value.Trim(), txtMetaKeyword.Value.Trim(), txtFacebook.Value.Trim()
                , txtGooglePlus.Value.Trim(), txtTwitter.Value.Trim(), txtH1.Value.Trim(), txtH2.Value.Trim(), txtH3.Value.Trim(), txtAnalytic.Value.Trim()
                , txtLikePage.Value.Trim(), txtVChat.Value.Trim(), txtLatitude.Value.Trim(), txtLongitude.Value.Trim(), editFooter.Text
                , txtLinkedIn.Value.Trim(), txtPinterest.Value.Trim(), txtreddit.Value.Trim(), txtFBFooter.Value.Trim()
                );

            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('{0}','Message');", Constant.UI.admin_msg_save_success), true);

        }

        /// <summary>
        /// CancelConfig
        /// </summary>
        private void CancelConfig()
        {
            ShowConfig();
        }

        /// <summary>
        /// Lặp để lấy attribute
        /// </summary>
        private void GetLoopControl()
        {
            try
            {
                GenControlBLL genControlBLL = new GenControlBLL();
                IList<PNK_GenControl> lstAll = genControlBLL.GetList(int.MinValue, string.Empty, "1", string.Empty, DBConvert.ParseInt(ConfigurationManager.AppSettings["genControlPageID"]), 1, true, "Ordering", 1
                , 9999, out total);
                lstAll = lstAll.Where(m => m.ParentId != 0).ToList();
                if (lstAll.Count > 0)
                {
                    rptGenControlVn.DataSource = lstAll.Where(m => m.GenControlDesc.LangId == 1).ToList();
                    rptGenControlVn.DataBind();

                    rptGenControlEng.DataSource = lstAll.Where(m => m.GenControlDesc.LangId == 2).ToList();
                    rptGenControlEng.DataBind();
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("SetLoopControl", "admin_editproduct", ex.Message);
            }
        }

        private void SaveLoopControl()
        {
            try
            {
                //Loop control tiếng Việt
                foreach (RepeaterItem item in rptGenControlVn.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        HtmlInputText txtContent = (HtmlInputText)item.FindControl("txtContent");
                        string dynamicId = txtContent.Attributes["dynamicId"];

                        //Get old obj
                        PNK_GenControlDesc objVnOld = new PNK_GenControlDesc();
                        Generic<PNK_GenControlDesc> genControlDesc = new Generic<PNK_GenControlDesc>();
                        string[] fields = { "MainId", "LangId" };
                        objVnOld.MainId = DBConvert.ParseInt(dynamicId);
                        objVnOld.LangId = Constant.DB.LangId;
                        objVnOld = genControlDesc.Load(objVnOld, fields);

                        //Get current obj
                        PNK_GenControlDesc objVnNew = new PNK_GenControlDesc();
                        objVnNew = objVnOld;
                        objVnNew.MainId = DBConvert.ParseInt(dynamicId);
                        objVnNew.Value = txtContent.Value;

                        //excute                      
                        genControlDesc.Update(objVnOld, objVnNew, fields);
                    }
                }

                //Loop control tiếng Anh
                foreach (RepeaterItem item in rptGenControlEng.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        HtmlInputText txtContent = (HtmlInputText)item.FindControl("txtContent");
                        string dynamicId = txtContent.Attributes["dynamicId"];

                        //Get old obj
                        PNK_GenControlDesc objEngOld = new PNK_GenControlDesc();
                        Generic<PNK_GenControlDesc> genControlDesc = new Generic<PNK_GenControlDesc>();
                        string[] fields = { "MainId", "LangId" };
                        objEngOld.MainId = DBConvert.ParseInt(dynamicId);
                        objEngOld.LangId = Constant.DB.LangId_En;
                        objEngOld = genControlDesc.Load(objEngOld, fields);

                        //Get current obj
                        PNK_GenControlDesc objEngNew = new PNK_GenControlDesc();
                        objEngNew = objEngOld;
                        objEngNew.MainId = DBConvert.ParseInt(dynamicId);
                        objEngNew.Value = txtContent.Value;

                        //excute                      
                        genControlDesc.Update(objEngOld, objEngNew, fields);
                    }
                }
            }
            catch (Exception ex)
            {

                //throw;
            }
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            //check role
            PNK_User user = (PNK_User)Session[Global.SESS_USER];
            if (user != null && user.Role != DBConvert.ParseByte(Constant.Security.AdminRoleValue))
            {
                Response.Redirect(LinkHelper.GetAdminLink("home"));
            }
            //end

            if (!this.IsPostBack)
            {
                InitPage();
                this.ltrAdminSave.Text = Constant.UI.admin_save;
                LocalizationUtility.SetValueControl(this);
            }
        }

        /// <summary>
        /// btnSave_Click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                CacheHelper.Clear("Configuration_GetList_" + WebUtils.CurrentUserIP);
                SaveConfig();

                //Save loop attribute
                SaveLoopControl();
            }
        }

        protected void btnUploadImageHeader_Click(object sender, EventArgs e)
        {
            try
            {
                if (fuImageHeader.HasFile)
                {
                    filenameUploadHeader = string.Format("{0}.{1}", DateTime.Now.Ticks + GenerateString.Generate(5), fuImageHeader.FileName.Split('.')[1]);
                    fuImageHeader.SaveAs(Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["LogoUpload"]), filenameUploadHeader));
                    SetVisibleImg(false, string.Format("{0}/{1}", ConfigurationManager.AppSettings["LogoUpload"], filenameUploadHeader), fuImageHeader, btnUploadImageHeader, lbnViewHeader, lbnDeleteHeader);
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("admin_editnews", "btnUploadImageHeader_Click", ex.ToString());
            }
        }

        protected void btnUploadImageFooter_Click(object sender, EventArgs e)
        {
            try
            {
                if (fuImageFooter.HasFile)
                {
                    filenameUploadFooter = string.Format("{0}.{1}", DateTime.Now.Ticks + GenerateString.Generate(5), fuImageFooter.FileName.Split('.')[1]);
                    fuImageFooter.SaveAs(Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["LogoUpload"]), filenameUploadFooter));
                    SetVisibleImg(false, string.Format("{0}/{1}", ConfigurationManager.AppSettings["LogoUpload"], filenameUploadFooter), fuImageFooter, btnUploadImageFooter, lbnViewFooter, lbnDeleteFooter);
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("admin_editnews", "btnUploadImageFooter_Click", ex.ToString());
            }
        }

        protected void btnUploadLocation_Click(object sender, EventArgs e)
        {
            try
            {
                if (fuLocation.HasFile)
                {
                    filenameUploadLocation = string.Format("{0}.{1}", DateTime.Now.Ticks + GenerateString.Generate(5), fuLocation.FileName.Split('.')[1]);
                    fuLocation.SaveAs(Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["LogoUpload"]), filenameUploadLocation));
                    SetVisibleImg(false, string.Format("{0}/{1}", ConfigurationManager.AppSettings["LogoUpload"], filenameUploadLocation), fuLocation, btnUploadLocation, lbnViewLocation, lbnDeleteLocation);
                }
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("admin_editnews", "btnUploadLocation_Click", ex.ToString());
            }
        }

        protected void lbnDeleteImageHeader_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(filenameUploadHeader))
            {
                string path = Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["LogoUpload"]), filenameUploadHeader);
                if (File.Exists(path))
                    File.Delete(path);
                SetVisibleImg(true, string.Empty, fuImageHeader, btnUploadImageHeader, lbnViewHeader, lbnDeleteHeader);
            }
        }

        protected void lbnDeleteImageFooter_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(filenameUploadFooter))
            {
                string path = Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["LogoUpload"]), filenameUploadFooter);
                if (File.Exists(path))
                    File.Delete(path);
                SetVisibleImg(true, string.Empty, fuImageFooter, btnUploadImageFooter, lbnViewFooter, lbnDeleteFooter);
            }
        }

        protected void lbnDeleteLocation_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(filenameUploadLocation))
            {
                string path = Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["LogoUpload"]), filenameUploadLocation);
                if (File.Exists(path))
                    File.Delete(path);
                SetVisibleImg(true, string.Empty, fuLocation, btnUploadLocation, lbnViewLocation, lbnDeleteLocation);
            }
        }

        protected void rptGenControl_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_GenControl data = (PNK_GenControl)e.Item.DataItem;

                Literal ltrName = e.Item.FindControl("ltrName") as Literal;
                ltrName.Text = data.GenControlDesc.Name;

                HtmlInputText txtContent = (HtmlInputText)e.Item.FindControl("txtContent");
                txtContent.Attributes.Add("dynamicId", data.GenControlDesc.Id.ToString());
                txtContent.Value = data.GenControlDesc.Value;
            }
        }

        #endregion
    }
}