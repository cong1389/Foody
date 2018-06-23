using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.IDAL;
using Cb.Model;
using Cb.DALFactory;
using Cb.Model.Xml;
using System.Web.UI.WebControls;

namespace Cb.BLL
{
    public class XMLConfigBLL
    {
        private IGeneric<sd_XML> generic;

        public XMLConfigBLL()
        {
            Type t = typeof(Cb.SQLServerDAL.Generic<sd_XML>);
            generic = DataAccessGeneric<sd_XML>.CreateSession(t.FullName);
        }

        public string LoadPage(string pageName, int id_xml, int idObject)
        {
            string re = string.Empty;
            XMLConfigSerializer serializer = new XMLConfigSerializer();

            sd_XML obj = new sd_XML() { Id = id_xml };
            obj = generic.Load(obj, new string[] { "Id" });

            XMLConfigCatalog obj_xml = serializer.Deserialize(obj.XmlContent);

            foreach (XMLConfig item in obj_xml.Lst)
            {
                if (item.Name == pageName)
                {
                    re = item.Value;
                    break;
                }
            }
            return re;
        }

        public XMLConfig LoadPageByXml(string pageName, int id_xml, int idObject)
        {
            string re = string.Empty;
            XMLConfigSerializer serializer = new XMLConfigSerializer();

            sd_XML obj = new sd_XML() { Id = id_xml };
            obj = generic.Load(obj, new string[] { "Id" });

            XMLConfigCatalog obj_xml = serializer.Deserialize(obj.XmlContent);

            XMLConfig xMLConfig = new XMLConfig();
            foreach (XMLConfig item in obj_xml.Lst)
            {
                if (item.Name == pageName)
                {
                    xMLConfig = item;
                }
            }
            return xMLConfig;
        }

        public void getDataDropDownCategory(DropDownList drp, int id_xml)
        {
            drp.Items.Clear();

            XMLConfigSerializer serializer = new XMLConfigSerializer();
            sd_XML obj = new sd_XML() { Id = id_xml };
            obj = generic.Load(obj, new string[] { "Id" });
            ListItem item = new ListItem(Localization.LocalizationUtility.GetText("strSelAItem"), string.Empty);
            drp.Items.Add(item);

            XMLConfigCatalog obj_xml = serializer.Deserialize(obj.XmlContent);
            foreach (XMLConfig objConfig in obj_xml.Lst)
            {
                item = new ListItem(objConfig.Value, objConfig.Name);
                drp.Items.Add(item);
            }
        }

        public void getDataDropDownPage(DropDownList drp, int id_xml)
        {
            drp.Items.Clear();

            XMLConfigSerializer serializer = new XMLConfigSerializer();
            sd_XML obj = new sd_XML() { Id = id_xml };
            obj = generic.Load(obj, new string[] { "Id" });
            ListItem item = new ListItem(Localization.LocalizationUtility.GetText("strSelAItem"), string.Empty);
            drp.Items.Add(item);

            XMLConfigCatalog obj_xml = serializer.Deserialize(obj.XmlContent);
            foreach (XMLConfig objConfig in obj_xml.Lst)
            {
                item = new ListItem(objConfig.Att, objConfig.Value);
                drp.Items.Add(item);
            }
        }

        /// <summary>
        /// Lay trong XML với value:Name,text :Att </summary> <param
        /// name="drp"></param> <param name="id_xml"></param>
        public void getDataDropDownCategoryByAtt(CheckBoxList drp, int id_xml)
        {
            drp.Items.Clear();

            XMLConfigSerializer serializer = new XMLConfigSerializer();
            sd_XML obj = new sd_XML() { Id = id_xml };
            obj = generic.Load(obj, new string[] { "Id" });
            ListItem item;

            XMLConfigCatalog obj_xml = serializer.Deserialize(obj.XmlContent);
            foreach (XMLConfig objConfig in obj_xml.Lst)
            {
                item = new ListItem(objConfig.Att, objConfig.Name);
                drp.Items.Add(item);
            }
        }


        public void getDataPageRobots(CheckBoxList drp, int id_xml)
        {
            drp.Items.Clear();

            XMLConfigSerializer serializer = new XMLConfigSerializer();
            sd_XML obj = new sd_XML() { Id = id_xml };
            obj = generic.Load(obj, new string[] { "Id" });
            ListItem item;

            XMLConfigCatalog obj_xml = serializer.Deserialize(obj.XmlContent);
            foreach (XMLConfig objConfig in obj_xml.Lst)
            {
                item = new ListItem(objConfig.Value, objConfig.Name);
                drp.Items.Add(item);
            }
        }
    }
}
