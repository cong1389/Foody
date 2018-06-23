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
    public partial class block_baseimage : DGCUserControl
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
            hddImageName.Value = ImageName;

            string url = string.Format("{0}/{1}", ImagePath, ImageName);
            url = WebUtils.GetUrlImage(ImagePath, ImageName);
            url = Utils.CombineUrl(WebUtils.GetBaseUrl(), url);
            if (!string.IsNullOrEmpty(url))
            {
                imgToCrop.ImageUrl = url;
                btnRemove.Visible = true;
            }            
        }

        private void SetSizeCrop()
        {
            minSize = string.Format("minSize: [ {0}, {1} ]", MinWidth, MinHeigh);
            maxSize = string.Format("maxSize: [ {0}, {1} ]", MaxWidth, MaxHeight);
            setSelect = string.Format("setSelect: [ {0}, {1}, {2}, {3} ]", 0, 0, MaxWidthBox, MaxHeightBox);
        }

        private string ResizeImage(string originalPath, string originalFileName, int maximumWidth, int maximumHeight, bool enforceRatio, bool addPadding)
        {
            string path = Path.Combine(Server.MapPath(originalPath), originalFileName).Replace("\\", "/");

            System.Drawing.Image image = System.Drawing.Image.FromFile(path);
            var imageEncoders = ImageCodecInfo.GetImageEncoders();
            EncoderParameters encoderParameters = new EncoderParameters(1);
            encoderParameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
            var canvasWidth = maximumWidth;
            var canvasHeight = maximumHeight;
            var newImageWidth = maximumWidth;
            var newImageHeight = maximumHeight;
            var xPosition = 0;
            var yPosition = 0;

            if (enforceRatio)
            {
                var ratioX = maximumWidth / (double)image.Width;
                var ratioY = maximumHeight / (double)image.Height;
                var ratio = ratioX < ratioY ? ratioX : ratioY;
                newImageHeight = (int)(image.Height * ratio);
                newImageWidth = (int)(image.Width * ratio);

                if (addPadding)
                {
                    xPosition = (int)((maximumWidth - (image.Width * ratio)) / 2);
                    yPosition = (int)((maximumHeight - (image.Height * ratio)) / 2);
                }
                else
                {
                    canvasWidth = newImageWidth;
                    canvasHeight = newImageHeight;
                }
            }

            var thumbnail = new Bitmap(canvasWidth, canvasHeight);
            var graphic = Graphics.FromImage(thumbnail);

            if (enforceRatio && addPadding)
            {
                graphic.Clear(Color.White);
            }

            graphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphic.SmoothingMode = SmoothingMode.HighQuality;
            graphic.PixelOffsetMode = PixelOffsetMode.HighQuality;
            graphic.CompositingQuality = CompositingQuality.HighQuality;
            graphic.DrawImage(image, xPosition, yPosition, newImageWidth, newImageHeight);

            string newFileName = originalFileName.Replace(".", "_R.");
            string pathNew = Path.Combine(Server.MapPath(originalPath), newFileName).Replace("\\", "/");

            thumbnail.Save(pathNew, imageEncoders[1], encoderParameters);
            image.Dispose();

            return newFileName;
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

        protected void FileUploadComplete(object sender, EventArgs e)
        {
            string fileName = System.IO.Path.GetFileName(AsyncFileUpload1.FileName);

            SetSizeCrop();

            string filePath = string.Empty;
            string extension = string.Empty;
            string fileNameUpload = string.Empty;
            try
            {
                //Xóa image cũ trước khi upload image mới
                string pathImageOld = Path.Combine(Server.MapPath(ImagePath), ImageName);
                if (File.Exists(pathImageOld))
                {
                    File.Delete(pathImageOld);
                }

                // Get selected image extension
                extension = Path.GetExtension(fileName).ToLower();
                if (fileName != null)
                {
                    fileNameUpload = string.Format("{0}{1}{2}", fileName.Split('.')[0], DateTime.Now.ToString("ddMMyyyyhhmmss"), extension);

                    filePath = Path.Combine(Server.MapPath(ImagePath), fileNameUpload);
                    //Check image is of valid type or not
                    if (extension == ".jpg" || extension == ".jpeg" || extension == ".png" || extension == ".gif" || extension == ".bmp")
                    {
                        //Upload bằng AsyncFileUpload
                        AsyncFileUpload1.SaveAs(filePath);

                        if (chkDefault.Checked)
                        {
                            Session["ImageName"] = "";
                            Session["ImageName"] = fileNameUpload;

                            string url = string.Format("{0}/{1}", ImagePath, fileNameUpload);

                            ScriptManager.RegisterClientScriptBlock(AsyncFileUpload1, this.GetType(), "newfile"
        , "window.parent.$find('" + AsyncFileUpload1.ClientID + "').newFileName='" + fileNameUpload + "|" + url + "';", true);

                        }
                        else
                        {
                            //Resize image và kết quả trả về tên hình sau khi resize
                            string fileNameNew = chkDefault.Checked == false ? ResizeImage(ImagePath, fileNameUpload, DBConvert.ParseInt(MaxWidth), DBConvert.ParseInt(MaxHeight), false, false) : fileNameUpload;
                            Session["ImageName"] = "";
                            Session["ImageName"] = ImageName = fileNameNew;

                            string url = string.Format("{0}/{1}", ImagePath, fileNameNew);

                            ScriptManager.RegisterClientScriptBlock(AsyncFileUpload1, this.GetType(), "newfile"
        , "window.parent.$find('" + AsyncFileUpload1.ClientID + "').newFileName='" + fileNameNew + "|" + url + "';", true);

                            //Xóa image AsyncFileUpload                        
                            File.Delete(filePath);
                        }
                    }
                    else
                    {
                        lblMsg.Text = "Please select jpg, jpeg, png, gif or bmp file only";
                    }
                }
                else
                {
                    lblMsg.Text = "Please select file to upload";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Oops!! error occured : " + ex.Message.ToString();
            }
            finally
            {
                extension = string.Empty;
            }
        }

        #endregion
    }
}