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
using System.Drawing.Design;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.Design;

[assembly: WebResource(AjaxDataControls.GridViewCheckBoxColumn.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.GridViewCheckBoxColumn.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// Represents a Boolean field that is displayed as a check box in a <see cref="GridView"/> control. 
    /// </summary>
    /// <seealso cref="GridView"/>
    /// <seealso cref="GridViewBoundColumn"/>
    /// <seealso cref="GridViewButtonColumn"/>
    /// <seealso cref="GridViewCommandColumn"/>
    /// <seealso cref="GridViewHyperLinkColumn"/>
    /// <seealso cref="GridViewImageColumn"/>
    /// <seealso cref="GridViewTemplateColumn"/>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [ParseChildren(true)]
    [TypeConverter(typeof(ExpandableObjectConverter))]
    public class GridViewCheckBoxColumn : GridViewBaseColumn
    {
        internal const string ScriptFileBase = "AjaxDataControls.GridView.Columns.GridViewCheckBoxColumn";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private string _text = string.Empty;
        private string _dataField = string.Empty;
        private bool _readOnly;

        /// <summary>
        /// Gets or sets the name of the data field to bind to the <see cref="GridViewCheckBoxColumn"/> object.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataField</b> property to specify the name of the data field to bind to the <see cref="GridViewCheckBoxColumn"/> object.
        /// </remarks>
        /// <value>The name of the data field to bind to the CheckBoxField. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Data")]
        [DefaultValue("")]
        public string DataField
        {
            get
            {
                return _dataField;
            }
            set
            {
                if (_dataField != value)
                {
                    _dataField = value;
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
            get
            {
                return _readOnly;
            }
            set
            {
                if (_readOnly != value)
                {
                    _readOnly = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the caption to display next to each check box in a <see cref="GridViewCheckBoxColumn"/> object.
        /// </summary>
        /// <remarks>
        /// The <b>Text</b> property is used to display a caption next to each check box in a <see cref="GridViewCheckBoxColumn"/> object. If the <b>Text</b> property is set to an empty string, no caption is displayed.
        /// </remarks>
        /// <value>The caption displayed next to each check box in the CheckBoxField. The default is an empty string ("").</value>
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
        /// Initializes a new instance of the <see cref="GridViewCheckBoxColumn"/> class.
        /// </summary>
        public GridViewCheckBoxColumn(): base()
        {
            base.AllowDragAndDrop = false;
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

            CheckBox chk = new CheckBox();

            chk.Enabled = false;
            container.Controls.Add(chk);
            chk.ApplyStyle(ControlStyle);

            if (!string.IsNullOrEmpty(Text))
            {
                container.Controls.Add(new LiteralControl(Text));
            }

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

            AddProperty(desc, "dataField", DataField);

            if (ReadOnly)
            {
                desc.AddProperty("readOnly", ReadOnly);
            }

            AddProperty(desc, "text", Text);

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
                    DataField = (string)states[1];
                }

                if (states[2] != null)
                {
                    ReadOnly = (bool)states[2];
                }

                if (states[3] != null)
                {
                    Text = (string)states[3];
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
            object[] states = new object[4];

            states[0] = base.SaveViewState();

            if (!string.IsNullOrEmpty(DataField))
            {
                states[1] = DataField;
            }

            if (ReadOnly)
            {
                states[2] = ReadOnly;
            }

            if (!string.IsNullOrEmpty(Text))
            {
                states[3] = Text;
            }

            return states;
        }
    }
}