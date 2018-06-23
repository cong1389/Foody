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
using System.Globalization;
using System.ComponentModel;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

[assembly: WebResource(AjaxDataControls.GridViewBoundColumn.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.GridViewBoundColumn.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// Represents a column that is displayed as text in a <see cref="GridView"/> control.
    /// </summary>
    /// <seealso cref="GridView"/>
    /// <seealso cref="GridViewButtonColumn"/>
    /// <seealso cref="GridViewCheckBoxColumn"/>
    /// <seealso cref="GridViewCommandColumn"/>
    /// <seealso cref="GridViewHyperLinkColumn"/>
    /// <seealso cref="GridViewImageColumn"/>
    /// <seealso cref="GridViewTemplateColumn"/>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [ParseChildren(true)]
    [TypeConverter(typeof(ExpandableObjectConverter))]
    public class GridViewBoundColumn: GridViewBaseColumn
    {
        internal const string ScriptFileBase = "AjaxDataControls.GridView.Columns.GridViewBoundColumn";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private bool _applyFormatInEditMode;
        private string _dataField = string.Empty;
        private string _dataFormatString = string.Empty;
        private string _nullDisplayText = string.Empty;
        private bool _readOnly;

        /// <summary>
        /// Gets or sets a value indicating whether the formatting string specified by the DataFormatString property is applied to field values when the <see cref="GridView"/> control that contains the <see cref="GridViewBoundColumn"/> object is in edit mode.
        /// </summary>
        /// <remarks>
        /// <see cref="GridView"/> has display modes that allow the user to read or edit records. By default, the formatting string specified by the <see cref="DataFormatString"/> property is applied to column values only when the <see cref="GridView"/> control is in read-only mode. To apply the formatting string to values displayed while the <see cref="GridView"/> control is in edit mode, set the <b>ApplyFormatInEditMode</b> property to <b>true</b>.
        /// </remarks>
        /// <value>
        /// <c>true</c> to apply the formatting string to column values in edit mode; otherwise, <c>false</c>. The default is <c>false</c>.
        /// </value>
        [Category("Behavior")]
        [DefaultValue(false)]
        public bool ApplyFormatInEditMode
        {
            [DebuggerStepThrough()]
            get
            {
                return _applyFormatInEditMode;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_applyFormatInEditMode != value)
                {
                    _applyFormatInEditMode = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the name of the data field to bind to the <see cref="GridViewBoundColumn"/> object.
        /// </summary>
        /// <remarks>
        /// Use the DataField property to specify the name of the data field to bind to the <see cref="GridViewBoundColumn"/> object. The values of the specified field are displayed in the <see cref="GridViewBoundColumn"/> object as text. You can optionally format the displayed text by setting the <see cref="DataFormatString"/> property.
        /// </remarks>
        /// <value>The name of the data field to bind to the <see cref="GridViewBoundColumn"/>. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Data")]
        [DefaultValue("")]
        public string DataField
        {
            [DebuggerStepThrough()]
            get
            {
                return _dataField;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_dataField != value)
                {
                    _dataField = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the string that specifies the display format for the value of the field.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataFormatString</b> property to specify a custom display format for the values displayed in the <see cref="GridViewBoundColumn"/> object. If the DataFormatString property is not set, the field's value is displayed without any special formatting.
        /// </remarks>
        /// <value>A formatting string that specifies the display format for the value of the column. The default is an empty string (""), which indicates that no special formatting is applied to the field value.</value>
        [Category("Data")]
        [DefaultValue("")]
        public string DataFormatString
        {
            [DebuggerStepThrough()]
            get
            {
                return _dataFormatString;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_dataFormatString != value)
                {
                    _dataFormatString = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the caption displayed for a column when the field's value is null.
        /// </summary>
        /// <remarks>
        /// Sometimes a field's value is stored as null in the data source. You can specify a custom caption to display for fields that have a null value by setting the <b>NullDisplayText</b> property. If this property is not set, null field values are displayed as empty strings ("").
        /// </remarks>
        /// <value>The caption displayed for a field when the field's value is null. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Data")]
        [DefaultValue("")]
        [Localizable(true)]
        public string NullDisplayText
        {
            [DebuggerStepThrough()]
            get
            {
                return _nullDisplayText;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_nullDisplayText != value)
                {
                    _nullDisplayText = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether the value of the field can be modified in edit mode.
        /// </summary>
        /// <value><c>true</c> to prevent the value of the field from being modified in edit mode; otherwise, <c>false</c>. The default is <c>false</c>.</value>
        [Category("Behavior")]
        [DefaultValue(false)]
        public bool ReadOnly
        {
            [DebuggerStepThrough()]
            get
            {
                return _readOnly;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_readOnly != value)
                {
                    _readOnly = value;
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

            container.Text = data;
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

            if (ApplyFormatInEditMode)
            {
                desc.AddProperty("applyFormatInEditMode", ApplyFormatInEditMode);
            }

            AddProperty(desc, "dataField", DataField);
            AddProperty(desc, "dataFormatString", DataFormatString);
            AddProperty(desc, "nullDisplayText", NullDisplayText);

            if (ReadOnly)
            {
                desc.AddProperty("readOnly", ReadOnly);
            }

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
                    ApplyFormatInEditMode = (bool)states[1];
                }

                if (states[2] != null)
                {
                    DataField = (string)states[2];
                }

                if (states[3] != null)
                {
                    DataFormatString = (string)states[3];
                }

                if (states[4] != null)
                {
                    NullDisplayText = (string)states[4];
                }

                if (states[5] != null)
                {
                    ReadOnly = (bool)states[5];
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
            object[] states = new object[6];

            states[0] = base.SaveViewState();

            if (ApplyFormatInEditMode)
            {
                states[1] = ApplyFormatInEditMode;
            }

            if (!string.IsNullOrEmpty(DataField))
            {
                states[2] = DataField;
            }

            if (!string.IsNullOrEmpty(DataFormatString))
            {
                states[3] = DataFormatString;
            }

            if (!string.IsNullOrEmpty(NullDisplayText))
            {
                states[4] = NullDisplayText;
            }

            if (ReadOnly)
            {
                states[5] = ReadOnly;
            }

            return states;
        }
    }
}