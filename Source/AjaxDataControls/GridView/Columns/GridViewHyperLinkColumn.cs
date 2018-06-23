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
using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Globalization;
using System.ComponentModel;
using System.Drawing.Design;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.Design;

[assembly: WebResource(AjaxDataControls.GridViewHyperLinkColumn.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.GridViewHyperLinkColumn.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// Represents a column that is displayed as a hyperlink in a <see cref="GridView"/> control.
    /// </summary>
    /// <seealso cref="GridView"/>
    /// <seealso cref="GridViewBoundColumn"/>
    /// <seealso cref="GridViewButtonColumn"/>
    /// <seealso cref="GridViewCommandColumn"/>
    /// <seealso cref="GridViewCheckBoxColumn"/>
    /// <seealso cref="GridViewImageColumn"/>
    /// <seealso cref="GridViewTemplateColumn"/>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [ParseChildren(true)]
    [TypeConverter(typeof(ExpandableObjectConverter))]
    public class GridViewHyperLinkColumn : GridViewBaseColumn
    {
        internal const string ScriptFileBase = "AjaxDataControls.GridView.Columns.GridViewHyperLinkColumn";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private string _dataTextField = string.Empty;
        private string _dataTextFormatString = string.Empty;

        private string _dataNavigateUrlFields = string.Empty;
        private string _dataNavigateUrlFormatString = string.Empty;

        private string _target = string.Empty;

        private string _text = string.Empty;
        private string _navigateUrl = string.Empty;

        /// <summary>
        /// Gets or sets the name of the field from the data source containing the text to display for the hyperlink captions in the HyperLinkColumn object.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataTextField</b> property to specify the name of the field that contains the text to display for the hyperlink captions in the HyperLinkColumn object. Instead of using this property to bind the hyperlink captions to a field, you can use the <see cref="Text"/> property to set the hyperlink captions to a static value. With this option, each hyperlink shares the same caption.
        /// </remarks>
        /// <value>The name of the field from the data source containing the values to display for the hyperlink captions in the HyperLinkColumn. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Data")]
        [DefaultValue("")]
        public string DataTextField
        {
            [DebuggerStepThrough()]
            get
            {
                return _dataTextField;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_dataTextField != value)
                {
                    _dataTextField = value;
                }
            }
        }

        /// <summary>
        /// Get or sets the string that specifies the format in which the hyperlink captions in a HyperLinkColumn object are displayed.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataTextFormatString</b> property to specify a custom display format for the captions displayed in the HyperLinkColumn object. If the <b>DataTextFormatString</b> property is not set, the field's value is displayed without any special formatting.
        /// </remarks>
        /// <value>A string that specifies the format in which the hyperlink captions in a HyperLinkColumn are displayed. The default is an empty string (""), which indicates that no special formatting is applied to the hyperlink captions.</value>
        [Category("Data")]
        [DefaultValue("")]
        public string DataTextFormatString
        {
            [DebuggerStepThrough()]
            get
            {
                return _dataTextFormatString;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_dataTextFormatString != value)
                {
                    _dataTextFormatString = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the names of the fields from the data source used to construct the URLs for the hyperlinks in the HyperLinkColumn object.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataNavigateUrlFields</b> property when the data source contains multiple fields that must be combined to create the hyperlinks for the HyperLinkColum object. The fields specified in the <b>DataNavigateUrlFields</b> property are combined with the format string in the <see cref="DataNavigateUrlFormatString"/> property to construct the hyperlinks in the HyperLinkColum object. Instead of using this property to bind the URLs of the hyperlinks to a field, you can use the <see cref="NavigateUrl"/> property to set the hyperlinks' URL to a static value. With this option, each hyperlink shares the same URL.
        /// </remarks>
        /// <value>An comma delimited string containing the names of the fields from the data source used to construct the URLs for the hyperlinks in the HyperLinkColumn. The default is an empty string, indicating that <b>DataNavigateUrlFields</b> is not set.</value>
        [Category("Data")]
        [DefaultValue("")]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string DataNavigateUrlFields
        {
            [DebuggerStepThrough()]
            get
            {
                return _dataNavigateUrlFields;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_dataNavigateUrlFields != value)
                {
                    _dataNavigateUrlFields = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the string that specifies the format in which the URLs for the hyperlinks in a HyperLinkColumn object are rendered.
        /// </summary>
        /// <value>A string that specifies the format in which the URLs for the hyperlinks in a HyperLinkColumn are rendered. The default is an empty string (""), which indicates that no special formatting is applied to the URL values.</value>
        [Category("Data")]
        [DefaultValue("")]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string DataNavigateUrlFormatString
        {
            [DebuggerStepThrough()]
            get
            {
                return _dataNavigateUrlFormatString;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_dataNavigateUrlFormatString != value)
                {
                    _dataNavigateUrlFormatString = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the target window or frame in which to display the Web page linked to when a hyperlink in a HyperLinkColumn object is clicked.
        /// </summary>
        /// <remarks>
        /// Use the <b>Target</b> property to specify the window or frame in which to display the Web content linked to a hyperlink when that hyperlink is clicked.
        /// </remarks>
        /// <value>The target window or frame in which to load the Web page linked to when a hyperlink in a HyperLinkColumn is clicked. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Behavior")]
        [DefaultValue("")]
        [TypeConverter(typeof(TargetConverter))]
        public string Target
        {
            [DebuggerStepThrough()]
            get
            {
                return _target;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_target != value)
                {
                    _target = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the text to display for each hyperlink in the HyperLinkColumn object.
        /// </summary>
        /// <remarks>
        /// Use the <b>Text</b> property to specify the caption to display for the hyperlinks in a HyperLinkColumn object. When this property is set, each hyperlink shares the same caption. Instead of using this property to set the hyperlink captions, you can use the <see cref="DataTextField"/> property to bind the hyperlink captions to a field in a data source. This allows you to display a different caption for each hyperlink.
        /// </remarks>
        /// <value>The text to display for each hyperlink in the HyperLinkColumn. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]
        public string Text
        {
            [DebuggerStepThrough()]
            get
            {
                return _text;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_text != value)
                {
                    _text = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the URL to navigate to when a hyperlink in a HyperLinkColumn object is clicked.
        /// </summary>
        /// <remarks>
        /// Use the <b>NavigateUrl</b> property to specify the URL to navigate to when a hyperlink in a HyperLinkColumn object is clicked. When this property is set, each hyperlink shares the same navigation URL. Instead of using this property to set the URL for the hyperlinks, you can use the <see cref="DataNavigateUrlFields"/> property to bind the URLs of the hyperlinks to a field in a data source. This allows you to have a different URL for each hyperlink.
        /// </remarks>
        /// <value>The URL to navigate to when a hyperlink in a HyperLinkColumn is clicked. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Behavior")]
        [DefaultValue("")]
        [Editor(typeof(UrlEditor), typeof(UITypeEditor))]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string NavigateUrl
        {
            [DebuggerStepThrough()]
            get
            {
                return _navigateUrl;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_navigateUrl != value)
                {
                    _navigateUrl = value;
                }
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
        /// Initializes a new instance of the <see cref="GridViewHyperLinkColumn"/> class.
        /// </summary>
        public GridViewHyperLinkColumn():base()
        {
        }

        /// <summary>
        /// Renders the data column. Used by the designer to render the column data in the design time.
        /// </summary>
        /// <remarks>
        /// This method should be used to show the rendered data in the Designer for the custom column. You do need this method otherwise.
        /// </remarks>
        /// <param name="container">The container.</param>
        /// <param name="data">The data.</param>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public override void RenderData(TableCell container, string data)
        {
            if (container == null)
            {
                throw new ArgumentNullException("container");
            }

            string buttonText = string.IsNullOrEmpty(Text) ? data : Text;

            HyperLink link = new HyperLink();
            link.Text = buttonText;
            link.NavigateUrl = "javascript:void(0)";
            container.Controls.Add(link);
            link.ApplyStyle(ControlStyle);

            container.ApplyStyle(ItemStyle);
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

            AddProperty(desc, "dataTextField", DataTextField);
            AddProperty(desc, "dataTextFormatString", DataTextFormatString);
            AddProperty(desc, "dataNavigateUrlFields", DataNavigateUrlFields);
            AddProperty(desc, "dataNavigateUrlFormatString", DataNavigateUrlFormatString);
            AddProperty(desc, "target", Target);
            AddProperty(desc, "text", Text);
            AddProperty(desc, "navigateUrl", NavigateUrl);

            return desc;
        }

        /// <summary>
        /// When implemented by a class, loads the server control's previously saved view state to the control.
        /// </summary>
        /// <param name="state">An <see cref="T:System.Object"/> that contains the saved view state values for the control.</param>
        protected override void LoadViewState(object state)
        {
            if (state != null)
            {
                object[] states = (object[])state;

                if (states[0] != null)
                {
                    base.LoadViewState(states[0]);
                }

                if (states[1] != null)
                {
                    DataTextField = (string)states[1];
                }

                if (states[2] != null)
                {
                    DataTextFormatString = (string)states[2];
                }

                if (states[3] != null)
                {
                    DataNavigateUrlFields = (string)states[3];
                }

                if (states[4] != null)
                {
                    DataNavigateUrlFormatString = (string)states[4];
                }

                if (states[5] != null)
                {
                    Target = (string)states[5];
                }

                if (states[6] != null)
                {
                    Text = (string)states[6];
                }

                if (states[7] != null)
                {
                    NavigateUrl = (string)states[7];
                }
            }
        }

        /// <summary>
        /// When implemented by a class, saves the changes to a server control's view state to an <see cref="T:System.Object"/>.
        /// </summary>
        /// <returns>
        /// The <see cref="T:System.Object"/> that contains the view state changes.
        /// </returns>
        protected override object SaveViewState()
        {
            object[] states = new object[8];

            states[0] = base.SaveViewState();

            if (!string.IsNullOrEmpty(DataTextField))
            {
                states[1] = DataTextField;
            }

            if (!string.IsNullOrEmpty(DataTextFormatString))
            {
                states[2] = DataTextFormatString;
            }

            if (!string.IsNullOrEmpty(DataNavigateUrlFields))
            {
                states[3] = DataNavigateUrlFields;
            }

            if (!string.IsNullOrEmpty(DataNavigateUrlFormatString))
            {
                states[4] = DataNavigateUrlFormatString;
            }

            if (!string.IsNullOrEmpty(Target))
            {
                states[5] = Target;
            }

            if (!string.IsNullOrEmpty(Text))
            {
                states[6] = Text;
            }

            if (!string.IsNullOrEmpty(NavigateUrl))
            {
                states[7] = NavigateUrl;
            }

            return states;
        }
    }
}