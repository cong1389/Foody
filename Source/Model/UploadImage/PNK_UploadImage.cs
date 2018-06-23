/**
                             * @version $Id:
                             * @package Digicom.NET
                             * @author Digicom Dev <dev@dgc.vn>
                             * @copyright Copyright (C) 2011 by Digicom. All rights reserved.
                             * @link http://www.dgc.vn
                            */

using System;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using System.Text;

namespace Cb.Model
{
    public class PNK_UploadImage
    {
        #region fields
        private int id;
        private string name;
        private string published;
        private int type;
        private string imagePath;
        private int ordering;
        private DateTime postDate;
        private DateTime updatedate;
        private int productId;

        private string longiTude;
        private string latitude;
        #endregion

        #region properties
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public string Name
        {
            get { return this.name; }
            set { this.name = value; }
        }
        public string Published
        {
            get { return this.published; }
            set { this.published = value; }
        }
        public int Type
        {
            get { return this.type; }
            set { this.type = value; }
        }
        public string ImagePath
        {
            get { return this.imagePath; }
            set { this.imagePath = value; }
        }
        public int Ordering
        {
            get { return this.ordering; }
            set { this.ordering = value; }
        }
        public DateTime PostDate
        {
            get { return this.postDate; }
            set { this.postDate = value; }
        }
        public DateTime Updatedate
        {
            get { return this.updatedate; }
            set { this.updatedate = value; }
        }
        public int ProductId
        {
            get { return this.productId; }
            set { this.productId = value; }
        }

        public string LongiTude
        {
            get { return this.longiTude; }
            set { this.longiTude = value; }
        }
        public string Latitude
        {
            get { return this.latitude; }
            set { this.latitude = value; }
        }

        #endregion

        #region constructor
        public PNK_UploadImage()
        {
            this.id = int.MinValue;
            this.name = string.Empty;
            this.published = string.Empty;
            this.type = int.MinValue;
            this.imagePath = string.Empty;
            this.ordering = int.MinValue;
            this.postDate = DateTime.MinValue;
            this.updatedate = DateTime.MinValue;
            this.productId = int.MinValue;

            this.longiTude = string.Empty;
            this.latitude = string.Empty;
        }
        public PNK_UploadImage(int id,
                    string name,
                    string published,
                    int type,
                    string imagePath,
                    int ordering,
                    DateTime postDate,
                    DateTime updatedate,
                    int productId,
                    string longiTude,
                    string latitude)
        {
            this.id = id;
            this.name = name;
            this.published = published;
            this.type = type;
            this.imagePath = imagePath;
            this.ordering = ordering;
            this.postDate = postDate;
            this.updatedate = updatedate;
            this.productId = productId;

            this.longiTude = longiTude;
            this.latitude = latitude;
        }
        #endregion

    }
}