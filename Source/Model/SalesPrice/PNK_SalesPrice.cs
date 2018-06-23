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
using System.Globalization;

namespace Cb.Model
{
    public class PNK_SalesPrice
    {
        #region fields
        private Int64 rowDesc;
        private int id;
        private string productId;
        private string storeGroup;
        private string salesPriceId;
        private string unitOfMeasureId;
        private DateTime startingDate;
        private DateTime endingDate;
        private decimal unitPrice;
        private int priceIncVAT;
        private int lineType;
        private string giftProductId;
        private string giftDescription;
        private decimal originPrice;
        private decimal dealPrice;
        private decimal quantity;
        private string periodicDiscountId;
        private int lineId;
                
        private string provinceNameDesc;
        private string salePriceTypeNameDesc;
        private string unitNameDesc;


        #endregion

        #region properties
        public Int64 RowDesc
        {
            get { return this.rowDesc; }
            set { this.rowDesc = value; }
        }
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public string ProductId
        {
            get { return this.productId; }
            set { this.productId = value; }
        }
        public string StoreGroup
        {
            get { return this.storeGroup; }
            set { this.storeGroup = value; }
        }
        public string SalesPriceId
        {
            get { return this.salesPriceId; }
            set { this.salesPriceId = value; }
        }
        public string UnitOfMeasureId
        {
            get { return this.unitOfMeasureId; }
            set { this.unitOfMeasureId = value; }
        }
        public DateTime StartingDate
        {
            get { return this.startingDate; }
            set { this.startingDate =value; }
        }
        public DateTime EndingDate
        {
            get { return this.endingDate; }
            set { this.endingDate = value; }
        }
        public decimal UnitPrice
        {
            get { return this.unitPrice; }
            set { this.unitPrice = value; }
        }
        public int PriceIncVAT
        {
            get { return this.priceIncVAT; }
            set { this.priceIncVAT = value; }
        }
        public int LineType
        {
            get { return this.lineType; }
            set { this.lineType = value; }
        }
        public string GiftProductId
        {
            get { return this.giftProductId; }
            set { this.giftProductId = value; }
        }
        public string GiftDescription
        {
            get { return this.giftDescription; }
            set { this.giftDescription = value; }
        }
        public decimal OriginPrice
        {
            get { return this.originPrice; }
            set { this.originPrice = value; }
        }
        public decimal DealPrice
        {
            get { return this.dealPrice; }
            set { this.dealPrice = value; }
        }
        public decimal Quantity
        {
            get { return this.quantity; }
            set { this.quantity = value; }
        }
        public string PeriodicDiscountId
        {
            get { return this.periodicDiscountId; }
            set { this.periodicDiscountId = value; }
        }
        public int LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }
        public string ProvinceNameDesc
        {
            get { return this.provinceNameDesc; }
            set { this.provinceNameDesc = value; }
        }
        public string SalePriceTypeNameDesc
        {
            get { return this.salePriceTypeNameDesc; }
            set { this.salePriceTypeNameDesc = value; }
        }
        public string UnitNameDesc
        {
            get { return this.unitNameDesc; }
            set { this.unitNameDesc = value; }
        }

        #endregion

        #region constructor
        public PNK_SalesPrice()
        {         
            this.id = int.MinValue;
            this.productId = string.Empty;
            this.storeGroup = string.Empty;
            this.salesPriceId = string.Empty;
            this.unitOfMeasureId = string.Empty;
            this.startingDate = DateTime.MinValue;
            this.endingDate = DateTime.MinValue;
            this.unitPrice = decimal.MinValue;
            this.priceIncVAT = int.MinValue;
            this.lineType = int.MinValue;
            this.giftProductId = string.Empty;
            this.giftDescription = string.Empty;
            this.originPrice = decimal.MinValue;
            this.dealPrice = decimal.MinValue;
            this.quantity = decimal.MinValue;
            this.periodicDiscountId = string.Empty;
            this.lineId = int.MinValue;
        }
        public PNK_SalesPrice(
                    int id,
                    string productId,
                    string storeGroup,
                    string salesPriceId,
                    string unitOfMeasureId,
                    DateTime startingDate,
                    DateTime endingDate,
                    decimal unitPrice,
                    int priceIncVAT,
                    int lineType,
                    string giftProductId,
                    string giftDescription,
                    decimal originPrice,
                    decimal dealPrice,
                    decimal quantity,
                    string periodicDiscountId,
                    int lineId)
        {
          
            this.id = id;
            this.productId = productId;
            this.storeGroup = storeGroup;
            this.salesPriceId = salesPriceId;
            this.unitOfMeasureId = unitOfMeasureId;
            this.startingDate = DateTime.MinValue;
            this.endingDate = DateTime.MinValue;
            this.unitPrice = unitPrice;
            this.priceIncVAT = priceIncVAT;
            this.lineType = lineType;
            this.giftProductId = giftProductId;
            this.giftDescription = giftDescription;
            this.originPrice = originPrice;
            this.dealPrice = dealPrice;
            this.quantity = quantity;
            this.periodicDiscountId = periodicDiscountId;
            this.lineId = lineId;
          
        }
        #endregion

    }
}