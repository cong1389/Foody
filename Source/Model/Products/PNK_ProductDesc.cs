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
    public class PNK_ProductDesc
    {
        #region fields
        private int id;
        private int mainId;
        private int langId;
        private string title;
        private string brief;
        private string detail;
        private string require;
        private string titleurl;
        private string position;
        private string utility;
        private string design;
        private string pictures;
        private string payment;
        private string contact;
        private string metadescription;
        private string metaKeyword;
        private string metaTitle;
        private string h1;
        private string h2;
        private string h3;

        private string productDivisionId;
        private string productTypeId;
        private string productGroupId;
        private string taxPercentId;
        private string unitId;
        private string fromDate;
        private string brandId;
        private decimal stock;

        private string brandNameDesc;
        private string productGroupNameDesc;

        #endregion

        #region properties
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public int MainId
        {
            get { return this.mainId; }
            set { this.mainId = value; }
        }
        public int LangId
        {
            get { return this.langId; }
            set { this.langId = value; }
        }
        public string Title
        {
            get { return this.title; }
            set { this.title = value; }
        }
        public string Brief
        {
            get { return this.brief; }
            set { this.brief = value; }
        }
        public string Detail
        {
            get { return this.detail; }
            set { this.detail = value; }
        }
        public string Require
        {
            get { return this.require; }
            set { this.require = value; }
        }
        public string TitleUrl
        {
            get { return this.titleurl; }
            set { this.titleurl = value; }
        }
        public string Position
        {
            get { return this.position; }
            set { this.position = value; }
        }
        public string Utility
        {
            get { return this.utility; }
            set { this.utility = value; }
        }
        public string Design
        {
            get { return this.design; }
            set { this.design = value; }
        }
        public string Pictures
        {
            get { return this.pictures; }
            set { this.pictures = value; }
        }
        public string Payment
        {
            get { return this.payment; }
            set { this.payment = value; }
        }
        public string Contact
        {
            get { return this.contact; }
            set { this.contact = value; }
        }
        public string Metadescription
        {
            get { return this.metadescription; }
            set { this.metadescription = value; }
        }
        public string MetaKeyword
        {
            get { return this.metaKeyword; }
            set { this.metaKeyword = value; }
        }
        public string MetaTitle
        {
            get { return this.metaTitle; }
            set { this.metaTitle = value; }
        }
        public string H1
        {
            get { return this.h1; }
            set { this.h1 = value; }
        }
        public string H2
        {
            get { return this.h2; }
            set { this.h2 = value; }
        }
        public string H3
        {
            get { return this.h3; }
            set { this.h3 = value; }
        }
        public string ProductDivisionId
        {
            get { return this.productDivisionId; }
            set { this.productDivisionId = value; }
        }
        public string ProductTypeId
        {
            get { return this.productTypeId; }
            set { this.productTypeId = value; }
        }
        public string ProductGroupId
        {
            get { return this.productGroupId; }
            set { this.productGroupId = value; }
        }
        public string TaxPercentId
        {
            get { return this.taxPercentId; }
            set { this.taxPercentId = value; }
        }
        public string UnitId
        {
            get { return this.unitId; }
            set { this.unitId = value; }
        }
        public string FromDate
        {
            get { return this.fromDate; }
            set { this.fromDate = value; }
        }
        public string BrandId
        {
            get { return this.brandId; }
            set { this.brandId = value; }
        }
        public decimal Stock
        {
            get { return this.stock; }
            set { this.stock = value; }
        }
        public string BrandNameDesc
        {
            get { return this.brandNameDesc; }
            set { this.brandNameDesc = value; }
        }
        public string ProductGroupNameDesc
        {
            get { return this.productGroupNameDesc; }
            set { this.productGroupNameDesc = value; }
        }
        #endregion

        #region constructor
        public PNK_ProductDesc()
        {
            this.id = int.MinValue;
            this.mainId = int.MinValue;
            this.langId = int.MinValue;
            this.title = string.Empty;
            this.brief = string.Empty;
            this.detail = string.Empty;
            this.require = string.Empty;
            this.titleurl = string.Empty;
            this.position = string.Empty;
            this.utility = string.Empty;
            this.design = string.Empty;
            this.pictures = string.Empty;
            this.payment = string.Empty;
            this.contact = string.Empty;
            this.metadescription = string.Empty;
            this.metaKeyword = string.Empty;
            this.metaTitle = string.Empty;
            this.h1 = string.Empty;
            this.h2 = string.Empty;
            this.h3 = string.Empty;

            this.productDivisionId = string.Empty;
            this.productTypeId = string.Empty;
            this.productGroupId = string.Empty;
            this.taxPercentId = string.Empty;
            this.unitId = string.Empty;
            this.fromDate = string.Empty;
            this.brandId = string.Empty;
            this.stock = decimal.MinValue;
            this.brandNameDesc = string.Empty;
        }
        public PNK_ProductDesc(int id,
                    int mainId,
                    int langId,
                    string title,
                    string brief,
                    string detail,
                    string require,
                    string titleurl,
                    string position,
                    string utility,
                    string design,
                    string pictures,
                    string payment,
                    string contact,
                    string metadescription,
                    string metaKeyword,
                    string metaTitle,
                    string h1,
                    string h2,
                    string h3,
                    string productDivisionId,
                    string productTypeId,
                    string productGroupId,
                    string taxPercentId,
                    string unitId,
                    string fromDate,
                    string brandId,
                    decimal stock,
                     string brandNameDesc)
        {
            this.id = id;
            this.mainId = mainId;
            this.langId = langId;
            this.title = title;
            this.brief = brief;
            this.detail = detail;
            this.require = require;
            this.titleurl = titleurl;
            this.position = position;
            this.utility = utility;
            this.design = design;
            this.pictures = pictures;
            this.payment = payment;
            this.contact = contact;
            this.metadescription = metadescription;
            this.metaKeyword = metaKeyword;
            this.metaTitle = metaTitle;
            this.h1 = h1;
            this.h2 = h2;
            this.h3 = h3;

            this.productDivisionId = productDivisionId;
            this.productTypeId = productTypeId;
            this.productGroupId = productGroupId;
            this.taxPercentId = taxPercentId;
            this.unitId = unitId;
            this.fromDate = fromDate;
            this.brandId = brandId;
            this.stock = stock;
            this.brandNameDesc = brandNameDesc;
        }
        #endregion
    }
}