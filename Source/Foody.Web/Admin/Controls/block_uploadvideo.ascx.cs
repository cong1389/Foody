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
using System.Data;

namespace Cb.Web.Admin.Controls
{
    public partial class block_uploadvideo : System.Web.UI.UserControl
    {
        //#region Parameter

        //IList<PNK_UploadImage> lst;

        //int total, imageID = int.MinValue, productId = int.MinValue;

        //protected string template_path;

        int total = int.MinValue, imageID = int.MinValue, productId = int.MinValue, productimageID = int.MinValue;

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

        private void GetList(int productId)
        {
            UploadImageBLL bll = new UploadImageBLL();
            IList<PNK_UploadImage> lst = bll.GetList(string.Empty, productId.ToString(), "1", 1, 100, out total);
            if (total > 0)
            {
                lst = lst.Where(m => m.Name == "Youtube").ToList();
                if (lst.Count > 0) txtID.Value = lst[0].ImagePath;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CategoryId = Utils.GetParameter("cid", string.Empty);
                Id = Utils.GetParameter("id", string.Empty);
                imageID = Id == string.Empty ? DBConvert.ParseInt(CategoryId) : DBConvert.ParseInt(Id);

                //GetId();
                GetList(imageID);

                ltrAdminSave.Text = Constant.UI.admin_save;
            }
        }

        private void GetId()
        {
            CategoryId = DBConvert.ParseString(Session["CategoryId"]);
            Id = DBConvert.ParseString(Session["ID"]);
            ImagePath = DBConvert.ParseString(Session["ImagePath"]);

            imageID = DBConvert.ParseInt(Id);
        }

        protected void btnSaveVideo_Click(object sender, EventArgs e)
        {
            GetId();

            PNK_UploadImage productcatObj = new PNK_UploadImage();
            Generic<PNK_UploadImage> genericBLL = new Generic<PNK_UploadImage>();

            //Get max id medical_product
            DBLibrary db = new DBLibrary();
            productId = db.Timso_int("SELECT TOP 1 id FROM PNK_Product mp  order by id desc") + 1;
            productimageID = db.Timso_int("SELECT TOP 1 ProductID FROM [PNK_UploadImage] mp where ProductID=" + imageID + " And Name='Youtube' ");

            //Update
            if (productimageID != 0)
            {
                DBHelper.ExcuteNonQuery("Update PNK_UploadImage set Name=" + "'Youtube',ImagePath=" + "'" + txtID.Value + "' Where ProductID=" + imageID + "     ", null);
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('{0}','Message');", Constant.UI.admin_msg_save_success), true);
            }
            else//Insert
            {
                productcatObj.Published = "1";
                productcatObj.Updatedate = DateTime.Now;
                productcatObj.Name = "Youtube";
                productcatObj.ImagePath = txtID.Value;
                productcatObj.ProductId = imageID == int.MinValue ? productId : imageID;
                productcatObj.PostDate = DateTime.Now;
                productcatObj.Ordering = genericBLL.getOrdering();

                //excute                
                if (genericBLL.Insert(productcatObj) != int.MinValue)
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('{0}','Message');", Constant.UI.admin_msg_save_success), true);
                else
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), string.Format("jAlert('{0}','Message');", Constant.UI.admin_msg_save_fail), true);

                Session["ID"] = productId;
            }
        }
    }
}