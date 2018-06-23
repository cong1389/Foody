using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.IO;
using System.Xml;

namespace Cb.Model.Xml
{
    public class XMLConfigSerializer
    {
        private XmlSerializer s = null;
        private Type type = null;

        /// <summary>Default constructor.</summary>
        public XMLConfigSerializer()
        {
            this.type = typeof(XMLConfigCatalog);
            this.s = new XmlSerializer(this.type);
        }

        #region BuidEngine

        /// <summary>Deserializes to an instance of XMLConfigCatalog.</summary>
        /// <param name="xml">String xml.</param>
        /// <returns>XMLConfigCatalog result.</returns>
        public XMLConfigCatalog Deserialize(string xml)
        {
            TextReader reader = new StringReader(xml);
            return Deserialize(reader);
        }

        /// <summary>Deserializes to an instance of XMLConfigCatalog.</summary>
        /// <param name="doc">XmlDocument instance.</param>
        /// <returns>XMLConfigCatalog result.</returns>
        public XMLConfigCatalog Deserialize(XmlDocument doc)
        {
            TextReader reader = new StringReader(doc.OuterXml);
            return Deserialize(reader);
        }

        /// <summary>Deserializes to an instance of XMLConfigCatalog.</summary>
        /// <param name="reader">TextReader instance.</param>
        /// <returns>XMLConfigCatalog result.</returns>
        public XMLConfigCatalog Deserialize(TextReader reader)
        {
            XMLConfigCatalog o = (XMLConfigCatalog)s.Deserialize(reader);
            reader.Close();
            return o;
        }

        /// <summary>Serializes to an XmlDocument.</summary>
        /// <param name="XMLConfigCatalog">XMLConfigCatalog to serialize.</param>
        /// <returns>XmlDocument instance.</returns>
        public XmlDocument Serialize(XMLConfigCatalog XMLConfigcatalog)
        {
            string xml = StringSerialize(XMLConfigcatalog);
            XmlDocument doc = new XmlDocument();
            doc.PreserveWhitespace = true;
            doc.LoadXml(xml);
            doc = Clean(doc);
            return doc;
        }

        private string StringSerialize(XMLConfigCatalog XMLConfigcatalog)
        {
            TextWriter w = WriterSerialize(XMLConfigcatalog);
            string xml = w.ToString();
            w.Close();
            return xml;
        }

        private TextWriter WriterSerialize(XMLConfigCatalog XMLConfigcatalog)
        {
            TextWriter w = new StringWriter();
            this.s = new XmlSerializer(this.type);
            s.Serialize(w, XMLConfigcatalog);
            w.Flush();
            return w;
        }

        private XmlDocument Clean(XmlDocument doc)
        {
            doc.RemoveChild(doc.FirstChild);
            XmlNode first = doc.FirstChild;
            foreach (XmlNode n in doc.ChildNodes)
            {
                if (n.NodeType == XmlNodeType.Element)
                {
                    first = n;
                    break;
                }
            }
            if (first.Attributes != null)
            {
                XmlAttribute a = null;
                a = first.Attributes["xmlns:xsd"];
                if (a != null) { first.Attributes.Remove(a); }
                a = first.Attributes["xmlns:xsi"];
                if (a != null) { first.Attributes.Remove(a); }
            }
            return doc;
        }

        /// <summary>Reads config data from config file.</summary>
        /// <param name="file">Config file name.</param>
        /// <returns></returns>
        public static XMLConfigCatalog ReadFile(string file)
        {
            XMLConfigSerializer serializer = new XMLConfigSerializer();
            try
            {
                string xml = string.Empty;
                using (StreamReader reader = new StreamReader(file))
                {
                    xml = reader.ReadToEnd();
                    reader.Close();
                }
                return serializer.Deserialize(xml);
            }
            catch { }
            return new XMLConfigCatalog();
        }

        /// <summary>Writes config data to config file.</summary>
        /// <param name="file">Config file name.</param>
        /// <param name="config">Config object.</param>
        /// <returns></returns>
        public static bool WriteFile(string file, XMLConfigCatalog config)
        {
            bool ok = false;
            XMLConfigSerializer serializer = new XMLConfigSerializer();
            try
            {
                string xml = serializer.Serialize(config).OuterXml;
                using (StreamWriter writer = new StreamWriter(file, false))
                {
                    writer.Write(xml);
                    writer.Flush();
                    writer.Close();
                }
                ok = true;
            }
            catch { }
            return ok;
        }
        #endregion

    }
}
