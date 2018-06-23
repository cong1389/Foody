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

namespace Cb.Model.ContentStatic
{
    public class PNK_ContentStaticDesc
    {
        #region fields
        private int id;
        private int mainId;
        private int langId;
        private string title;
        private string titleurl;
        private string brief;
        private string detail;

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
            get { return this.titleurl; }
            set { this.titleurl = value; }
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

        #endregion

        #region constructor
        public PNK_ContentStaticDesc()
        {
            this.id = int.MinValue;
            this.mainId = int.MinValue;
            this.langId = int.MinValue;
            this.title = string.Empty;
            this.titleurl = string.Empty;
            this.brief = string.Empty;
            this.detail = string.Empty;
        }
        public PNK_ContentStaticDesc(int id,
                    int mainId,
                    int langId,
                    string title,
                    string titleurl,
                    string brief,
                    string detail

                   )
        {
            this.id = id;
            this.mainId = mainId;
            this.langId = langId;
            this.title = title;
            this.titleurl = titleurl;
            this.brief = brief;
            this.detail = detail;
        }
        #endregion
    }
}