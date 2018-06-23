#region Copyright (c) 2007 DotNetSlackers.com
/*
[===========================================================================]
[   Copyright (c) 2007, DotNetSlackers.com                                  ]
[   All rights reserved.                                                    ]
[                                                                           ]
[   Redistribution and use in source and binary forms, with or without      ]
[   modification, are permitted provided that the following conditions      ]
[   are met:                                                                ]
[                                                                           ]
[   * Redistributions of source code must retain the above copyright        ]
[   notice, this list of conditions and the following disclaimer.           ]
[                                                                           ]
[   * Redistributions in binary form must reproduce the above copyright     ]
[   notice, this list of conditions and the following disclaimer in         ]
[   the documentation and/or other materials provided with the              ]
[   distribution.                                                           ]
[                                                                           ]
[   * Neither the name of DotNetSlackers.com nor the names of its           ]
[   contributors may be used to endorse or promote products derived         ]
[   from this software without specific prior written permission.           ]
[                                                                           ]
[   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS     ]
[   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT       ]
[   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       ]
[   FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE          ]
[   COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,     ]
[   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES                ]
[   (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR      ]
[   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)      ]
[   HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,     ]
[   STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING   ]
[   IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE      ]
[   POSSIBILITY OF SUCH DAMAGE.                                             ]
[===========================================================================]
*/
#endregion

using System;
using System.IO;
using System.Text;
using System.Diagnostics;
using System.Globalization;
using System.ComponentModel;
using System.Drawing.Design;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.Design;

[assembly: WebResource(AjaxDataControls.GridViewTemplateColumn.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.GridViewTemplateColumn.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// Represents a field that displays custom content in a <see cref="GridView"/> control.
    /// </summary>
    /// <seealso cref="GridViewBoundColumn"/>
    /// <seealso cref="GridViewButtonColumn"/>
    /// <seealso cref="GridViewCheckBoxColumn"/>
    /// <seealso cref="GridViewCommandColumn"/>
    /// <seealso cref="GridViewHyperLinkColumn"/>
    /// <seealso cref="GridViewImageColumn"/>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [ParseChildren(true)]
    [TypeConverter(typeof(ExpandableObjectConverter))]
    public class GridViewTemplateColumn : GridViewBaseColumn
    {
        internal const string ScriptFileBase = "AjaxDataControls.GridView.Columns.GridViewTemplateColumn";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private ITemplate _headerTemplate;
        private ITemplate _itemTemplate;
        private ITemplate _alternatingItemTemplate;
        private ITemplate _footerTemplate;
        private ITemplate _editItemTemplate;

        /// <summary>
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for displaying the header section of a <see cref="GridViewTemplateColumn"/> object.
        /// </summary>
        /// <remarks>
        /// Use the <b>HeaderTemplate</b> property to specify the custom content displayed for the header section of a <see cref="GridViewTemplateColumn"/> object. Define the content by creating a template that specifies how the header section is rendered. To specify a template, first place opening and closing &lt;HeaderTemplate&gt; tags between the opening and closing tags of the &lt;GridViewTemplateColumn&gt; element. Next, add the custom content between the opening and closing &lt;HeaderTemplate&gt; tags. The content can be as simple as plain text or more complex (embedding other controls in the template, for example).
        /// </remarks>
        /// <value>A <see cref="System.Web.UI.ITemplate"/>-implemented object that contains the template for displaying the header section of a <see cref="GridViewTemplateColumn"/> in a GridView control. The default is a null reference (<b>Nothing</b> in Visual Basic), which indicates that this property is not set.</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public ITemplate HeaderTemplate
        {
            [DebuggerStepThrough()]
            get
            {
                return _headerTemplate;
            }
            [DebuggerStepThrough()]
            set
            {
                _headerTemplate = value;
            }
        }

        /// <summary>
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for displaying an item in a GridView control.
        /// </summary>
        /// <remarks>
        /// Use the <b>ItemTemplate</b> property to specify the custom content displayed for the items in a <see cref="GridViewTemplateColumn"/> object. Define the content by creating a template that specifies how the items are rendered. To specify a template, first place opening and closing &lt;ItemTemplate&gt; tags between the opening and closing tags of the &lt;GridViewTemplateColumn&gt; element. Next, add the custom content between the opening and closing &lt;ItemTemplate&gt; tags. The content can be as simple as plain text or more complex (embedding other controls in the template, for example).
        /// </remarks>
        /// <value>A <see cref="System.Web.UI.ITemplate"/>-implemented object that contains the template for displaying an item in a <see cref="GridViewTemplateColumn"/>. The default is a null reference (<b>Nothing</b> in Visual Basic), which indicates that this property is not set.</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public ITemplate ItemTemplate
        {
            [DebuggerStepThrough()]
            get
            {
                return _itemTemplate;
            }
            [DebuggerStepThrough()]
            set
            {
                _itemTemplate = value;
            }
        }

        /// <summary>
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for displaying the alternating items in a <see cref="GridViewTemplateColumn"/> object.
        /// </summary>
        /// <remarks>
        /// Use the <b>AlternatingItemTemplate</b> property to specify the custom content displayed for the alternating items in a <see cref="GridViewTemplateColumn"/> object. Define the content by creating a template that specifies how the alternating items are rendered. To specify a template, first place opening and closing &lt;AlternatingItemTemplate&gt; tags between the opening and closing tags of the &lt;GridViewTemplateColumn&gt; element. Next, add the custom content between the opening and closing &lt;AlternatingItemTemplate&gt; tags. The content can be as simple as plain text or more complex (embedding other controls in the template, for example).
        /// </remarks>
        /// <value>A <see cref="System.Web.UI.ITemplate"/>-implemented object that contains the template for displaying the alternating items in a <see cref="GridViewTemplateColumn"/>. The default is a null reference (<b>Nothing</b> in Visual Basic), which indicates that this property is not set.</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public ITemplate AlternatingItemTemplate
        {
            [DebuggerStepThrough()]
            get
            {
                return _alternatingItemTemplate;
            }
            [DebuggerStepThrough()]
            set
            {
                _alternatingItemTemplate = value;
            }
        }

        /// <summary>
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for displaying the footer section of a <see cref="GridViewTemplateColumn"/> object.
        /// </summary>
        /// <remarks>
        /// Use the <b>FooterTemplate</b> property to specify the custom content displayed in the footer section of a <see cref="GridViewTemplateColumn"/> object. Define the content by creating a template that specifies how the footer section is rendered. To specify a template, first place opening and closing &lt;FooterTemplate&gt; tags between the opening and closing tags of the &lt;GridViewTemplateColumn&gt; element. Next, add the custom content between the opening and closing &lt;FooterTemplate&gt; tags. The content can be as simple as plain text or more complex (embedding other controls in the template, for example).
        /// </remarks>
        /// <value>A <see cref="System.Web.UI.ITemplate"/>-implemented object that contains the template for displaying the footer section of a <see cref="GridViewTemplateColumn"/>. The default is a null reference (<b>Nothing</b> in Visual Basic), which indicates that this property is not set.</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public ITemplate FooterTemplate
        {
            [DebuggerStepThrough()]
            get
            {
                return _footerTemplate;
            }
            [DebuggerStepThrough()]
            set
            {
                _footerTemplate = value;
            }
        }

        /// <summary>
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for displaying an item in edit mode in a <see cref="GridViewTemplateColumn"/> object.
        /// </summary>
        /// <remarks>
        /// Use the <b>EditItemTemplate</b> property to specify the custom content displayed for an item that is in edit mode in a <see cref="GridViewTemplateColumn"/> object. Define the content by creating a template that specifies how an item in edit mode is rendered. The <b>EditItemTemplate</b> property usually contains input controls for the user to modify a value in a data source. To specify a template, first place opening and closing &lt;EditItemTemplate&gt; tags between the opening and closing tags of the &lt;GridViewTemplateColumn&gt; element. Next, add the custom content between the opening and closing &lt;EditItemTemplate&gt; tags. The content can be as simple as plain text or more complex (embedding other controls in the template, for example).
        /// </remarks>
        /// <value>A <see cref="System.Web.UI.ITemplate"/>-implemented object that contains the template for displaying an item in edit mode in a <see cref="GridViewTemplateColumn"/>. The default is a null reference (<b>Nothing</b> in Visual Basic), which indicates that this property is not set.</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public ITemplate EditItemTemplate
        {
            [DebuggerStepThrough()]
            get
            {
                return _editItemTemplate;
            }
            [DebuggerStepThrough()]
            set
            {
                _editItemTemplate = value;
            }
        }

        /// <summary>
        /// Gets the base name of the script file without the extension.
        /// </summary>
        /// <value>The name of the script file base name.</value>
        /// <remarks>
        /// This method will return the base name without the .debug.js or .js extension of the associated script file of this column.
        /// </remarks>
        protected override string ScriptBaseFileName
        {
            [DebuggerStepThrough()]
            get
            {
                return ScriptFileBase;
            }
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="GridViewTemplateColumn"/> class.
        /// </summary>
        public GridViewTemplateColumn() : base()
        {
        }

        /// <summary>
        /// Renders the header. Used by the designer to render the column header in the design time.
        /// </summary>
        /// <param name="container">The container.</param>
        /// <remarks>
        /// This method should be used to show the rendered data in the Designer for the custom column. You do need this method otherwise.
        /// </remarks>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public override void RenderHeader(TableCell container)
        {
            if (container == null)
            {
                throw new ArgumentNullException("container");
            }

            if (HeaderTemplate == null)
            {
                base.RenderHeader(container);
            }
            else
            {
                HeaderTemplate.InstantiateIn(container);
                container.ApplyStyle(HeaderStyle);
            }
        }

        /// <summary>
        /// Renders the data column. Used by the designer to render the column data in the design time.
        /// </summary>
        /// <param name="container">The container.</param>
        /// <param name="data">The data.</param>
        /// <remarks>
        /// This method should be used to show the rendered data in the Designer for the custom column. You do need this method otherwise.
        /// </remarks>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public override void RenderData(TableCell container, string data)
        {
            if (container == null)
            {
                throw new ArgumentNullException("container");
            }

            if (ItemTemplate != null)
            {
                ItemTemplate.InstantiateIn(container);
            }

            container.ApplyStyle(ItemStyle);
        }

        /// <summary>
        /// Renders the footer. Used by the designer to render the column footer in the design time.
        /// </summary>
        /// <param name="container">The container.</param>
        /// <remarks>
        /// This method should be used to show the rendered data in the Designer for the custom column. You do need this method otherwise.
        /// </remarks>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public override void RenderFooter(TableCell container)
        {
            if (container == null)
            {
                throw new ArgumentNullException("container");
            }

            if (FooterTemplate == null)
            {
                base.RenderFooter(container);
            }
            else
            {
                FooterTemplate.InstantiateIn(container);
                container.ApplyStyle(FooterStyle);
            }
        }

        /// <summary>
        /// Builds the descriptor for this column.
        /// </summary>
        /// <returns>
        /// Returns the descriptor embedding all the properties of this column.
        /// </returns>
        protected override GridViewColumnScriptDescriptor BuildDescriptor()
        {
            GridViewColumnScriptDescriptor desc = base.BuildDescriptor();

            AddTempateHtml(desc, "headerTemplate", HeaderTemplate);
            AddTempateHtml(desc, "itemTemplate", ItemTemplate);
            AddTempateHtml(desc, "alternatingItemTemplate", AlternatingItemTemplate);
            AddTempateHtml(desc, "footerTemplate", FooterTemplate);
            AddTempateHtml(desc, "editItemTemplate", EditItemTemplate);

            return desc;
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1011:ConsiderPassingBaseTypesAsParameters")]
        private static void AddTempateHtml(GridViewColumnScriptDescriptor descriptor, string propertyName, ITemplate template)
        {
            if (template != null)
            {
                StringBuilder output = new StringBuilder();
                StringWriter sw = new StringWriter(output, CultureInfo.CurrentCulture);
                HtmlTextWriter htw = new HtmlTextWriter(sw);

                using (Control control = new Control())
                {
                    template.InstantiateIn(control);
                    control.RenderControl(htw);

                    htw.Close();

                    AddProperty(descriptor, propertyName, output.ToString());
                }
            }
        }
    }
}
