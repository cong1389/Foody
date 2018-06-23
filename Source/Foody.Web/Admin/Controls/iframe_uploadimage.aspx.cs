using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.BLL;
using Cb.Model;
using System.IO;
using Cb.DBUtility;
using Cb.Utility;
using Cb.Model.Products;
using Cb.Localization;
using System.Configuration;
using AjaxControlToolkit;

namespace Cb.Web.Admin.Controls
{
    public partial class iframe_uploadimage : System.Web.UI.Page
    {
        #region Parameter

        IList<PNK_UploadImage> lst;

        int total, idImage = int.MinValue, productId = int.MinValue;

        protected string template_path;

        public string CategoryId
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

        public string Id
        {
            get
            {
                if (ViewState["Id"] != null)
                    return ViewState["Id"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["Id"] = value;
            }
        }

        public string ImagePath
        {
            get
            {
                if (ViewState["ImagePath"] != null)
                    return ViewState["ImagePath"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["ImagePath"] = value;
            }
        }

        private string fileNameUpload
        {
            get
            {
                if (ViewState["fileNameUpload"] != null)
                    return ViewState["fileNameUpload"].ToString();
                else
                    return string.Empty;
            }
            set
            {
                ViewState["fileNameUpload"] = value;
            }
        }

        #endregion

        #region Common

        private void GetId()
        {
            CategoryId = DBConvert.ParseString(Session["CategoryId"]);
            Id = DBConvert.ParseString(Session["ID"]);
            ImagePath = DBConvert.ParseString(Session["ImagePath"]);

            this.idImage = productId = Id == string.Empty ? DBConvert.ParseInt(CategoryId) : DBConvert.ParseInt(Id);
            this.template_path = WebUtils.GetWebPath();
        }

        private void BindAlbum(int productId)
        {
            UploadImageBLL bll = new UploadImageBLL();
            lst = bll.GetList(string.Empty, productId.ToString(), "1", 1, 100, out  total);
            //if (total > 0)
            //{
            grdImage.DataSource = lst;
            grdImage.DataBind();
            //}
        }

        /// <summary>
        /// get data for insert update
        /// </summary>
        /// <param name="userObj"></param>
        /// <returns></returns>
        private PNK_UploadImage GetDataObjectParent(PNK_UploadImage productcatObj)
        {
            HttpFileCollection attachments = Request.Files;
            for (int i = 0; i < attachments.Count; i++)
            {
                HttpPostedFile attachment = attachments[i];
                if (attachment.ContentLength > 0 && !String.IsNullOrEmpty(attachment.FileName))
                {
                    productcatObj.Published = "1";
                    productcatObj.Updatedate = DateTime.Now;
                    productcatObj.Name = attachment.FileName;
                    productcatObj.ImagePath = ImagePath;
                }
            }
            return productcatObj;
        }

        /// <summary>
        /// Save location
        /// </summary>
        private int SaveNewsCategory()
        {
            GetId();

            PNK_UploadImage productcatObj = new PNK_UploadImage();
            Generic<PNK_UploadImage> genericBLL = new Generic<PNK_UploadImage>();

            if (idImage == int.MinValue)
            {
                //Get max id medical_product
                DBLibrary db = new DBLibrary();
                productId = db.Timso_int("SELECT TOP 1 id FROM PNK_Product mp ORDER BY id desc") + 1;

                //get data insert
                productcatObj = this.GetDataObjectParent(productcatObj);
                productcatObj.ProductId = productId;
                productcatObj.PostDate = DateTime.Now;
                productcatObj.Ordering = genericBLL.getOrdering();

                //excute
                genericBLL.Insert(productcatObj);
            }
            else
            {
                productcatObj.Published = "1";
                productcatObj.Updatedate = DateTime.Now;
                productcatObj.Name = fileNameUpload;
                productcatObj.ImagePath = ImagePath;
                productcatObj.ProductId = idImage;
                productcatObj.PostDate = DateTime.Now;
                productcatObj.Ordering = genericBLL.getOrdering();

                //excute
                genericBLL.Insert(productcatObj);
                BindAlbum(idImage);
                //    }
                //}
            }
            return productId;
        }

        #endregion

        #region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetId();
                BindAlbum(idImage);
            }
        }

        protected void btnUploadImage_Click(object sender, EventArgs e)
        {
            GetId();
            BindAlbum(idImage);
        }

        protected void grdImage_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdImage.PageIndex = e.NewPageIndex;
            GetId();
            BindAlbum(productId);
        }

        protected void grdImage_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int idImage = DBConvert.ParseInt(grdImage.DataKeys[e.Row.RowIndex].Values[0]);
                string imageName = e.Row.Cells[1].Text.ToLower();
                System.Web.UI.WebControls.Image colImage = (System.Web.UI.WebControls.Image)e.Row.FindControl("colImage");
                if (imageName.Contains("jpg") || imageName.Contains("jpeg") || imageName.Contains("png")
                    || imageName.Contains("gif") || imageName.Contains("bmp"))
                {
                    //Trường hợp khi upload hình
                    HttpFileCollection attachments = Request.Files;
                    for (int i = 0; i < attachments.Count; i++)
                    {
                        colImage.ImageUrl = Path.Combine(ImagePath, imageName);
                    }

                    //Trường hợp lần đầu tiên load lên, không có Request
                    if (attachments.Count == 0)
                        colImage.ImageUrl = Path.Combine(ImagePath, imageName);

                }
                else if (imageName.Contains("mp3"))//Set icon mp3 file
                {
                    colImage.ImageUrl = Path.Combine(@"\Admin\images\mp3.jpg");
                }
                else if (imageName.Contains("xls"))//Set icon excel file
                {
                    colImage.ImageUrl = Path.Combine(@"\Admin\images\excel.png");
                }
                else if (imageName.Contains("pdf"))//Set icon excel file
                {
                    colImage.ImageUrl = Path.Combine(@"\Admin\images\pdf.png");
                }
                //else//Set icon youtube file
                //{
                //    colImage.ImageUrl = Path.Combine(@"\Admin\images\Youtube.png");
                //}

            }
        }

        protected void grdImage_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int idImage = DBConvert.ParseInt(grdImage.DataKeys[e.RowIndex].Value);
                DBLibrary db = new DBLibrary();
                productId = db.Timso_int(string.Format("SELECT TOP 1 productid FROM PNK_UploadImage mp where id={0}  ORDER BY id desc", idImage));
                db.Timso_int(string.Format("DELETE FROM PNK_UploadImage WHERE id={0}", idImage));

                string imagePath = Server.MapPath(string.Format("{0}/{1}", grdImage.Rows[e.RowIndex].Cells[3].Text, grdImage.Rows[e.RowIndex].Cells[1].Text));
                //if (File.Exists(imagePath))
                //{
                File.Delete(imagePath);
                BindAlbum(productId);

                //}
            }
            catch (Exception ex)
            {

                // throw;
            }
        }

        protected void upload_OnUploadStart(object sender, AjaxControlToolkit.AjaxFileUploadStartEventArgs e)
        {
            lbMsg.Text = "fdsaf";
        }

        protected void upload_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            string fileName = Path.GetFileName(e.FileName);

            byte[] Image = null;
            string extension = string.Empty;
            extension = Path.GetExtension(fileName).ToLower();// Get selected image extension
            if (fileName != null)
            {
                fileNameUpload = fileName;
                //fileNameUpload = string.Format("{0}{1}{2}", fileName.Split('.')[0], DateTime.Now.ToString("ddMMyyyyhhmmss"), extension);

                string path = Path.Combine(Server.MapPath(ImagePath), fileNameUpload);
                if (extension == ".jpg" || extension == ".jpeg" || extension == ".png" || extension == ".gif" || extension == ".bmp"
                    || extension == ".pdf" || extension == ".xlsx" || extension == ".xls")
                {
                    path = Path.Combine(Server.MapPath(ImagePath), fileNameUpload);
                    upLoad.SaveAs(path);
                }
                if (extension == ".mp3")
                {
                    string fileNameUploadMp3 = fileNameUpload;
                    string fileNameUploadOgg = fileNameUpload.Replace("mp3", "ogg").Replace("MP3", "ogg");

                    path = Path.Combine(Server.MapPath(ImagePath), fileNameUploadMp3);
                    upLoad.SaveAs(path);
                }

                else
                {
                    lbMsg.Text = "fdsaf";
                }
            }
            else
            {
                fileNameUpload = txtIdVideo.Value.Trim();
                txtIdVideo.Value = null;
            }

            productId = SaveNewsCategory();
            btnUploadImage_Click(null, null);

        }

        #endregion
    }
}