using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace Cb.Model.Xml
{
    [XmlRoot("ConfigCatalog")]
    public class XMLConfigCatalog
    {
        private XMLConfigs lst;

        [XmlArrayItem("Config", typeof(XMLConfig))]
        [XmlArray("Configs")]
        public XMLConfigs Lst
        {
            get { return lst; }
            set { lst = value; }
        }

        public XMLConfigCatalog()
        {
            this.lst = new XMLConfigs();
        }

        public XMLConfigCatalog(XMLConfigs lst)
        {
            this.lst = lst;
        }
    }
}
