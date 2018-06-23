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

namespace Cb.Model.Products
{
    public class PNK_Product
    {
        #region fields
        private int id;
        private int categoryId;
        private string image;

        private string published;
        private string hot;
        private string feature;
        private string promotion;
        private string post;
        private DateTime postDate;
        private DateTime updateDate;
        private int ordering;

        private string longitude;
        private string latitude;

        private string price;
        private string area;
        private string district;
        private string bedroom;
        private string bathroom;
        private string code;
        private string status;
        private string province;
        private string website;
        private string updateBy;
        private string cost;
        private string page;
        private int imageType;
        private string imageFont;

        private PNK_ProductDesc productDesc;

        private string categoryNameDesc;
        private string categoryUrlDesc;
        private string categoryBriefDesc;
        private string categoryDetailDesc;
        private string categoryMetaTitleDesc;
        private string categoryMetaKeywordDesc;
        private string categoryMetaDecriptionDesc;

        #endregion

        #region properties
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public int CategoryId
        {
            get { return this.categoryId; }
            set { this.categoryId = value; }
        }
        public string Image
        {
            get { return this.image; }
            set { this.image = value; }
        }
        public string Latitude
        {
            get { return this.latitude; }
            set { this.latitude = value; }
        }
        public string Published
        {
            get { return this.published; }
            set { this.published = value; }
        }
        public string Hot
        {
            get { return this.hot; }
            set { this.hot = value; }
        }
        public string Feature
        {
            get { return this.feature; }
            set { this.feature = value; }
        }
        public string Promotion
        {
            get { return this.promotion; }
            set { this.promotion = value; }
        }
        public DateTime PostDate
        {
            get { return this.postDate; }
            set { this.postDate = value; }
        }
        public DateTime UpdateDate
        {
            get { return this.updateDate; }
            set { this.updateDate = value; }
        }
        public int Ordering
        {
            get { return this.ordering; }
            set { this.ordering = value; }
        }
        public string Longitude
        {
            get { return this.longitude; }
            set { this.longitude = value; }
        }
        public string Post
        {
            get { return this.post; }
            set { this.post = value; }
        }

        public string Price
        {
            get { return this.price; }
            set { this.price = value; }
        }
        public string Area
        {
            get { return this.area; }
            set { this.area = value; }
        }
        public string District
        {
            get { return this.district; }
            set { this.district = value; }
        }
        public string Bedroom
        {
            get { return this.bedroom; }
            set { this.bedroom = value; }
        }
        public string Bathroom
        {
            get { return this.bathroom; }
            set { this.bathroom = value; }
        }
        public string Status
        {
            get { return this.status; }
            set { this.status = value; }
        }
        public string Code
        {
            get { return this.code; }
            set { this.code = value; }
        }
        public string Province
        {
            get { return this.province; }
            set { this.province = value; }
        }
        public string Website
        {
            get { return this.website; }
            set { this.website = value; }
        }

        public string UpdateBy
        {
            get { return this.updateBy; }
            set { this.updateBy = value; }
        }
        public string Cost
        {
            get { return this.cost; }
            set { this.cost = value; }
        }
        public string Page
        {
            get { return this.page; }
            set { this.page = value; }
        }
        public int ImageType
        {
            get { return this.imageType; }
            set { this.imageType = value; }
        }
        public string ImageFont
        {
            get { return this.imageFont; }
            set { this.imageFont = value; }
        }
        public PNK_ProductDesc ProductDesc
        {
            get { return productDesc; }
            set { productDesc = value; }
        }

        public string CategoryNameDesc
        {
            get { return categoryNameDesc; }
            set { categoryNameDesc = value; }
        }

        public string CategoryUrlDesc
        {
            get { return categoryUrlDesc; }
            set { categoryUrlDesc = value; }
        }

        public string CategoryBriefDesc
        {
            get { return categoryBriefDesc; }
            set { categoryBriefDesc = value; }
        }

        public string CategoryDetailDesc
        {
            get { return categoryDetailDesc; }
            set { categoryDetailDesc = value; }
        }
        public string CategoryMetaTitleDesc
        {
            get { return categoryMetaTitleDesc; }
            set { categoryMetaTitleDesc = value; }
        }
        public string CategoryMetaKeywordDesc
        {
            get { return categoryMetaKeywordDesc; }
            set { categoryMetaKeywordDesc = value; }
        }
        public string CategoryMetaDecriptionDesc
        {
            get { return categoryMetaDecriptionDesc; }
            set { categoryMetaDecriptionDesc = value; }
        }



        #endregion

        #region constructor

        public PNK_Product()
        {
            this.id = int.MinValue;
            this.categoryId = int.MinValue;
            this.image = string.Empty;
            this.latitude = string.Empty;
            this.published = string.Empty;
            this.hot = string.Empty;
            this.feature = string.Empty;
            this.promotion = string.Empty;
            this.postDate = DateTime.MinValue;
            this.updateDate = DateTime.MinValue;
            this.ordering = int.MinValue;
            this.longitude = string.Empty;

            this.price = string.Empty;
            this.area = string.Empty;
            this.district = string.Empty;
            this.bedroom = string.Empty;
            this.bathroom = string.Empty;
            this.status = string.Empty;
            this.code = string.Empty;
            this.province = string.Empty;
            this.website = string.Empty;
            this.updateBy = string.Empty;
            this.cost = string.Empty;
            this.page = string.Empty;
            this.imageType = int.MinValue;
            this.imageFont = string.Empty;

            productDesc = new PNK_ProductDesc();
        }

        public PNK_Product(int id,
                    int categoryId,
                    string image,
                    string latitude,
                    string published,
                    string hot,
                    string feature,
                    string promotion,
                    DateTime postDate,
                    DateTime updateDate,
                    int ordering,
                    string longitude, string post,
                    string price,
                    string area,
                    string district,
                    string bedroom,
                    string bathroom,
                    string status,
                    string code,
                    string province,
                    string website,
                    string updateBy,
                    string cost,
                    string page,
                    int imageType,
                    string imageFont)
        {
            this.id = id;
            this.categoryId = categoryId;
            this.image = image;
            this.latitude = latitude;
            this.published = published;
            this.hot = hot;
            this.feature = feature;
            this.promotion = promotion;
            this.postDate = postDate;
            this.updateDate = updateDate;
            this.ordering = ordering;
            this.longitude = longitude;
            this.post = post;
            this.price = price;
            this.area = area;
            this.district = district;
            this.bedroom = bedroom;
            this.bathroom = bathroom;
            this.status = status;
            this.code = code;
            this.province = province;
            this.website = website;
            this.updateBy = updateBy;
            this.cost = cost;
            this.page = page;
            this.imageType = imageType;
            this.imageFont = imageFont;
        }
        #endregion
    }
}