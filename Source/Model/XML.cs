/**
 * @version $Id:
 * @package Cybervn.NET
 * @author Cybervn Dev <dev@cybervn.vn>
 * @copyright Copyright (C) 2009 by Cybervn. All rights reserved.
 * @link http://www.Cybervn.com
 */
using System;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using System.Text;

namespace Cb.Model
{
    public class sd_XML
    {
        #region fields
        private int id;
        private string xmlContent;
        #endregion

        #region properties
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public string XmlContent
        {
            get { return this.xmlContent; }
            set { this.xmlContent = value; }
        }
        #endregion

        #region constructor
        public sd_XML()
        {
            this.id = int.MinValue;
            this.xmlContent = string.Empty;
        }
        public sd_XML(int id,
                    string xmlContent)
        {
            this.id = id;
            this.xmlContent = xmlContent;
        }
        #endregion

    }
}