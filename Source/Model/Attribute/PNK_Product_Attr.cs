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
    public class PNK_Product_Attr
    {
        #region fields
        private int productId;
        private int attrId;
        private string value;
        #endregion

        #region properties
        public int ProductId
        {
            get { return this.productId; }
            set { this.productId = value; }
        }
        public int AttrId
        {
            get { return this.attrId; }
            set { this.attrId = value; }
        }
        public string Value
        {
            get { return this.value; }
            set { this.value = value; }
        }
        #endregion

        #region constructor
        public PNK_Product_Attr()
        {
            this.productId = int.MinValue;
            this.attrId = int.MinValue;
            this.value = string.Empty;
        }
        public PNK_Product_Attr(int productId,
                    int attrId,
                    string value)
        {
            this.productId = productId;
            this.attrId = attrId;
            this.value = value;
        }
        #endregion

    }
}