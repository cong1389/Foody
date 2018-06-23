using System;
using System.Web;
using System.IO;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using Cb.Model;
using System.Collections.Generic;

namespace Cb.BLL.UploadImage
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>

    public class DisplayImage : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.Clear();
            context.Response.ContentType = "image/jpeg";

            if (context.Request.QueryString["id"] != null)
            {
                int id = 0;
                id = Convert.ToInt32(context.Request.QueryString["id"]);
                //MemoryStream memoryStream = new MemoryStream(GetImageFromDB(id), false);
                //System.Drawing.Image imgFromGB = System.Drawing.Image.FromStream(memoryStream);
                //imgFromGB.Save(context.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
            }
        }
        //private byte[] GetImageFromDB(int id)
        //{
        //    byte[] btImage = null;
        //    int total;
        //    UploadImageBLL bll = new UploadImageBLL();
        //    IList<PNK_uploadimage> lst = bll.GetList(string.Empty, "1", 1, 100, out  total);
        //    if (total > 0)
        //    {
        //        btImage = (byte[])lst[0].ImageContent;
        //    }

        //    return btImage;
        //}

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
