using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace Cb.Model.Xml
{
    public class XMLConfig
    {
        #region Field
        private string name;
        private string value;
        private string att;



        private XMLConfigs lst;

        #endregion

        #region Properties

        [XmlArrayItem("Config", typeof(XMLConfig))]
        [XmlArray("Configs")]
        public XMLConfigs Lst
        {
            get { return lst; }
            set { lst = value; }
        }


        [XmlAttribute("value")]
        public string Value
        {
            get { return value; }
            set { this.value = value; }
        }

        [XmlAttribute("name")]
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        [XmlAttribute("att")]
        public string Att
        {
            get { return att; }
            set { att = value; }
        }
        #endregion

        #region Contructor
        public XMLConfig()
        {
            this.name = string.Empty;
            this.value = string.Empty;
            this.att = string.Empty;

            this.lst = new XMLConfigs();
        }

        public XMLConfig(string name, string link)
        {
            this.name = name;
            this.value = link;
            this.lst = new XMLConfigs();
        }

        #endregion
    }
}
