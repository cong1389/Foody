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
    public class PNK_User
    {
        #region fields
        private int id;
        private string fullName;
        private string username;
        private string password;
        private string phone;
        private string address;
        private string email;
        private string isNewsletter;
        private int role;
        private string published;
        private DateTime postDate;
        private DateTime updateDate;
        private string token;
        private string mobile;
        private int locationId;
        private string image;
        private string locationDesc;

        #endregion

        #region properties
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public string FullName
        {
            get { return this.fullName; }
            set { this.fullName = value; }
        }
        public string Username
        {
            get { return this.username; }
            set { this.username = value; }
        }
        public string Password
        {
            get { return this.password; }
            set { this.password = value; }
        }
        public string Phone
        {
            get { return this.phone; }
            set { this.phone = value; }
        }
        public string Address
        {
            get { return this.address; }
            set { this.address = value; }
        }
        public string Email
        {
            get { return this.email; }
            set { this.email = value; }
        }
        public string IsNewsletter
        {
            get { return this.isNewsletter; }
            set { this.isNewsletter = value; }
        }
        public int Role
        {
            get { return this.role; }
            set { this.role = value; }
        }
        public string Published
        {
            get { return this.published; }
            set { this.published = value; }
        }
        public DateTime PostDate
        {
            get { return this.postDate; }
            set { this.postDate = value; }
        }
        public DateTime UpdateDate
        {
            get { return this.updateDate; }
            set { this.updateDate = value; }
        }
        public string Token
        {
            get { return this.token; }
            set { this.token = value; }
        }
        public string Mobile
        {
            get { return this.mobile; }
            set { this.mobile = value; }
        }
        public int LocationId
        {
            get { return this.locationId; }
            set { this.locationId = value; }
        }
        public string LocationDesc
        {
            get { return locationDesc; }
            set { locationDesc = value; }
        }
        public string Image
        {
            get { return image; }
            set { image = value; }
        }
        #endregion

        #region constructor
        public PNK_User()
        {
            this.id = int.MinValue;
            this.fullName = string.Empty;
            this.username = string.Empty;
            this.password = string.Empty;
            this.phone = string.Empty;
            this.address = string.Empty;
            this.email = string.Empty;
            this.isNewsletter = string.Empty;
            this.role = int.MinValue;
            this.published = string.Empty;
            this.postDate = DateTime.MinValue;
            this.updateDate = DateTime.MinValue;
            this.token = string.Empty;
            this.mobile = string.Empty;
            this.image = string.Empty;
            this.locationId = int.MinValue;
        }
        public PNK_User(int id,
                    string fullName,
                    string username,
                    string password,
                    string phone,
                    string address,
                    string email,
                    string isNewsletter,
                    int role,
                    string published,
                    DateTime postDate,
                    DateTime updateDate,
                    string token,
                    string mobile,
                    string image,
                    int locationId)
        {
            this.id = id;
            this.fullName = fullName;
            this.username = username;
            this.password = password;
            this.phone = phone;
            this.address = address;
            this.email = email;
            this.isNewsletter = isNewsletter;
            this.role = role;
            this.published = published;
            this.postDate = postDate;
            this.updateDate = updateDate;
            this.token = token;
            this.mobile = mobile;
            this.image = image;
            this.locationId = locationId;
        }
        #endregion

    }
}