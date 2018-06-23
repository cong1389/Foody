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
    public class PNK_Province
    {
        #region fields
        private string id;
        private string name;
        private int type;
        private string parentId;
        private int published;
        private int bigCity;
        private int readyToDelivery;
        private string zoneCode;
        private int numOfDayFrom;
        private int numOfDayTo;
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
        public int Type
        {
            get { return this.type; }
            set { this.type = value; }
        }
        public string ParentId
        {
            get { return this.parentId; }
            set { this.parentId = value; }
        }
        public int Published
        {
            get { return this.published; }
            set { this.published = value; }
        }
        public int BigCity
        {
            get { return this.bigCity; }
            set { this.bigCity = value; }
        }
        public int ReadyToDelivery
        {
            get { return this.readyToDelivery; }
            set { this.readyToDelivery = value; }
        }
        public string ZoneCode
        {
            get { return this.zoneCode; }
            set { this.zoneCode = value; }
        }
        public int NumOfDayFrom
        {
            get { return this.numOfDayFrom; }
            set { this.numOfDayFrom = value; }
        }
        public int NumOfDayTo
        {
            get { return this.numOfDayTo; }
            set { this.numOfDayTo = value; }
        }
        #endregion

        #region constructor
        public PNK_Province()
        {
            this.id = string.Empty;
            this.name = string.Empty;
            this.type = int.MinValue;
            this.parentId = string.Empty;
            this.published = int.MinValue;
            this.bigCity = int.MinValue;
            this.readyToDelivery = int.MinValue;
            this.zoneCode = string.Empty;
            this.numOfDayFrom = int.MinValue;
            this.numOfDayTo = int.MinValue;
        }
        public PNK_Province(string id,
                    string name,
                    int type,
                    string parentId,
                    int published,
                    int bigCity,
                    int readyToDelivery,
                    string zoneCode,
                    int numOfDayFrom,
                    int numOfDayTo)
        {
            this.id = id;
            this.name = name;
            this.type = type;
            this.parentId = parentId;
            this.published = published;
            this.bigCity = bigCity;
            this.readyToDelivery = readyToDelivery;
            this.zoneCode = zoneCode;
            this.numOfDayFrom = numOfDayFrom;
            this.numOfDayTo = numOfDayTo;
        }
        #endregion

    }
}