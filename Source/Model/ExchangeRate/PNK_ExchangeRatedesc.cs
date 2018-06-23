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
    public class PNK_ExchangeRateDesc
    {
        #region fields
        private int id;
        private int mainId;
        private int langId;
        private string title;
        private string titleUrl;
        private string brief;
        private string detail;
        private decimal amount;
        private string fromCurrency;
        private string toCurrency;
        private string metaTitle;
        private string metaKeyword;
        private string metaDecription;
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
        public string TitleUrl
        {
            get { return this.titleUrl; }
            set { this.titleUrl = value; }
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
        public decimal Amount
        {
            get { return this.amount; }
            set { this.amount = value; }
        }
        public string FromCurrency
        {
            get { return this.fromCurrency; }
            set { this.fromCurrency = value; }
        }
        public string ToCurrency
        {
            get { return this.toCurrency; }
            set { this.toCurrency = value; }
        }
        public string MetaTitle
        {
            get { return this.metaTitle; }
            set { this.metaTitle = value; }
        }
        public string MetaKeyword
        {
            get { return this.metaKeyword; }
            set { this.metaKeyword = value; }
        }
        public string MetaDecription
        {
            get { return this.metaDecription; }
            set { this.metaDecription = value; }
        }
        #endregion

        #region constructor
        public PNK_ExchangeRateDesc()
        {
            this.id = int.MinValue;
            this.mainId = int.MinValue;
            this.langId = int.MinValue;
            this.title = string.Empty;
            this.titleUrl = string.Empty;
            this.brief = string.Empty;
            this.detail = string.Empty;
            this.amount = decimal.MinValue;
            this.fromCurrency = string.Empty;
            this.toCurrency = string.Empty;
            this.metaTitle = string.Empty;
            this.metaKeyword = string.Empty;
            this.metaDecription = string.Empty;
        }
        public PNK_ExchangeRateDesc(int id,
                    int mainId,
                    int langId,
                    string title,
                    string titleUrl,
                    string brief,
                    string detail,
                    decimal amount,
                    string fromCurrency,
                    string toCurrency,
                    string metaTitle,
                    string metaKeyword,
                    string metaDecription)
        {
            this.id = id;
            this.mainId = mainId;
            this.langId = langId;
            this.title = title;
            this.titleUrl = titleUrl;
            this.brief = brief;
            this.detail = detail;
            this.amount = amount;
            this.fromCurrency = fromCurrency;
            this.toCurrency = toCurrency;
            this.metaTitle = metaTitle;
            this.metaKeyword = metaKeyword;
            this.metaDecription = metaDecription;
        }
        #endregion

    }
}