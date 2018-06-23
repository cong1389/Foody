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
using System.Web.UI.HtmlControls;

namespace Cb.Web.Admin.Controls
{
    public partial class block_uploadimage : DGCUserControl
    {
        //#region Parameter

        //IList<PNK_UploadImage> lst;

        //int total, idImage = int.MinValue, productId = int.MinValue;

        //protected string template_path;

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

        //private string filenameUpload
        //{
        //    get
        //    {
        //        if (ViewState["filenameUpload"] != null)
        //            return ViewState["filenameUpload"].ToString();
        //        else
        //            return string.Empty;
        //    }
        //    set
        //    {
        //        ViewState["filenameUpload"] = value;
        //    }
        //}

        //#endregion

        //#region Common

        //private void GetId()
        //{
        //    //get ID param 
        //    //CategoryId = Utils.GetParameter("cid", string.Empty);
        //    //Id = Utils.GetParameter("id", string.Empty);
        //    this.idImage = Id == string.Empty ? DBConvert.ParseInt(CategoryId) : DBConvert.ParseInt(Id);
        //    this.template_path = WebUtils.GetWebPath();
        //}

        //private void GetList(int productId)
        //{
        //    UploadImageBLL bll = new UploadImageBLL();
        //    //id = Utils.GetParameter("id", string.Empty);
        //    //id = id == string.Empty ? DBConvert.ParseString(productId) : id;

        //    lst = bll.GetList(string.Empty, DBConvert.ParseInt(productId), "1", 1, 100, out  total);
        //    if (total > 0)
        //    {
        //        grdImage.DataSource = lst;
        //        grdImage.DataBind();
        //    }
        //}

        ///// <summary>
        ///// get data for insert update
        ///// </summary>
        ///// <param name="userObj"></param>
        ///// <returns></returns>
        //private PNK_UploadImage getDataObjectParent(PNK_UploadImage productcatObj)
        //{
        //    HttpFileCollection attachments = Request.Files;
        //    for (int i = 0; i < attachments.Count; i++)
        //    {
        //        HttpPostedFile attachment = attachments[i];
        //        if (attachment.ContentLength > 0 && !String.IsNullOrEmpty(attachment.FileName))
        //        {
        //            productcatObj.Published = "1";
        //            productcatObj.Updatedate = DateTime.Now;
        //            productcatObj.Name = attachment.FileName;
        //            productcatObj.ImagePath = ImagePath;
        //        }
        //    }
        //    return productcatObj;
        //}

        ///// <summary>
        ///// Save location
        ///// </summary>
        //private int SaveNewsCategory()
        //{
        //    GetId();

        //    PNK_UploadImage productcatObj = new PNK_UploadImage();
        //    Generic<PNK_UploadImage> genericBLL = new Generic<PNK_UploadImage>();

        //    if (idImage == int.MinValue)
        //    {
        //        //Get max id medical_product
        //        DBLibrary db = new DBLibrary();
        //        productId = db.Timso_int("SELECT TOP 1 id FROM PNK_Product mp ORDER BY id desc") + 1;

        //        //get data insert
        //        productcatObj = this.getDataObjectParent(productcatObj);
        //        productcatObj.ProductId = productId;
        //        productcatObj.PostDate = DateTime.Now;
        //        productcatObj.Ordering = genericBLL.getOrdering();

        //        //excute
        //        genericBLL.Insert(productcatObj);
        //    }
        //    else
        //    {
        //        //string[] fields = { "Id" };
        //        //productcatObj.Id = this.idImage;
        //        //productcatObj.ProductId = DBConvert.ParseInt(Utils.GetParameter("id", string.Empty));
        //        //IList<PNK_UploadImage> lst = genericBLL.GetAllBy(new PNK_UploadImage(), string.Format("WHERE productid={0}", idImage), null);// Load(productcatObj, fields);

        //        //get data insert
        //        HttpFileCollection attachments = Request.Files;
        //        for (int i = 0; i < attachments.Count; i++)
        //        {
        //            HttpPostedFile attachment = attachments[i];
        //            if (attachment.ContentLength > 0 && !String.IsNullOrEmpty(attachment.FileName))
        //            {
        //                string extension = WebUtils.GetFileImageExtension(attachment.FileName);
        //                filenameUpload = string.Format("{0}{1}.{2}", attachment.FileName.Split('.')[0], DateTime.Now.ToString("ddMMyyyyhhmmss"), extension);

        //                productcatObj.Published = "1";
        //                productcatObj.Updatedate = DateTime.Now;
        //                productcatObj.Name = filenameUpload;
        //                productcatObj.ImagePath = ImagePath;
        //                //productcatObj = this.getDataObjectParent(productcatObj);
        //                productcatObj.ProductId = idImage;
        //                productcatObj.PostDate = DateTime.Now;
        //                productcatObj.Ordering = genericBLL.getOrdering();

        //                //excute
        //                genericBLL.Insert(productcatObj);
        //                GetList(idImage);
        //            }
        //        }
        //    }
        //    return productId;
        //}

        //#endregion

        //#region Event

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["CategoryId"] = CategoryId;

                int idImage = int.MinValue;
                CategoryId = Utils.GetParameter("cid", string.Empty);
                Id = Utils.GetParameter("id", string.Empty);
                idImage = Id == string.Empty ? DBConvert.ParseInt(CategoryId) : DBConvert.ParseInt(Id);

                Session["ID"] = Id;
                Session["ImagePath"] = ImagePath;

                HtmlControl iframe = (HtmlControl)this.FindControl("ifrmUploadImage");
                iframe.Attributes["src"] = string.Format("/Admin/Controls/iframe_uploadimage.aspx");

                //GetId();
                //GetList(idImage);
            }

        }

        //protected void btnUploadImage_Click(object sender, EventArgs e)
        //{
        //    if (fuImage.HasFile)
        //    {
        //        if (fuImage.PostedFile.ContentLength < 20728650)
        //        {
        //        }
        //    }

        //    byte[] Image = null;
        //    string extension = string.Empty;
        //    extension = Path.GetExtension(fuImage.FileName).ToLower();// Get selected image extension
        //    if (fuImage.PostedFile != null && fuImage.PostedFile.FileName != "")
        //    {

        //        filenameUpload = string.Format("{0}{1}{2}", fuImage.PostedFile.FileName.Split('.')[0], DateTime.Now.ToString("ddMMyyyyhhmmss"), extension);

        //        string path = Path.Combine(Server.MapPath(ImagePath), filenameUpload);
        //        if (extension == ".jpg" || extension == ".jpeg" || extension == ".png" || extension == ".gif" || extension == ".bmp")
        //        {
        //            HttpFileCollection attachments = Request.Files;
        //            for (int i = 0; i < attachments.Count; i++)
        //            {
        //                HttpPostedFile attachment = attachments[i];
        //                if (attachment.ContentLength > 0 && !String.IsNullOrEmpty(attachment.FileName))
        //                {
        //                    extension = WebUtils.GetFileImageExtension(attachment.FileName);
        //                    filenameUpload = string.Format("{0}{1}.{2}", attachment.FileName.Split('.')[0], DateTime.Now.ToString("ddMMyyyyhhmmss"), extension);
        //                    path = Path.Combine(Server.MapPath(ImagePath), filenameUpload);
        //                    attachment.SaveAs(path);
        //                    Image = new byte[attachment.ContentLength];
        //                    HttpPostedFile UploadedImage = fuImage.PostedFile;
        //                    UploadedImage.InputStream.Read(Image, 0, (int)attachment.ContentLength);
        //                }
        //            }
        //            //fuImage.SaveAs(path);
        //            //Image = new byte[fuImage.PostedFile.ContentLength];
        //            //HttpPostedFile UploadedImage = fuImage.PostedFile;
        //            //UploadedImage.InputStream.Read(Image, 0, (int)fuImage.PostedFile.ContentLength);


        //        }
        //        else if (extension == ".mp3")
        //        {
        //            string pathNameMp3 = path;
        //            string fileNameOgg = pathNameMp3.Replace("mp3", "ogg").Replace("MP3", "ogg");
        //            fuImage.SaveAs(pathNameMp3);
        //            fuImage.SaveAs(fileNameOgg);
        //        }
        //    }
        //    else
        //    {
        //        filenameUpload = txtIdVideo.Value.Trim();
        //        txtIdVideo.Value = null;
        //    }

        //    productId = SaveNewsCategory();

        //    GetList(productId);
        //}

        //protected void grdImage_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    grdImage.PageIndex = e.NewPageIndex;
        //    GetList(productId);
        //}

        //protected void grdImage_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        int idImage = DBConvert.ParseInt(grdImage.DataKeys[e.Row.RowIndex].Values[0]);
        //        string imageName = e.Row.Cells[1].Text.ToLower();
        //        System.Web.UI.WebControls.Image colImage = (System.Web.UI.WebControls.Image)e.Row.FindControl("colImage");
        //        if (imageName.Contains("jpg") || imageName.Contains("jpeg") || imageName.Contains("png")
        //            || imageName.Contains("gif") || imageName.Contains("bmp"))
        //        {
        //            //Trường hợp khi upload hình
        //            HttpFileCollection attachments = Request.Files;
        //            for (int i = 0; i < attachments.Count; i++)
        //            {
        //                colImage.ImageUrl = Path.Combine(ImagePath, imageName);
        //            }

        //            //Trường hợp lần đầu tiên load lên, không có Request
        //            if (attachments.Count == 0)
        //                colImage.ImageUrl = Path.Combine(ImagePath, imageName);

        //        }
        //        else if (imageName.Contains("mp3"))//Set icon mp3 file
        //        {
        //            colImage.ImageUrl = Path.Combine(@"\Admin\images\mp3.jpg");
        //        }
        //        else//Set icon youtube file
        //        {
        //            colImage.ImageUrl = Path.Combine(@"\Admin\images\Youtube.png");
        //        }

        //    }
        //}

        //protected void grdImage_RowDeleting(object sender, GridViewDeleteEventArgs e)
        //{
        //    try
        //    {
        //        int idImage = DBConvert.ParseInt(grdImage.DataKeys[e.RowIndex].Value);
        //        DBLibrary db = new DBLibrary();
        //        productId = db.Timso_int(string.Format("SELECT TOP 1 productid FROM dbo.medical_uploadimage mp where id={0}  ORDER BY id desc", idImage));
        //        db.Timso_int(string.Format("DELETE FROM dbo.medical_uploadimage WHERE id={0}", idImage));


        //        string imagePath = Server.MapPath(string.Format("{0}/{1}", grdImage.Rows[e.RowIndex].Cells[3].Text, grdImage.Rows[e.RowIndex].Cells[1].Text));
        //        //if (File.Exists(imagePath))
        //        //{
        //        File.Delete(imagePath);
        //        GetList(productId);

        //        //}
        //    }
        //    catch (Exception ex)
        //    {

        //        // throw;
        //    }
        //}

        //#endregion

        //#region Trainning

        //protected void OnUploadComplete(object sender, AjaxFileUploadEventArgs e)
        //{
        //    string fileName = Path.GetFileName(e.FileName);
        //    //AjaxFileUpload11.SaveAs(Server.MapPath("~/Uploads/" + fileName));

        //}


        //#endregion

    }
}
