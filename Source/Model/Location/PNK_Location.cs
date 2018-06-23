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
    public class PNK_Location
    {
        #region fields
        private int id;
        private int parentId;
        private int ordering;
        private object postDate;
        private string published;
        private object updateDate;
        private string pathTree;
        #endregion

        #region properties
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public int ParentId
        {
            get { return this.parentId; }
            set { this.parentId = value; }
        }
        public int Ordering
        {
            get { return this.ordering; }
            set { this.ordering = value; }
        }
        public object PostDate
        {
            get { return this.postDate; }
            set { this.postDate = value; }
        }
        public string Published
        {
            get { return this.published; }
            set { this.published = value; }
        }
        public object UpdateDate
        {
            get { return this.updateDate; }
            set { this.updateDate = value; }
        }
        public string PathTree
        {
            get { return this.pathTree; }
            set { this.pathTree = value; }
        }
        #endregion

        #region constructor

        public PNK_Location(int id,
                    int parentId,
                    int ordering,
                    object postDate,
                    string published,
                    object updateDate,
                    string pathTree)
        {
            this.id = id;
            this.parentId = parentId;
            this.ordering = ordering;
            this.postDate = postDate;
            this.published = published;
            this.updateDate = updateDate;
            this.pathTree = pathTree;
        }
        #endregion

        #region extend

        private PNK_LocationDesc objLocDesc;

        public PNK_LocationDesc ObjLocDesc
        {
            get { return objLocDesc; }
            set { objLocDesc = value; }
        }

        public PNK_Location()
        {
            this.id = int.MinValue;
            this.parentId = int.MinValue;
            this.ordering = int.MinValue;
            this.postDate = DateTime.MinValue;
            this.published = string.Empty;
            this.updateDate = DateTime.MinValue;
            this.pathTree = string.Empty;
            this.objLocDesc = new PNK_LocationDesc();
        }

        #endregion

    }
}