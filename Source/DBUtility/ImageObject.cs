/*
   Author  : Nguyen Van Tho 
   Email   : nguyenvantho@kng.vn
   Date    : 2007-12
   Company :  KNG (Vietnam)
   Team: .NET
 */


using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.IO;

namespace Cb.DBUtility
{
    class ImageResize
    {
        enum Dimensions
        {
            Width,
            Height
        }
        enum AnchorPosition
        {
            Top,
            Center,
            Bottom,
            Left,
            Right
        }
        //[STAThread]
        //static void Main(string[] args)
        //{
        //  //set a working directory
        //  string WorkingDirectory = @"C:\Projects\Tutorials\ImageResize";

        //  //create a image object containing a verticel photograph
        //  Image imgPhotoVert = Image.FromFile(WorkingDirectory + @"\imageresize_vert.jpg");
        //  Image imgPhotoHoriz = Image.FromFile(WorkingDirectory + @"\imageresize_horiz.jpg");
        //  Image imgPhoto = null;

        //  imgPhoto = ScaleByPercent(imgPhotoVert, 50);
        //  imgPhoto.Save(WorkingDirectory + @"\images\imageresize_1.jpg", ImageFormat.Jpeg);
        //  imgPhoto.Dispose();

        //  imgPhoto = ConstrainProportions(imgPhotoVert, 200, Dimensions.Width);
        //  imgPhoto.Save(WorkingDirectory + @"\images\imageresize_2.jpg", ImageFormat.Jpeg);
        //  imgPhoto.Dispose();

        //  imgPhoto = FixedSize(imgPhotoVert, 200, 200);
        //  imgPhoto.Save(WorkingDirectory + @"\images\imageresize_3.jpg", ImageFormat.Jpeg);
        //  imgPhoto.Dispose();

        //  imgPhoto = Crop(imgPhotoVert, 200, 200, AnchorPosition.Center);
        //  imgPhoto.Save(WorkingDirectory + @"\images\imageresize_4.jpg", ImageFormat.Jpeg);
        //  imgPhoto.Dispose();

        //  imgPhoto = Crop(imgPhotoHoriz, 200, 200, AnchorPosition.Center);
        //  imgPhoto.Save(WorkingDirectory + @"\images\imageresize_5.jpg", ImageFormat.Jpeg);
        //  imgPhoto.Dispose();

        //}

    }
    public class ImageObject
    {
        enum Dimensions
        {
            Width,
            Height
        }
        enum AnchorPosition
        {
            Top,
            Center,
            Bottom,
            Left,
            Right
        }
        /// <SUMMARY>
        /// This function takes a max width/height
        /// and makes a new file based on it
        /// </SUMMARY>
        /// <PARAM name="MaxWidth">Max width of the new image</PARAM>
        /// <PARAM name="MaxHeight">Max Height of the new image</PARAM>
        /// <PARAM name="FileName">Original file name</PARAM>
        /// <PARAM name="NewFileName">new file name</PARAM>
        public static void ResizeImage(int MaxWidth, int MaxHeight,
          string FileName, string NewFileName)
        {
            // load up the image, figure out a "best fit"
            // resize, and then save that new image
            Bitmap OriginalBmp =
              (System.Drawing.Bitmap)Image.FromFile(FileName);

            Size ResizedDimensions = new Size();

            if (OriginalBmp.Width > MaxWidth || OriginalBmp.Height > MaxHeight)
                ResizedDimensions =
                  GetDimensionsOfResizeImage(MaxWidth, MaxHeight, ref OriginalBmp, true);
            else
            {
                ResizedDimensions = new Size(OriginalBmp.Width, OriginalBmp.Height);
            }
            // Bitmap NewBmp = new Bitmap(OriginalBmp, ResizedDimensions);

            using (Bitmap newImage = new Bitmap(ResizedDimensions.Width, ResizedDimensions.Height, PixelFormat.Format24bppRgb))
            {
                using (Graphics canvas = Graphics.FromImage(newImage))
                {
                    canvas.SmoothingMode = SmoothingMode.AntiAlias;
                    canvas.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    canvas.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    canvas.DrawImage(OriginalBmp, new Rectangle(new Point(0, 0), ResizedDimensions));
                    newImage.Save(NewFileName, System.Drawing.Imaging.ImageFormat.Jpeg);
                    newImage.Dispose();
                }
            }
            OriginalBmp.Dispose();

        }

        public static void ResizeImage_New(int MaxWidth, int MaxHeight,
            string FileName, string NewFileName)
        {
            // load up the image, figure out a "best fit"
            // resize, and then save that new image
            Bitmap OriginalBmp =
                (System.Drawing.Bitmap)Image.FromFile(FileName);

            Size ResizedDimensions = new Size();

            ResizedDimensions = GetDimensionsOfResizeImage(MaxWidth, MaxHeight, ref OriginalBmp, true);

            // Bitmap NewBmp = new Bitmap(OriginalBmp, ResizedDimensions);

            using (Bitmap newImage = new Bitmap(ResizedDimensions.Width, ResizedDimensions.Height, PixelFormat.Format24bppRgb))
            {
                using (Graphics canvas = Graphics.FromImage(newImage))
                {
                    canvas.SmoothingMode = SmoothingMode.AntiAlias;
                    canvas.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    canvas.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    canvas.DrawImage(OriginalBmp, new Rectangle(new Point(0, 0), ResizedDimensions));
                    newImage.Save(NewFileName, System.Drawing.Imaging.ImageFormat.Jpeg);
                    newImage.Dispose();
                }
            }
            OriginalBmp.Dispose();

        }

        public static void CropCenterImage(int Width, int Height,
          string FileName, string NewFileName)
        {
            //create a image object containing a verticel photograph
            Image imgPhotoOld = Image.FromFile(FileName);
            Image imgPhotoNew = null;

            imgPhotoNew = Crop(imgPhotoOld, Width, Height, AnchorPosition.Center);
            imgPhotoNew.Save(NewFileName, ImageFormat.Jpeg);
            imgPhotoNew.Dispose();
            imgPhotoOld.Dispose();
        }

        public static void DrawImage(int MaxWidth, int MaxHeight, string FileName, Stream outputStream, bool resizeWidthHeight)
        {
            // load up the image, figure out a "best fit"
            // resize, and then save that new image
            Bitmap OriginalBmp =
              (System.Drawing.Bitmap)Image.FromFile(FileName);

            //if(MaxWidth >= OriginalBmp.Width)
            //{
            //  OriginalBmp.Save(outputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
            //}

            Size ResizedDimensions =
              GetDimensions(MaxWidth, MaxHeight, ref OriginalBmp, resizeWidthHeight);
            //Bitmap NewBmp = new Bitmap(OriginalBmp, ResizedDimensions);

            using (Bitmap newImage = new Bitmap(ResizedDimensions.Width, ResizedDimensions.Height, PixelFormat.Format24bppRgb))
            {
                using (Graphics canvas = Graphics.FromImage(newImage))
                {
                    canvas.SmoothingMode = SmoothingMode.AntiAlias;
                    canvas.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    canvas.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    canvas.DrawImage(OriginalBmp, new Rectangle(new Point(0, 0), ResizedDimensions));
                    newImage.Save(outputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
                    newImage.Dispose();
                }
            }

            //NewBmp.Save(outputStream, ImageFormat.Jpeg);

            OriginalBmp.Dispose();
            //NewBmp.Dispose();
        }

        public static void DrawImage2(int MaxWidth, int MaxHeight, string FileName, Stream outputStream, bool resizeWidthHeight)
        {
            //create a image object containing a verticel photograph
            Image imgPhotoOld = Image.FromFile(FileName);
            Image imgPhotoNew = null;

            imgPhotoNew = FixedSize(imgPhotoOld, MaxWidth, MaxHeight); //Crop(imgPhotoOld, MaxWidth, MaxHeight, AnchorPosition.Center);
            imgPhotoNew.Save(outputStream, ImageFormat.Jpeg);
            imgPhotoNew.Dispose();
            imgPhotoOld.Dispose();
        }

        /// <SUMMARY>
        /// this function aims to give you a best fit
        /// for a resize. It assumes width is more important 
        /// then height. If an image is already smaller
        /// then max dimensions it will not resize it.
        /// </SUMMARY>
        /// <PARAM name="MaxWidth">max width of the new image</PARAM>
        /// <PARAM name="MaxHeight">max height of the new image</PARAM>
        /// <PARAM name="Bmp">BMP of the current image,
        ///              passing by ref so fast</PARAM>
        /// <RETURNS></RETURNS>
        public static Size GetDimensions(int MaxWidth,
          int MaxHeight, ref Bitmap Bmp, bool byWidthHeight)
        {
            int Width;
            int Height;

            Height = Bmp.Height;
            Width = Bmp.Width;

            // this means you want to shrink
            // an image that is already shrunken!

            if (MaxHeight < 0 || MaxWidth < 0)
                return new Size(Width, Height);

            /*DinhVinh: Comand from here.*/
            float MultiplierHeight;
            float MultiplierWidth;

            // check to see if we can shrink it width first
            MultiplierWidth = (float)((float)MaxWidth / (float)Width);
            MultiplierHeight = (float)((float)MaxHeight / (float)Height);

            if (byWidthHeight)
            {
                if (MultiplierHeight > MultiplierWidth)
                {
                    Height = (int)(Height * MultiplierWidth);
                    Width = (int)(Width * MultiplierWidth);
                }
                else
                {
                    Height = (int)(Height * MultiplierHeight);
                    Width = (int)(Width * MultiplierHeight);
                }
            }
            else
            {
                Height = MaxHeight;
                Width = MaxWidth;
            }
            /*DinhVinh: End comand from here */
            return new Size(Width, Height);
        }

        public static Size GetDimensions(int MaxWidth,
          int MaxHeight, ref Image Imp, bool byWidthHeight)
        {
            int Width;
            int Height;

            Height = Imp.Height;
            Width = Imp.Width;

            // this means you want to shrink
            // an image that is already shrunken!

            if (MaxHeight < 0 || MaxWidth < 0)
                return new Size(Width, Height);

            /*DinhVinh: Comand from here.*/
            float MultiplierHeight;
            float MultiplierWidth;

            // check to see if we can shrink it width first
            MultiplierWidth = (float)((float)MaxWidth / (float)Width);
            MultiplierHeight = (float)((float)MaxHeight / (float)Height);

            if (byWidthHeight)
            {
                if (MultiplierHeight > MultiplierWidth)
                {
                    Height = (int)(Height * MultiplierWidth);
                    Width = (int)(Width * MultiplierWidth);
                }
                else
                {
                    Height = (int)(Height * MultiplierHeight);
                    Width = (int)(Width * MultiplierHeight);
                }
            }
            else
            {
                Height = MaxHeight;
                Width = MaxWidth;
            }
            /*DinhVinh: End comand from here */
            return new Size(Width, Height);
        }

        /// <SUMMARY>
        /// this function aims to give you a best fit
        /// for a resize. It assumes width is more important 
        /// then height. If an image is already smaller
        /// then max dimensions it will not resize it.
        /// </SUMMARY>
        /// <PARAM name="MaxWidth">max width of the new image</PARAM>
        /// <PARAM name="MaxHeight">max height of the new image</PARAM>
        /// <PARAM name="Bmp">BMP of the current image,
        ///              passing by ref so fast</PARAM>
        /// <RETURNS></RETURNS>
        public static Size GetDimensionsOfResizeImage(int MaxWidth,
          int MaxHeight, ref Bitmap Bmp, bool byWidthHeight)
        {
            int Width;
            int Height;

            Height = Bmp.Height;
            Width = Bmp.Width;

            // this means you want to shrink
            // an image that is already shrunken!

            if (MaxHeight < 0 || MaxWidth < 0)
                return new Size(Width, Height);

            float Multiplier;

            // check to see if we can shrink it width first
            Multiplier = (float)((float)MaxWidth / (float)Width);

            Height = (int)(Height * Multiplier);
            Width = (int)(Width * Multiplier);

            if (byWidthHeight)
            {
                if (Height > MaxHeight)
                {
                    Multiplier = (float)((float)MaxHeight / (float)Height);
                    Height = (int)(Height * Multiplier);
                    Width = (int)(Width * Multiplier);
                }
            }
            return new Size(Width, Height);
        }

        /// <summary>
        /// genarate secure code
        /// </summary>
        /// <param name="secureText">a generated text</param>
        /// <param name="fontName">font name of the text</param>
        /// <param name="outputStream"></param>
        public static void DrawTextImage(string secureText, string fontName, string bgPicture, Stream outputStream)
        {
            System.Drawing.Image imgBitmap = null;// new Bitmap(1, 1);

            if (bgPicture != null && bgPicture != "")
                imgBitmap = new Bitmap(bgPicture);

            Font f = new Font(fontName, 14);
            //Graphics graphics = Graphics.FromImage(imgBitmap);

            int width = imgBitmap.Width; // (int)graphics.MeasureString(secureText, f).Width;
            int height = imgBitmap.Height; //(int)graphics.MeasureString(secureText, f).Height;
            //imgBitmap = new Bitmap(imgBitmap, new Size(width, height));

            //graphics = Graphics.FromImage(imgBitmap);
            //graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;


            using (Bitmap newImage = new Bitmap(width, height, PixelFormat.Format24bppRgb))
            {
                using (Graphics canvas = Graphics.FromImage(newImage))
                {
                    canvas.SmoothingMode = SmoothingMode.AntiAlias;
                    canvas.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    canvas.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    canvas.DrawImage(imgBitmap, new Rectangle(new Point(0, 0), new Size(width, height)));
                    canvas.DrawString(secureText, f, new SolidBrush(Color.Black), 12, 0, StringFormat.GenericTypographic);
                    newImage.Save(outputStream, ImageFormat.Jpeg);
                    canvas.Flush();
                }
            }

        }
        // This function draw no image
        public static void DrawNoImage(Stream outputStream)
        {
            System.Drawing.Image imgBitmap = new Bitmap(1, 1);
            imgBitmap.Save(outputStream, ImageFormat.Gif);
        }

        // new function 
        static Image ScaleByPercent(Image imgPhoto, int Percent)
        {
            float nPercent = ((float)Percent / 100);

            int sourceWidth = imgPhoto.Width;
            int sourceHeight = imgPhoto.Height;
            int sourceX = 0;
            int sourceY = 0;

            int destX = 0;
            int destY = 0;
            int destWidth = (int)(sourceWidth * nPercent);
            int destHeight = (int)(sourceHeight * nPercent);

            Bitmap bmPhoto = new Bitmap(destWidth, destHeight, PixelFormat.Format24bppRgb);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

            Graphics grPhoto = Graphics.FromImage(bmPhoto);
            grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;

            grPhoto.DrawImage(imgPhoto,
              new Rectangle(destX, destY, destWidth, destHeight),
              new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
              GraphicsUnit.Pixel);

            grPhoto.Dispose();
            return bmPhoto;
        }
        static Image ConstrainProportions(Image imgPhoto, int Size, Dimensions Dimension)
        {
            int sourceWidth = imgPhoto.Width;
            int sourceHeight = imgPhoto.Height;
            int sourceX = 0;
            int sourceY = 0;
            int destX = 0;
            int destY = 0;
            float nPercent = 0;

            switch (Dimension)
            {
                case Dimensions.Width:
                    nPercent = ((float)Size / (float)sourceWidth);
                    break;
                default:
                    nPercent = ((float)Size / (float)sourceHeight);
                    break;
            }

            int destWidth = (int)(sourceWidth * nPercent);
            int destHeight = (int)(sourceHeight * nPercent);

            Bitmap bmPhoto = new Bitmap(destWidth, destHeight, PixelFormat.Format64bppArgb);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

            Graphics grPhoto = Graphics.FromImage(bmPhoto);
            grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;

            grPhoto.DrawImage(imgPhoto,
            new Rectangle(destX, destY, destWidth, destHeight),
            new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
            GraphicsUnit.Pixel);

            grPhoto.Dispose();
            return bmPhoto;
        }

        static Image FixedSize(Image imgPhoto, int Width, int Height)
        {
            int sourceWidth = imgPhoto.Width;
            int sourceHeight = imgPhoto.Height;
            int sourceX = 0;
            int sourceY = 0;
            int destX = 0;
            int destY = 0;

            float nPercent = 0;
            float nPercentW = 0;
            float nPercentH = 0;

            nPercentW = ((float)Width / (float)sourceWidth);
            nPercentH = ((float)Height / (float)sourceHeight);

            //if we have to pad the height pad both the top and the bottom
            //with the difference between the scaled height and the desired height
            if (nPercentH < nPercentW)
            {
                nPercent = nPercentH;
                destX = (int)((Width - (sourceWidth * nPercent)) / 2);
            }
            else
            {
                nPercent = nPercentW;
                destY = (int)((Height - (sourceHeight * nPercent)) / 2);
            }

            int destWidth = (int)(sourceWidth * nPercent);
            int destHeight = (int)(sourceHeight * nPercent);

            Bitmap bmPhoto = new Bitmap(Width, Height, PixelFormat.Format64bppArgb);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

            Graphics grPhoto = Graphics.FromImage(bmPhoto);
            grPhoto.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;

            grPhoto.Clear(Color.White);
            grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;

            grPhoto.DrawImage(imgPhoto,
              new Rectangle(destX, destY, destWidth, destHeight),
              new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
              GraphicsUnit.Pixel);

            grPhoto.Dispose();
            return bmPhoto;
        }
        static Image Crop(Image imgPhoto, int Width, int Height, AnchorPosition Anchor)
        {
            int sourceWidth = imgPhoto.Width;
            int sourceHeight = imgPhoto.Height;
            int sourceX = 0;
            int sourceY = 0;
            int destX = 0;
            int destY = 0;

            float nPercent = 0;
            float nPercentW = 0;
            float nPercentH = 0;

            nPercentW = ((float)Width / (float)sourceWidth);
            nPercentH = ((float)Height / (float)sourceHeight);

            if (nPercentH < nPercentW)
            {
                nPercent = nPercentW;
                switch (Anchor)
                {
                    case AnchorPosition.Top:
                        destY = 0;
                        break;
                    case AnchorPosition.Bottom:
                        destY = (int)(Height - (sourceHeight * nPercent));
                        break;
                    default:
                        destY = (int)((Height - (sourceHeight * nPercent)) / 2);
                        break;
                }
            }
            else
            {
                nPercent = nPercentH;
                switch (Anchor)
                {
                    case AnchorPosition.Left:
                        destX = 0;
                        break;
                    case AnchorPosition.Right:
                        destX = (int)(Width - (sourceWidth * nPercent));
                        break;
                    default:
                        destX = (int)((Width - (sourceWidth * nPercent)) / 2);
                        break;
                }
            }

            int destWidth = (int)(sourceWidth * nPercent);
            int destHeight = (int)(sourceHeight * nPercent);

            Bitmap bmPhoto = new Bitmap(Width, Height, PixelFormat.Format64bppArgb);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

            Graphics grPhoto = Graphics.FromImage(bmPhoto);
            grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;

            grPhoto.DrawImage(imgPhoto,
              new Rectangle(destX, destY, destWidth, destHeight),
              new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
              GraphicsUnit.Pixel);

            grPhoto.Dispose();
            return bmPhoto;
        }
    }
}