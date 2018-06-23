/**
                             * @version $Id:
                             * @package Digicom.NET
                             * @author Digicom Dev <dev@dgc.vn>
                             * @copyright Copyright (C) 2011 by Digicom. All rights reserved.
                             * @link http://www.dgc.vn
                            */


namespace Cb.Model
{
    public class PNK_GenControlDesc
    {
        #region fields
        private int id;
        private int mainId;
        private int langId;
        private string name;
        private string nameUrl;
        private string brief;
        private string detail;

        private string metaTitle;
        private string metaKeyword;
        private string metaDecription;

        private string h1;
        private string h2;
        private string h3;

        private string value;
        private int controlType;

        private string treeNameDesc;
        private string treeNameUrlDesc;
        private int treeLevelDesc;
        private string treeIdDesc;

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
        public string NameUrl
        {
            get { return this.nameUrl; }
            set { this.nameUrl = value; }
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

        public string MetaTitle
        {
            get { return this.metaTitle; }
            set { this.metaTitle = value; }
        }
        public string MetaKeyword
        {
            get { return this.metaKeyword; }
            set { this.metaKeyword = value; }
        }
        public string MetaDecription
        {
            get { return this.metaDecription; }
            set { this.metaDecription = value; }
        }

        public string H1
        {
            get { return this.h1; }
            set { this.h1 = value; }
        }

        public string H2
        {
            get { return this.h2; }
            set { this.h2 = value; }
        }

        public string H3
        {
            get { return this.h3; }
            set { this.h3 = value; }
        }

        public string Value
        {
            get { return this.value; }
            set { this.value = value; }
        }

        public int ControlType
        {
            get { return this.controlType; }
            set { this.controlType = value; }
        }

        public string TreeNameDesc
        {
            get { return this.treeNameDesc; }
            set { this.treeNameDesc = value; }
        }
        public string TreeNameUrlDesc
        {
            get { return this.treeNameUrlDesc; }
            set { this.treeNameUrlDesc = value; }
        }
        public int TreeLevelDesc
        {
            get { return this.treeLevelDesc; }
            set { this.treeLevelDesc = value; }
        }
        public string TreeIdDesc
        {
            get { return this.treeIdDesc; }
            set { this.treeIdDesc = value; }
        }

        #endregion

        #region constructor
        public PNK_GenControlDesc()
        {
            this.id = int.MinValue;
            this.mainId = int.MinValue;
            this.langId = int.MinValue;
            this.name = string.Empty;
            this.nameUrl = string.Empty;
            this.brief = string.Empty;
            this.detail = string.Empty;
            this.metaTitle = string.Empty;
            this.metaKeyword = string.Empty;
            this.metaDecription = string.Empty;
            this.h1 = string.Empty;
            this.h2 = string.Empty;
            this.h3 = string.Empty;

            this.value = string.Empty;
            this.controlType = int.MinValue;

            this.treeNameDesc = string.Empty;
            this.treeNameUrlDesc = string.Empty;
            this.treeLevelDesc = int.MinValue;
            this.treeIdDesc = string.Empty;
        }
        public PNK_GenControlDesc(int id,
                    int mainId,
                    int langId,
                    string name,
                    string nameUrl,
                    string brief,
                    string detail,
                    string metaTitle,
                    string metaKeyword,
                    string metaDecription,
                    string h1,
                    string h2,
                    string h3,
                    string value,
                    int controlType,
                    string treeNameDesc,
                    string treeNameUrlDesc,
                    int treeLevelDesc,
                    string treeIdDesc)
        {
            this.id = id;
            this.mainId = mainId;
            this.langId = langId;
            this.name = name;
            this.nameUrl = nameUrl;
            this.brief = brief;
            this.detail = detail;
            this.metaTitle = metaTitle;
            this.metaKeyword = metaKeyword;
            this.metaDecription = metaDecription;
            this.h1 = h1;
            this.h2 = h2;
            this.h3 = h3;
            this.value = value;
            this.controlType = controlType;
            this.treeNameDesc = treeNameDesc;
            this.treeNameUrlDesc = treeNameUrlDesc;
            this.treeLevelDesc = treeLevelDesc;
            this.treeIdDesc = treeIdDesc;
        }
        #endregion

    }
}