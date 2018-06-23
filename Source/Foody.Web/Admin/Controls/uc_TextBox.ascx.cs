using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cb.Web.Admin.Controls
{
    public partial class uc_TextBox : System.Web.UI.UserControl
    {
        private string title = string.Empty;
        public string Title
        {
            set { title = value; }
            get { return title; }
        }

        private string content = string.Empty;
        public string Content
        {
            set { content = value; }
            get { return content; }
        }

        public uc_TextBox()
        {
            //ltrName.Text = title;
           // txtValue.Text =;
        }


        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}