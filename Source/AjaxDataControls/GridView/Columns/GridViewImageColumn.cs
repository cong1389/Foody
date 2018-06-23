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

[assembly: WebResource(AjaxDataControls.GridViewImageColumn.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.GridViewImageColumn.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// Represents a column that is displayed as an image in a <see cref="GridView"/> control.
    /// </summary>
    /// <seealso cref="GridViewBoundColumn"/>
    /// <seealso cref="GridViewButtonColumn"/>
    /// <seealso cref="GridViewCheckBoxColumn"/>
    /// <seealso cref="GridViewCommandColumn"/>
    /// <seealso cref="GridViewHyperLinkColumn"/>
    /// <seealso cref="GridViewTemplateColumn"/>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [ParseChildren(true)]
    [TypeConverter(typeof(ExpandableObjectConverter))]
    public class GridViewImageColumn : GridViewBaseColumn
    {
        internal const string ScriptFileBase = "AjaxDataControls.GridView.Columns.GridViewImageColumn";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private string _alternateText = string.Empty;

        private string _dataAlternateTextField = string.Empty;
        private string _dataAlternateTextFormatString = string.Empty;

        private string _dataImageUrlField = string.Empty;
        private string _dataImageUrlFormatString = string.Empty;

        private string _nullDisplayText = string.Empty;
        private string _nullImageUrl = string.Empty;

        /// <summary>
        /// Gets or sets the alternate text displayed for an image in the <see cref="GridViewImageColumn"/> object.
        /// </summary>
        /// <remarks>
        /// Use the <b>AlternateText</b> property to specify the alternate text for the images displayed in an <see cref="GridViewImageColumn"/> object. The alternate text is displayed when an image cannot be loaded or is unavailable. Browsers that support the ToolTips feature also display this text as a ToolTip.
        /// </remarks>
        /// <value>The alternate text for an image displayed in the <see cref="GridViewImageColumn"/> object. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]
        public string AlternateText
        {
            [DebuggerStepThrough()]
            get
            {
                return _alternateText;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_alternateText != value)
                {
                    _alternateText = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the name of the field from the data source that contains the values to bind to the AlternateText property of each image in an <see cref="GridViewImageColumn"/> object.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataAlternateTextField</b> property to specify the name of the field from the data source that contains the values to bind to the <b>AlternateText</b> property of each image in an <see cref="GridViewImageColumn"/> object. This enables you to have different alternate text for each image displayed. The alternate text is displayed when an image cannot be loaded or is unavailable. Browsers that support the ToolTips feature also display this text as a ToolTip.
        /// </remarks>
        /// <value>The name of the field to bind the <b>AlternateText</b> property of each image in an ImageField object.</value>
        [Category("Data")]
        [DefaultValue("")]
        public string DataAlternateTextField
        {
            [DebuggerStepThrough()]
            get
            {
                return _dataAlternateTextField;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_dataAlternateTextField != value)
                {
                    _dataAlternateTextField = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the string that specifies the format in which the alternate text for each image in an <see cref="GridViewImageColumn"/> object is rendered.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataAlternateTextFormatString</b> property to specify a custom format for the alternate text values of the images displayed in an <see cref="GridViewImageColumn"/> object.
        /// </remarks>
        /// <value>A string that specifies the format in which the alternate text for each image in an <see cref="GridViewImageColumn"/> object is rendered. The default is an empty string (""), which indicates that now special formatting is applied to the alternate text.</value>
        [Category("Data")]
        [DefaultValue("")]
        public string DataAlternateTextFormatString
        {
            [DebuggerStepThrough()]
            get
            {
                return _dataAlternateTextFormatString;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_dataAlternateTextFormatString != value)
                {
                    _dataAlternateTextFormatString = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the name of the field from the data source that contains the values to bind to the ImageUrl property of each image in an <see cref="GridViewImageColumn"/> object.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataImageUrlField</b> property to specify the name of the field to bind to the <b>ImageUrl</b> property of each image in an <see cref="GridViewImageColumn"/> object. The specified field must contain the URLs for the images to display in the <see cref="GridViewImageColumn"/> object. You can optionally format the URL values by setting the <see cref="DataImageUrlFormatString"/> property.
        /// </remarks>
        /// <value>The name of the field to bind to the <b>ImageUrl</b> property of each image in an <see cref="GridViewImageColumn"/> object.</value>
        [Category("Data")]
        [DefaultValue("")]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string DataImageUrlField
        {
            [DebuggerStepThrough()]
            get
            {
                return _dataImageUrlField;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_dataImageUrlField != value)
                {
                    _dataImageUrlField = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the string that specifies the format in which the URL for each image in an <see cref="GridViewImageColumn"/> object is rendered.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataImageUrlFormatString</b> property to specify a custom format for the URLs of the images displayed in an <see cref="GridViewImageColumn"/> object. This is useful when you need to generate a URL, such as when the <see cref="GridViewImageColumn"/> object simply contains the file name. If the DataImageUrlFormatString property is not set, the URL values do not get any special formatting.
        /// </remarks>
        /// <value>A string that specifies the format in which the URL for each image in an <see cref="GridViewImageColumn"/> object is rendered. The default is the empty string ("") , which indicates that no special formatting is applied to the URLs.</value>
        [Category("Data")]
        [DefaultValue("")]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string DataImageUrlFormatString
        {
            [DebuggerStepThrough()]
            get
            {
                return _dataImageUrlFormatString;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_dataImageUrlFormatString != value)
                {
                    _dataImageUrlFormatString = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the text to display in an <see cref="GridViewImageColumn"/> object when the value of the field specified by the DataImageUrlField property is a null reference (Nothing in Visual Basic).
        /// </summary>
        /// <remarks>
        /// When the value of the field specified by the <see cref="DataImageUrlField"/> property is a null reference (<b>Nothing</b> in Visual Basic), an image cannot be displayed in an <see cref="GridViewImageColumn"/> object. Use the <b>NullDisplayText</b> property to specify the text to display in the image's place. The text usually indicates that the normal image is not available or cannot be found.
        /// </remarks>
        /// <value>The text to display when the value of a field is a null reference (<b>Nothing</b> in Visual Basic). The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Data")]
        [DefaultValue("")]
        [Localizable(true)]
        public string NullDisplayText
        {
            get
            {
                return _nullDisplayText;
            }
            set
            {
                if (_nullDisplayText != value)
                {
                    _nullDisplayText = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the URL to an alternate image displayed in an <see cref="GridViewImageColumn"/> object when the value of the field specified by the DataImageUrlField property is a null reference (Nothing in Visual Basic).
        /// </summary>
        /// <remarks>
        /// When the value of the field specified by the <see cref="DataImageUrlField"/> property is a null reference (<b>Nothing</b> in Visual Basic), an image cannot be displayed in an ImageColum object. Use the <b>NullImageUrl</b> property to specify the URL to an alternate image to display. The alternate image is usually an image that indicates that the normal image is not available or cannot be found.
        /// </remarks>
        /// <value>The URL to an alternate image displayed when the value of a field is a null reference (<b>Nothing</b> in Visual Basic). The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Data")]
        [DefaultValue("")]
        [Localizable(true)]
        [Editor(typeof(ImageUrlEditor), typeof(UITypeEditor))]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string NullImageUrl
        {
            get
            {
                return _nullImageUrl;
            }
            set
            {
                if (_nullImageUrl != value)
                {
                    _nullImageUrl = value;
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
        /// Initializes a new instance of the <see cref="GridViewImageColumn"/> class.
        /// </summary>
        public GridViewImageColumn(): base()
        {
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

            Image img = new Image();

            if (!string.IsNullOrEmpty(AlternateText))
            {
                img.AlternateText = AlternateText;
            }

            container.Controls.Add(img);
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

            AddProperty(desc, "alternateText", AlternateText);
            AddProperty(desc, "dataAlternateTextField", DataAlternateTextField);
            AddProperty(desc, "dataAlternateTextFormatString", DataAlternateTextFormatString);
            AddProperty(desc, "dataImageUrlField", DataImageUrlField);
            AddProperty(desc, "dataImageUrlFormatString", DataImageUrlFormatString);
            AddProperty(desc, "nullDisplayText", NullDisplayText);
            AddProperty(desc, "nullImageUrl", NullImageUrl);

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
                    AlternateText = (string)states[1];
                }

                if (states[2] != null)
                {
                    DataAlternateTextField = (string)states[2];
                }

                if (states[3] != null)
                {
                    DataAlternateTextFormatString = (string)states[3];
                }

                if (states[4] != null)
                {
                    DataImageUrlField = (string)states[4];
                }

                if (states[5] != null)
                {
                    DataImageUrlFormatString = (string)states[5];
                }

                if (states[6] != null)
                {
                    NullDisplayText = (string)states[6];
                }

                if (states[7] != null)
                {
                    NullImageUrl = (string)states[7];
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

            if (!string.IsNullOrEmpty(AlternateText))
            {
                states[1] = AlternateText;
            }

            if (!string.IsNullOrEmpty(DataAlternateTextField))
            {
                states[2] = DataAlternateTextField;
            }

            if (!string.IsNullOrEmpty(DataAlternateTextFormatString))
            {
                states[3] = DataAlternateTextFormatString;
            }

            if (!string.IsNullOrEmpty(DataImageUrlField))
            {
                states[4] = DataImageUrlField;
            }

            if (!string.IsNullOrEmpty(DataImageUrlFormatString))
            {
                states[5] = DataImageUrlFormatString;
            }

            if (!string.IsNullOrEmpty(NullDisplayText))
            {
                states[6] = NullDisplayText;
            }

            if (!string.IsNullOrEmpty(NullImageUrl))
            {
                states[7] = NullImageUrl;
            }

            return states;
        }
    }
}