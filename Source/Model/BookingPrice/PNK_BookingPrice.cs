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
    public class PNK_BookingPrice
    {
        #region fields
        private int iD;
        private int productId;
        private string name;
        private double value;
        private string priceClass;

        private int min;
        private int max;
        private string groupType;
        private string published;
        private int ordering;

        #endregion

        #region properties
        public int ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }
        public int ProductId
        {
            get { return this.productId; }
            set { this.productId = value; }
        }
        public string Name
        {
            get { return this.name; }
            set { this.name = value; }
        }
        public double Value
        {
            get { return this.value; }
            set { this.value = value; }
        }
        public string PriceClass
        {
            get { return this.priceClass; }
            set { this.priceClass = value; }
        }

        public int Min
        {
            get { return this.min; }
            set
            { this.min = value == int.MinValue ? 1 : value; }
        }
        public int Max
        {
            get { return this.max; }
            set { this.max = value == int.MinValue ? 1 : value; }
        }
        public string GroupType
        {
            get { return this.groupType; }
            set { this.groupType = value; }
        }
        public string Published
        {
            get { return this.published; }
            set { this.published = value; }
        }
        public int Ordering
        {
            get { return this.ordering; }
            set { this.ordering = value; }
        }
        #endregion

        #region constructor
        public PNK_BookingPrice()
        {
            this.iD = int.MinValue;
            this.name = string.Empty;
            this.value = double.MinValue;
            this.priceClass = string.Empty;
            this.productId = int.MinValue;
            this.min = int.MinValue;
            this.max = int.MinValue;
            this.groupType = string.Empty;
            this.published = string.Empty;
            this.ordering = int.MinValue;
        }
        public PNK_BookingPrice(int iD,
                    string name,
                    double value,
                    string priceClass,
                    int productId,
                    int min,
                    int max,
                    string groupType,
                    string published,
                    int ordering)
        {
            this.iD = iD;
            this.name = name;
            this.value = value;
            this.priceClass = priceClass;
            this.productId = productId;
            this.min = min;
            this.max = max;
            this.groupType = groupType;
            this.published = published;
            this.ordering = ordering;
        }
        #endregion

    }
}