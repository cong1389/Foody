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
    public class PNK_UnitMeasure
    {
        #region fields
        private string id;
        private string name;
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
        #endregion

        #region constructor
        public PNK_UnitMeasure()
        {
            this.id = string.Empty;
            this.name = string.Empty;
        }
        public PNK_UnitMeasure(string id,
                    string name)
        {
            this.id = id;
            this.name = name;
        }
        #endregion

    }
}