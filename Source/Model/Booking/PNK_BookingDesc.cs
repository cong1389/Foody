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
    public class PNK_BookingDesc
    {
        #region fields
        private int id;
        private int mainId;
        private int langId;
        private string name;
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
        public string Name
        {
            get { return this.name; }
            set { this.name = value; }
        }
        #endregion

        #region constructor
        public PNK_BookingDesc()
        {
            this.id = int.MinValue;
            this.mainId = int.MinValue;
            this.langId = int.MinValue;
            this.name = string.Empty;
        }
        public PNK_BookingDesc(int id,
                    int mainId,
                    int langId,
                    string name)
        {
            this.id = id;
            this.mainId = mainId;
            this.langId = langId;
            this.name = name;
        }
        #endregion

    }
}