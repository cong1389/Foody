using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Web.UI;
using System.Drawing.Design;
using System.IO;

namespace Cb.WebControls
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:DGCBannerControl runat=server></{0}:DGCBannerControl>")]
    public class DGCBannerControl : WebControl
    {
        #region Properties

        private string filePath;
        private string linkUrl;

        public string LinkUrl
        {
            get { return linkUrl; }
            set { linkUrl = value; }
        }
        public string FilePath
        {
            get { return filePath; }
            set { filePath = value; }
        }
        #endregion


        [Category("SWF Source File")]
        [Browsable(true)]

        [Description("Set path to SWF source file.")]
        //[Editor(GetType(UrlEditor), GetType(UITypeEditor) ]




        protected override void RenderContents(HtmlTextWriter writer)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                if (!string.IsNullOrEmpty(FilePath))
                {
                    bool isFlash;
                    if (Path.GetExtension(FilePath) == ".swf" || Path.GetExtension(FilePath) == ".flv")
                        isFlash = true;
                    else
                        isFlash = false;


                    if (isFlash)
                    {
                        sb.Append("<object classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000");
                        sb.Append("codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,2,0' Width = '" + Width.Value.ToString() + "' Height = '" + Height.Value.ToString() + "' > ");
                        sb.Append("<param name='movie' value=" + FilePath.ToString() + "> ");
                        sb.Append("<param name='quality' value='high'> ");
                        sb.Append("<param name='BGCOLOR' value='#000000'>");
                        sb.Append("<param name='SCALE' value='showall'>");
                        sb.Append("<embed src='" + FilePath.ToString() + "' quality = 'high' ");
                        sb.Append("pluginspage=http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash type=application/x-shockwave-flash ");
                        sb.Append("Width = " + Width.Value.ToString() + " ");
                        sb.Append("Height = " + Height.Value.ToString() + " ");
                        sb.Append("bgcolor=#000000 ");
                        sb.Append("scale='showall' wmode='transparent'></embed></object>");
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(LinkUrl))
                            sb.AppendFormat("<a href='{0}'><img border='0' src='{1}' height='{2}' width='{3}'/></a>", LinkUrl, FilePath, Height.Value.ToString(), Width.Value.ToString());
                        else
                            sb.AppendFormat("<img border='0' src='{0}' height='{1}' width='{2}'/>", FilePath, Height.Value.ToString(), Width.Value.ToString());
                    }
                }
                writer.RenderBeginTag(HtmlTextWriterTag.Div);
                writer.Write(sb.ToString());
                writer.RenderEndTag();
            }
            catch (Exception ex)
            {
                writer.RenderBeginTag(HtmlTextWriterTag.Div);
                writer.Write("Custom Flash Control");
                writer.RenderEndTag();

            }
        }
    }
}
