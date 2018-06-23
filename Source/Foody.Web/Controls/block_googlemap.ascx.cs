using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cb.Localization;
using Cb.Utility;
using Subgurim.Controles;
using Cb.BLL;
using Cb.DBUtility;
using System.Text;
using Subgurim.Controles.GoogleChartIconMaker;
using System.Drawing;
using Cb.Model;

namespace Cb.Web.Controls
{
    public partial class block_googlemap : DGCUserControl
    {
        #region Parameter

        #endregion

        #region Common

        private void InitPage()
        {
            ShowConfig();
        }

        private void ShowConfig()
        {
            string latitude = string.Empty, longitude = string.Empty, companyName = string.Empty, imageName = string.Empty, address = string.Empty;

            ConfigurationBLL pcBll = new ConfigurationBLL();
            IList<PNK_Configuration> lst = pcBll.GetList();
            if (lst != null && lst.Count > 0)
            {
                foreach (PNK_Configuration item in lst)
                {
                    if (LangInt == 1)
                    {
                        if (item.Key_name == Constant.Configuration.config_latitude)
                        {
                            latitude = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.config_longitude)
                        {
                            longitude = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.config_company_name_vi)
                        {
                            companyName = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.config_logoHeader)
                        {
                            imageName = item.Value_name;
                        }
                        else if (item.Key_name == Constant.Configuration.config_address_vi)
                        {
                            address = item.Value_name;
                        }
                    }
                }

                if (!string.IsNullOrEmpty(latitude) && !string.IsNullOrEmpty(longitude))
                {
                    LoadGMap(latitude, longitude, companyName, address, imageName);
                }

            }
        }

        private void LoadGMap(string latitude, string longitude, string companyName, string address, string imageName)
        {
            PinIcon p;
            GMarker gm;
            GInfoWindow win;

            GLatLng mainLocation = new GLatLng(DBConvert.ParseDouble(latitude), DBConvert.ParseDouble(longitude));
            GMapType.GTypes maptype = GMapType.GTypes.Normal;
            GMap1.setCenter(mainLocation, 15, maptype);
            GMap1.enableHookMouseWheelToZoom = true;

            GMapUIOptions options = new GMapUIOptions();
            options.maptypes_hybrid = true;
            options.maptypes_normal = true;
            options.zoom_scrollwheel = true;
            GMap1.Add(new GMapUI(options));

            //GMarker marker = new GMarker(mainLocation);
            GIcon icon = new GIcon();
            icon.markerIconOptions = new MarkerIconOptions(50, 50, Color.Blue);
            p = new PinIcon(PinIcons.home, Color.Cyan);
            gm = new GMarker(mainLocation, new GMarkerOptions(new GIcon(p.ToString(), p.Shadow())));
            win = new GInfoWindow(gm, HtmlIconMap(imageName, companyName, address), false, GListener.Event.mouseover);
            GMap1.Add(win);
        }

        private string HtmlIconMap(string imageName, string companyName, string address)
        {
            string imagePath = WebUtils.GetUrlImage(Constant.DSC.AdvUploadFolder, imageName);

            StringBuilder sb = new StringBuilder();
            sb.Append("<div class=\" mapheader \" > <strong>" + companyName + "</strong></div>");
            sb.AppendLine("<div class=\"mapimg\">");
            sb.AppendLine("<img runat=\"server\" id=\"img\" class=\"center-block img-thumbnail\" src=\" " + imagePath + "   \"/> ");
            sb.AppendLine("</div>");
            sb.AppendLine(" <div class=\"mapimgbody\">");
            sb.AppendLine(" <div>");
            sb.AppendLine("" + address + "<br>");
            sb.AppendLine("</div>");
            sb.AppendLine(" </div>");
            sb.AppendLine("</div>");
            return sb.ToString();
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

        #endregion
    }
}