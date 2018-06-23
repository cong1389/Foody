using Cb.BLL;
using Cb.BLL.Product;
using Cb.DBUtility;
using Cb.Localization;
using Cb.Model;
using Cb.Model.Products;
using Cb.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Cb.Web.Controls
{
    public partial class block_slide : DGCUserControl
    {
        #region Parameter

        protected string title, metaDescription, metaKeyword, h1, h2, h3, analytic;
        int total;

        #endregion

        #region Common

        private void InitPage()
        {
            GetBanner();
        }

        private void GetBanner()
        {
            BannerBLL bannerBLL = new BannerBLL();
            IList<PNK_Banner> lst = bannerBLL.GetList(DBConvert.ParseInt(ConfigurationManager.AppSettings["slideId"]), string.Empty, "1", 1, 100, out total);
            if (total > 0)
            {
                this.rptResult.DataSource = lst;
                this.rptResult.DataBind();
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
                PNK_Banner data = e.Item.DataItem as PNK_Banner;
                string link = data.LinkUrl, dataX1 = string.Empty, dataBgposition = string.Empty, dataY1 = string.Empty
                    , dataX2 = string.Empty, dataY2 = string.Empty
                    , dataX3 = string.Empty, dataY3 = string.Empty;

                switch (data.Align.ToString())
                {
                    case "1":
                        dataBgposition = "center center";
                        dataX1 = " data-x=\"['center','center','center','center']\" data-hoffset=\"['0','0','0','0']\" ";
                        dataY1 = " data-y=\"['middle','middle','middle','middle']\" data-voffset=\"['-1','0','0','0']\"";

                        dataX2 = " data-x=\"['center','center','center','center']\" data-hoffset=\"['2','0','0','0']\"";
                        dataY2 = "data-y=\"['top','top','middle','middle']\" data-voffset=\"['301','250','-7','-7']\"";

                        dataX3 = " data-x=\"['center','center','center','center']\" data-hoffset=\"['0','0','0','0']\"";
                        dataY3 = " data-y=\"['middle','middle','middle','middle']\" data-voffset=\"['124','124','90','75']\"";
                        break;
                    case "2":
                    default:
                        dataBgposition = "center center";
                        dataX1 = " data-x=\"['left','left','left','center']\" data-hoffset=\"['11','20','20','20']\" ";
                        dataY1 = " data-y=\"['middle','middle','middle','middle']\" data-voffset=\"['-68','-68','-68','-40']\"";

                        dataX2 = " data-x=\"['left','left','left','left']\" data-hoffset = \"['11','20','20','20']  \"";
                        dataY2 = " data-y=\"['middle','middle','middle','middle']\" data-voffset = \"['0','0','0','0']  \"";

                        dataX3 = " data-x=\"['left','left','left','left']\" data-hoffset = \"['9','80','80','94'] \"";
                        dataY3 = " data-y=\"['top','top','top','top']\" data-voffset = \"['370','320','250','262'] \"";
                        break;
                }

                //HtmlImage img = e.Item.FindControl("img") as HtmlImage;
                HtmlImage img = new HtmlImage();
                string src = WebUtils.GetUrlImage(ConfigurationManager.AppSettings["SliderUpload"], data.Image);
                img.Src = src;
                //img.Alt = data.Name;

                //HtmlControl li = e.Item.FindControl("li") as HtmlControl;
                //li.Attributes.Add("data-thumb", src);
                //li.Attributes.Add("data-index", string.Format("rs-{0}", data.Id));
                // li.Attributes.Add("data-bgposition", dataBgposition);

                //HtmlAnchor hypLink = e.Item.FindControl("hypLink") as HtmlAnchor;                

                StringBuilder sb = new StringBuilder();
                sb.AppendFormat(" <li  data-index=\"rs-{0}\" data-transition=\"fadetotopfadefrombottom\" data-slotamount=\"default\" data-hideafterloop=\"0\" data-hideslideonmobile=\"off\" data-easein=\"default\" data-easeout=\"default\" data-masterspeed=\"300\" data-thumb=\"{1}\" data-rotate=\"0\" data-saveperformance=\"off\" data-title=\"Slide\" data-param1=\"\" data-param2=\"\" data-param3=\"\" data-param4=\"\" data-param5=\"\" data-param6=\"\" data-param7=\"\" data-param8=\"\" data-param9=\"\" data-param10=\"\" data-description=\"\">", data.Id, src);
                sb.AppendFormat("<img src=\"{0}\" alt = \"\" title = \"slider-demo2v3\" width = \"1920\" height = \"650\" data-bgposition = \"center center\" data-bgfit = \"cover\" data-bgrepeat = \"no-repeat\" data-bgparallax = \"off\" class=\"rev-slidebg\" data-no-retina>", src);

                sb.Append("<!--LAYER NR. 1-->");
                sb.Append("<div class=\"tp-caption NotGeneric-Title   tp-resizeme rs-parallaxlevel-3\" ");
                sb.AppendFormat("id=\"slide-{0}-layer-1\"", data.Id);
                sb.Append(dataX1);
                sb.Append(dataY1);
                sb.Append(" data-fontsize=\"['40','30','26','18']\"");
                sb.Append(" data-lineheight=\"none\"");
                sb.Append("data-width=\"['none','none','none','425']\"");
                sb.Append("data-height=\"none\"");
                sb.Append("data-whitespace=\"['nowrap', 'nowrap', 'nowrap', 'nowrap']\" data-transform_idle=\"o:1;\" ");
                sb.Append("data-transform_in=\"y: [100%];z:0;rZ:-35deg;sX:1;sY:1;skX:0;skY:0;s:2000;e:Power4.easeInOut;\" ");
                sb.Append("data-transform_out=\"y:[100%];s:1000;e:Power2.easeInOut;\" ");
                sb.Append("data-mask_in=\"x:0px;y:0px;s:inherit;e:inherit;\" data-mask_out=\"x:inherit;y:inherit;s:inherit;e:inherit;\" ");
                sb.Append("data-start=\"1000\" ");
                //  sb.Append("data-splitin=\"chars\"");
                sb.Append("data-splitout=\"none\"");
                sb.Append(" data-responsive_offset=\"on\"");
                sb.Append("data-elementdelay=\"0.05\"");
                sb.Append("data-end=\"8700\"");
                sb.Append("style=\"z-index: 5; white-space: nowrap;\">");
                sb.Append(data.Name);
                sb.Append("</div>");

                sb.Append("<!-- LAYER NR. 2 -->");
                sb.Append(" <div class=\"tp-caption NotGeneric-SubTitle   tp-resizeme rs-parallaxlevel-2\"");
                sb.AppendFormat("id=\"slide-{0}-layer-2\"", data.Id);
                sb.Append(dataX2);
                sb.Append(dataY2);
                sb.Append(" data-fontsize=\"['18','13','13','16']\"");
                sb.Append("data-width=\"['none','none','none','425']\"");
                sb.Append("data-height=\"none\"");
                sb.Append(" data-whitespace=\"['nowrap','nowrap','nowrap','normal']\" data-transform_idle=\"o:1;\"");
                sb.Append("data-transform_in=\"y:[100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0;s:2000;e:Power4.easeInOut;\"");
                sb.Append("data-transform_out=\"y:[100%];s:1000;e:Power2.easeInOut;\" data-start=\"1500\"");
                sb.Append("data-splitin=\"none\" data-splitout=\"none\" data-responsive_offset=\"on\"");
                sb.Append("data-end=\"8300\"");
                sb.Append("style=\"z-index: 6; white-space: nowrap;font-family:Helvetica; font-size: 18px;\"> ");
                sb.Append(data.Detail);
                sb.Append("</div>");

                //Button 1                  
                if (data.OutPage == 1)
                {
                    sb.Append("<!-- LAYER NR. 3 -->");
                    sb.Append("<div class='tp-caption NotGeneric-CallToAction rev-btn'");
                    sb.AppendFormat("id=\"slide-{0}-layer-3\"", data.Id);
                    sb.Append(dataX3);
                    sb.Append(dataY3);
                    sb.Append(" data-fontsize=\"['14','14','14','11']\"");
                    sb.Append(" data-lineheight=\"['14','14','14','11']\"");
                    sb.Append("data-fontweight=\"['400', '500', '400', '400']\"");
                    sb.Append("data-width=\"none\" data-height=\"none\" data-whitespace=\"['nowrap', 'nowrap', 'nowrap', 'normal']\" data-visibility=\"['on', 'on', 'on', 'off']\" data-transform_idle=\"o:1;\"");
                    sb.Append("data-transform_hover=\"o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;\"");
                    sb.Append("data-style_hover=\"c:rgba(253, 189, 16, 1.00);bg:rgba(255, 255, 255, 1.00);bc:rgba(255, 255, 255, 1.00);\"");
                    sb.Append("data-transform_in=\"y:50px;opacity:0;s:1500;e:Power4.easeInOut;\" data-transform_out=\"y:[175%];s:1000;e:Power2.easeInOut;\"");
                    sb.Append("x:inherit;y:inherit;s:inherit;e:inherit;");
                    sb.Append("data-start=\"2000\" data-splitin=\"none\" data-splitout=\"none\" data-responsive_offset=\"off\"");
                    sb.Append("data-end=\"8300\"");
                    sb.Append("data-actions='[{\"event\":\"click\",\"action\":\"simplelink\",\"target\":\"_self\",\"url\":\"" + data.LinkUrl + "\",\"delay\":\"\"}]'");
                    sb.Append("style=\"z-index: 9; white-space: nowrap; font-weight: 400;font-family:Helvetica;text-align:center;background-color:rgba(253, 189, 16, 1.00);padding:15px 25px 15px 25px;border-style:none;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;cursor:pointer;\">");
                    sb.Append("Chi tiết");
                    sb.Append("</div>");
                }

                Literal ltrLayer1 = e.Item.FindControl("ltrLayer1") as Literal;
                ltrLayer1.Text = sb.ToString();

                sb.Append("</li>");

                //HtmlAnchor hypLink = e.Item.FindControl("hypLink") as HtmlAnchor;
                //hypLink.HRef = data.LinkUrl;
            }
        }

        #endregion
    }
}