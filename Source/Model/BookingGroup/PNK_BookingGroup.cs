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
    public class PNK_BookingGroup
    {
        #region fields
        private int id;
        private string name;
        private int ordering;
        private string groupType;
        #endregion

        #region properties
        public int ID
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public string Name
        {
            get { return this.name; }
            set { this.name = value; }
        }
        public int Ordering
        {
            get { return this.ordering; }
            set { this.ordering = value; }
        }
        public string GroupType
        {
            get { return this.groupType; }
            set { this.groupType = value; }
        }
        #endregion

        #region constructor
        public PNK_BookingGroup()
        {
            this.id = int.MinValue;
            this.name = string.Empty;
            this.ordering = int.MinValue;
            this.groupType = string.Empty;
        }
        public PNK_BookingGroup(int id,
                    string name,
                    int ordering,
                    string groupType)
        {
            this.id = id;
            this.name = name;
            this.ordering = ordering;
            this.groupType = groupType;
        }
        #endregion

    }
}