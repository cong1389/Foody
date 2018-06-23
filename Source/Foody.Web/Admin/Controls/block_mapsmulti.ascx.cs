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
using Cb.Localization;
using System.Configuration;
using AjaxControlToolkit;
using System.Data.SqlClient;
using System.Data;
using System.ComponentModel;

namespace Cb.Web.Admin.Controls
{
    public partial class block_mapsmulti : DGCUserControl
    {
        #region Parameter

        /// <summary>
        /// Type default của maps=1;
        /// </summary>
        static int type = 1;

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

        private void InitPage()
        {
            BindData(type);
        }

        private void GetId()
        {
            CategoryId = DBConvert.ParseString(Session["CategoryId"]);
            Id = DBConvert.ParseString(Session["ID"]);

            this.idImage = productId = Id == string.Empty ? DBConvert.ParseInt(CategoryId) : DBConvert.ParseInt(Id);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="productId"></param>
        /// <param name="type">==NULL mặc định hình</param>
        /// <param name="type">==1:map</param>
        private void BindData(int type)
        {
            GetId();

            UploadImageBLL bll = new UploadImageBLL();
            lst = bll.GetList(string.Empty, productId.ToString(), "1", type, 1, 100, out  total);
            if (total > 0)
            {
                grdMultiMaps.DataSource = lst;
                grdMultiMaps.DataBind();

                grdMultiMaps.Columns[4].Visible = true;
            }
            else
            {
                PNK_UploadImage pnk = new PNK_UploadImage();
                DataTable dt = Common.UtilityLocal.ObjectToData(pnk);
                grdMultiMaps.DataSource = dt;
                grdMultiMaps.DataBind();

                grdMultiMaps.Columns[4].Visible = false;
                foreach (GridViewRow row in grdMultiMaps.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        LinkButton lb = ((LinkButton)row.FindControl("lnkRemove"));
                        if (lb != null )
                        {
                            lb.Visible = false;
                        }
                    }
                }
            }

        }


        /// <summary>
        /// Save location
        /// </summary>
        private int SaveNewsCategory(string name, string imagePath, int idImage, string longiTude, string latitude)
        {
            GetId();

            PNK_UploadImage productcatObj = new PNK_UploadImage();
            Generic<PNK_UploadImage> genericBLL = new Generic<PNK_UploadImage>();

            if (idImage == int.MinValue)
            {
                productcatObj.Published = "1";
                productcatObj.Name = name;
                productcatObj.ProductId = DBConvert.ParseInt(productId);
                productcatObj.LongiTude = longiTude;
                productcatObj.Latitude = latitude;
                productcatObj.Ordering = genericBLL.getOrdering();
                productcatObj.Type = type;
                productcatObj.Updatedate = DateTime.Now;
                productcatObj.PostDate = DateTime.Now;
                //excute             
                genericBLL.Insert(productcatObj);

            }
            else
            {
                productcatObj.Published = "1";
                productcatObj.Name = name;
                productcatObj.Id = idImage;
                productcatObj.ProductId = DBConvert.ParseInt(productId);
                productcatObj.LongiTude = longiTude;
                productcatObj.Latitude = latitude;
                productcatObj.Ordering = genericBLL.getOrdering();
                productcatObj.Type = type;
                productcatObj.Updatedate = DateTime.Now;
                productcatObj.PostDate = DateTime.Now;
                //excute
                genericBLL.Update(productcatObj, productcatObj, new string[] { "Id" });
                grdMultiMaps.EditIndex = -1;
            }

            BindData(type);

            return productId;
        }

        #endregion

        #region Event

        protected void AddNewCustomer(object sender, EventArgs e)
        {
            string name = ((TextBox)grdMultiMaps.FooterRow.FindControl("txtName")).Text;
            string longiTude = ((TextBox)grdMultiMaps.FooterRow.FindControl("txtLongiTude")).Text;
            string latitude = ((TextBox)grdMultiMaps.FooterRow.FindControl("txtLatitude")).Text;

            SaveNewsCategory(name, string.Empty, int.MinValue, longiTude, latitude);
        }

        protected void grdMultiMaps_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            BindData(type);
            grdMultiMaps.PageIndex = e.NewPageIndex;
            grdMultiMaps.DataBind();
        }

        protected void grdMultiMaps_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdMultiMaps.EditIndex = e.NewEditIndex;
            BindData(type);
        }

        protected void grdMultiMaps_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdMultiMaps.EditIndex = -1;
            BindData(type);
        }

        protected void grdMultiMaps_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int idImage = DBConvert.ParseInt(((Label)grdMultiMaps.Rows[e.RowIndex].FindControl("lbID")).Text);
            string name = ((TextBox)grdMultiMaps.Rows[e.RowIndex].FindControl("txtName")).Text;
            string longiTude = ((TextBox)grdMultiMaps.Rows[e.RowIndex].FindControl("txtLongiTude")).Text;
            string latitude = ((TextBox)grdMultiMaps.Rows[e.RowIndex].FindControl("txtLatitude")).Text;

            SaveNewsCategory(name, string.Empty, DBConvert.ParseInt(idImage), longiTude, latitude);
        }

        protected void grdMultiMaps_RowDeleted(object sender, GridViewDeleteEventArgs e)
        {
            string idImage = grdMultiMaps.DataKeys[e.RowIndex].Value.ToString();
            Generic<PNK_UploadImage> genericBLL = new Generic<PNK_UploadImage>();
            genericBLL.Delete(idImage);
            BindData(type);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitPage();
            }
        }

        #endregion

    }
}