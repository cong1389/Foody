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
    public partial class block_googlemap_detail : DGCUserControl
    {
        #region Parameter

        /// <summary>
        /// Type default của maps=1;
        /// </summary>
        static int type = 1;

        int total = int.MinValue;

        private string productId = string.Empty;
        public string ProductId { set; get; }

        private string latitude = string.Empty;
        public string Latitude { set; get; }

        private string longitude = string.Empty;
        public string Longitude { set; get; }

        private string companyName = string.Empty;
        public string CompanyName { set; get; }

        #endregion

        #region Common

        private void InitPage()
        {
            ShowConfig();
        }

        private void ShowConfig()
        {
            string latitude = Latitude, longitude = Longitude, companyName = CompanyName, imageName = string.Empty, address = string.Empty;

            //get list vĩ độ, kinh độ
            UploadImageBLL bll = new UploadImageBLL();
            IList<PNK_UploadImage> lst = bll.GetList(string.Empty, ProductId, "1", type, 1, 100, out  total);
            if (total > 0)
            {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < total; i++)
                {
                    latitude = lst[i].Latitude;
                    longitude = lst[i].LongiTude;
                    companyName = lst[i].Name;
                    LoadGMap(latitude, longitude, companyName, address, imageName);

                    //if (i == 0)
                    //{
                    //    sb.Append("function ResetMap(mapss) {");
                    //    sb.Append(" var mapOptions = {zoom: 15,center: new google.maps.LatLng(-37.8122172,144.965374), mapTypeId: google.maps.MapTypeId.ROADMAP};");
                    //    sb.AppendFormat("mapid = '{0}';", GMap1.ClientID);
                    //    sb.Append("var map = new google.maps.Map(document.getElementById(mapid), mapOptions);");
                    //    sb.Append("var center = map.getCenter();");
                    //    sb.Append("google.maps.event.trigger(map, 'resize');");
                    //    sb.Append("map.setCenter(center);");
                    //    sb.Append(" $('#tabDetail a[href=\"#tabMaps\"]').on('click', function () {google.maps.event.trigger(map, 'resize');});");
                    //    sb.Append("google.maps.event.trigger(map, 'resize');");

                    //    sb.Append("}");
                    //    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "ResetMap", sb.ToString(), true);
                    //}
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

            GMap1.addControl(new GControl(GControl.preBuilt.GOverviewMapControl));
            GMap1.addControl(new GControl(GControl.preBuilt.LargeMapControl));
            GMap1.Add(win);
        }

        private string HtmlIconMap(string imageName, string companyName, string address)
        {
            string imagePath = WebUtils.GetUrlImage(Constant.DSC.AdvUploadFolder, imageName);

            StringBuilder sb = new StringBuilder();

            //  sb.AppendLine("<div class=\"mapimg\"><img runat=\"server\" id=\"img\" class=\"center-block img-thumbnail\" src=\" " + imagePath + "   \"/> </div>");
            sb.Append("<div class=\" mapheader \" > <strong>" + companyName + "</strong></div>");
            sb.AppendLine(" <div class=\"mapimgbody\">");
            sb.AppendLine(" <div>");
            sb.AppendLine("" + address + "<br>");
            sb.AppendLine("</div>");
            sb.AppendLine(" </div>");
            // sb.AppendLine("</div>");
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