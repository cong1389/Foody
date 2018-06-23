using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using Cb.Utility;
using Cb.BLL;
using Cb.Model;
using Cb.DBUtility;
using System.Configuration;
using AjaxControlToolkit;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

namespace Cb.Web.Admin.Controls
{
    public partial class block_uploadfile : System.Web.UI.UserControl
    {
        #region Parameter

        protected string minSize, maxSize, setSelect, urlImage;

        public string MinWidth
        {
            get
            {
                if (ViewState["MinWidth"] != null)
                    return ViewState["MinWidth"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["MinWidth"] = value;
            }
        }
        public string MinHeigh
        {
            get
            {
                if (ViewState["MinHeigh"] != null)
                    return ViewState["MinHeigh"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["MinHeigh"] = value;
            }
        }

        public string MaxWidth
        {
            get
            {
                if (ViewState["MaxWidth"] != null)
                    return ViewState["MaxWidth"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["MaxWidth"] = value;
            }
        }
        public string MaxHeight
        {
            get
            {
                if (ViewState["MaxHeight"] != null)
                    return ViewState["MaxHeight"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["MaxHeight"] = value;
            }
        }

        public string MaxWidthBox
        {
            get
            {
                if (ViewState["MaxWidthBox"] != null)
                    return ViewState["MaxWidthBox"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["MaxWidthBox"] = value;
            }
        }
        public string MaxHeightBox
        {
            get
            {
                if (ViewState["MaxHeightBox"] != null)
                    return ViewState["MaxHeightBox"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["MaxHeightBox"] = value;
            }
        }

        public string ImageName
        {
            get
            {
                if (ViewState["ImageName"] != null)
                    return ViewState["ImageName"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["ImageName"] = value;
            }
        }
        public string ImagePath
        {
            get
            {
                if (ViewState["ImagePath"] != null)
                {
                    return ViewState["ImagePath"].ToString();
                }
                else
                    return string.Empty;
            }
            set
            {
                ViewState["ImagePath"] = value;
            }
        }

        //private string pathImageOld
        //{
        //    get
        //    {
        //        if (ViewState["pathImageOld"] != null)
        //            return ViewState["pathImageOld"].ToString();
        //        else
        //            return string.Empty;
        //    }
        //    set
        //    {
        //        ViewState["pathImageOld"] = value;
        //    }
        //}

        #endregion

        #region Common

        private void InitPage()
        {
            hddNameFileUpload.Value = ImageName;
            if (!string.IsNullOrEmpty(ImageName))
            {
                txtFilename.Text = ImageName;
            }
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

        protected void FileUpload1_OnUploadedComplete(object sender, EventArgs e)
        {
            string fileName = System.IO.Path.GetFileName(fileUpload1.FileName);

            string filePath = string.Empty;
            string extension = string.Empty;
            string fileNameUpload = string.Empty;
            try
            {
                extension = Path.GetExtension(fileName).ToLower();
                if (fileName != null)
                {
                    fileNameUpload = string.Format("{0}{1}{2}", fileName.Split('.')[0], DateTime.Now.ToString("ddMMyyyyhhmmss"), extension);

                    filePath = Path.Combine(Server.MapPath(ConfigurationManager.AppSettings["ProductUpload"]), fileNameUpload);
                    //Check image is of valid type or not
                    if (extension == ".pdf" || extension == ".doc" || extension == ".docx")
                    {
                        //Upload bằng AsyncFileUpload
                        fileUpload1.SaveAs(filePath);

                        Session["ImageName"] = "";
                        Session["ImageName"] = fileNameUpload;

                        string url = string.Format("{0}/{1}", ImagePath, fileNameUpload);

                        ScriptManager.RegisterClientScriptBlock(fileUpload1, this.GetType(), "newfile1"
                        , "window.parent.$find('" + fileUpload1.ClientID + "').newFileName1='" + fileNameUpload + "|" + url + "';", true);
                    }
                }
                else
                {
                    // lblMsg.Text = "Please select file to upload";
                }
            }
            catch (Exception ex)
            {
                // lblMsg.Text = "Oops!! error occured : " + ex.Message.ToString();
            }
            finally
            {
                extension = string.Empty;
            }
        }

        #endregion
    }
}