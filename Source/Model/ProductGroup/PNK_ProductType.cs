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

namespace Cb.Model.ProductGroup
{
    public class PNK_ProductGroup
    {
        #region fields
        private int id;
        private int divisionId;
        private int productTypeId;
        private string image;
        private string resource;
        private string published;
        private DateTime postDate;
        private DateTime updateDate;
        private int ordering;
        private string code;
        private PNK_ProductGroupDesc contentstaticDesc;

        #endregion

        #region properties

        public PNK_ProductGroupDesc ProductGroupDesc
        {
            get { return contentstaticDesc; }
            set { contentstaticDesc = value; }
        }
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public int DivisionId
        {
            get { return this.divisionId; }
            set { this.divisionId = value; }
        }
        public int ProductTypeId
        {
            get { return this.productTypeId; }
            set { this.productTypeId = value; }
        }
        public string Image
        {
            get { return this.image; }
            set { this.image = value; }
        }
        public string Latitude
        {
            get { return this.resource; }
            set { this.resource = value; }
        }
        public string Published
        {
            get { return this.published; }
            set { this.published = value; }
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
        public string Code
        {
            get { return this.code; }
            set { this.code = value; }
        }
        #endregion

        #region constructor
        public PNK_ProductGroup()
        {
            this.id = int.MinValue;
            this.divisionId = int.MinValue;
            this.productTypeId = int.MinValue;
            this.image = string.Empty;
            this.resource = string.Empty;
            this.published = string.Empty;
            this.postDate = DateTime.MinValue;
            this.updateDate = DateTime.MinValue;
            this.ordering = int.MinValue;
            this.code = string.Empty;
            contentstaticDesc = new PNK_ProductGroupDesc();
        }
        public PNK_ProductGroup(int id,
                    int divisionId,
                    int productTypeId,
                    string image,
                    string resource,
                    string published,
                    DateTime postDate,
                    DateTime updateDate,
                    int ordering,
                    string longitude, string code)
        {
            this.id = id;
            this.divisionId = divisionId;
            this.productTypeId = productTypeId;
            this.image = image;
            this.resource = resource;
            this.published = published;
            this.postDate = postDate;
            this.updateDate = updateDate;
            this.ordering = ordering;
            this.code = code;
        }
        #endregion
    }
}