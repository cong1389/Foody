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
    public class PNK_Configuration
    {
        #region fields
        private string key_name;
        private string value_name;
        #endregion

        #region properties
        public string Key_name
        {
            get { return this.key_name; }
            set { this.key_name = value; }
        }
        public string Value_name
        {
            get { return this.value_name; }
            set { this.value_name = value; }
        }
        #endregion

        #region constructor
        public PNK_Configuration()
        {
            this.key_name = string.Empty;
            this.value_name = string.Empty;
        }
        public PNK_Configuration(string key_name,
                    string value_name)
        {
            this.key_name = key_name;
            this.value_name = value_name;
        }
        #endregion

    }
}