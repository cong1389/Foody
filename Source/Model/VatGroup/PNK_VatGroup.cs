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
    public class PNK_VatGroup
    {
        #region fields
        private string id;
        private string name;
        private int vATPercent;
        private string lastDate;
        private string userId;
        #endregion

        #region properties
        public string Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public string Name
        {
            get { return this.name; }
            set { this.name = value; }
        }
        public int VATPercent
        {
            get { return this.vATPercent; }
            set { this.vATPercent = value; }
        }
        public string LastDate
        {
            get { return this.lastDate; }
            set { this.lastDate = value; }
        }
        public string UserId
        {
            get { return this.userId; }
            set { this.userId = value; }
        }
        #endregion

        #region constructor
        public PNK_VatGroup()
        {
            this.id = string.Empty;
            this.name = string.Empty;
            this.vATPercent = int.MinValue;
            this.lastDate = string.Empty;
            this.userId = string.Empty;
        }
        public PNK_VatGroup(string id,
                    string name,
                    int vATPercent,
                    string lastDate,
                    string userId)
        {
            this.id = id;
            this.name = name;
            this.vATPercent = vATPercent;
            this.lastDate = lastDate;
            this.userId = userId;
        }
        #endregion

    }
}