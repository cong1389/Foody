using Cb.BLL;
using Cb.Localization;
using Cb.Model;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cb.Web.Controls
{
    public partial class block_programtour : DGCUserControl
    {
        #region Parameter

        protected string template_path, pageName, nameurl, url, cid, cidsub, id;
        int total;

        private string productId = string.Empty;
        public string ProductId { set; get; }

        #endregion

        #region Common

        private void InitPage()
        {
            template_path = WebUtils.GetWebPath();
            pageName = Utils.GetParameter("page", "home");
            cid = Utils.GetParameter("cid", string.Empty);
            cidsub = Utils.GetParameter("cidsub", string.Empty);
            id = Utils.GetParameter("id", string.Empty);

            GetDetail();

        }

        private void GetDetail()
        {
            ProgramTourBLL pcBll = new ProgramTourBLL();
            IList<PNK_ProgramTour> lst = null;
            string level = string.Empty;

            if (Session["level"] != null)
            {

                switch (level)
                {
                    case "1":
                        lst = pcBll.GetList(LangInt, pageName, string.Empty, string.Empty, 1, 9999, out total);
                        //lst = pcBll.GetList(LangInt, pageName, string.Empty, string.Empty, string.Empty, null, string.Empty, 1, 9999, out total);
                        break;
                    case "2":
                        lst = pcBll.GetList(LangInt, cid, string.Empty, string.Empty, 1, 9999, out total);
                        //lst = pcBll.GetList(LangInt, cid, string.Empty, string.Empty, string.Empty, null, string.Empty, 1, 9999, out total);
                        break;
                    case "3":
                        lst = pcBll.GetList(LangInt, cidsub, string.Empty, string.Empty, 1, 9999, out total);
                        //lst = pcBll.GetList(LangInt, cidsub, string.Empty, string.Empty, string.Empty, null, string.Empty, 1, 9999, out total);
                        break;
                    case "4":
                    default:
                        lst = pcBll.GetList(LangInt, string.Empty, string.Empty, ProductId, 1, 9999, out total);
                        break;
                }
            }

            if (total > 0)
            {
                rptResult.DataSource = lst;
                rptResult.DataBind();
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

        protected void rptResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PNK_ProgramTour data = e.Item.DataItem as PNK_ProgramTour;

                Literal ltrTitle = e.Item.FindControl("ltrTitle") as Literal;
                ltrTitle.Text = data.ProgramTourDesc.Title;

                Literal ltrDetail = e.Item.FindControl("ltrDetail") as Literal;
                ltrDetail.Text = data.ProgramTourDesc.Detail;

                Literal ltrIcon = e.Item.FindControl("ltrIcon") as Literal;
                int imageType = data.ImageType;
                string result = string.Empty;
                string imagePath = data.Image == "" ? "<i class=\"fa fa-flag-o\"></i>" : data.Image;
                //switch (imageType)
                //{
                //    case 1:
                //        result = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["ProductUpload"], imagePath);
                //        break;
                //    case 2:
                        result = data.ImageFont;
                //        break;

                //}
                ltrIcon.Text = result;

            }
        }

        #endregion
    }
}