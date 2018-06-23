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

[assembly: WebResource(AjaxDataControls.GridViewCommandColumn.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.GridViewCommandColumn.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// Represents a special column that displays command buttons to perform selecting, editing, or deleting operations in a <see cref="GridView"/> control.
    /// </summary>
    /// <seealso cref="GridView"/>
    /// <seealso cref="GridViewBoundColumn"/>
    /// <seealso cref="GridViewButtonColumn"/>
    /// <seealso cref="GridViewCheckBoxColumn"/>
    /// <seealso cref="GridViewHyperLinkColumn"/>
    /// <seealso cref="GridViewImageColumn"/>
    /// <seealso cref="GridViewTemplateColumn"/>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [ParseChildren(true)]
    [TypeConverter(typeof(ExpandableObjectConverter))]
    public class GridViewCommandColumn : GridViewBaseColumn
    {
        internal const string ScriptFileBase = "AjaxDataControls.GridView.Columns.GridViewCommandColumn";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private const string DefaultCancelText = "Cancel";
        private const string DefaultDeleteText = "Delete";
        private const string DefaultEditText = "Edit";
        private const string DefaultSelectText = "Select";
        private const string DefaultUpdateText = "Update";

        private GridViewColumnButtonType _buttonType = GridViewColumnButtonType.Link;

        private string _cancelImageUrl = string.Empty;
        private string _cancelText = DefaultCancelText;

        private string _deleteImageUrl = string.Empty;
        private string _deleteText = DefaultDeleteText;

        private string _editImageUrl = string.Empty;
        private string _editText = DefaultEditText;

        private string _selectImageUrl = string.Empty;
        private string _selectText = DefaultSelectText;

        private string _updateImageUrl = string.Empty;
        private string _updateText = DefaultUpdateText;

        private bool _showCancelButton;
        private bool _showDeleteButton;
        private bool _showEditButton;
        private bool _showSelectButton;

        /// <summary>
        /// Gets or sets the button type to display in the <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// Use the ButtonType property to specify which type of button is displayed in a <see cref="GridViewCommandColumn"/>.
        /// </remarks>
        /// <value>One of the ButtonType values. The default is <b>GridViewColumnButtonType.Link</b>.</value>
        [Category("Behavior")]
        [DefaultValue(GridViewColumnButtonType.Link)]
        public GridViewColumnButtonType ButtonType
        {
            [DebuggerStepThrough()]
            get
            {
                return _buttonType;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_buttonType != value)
                {
                    _buttonType = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the URL to an image to display for the Cancel button in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> is set to <b>ButtonType.Image</b>, use the <b>CancelImageUrl</b> property to specify the image to display for the Cancel button. This image can be in any file format (.jpg, .gif, .bmp, and so on), as long as the client's browser supports that format.
        /// </remarks>
        /// <value>The URL to an image to display for the Cancel button in a <see cref="GridViewCommandColumn"/>. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Editor(typeof(ImageUrlEditor), typeof(UITypeEditor))]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string CancelImageUrl
        {
            [DebuggerStepThrough()]
            get
            {
                return _cancelImageUrl;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_cancelImageUrl != value)
                {
                    _cancelImageUrl = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the caption for the Cancel button displayed in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> field is set to <b>ButtonType.Button</b> or <b>ButtonType.Link</b>, use the <b>CancelText</b> property to specify the text to display for the Cancel button.
        /// </remarks>
        /// <value>The caption for the Cancel button in a <see cref="GridViewCommandColumn"/>. The default is "Cancel".</value>
        [Category("Appearance")]
        [DefaultValue(DefaultCancelText)]
        [Localizable(true)]
        public string CancelText
        {
            [DebuggerStepThrough()]
            get
            {
                return _cancelText;
            }
            [DebuggerStepThrough()]
            [SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters")]
            set
            {
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentException("Value cannot be blank.");
                }

                if (_cancelText != value)
                {
                    _cancelText = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the URL to an image to display for the Delete button in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> is set to <b>ButtonType.Image</b>, use the <b>DeleteImageUrl</b> property to specify the image to display for the Delete button. This image can be in any file format (.jpg, .gif, .bmp, and so on), as long as the client's browser supports that format.
        /// </remarks>
        /// <value>The URL to an image to display for the Delete button in a <see cref="GridViewCommandColumn"/>. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Editor(typeof(ImageUrlEditor), typeof(UITypeEditor))]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string DeleteImageUrl
        {
            [DebuggerStepThrough()]
            get
            {
                return _deleteImageUrl;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_deleteImageUrl != value)
                {
                    _deleteImageUrl = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the caption for the Delete button displayed in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> field is set to <b>ButtonType.Button</b> or <b>ButtonType.Link</b>, use the <b>DeleteText</b> property to specify the text to display for the Delete button.
        /// </remarks>
        /// <value>The caption for the Delete button in a <see cref="GridViewCommandColumn"/>. The default is "Delete".</value>
        [Category("Appearance")]
        [DefaultValue(DefaultDeleteText)]
        [Localizable(true)]
        public string DeleteText
        {
            [DebuggerStepThrough()]
            get
            {
                return _deleteText;
            }
            [DebuggerStepThrough()]
            [SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters")]
            set
            {
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentException("Value cannot be blank.");
                }

                if (_deleteText != value)
                {
                    _deleteText = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the URL to an image to display for the Edit button in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> is set to <b>ButtonType.Image</b>, use the <b>EditImageUrl</b> property to specify the image to display for the Edit button. This image can be in any file format (.jpg, .gif, .bmp, and so on), as long as the client's browser supports that format.
        /// </remarks>
        /// <value>The URL to an image to display for the Edit button in a <see cref="GridViewCommandColumn"/>. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Editor(typeof(ImageUrlEditor), typeof(UITypeEditor))]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string EditImageUrl
        {
            [DebuggerStepThrough()]
            get
            {
                return _editImageUrl;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_editImageUrl != value)
                {
                    _editImageUrl = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the caption for the Edit button displayed in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> field is set to <b>ButtonType.Button</b> or <b>ButtonType.Link</b>, use the <b>EditText</b> property to specify the text to display for the Edit button.
        /// </remarks>
        /// <value>The caption for the Edit button in a <see cref="GridViewCommandColumn"/>. The default is "Edit".</value>
        [Category("Appearance")]
        [DefaultValue(DefaultEditText)]
        [Localizable(true)]
        public string EditText
        {
            [DebuggerStepThrough()]
            get
            {
                return _editText;
            }
            [DebuggerStepThrough()]
            [SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters")]
            set
            {
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentException("Value cannot be blank.");
                }

                if (_editText != value)
                {
                    _editText = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the URL to an image to display for the Select button in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> is set to <b>ButtonType.Image</b>, use the <b>SelectImageUrl</b> property to specify the image to display for the Select button. This image can be in any file format (.jpg, .gif, .bmp, and so on), as long as the client's browser supports that format.
        /// </remarks>
        /// <value>The URL to an image to display for the Select button in a <see cref="GridViewCommandColumn"/>. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Editor(typeof(ImageUrlEditor), typeof(UITypeEditor))]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string SelectImageUrl
        {
            [DebuggerStepThrough()]
            get
            {
                return _selectImageUrl;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_selectImageUrl != value)
                {
                    _selectImageUrl = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the caption for the Select button displayed in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> field is set to <b>ButtonType.Button</b> or <b>ButtonType.Link</b>, use the <b>SelectText</b> property to specify the text to display for the Select button.
        /// </remarks>
        /// <value>The caption for the Select button in a <see cref="GridViewCommandColumn"/>. The default is "Select".</value>
        [Category("Appearance")]
        [DefaultValue(DefaultSelectText)]
        [Localizable(true)]
        public string SelectText
        {
            [DebuggerStepThrough()]
            get
            {
                return _selectText;
            }
            [DebuggerStepThrough()]
            [SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters")]
            set
            {
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentException("Value cannot be blank.");
                }

                if (_selectText != value)
                {
                    _selectText = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the URL to an image to display for the Update button in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> is set to <b>ButtonType.Image</b>, use the <b>UpdateImageUrl</b> property to specify the image to display for the Update button. This image can be in any file format (.jpg, .gif, .bmp, and so on), as long as the client's browser supports that format.
        /// </remarks>
        /// <value>The URL to an image to display for the Update button in a <see cref="GridViewCommandColumn"/>. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Editor(typeof(ImageUrlEditor), typeof(UITypeEditor))]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string UpdateImageUrl
        {
            [DebuggerStepThrough()]
            get
            {
                return _updateImageUrl;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_updateImageUrl != value)
                {
                    _updateImageUrl = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the caption for the Update button displayed in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> field is set to <b>ButtonType.Button</b> or <b>ButtonType.Link</b>, use the <b>UpdateText</b> property to specify the text to display for the Update button.
        /// </remarks>
        /// <value>The caption for the Update button in a <see cref="GridViewCommandColumn"/>. The default is "Update".</value>
        [Category("Appearance")]
        [DefaultValue(DefaultUpdateText)]
        [Localizable(true)]
        public string UpdateText
        {
            [DebuggerStepThrough()]
            get
            {
                return _updateText;
            }
            [DebuggerStepThrough()]
            [SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters")]
            set
            {
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentException("Value cannot be blank.");
                }

                if (_updateText != value)
                {
                    _updateText = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether a Cancel button is displayed in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// Use the <b>ShowCancelButton</b> property to specify whether the Cancel button is displayed in a <see cref="GridViewCommandColumn"/> object. A Cancel button can be displayed in a <see cref="GridViewCommandColumn"/> when the corresponding record in GridView control is in edit mode. The Cancel button allows the user to cancel the edit operation and returns the record to its normal display mode. When the <see cref="ButtonType"/> property of a <see cref="GridViewCommandColumn"/> is set to <b>ButtonType.Button</b> or <b>ButtonType.Link</b>, use the <see cref="CancelText"/> property to specify the text to display for a Cancel button. Alternatively, you can display an image by first setting the <see cref="ButtonType"/> property to <b>ButtonType.Image</b> and then setting the <see cref="CancelImageUrl"/> property.
        /// </remarks>
        /// <value><c>true</c> to display a Cancel button in a <see cref="GridViewCommandColumn"/>; otherwise, <c>false</c>. The default is <c>true</c>.</value>
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool ShowCancelButton
        {
            [DebuggerStepThrough()]
            get
            {
                return _showCancelButton;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_showCancelButton != value)
                {
                    _showCancelButton = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether a Delete button is displayed in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// Use the <b>ShowDeleteButton</b> property to specify whether a Delete button is displayed in a <see cref="GridViewCommandColumn"/> for each record in the GridView control. The Delete button allows you to remove a record from the data source.
        /// </remarks>
        /// <value><c>true</c> to display a Delete button in a <see cref="GridViewCommandColumn"/>; otherwise, <c>false</c>. The default is <c>false</c>.</value>
        [Category("Appearance")]
        [DefaultValue(false)]
        public bool ShowDeleteButton
        {
            [DebuggerStepThrough()]
            get
            {
                return _showDeleteButton;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_showDeleteButton != value)
                {
                    _showDeleteButton = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether a Edit button is displayed in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// Use the <b>ShowEditButton</b> property to specify whether an Edit button is displayed in the <see cref="GridViewCommandColumn"/> for each record in the GridView control. The Edit button allows you to edit the values of a record. When the user clicks an Edit button, input controls are displayed for each column in the record. The Edit button for the record is replaced with an Update button and a Cancel button, and all other command buttons for the record are hidden. Clicking the Update button updates the record with the new values in the data source, whereas clicking the Cancel button cancels the operation.
        /// </remarks>
        /// <value><c>true</c> to display a Edit button in a <see cref="GridViewCommandColumn"/>; otherwise, <c>false</c>. The default is <c>false</c>.</value>
        [Category("Appearance")]
        [DefaultValue(false)]
        public bool ShowEditButton
        {
            [DebuggerStepThrough()]
            get
            {
                return _showEditButton;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_showEditButton != value)
                {
                    _showEditButton = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether a Select button is displayed in a <see cref="GridViewCommandColumn"/>.
        /// </summary>
        /// <remarks>
        /// Use the <b>ShowSelectButton</b> property to specify whether a Select button is displayed in a <see cref="GridViewCommandColumn"/> for each record in the GridView control. The Select button allows the user to select a row in the GridView control. When the Select button for a record is clicked, the GridView control responds accordingly. For example, a it updates the <b>SelectedIndex</b>, <b>SelectedRow</b>, and <b>SelectedValue</b> properties to values corresponding to the selected row. The <b>SelectedRowStyle</b> style is then applied to the selected row and the SelectedIndexChanged event is raised.
        /// </remarks>
        /// <value><c>true</c> to display a Select button in a <see cref="GridViewCommandColumn"/>; otherwise, <c>false</c>. The default is <c>false</c>.</value>
        [Category("Appearance")]
        [DefaultValue(false)]
        public bool ShowSelectButton
        {
            [DebuggerStepThrough()]
            get
            {
                return _showSelectButton;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_showSelectButton != value)
                {
                    _showSelectButton = value;
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
        /// Initializes a new instance of the <see cref="GridViewCommandColumn"/> class.
        /// </summary>
        public GridViewCommandColumn(): base()
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

            bool addSpace = false;

            if (ShowEditButton)
            {
                container.Controls.Add(CreateButton(EditText, EditImageUrl));
                addSpace = true;
            }

            if (ShowDeleteButton)
            {
                if (addSpace)
                {
                    container.Controls.Add(new LiteralControl(" "));
                }

                container.Controls.Add(CreateButton(DeleteText, DeleteImageUrl));
                addSpace = true;
            }

            if (ShowSelectButton)
            {
                if (addSpace)
                {
                    container.Controls.Add(new LiteralControl(" "));
                }

                container.Controls.Add(CreateButton(SelectText, SelectImageUrl));
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

            if (ButtonType != GridViewColumnButtonType.Link)
            {
                desc.AddScriptProperty("buttonType", typeof(GridViewColumnButtonType).FullName + "." + ButtonType.ToString());
            }

            AddImage(desc, "cancelImageUrl", CancelImageUrl);

            if (!IsStringEqual(CancelText, DefaultCancelText))
            {
                AddProperty(desc, "cancelText", CancelText);
            }

            AddImage(desc, "deleteImageUrl", DeleteImageUrl);

            if (!IsStringEqual(DeleteText, DefaultDeleteText))
            {
                AddProperty(desc, "deleteText", DeleteText);
            }

            AddImage(desc, "editImageUrl", EditImageUrl);

            if (!IsStringEqual(EditText, DefaultEditText))
            {
                AddProperty(desc, "editText", EditText);
            }

            AddImage(desc, "selectImageUrl", SelectImageUrl);

            if (!IsStringEqual(SelectText, DefaultSelectText))
            {
                AddProperty(desc, "selectText", SelectText);
            }

            AddImage(desc, "updateImageUrl", UpdateImageUrl);

            if (!IsStringEqual(UpdateText, DefaultUpdateText))
            {
                AddProperty(desc, "updateText", UpdateText);
            }

            if (ShowCancelButton)
            {
                desc.AddProperty("showCancelButton", ShowCancelButton);
            }

            if (ShowDeleteButton)
            {
                desc.AddProperty("showDeleteButton", ShowDeleteButton);
            }

            if (ShowEditButton)
            {
                desc.AddProperty("showEditButton", ShowEditButton);
            }

            if (ShowSelectButton)
            {
                desc.AddProperty("showSelectButton", ShowSelectButton);
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
                    ButtonType = (GridViewColumnButtonType)states[1];
                }

                if (states[2] != null)
                {
                    CancelImageUrl = (string)states[2];
                }

                if (states[3] != null)
                {
                    CancelText = (string)states[3];
                }

                if (states[4] != null)
                {
                    DeleteImageUrl = (string)states[4];
                }

                if (states[5] != null)
                {
                    DeleteText = (string)states[5];
                }

                if (states[6] != null)
                {
                    EditImageUrl = (string)states[6];
                }

                if (states[7] != null)
                {
                    EditText = (string)states[7];
                }

                if (states[8] != null)
                {
                    SelectImageUrl = (string)states[8];
                }

                if (states[9] != null)
                {
                    SelectText = (string)states[9];
                }

                if (states[10] != null)
                {
                    UpdateImageUrl = (string)states[10];
                }

                if (states[11] != null)
                {
                    UpdateText = (string)states[11];
                }

                if (states[12] != null)
                {
                    ShowCancelButton = (bool)states[12];
                }

                if (states[13] != null)
                {
                    ShowDeleteButton = (bool)states[13];
                }

                if (states[14] != null)
                {
                    ShowEditButton = (bool)states[14];
                }

                if (states[15] != null)
                {
                    ShowSelectButton = (bool)states[15];
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
            object[] states = new object[16];

            states[0] = base.SaveViewState();

            if (ButtonType != GridViewColumnButtonType.Link)
            {
                states[1] = ButtonType;
            }

            if (!string.IsNullOrEmpty(CancelImageUrl))
            {
                states[2] = CancelImageUrl;
            }

            if (!IsStringEqual(CancelText, DefaultCancelText))
            {
                states[3] = CancelText;
            }

            if (!string.IsNullOrEmpty(DeleteImageUrl))
            {
                states[4] = DeleteImageUrl;
            }

            if (!IsStringEqual(DeleteText, DefaultDeleteText))
            {
                states[5] = DeleteText;
            }

            if (!string.IsNullOrEmpty(EditImageUrl))
            {
                states[6] = EditImageUrl;
            }

            if (!IsStringEqual(EditText, DefaultEditText))
            {
                states[7] = EditText;
            }

            if (!string.IsNullOrEmpty(SelectImageUrl))
            {
                states[8] = SelectImageUrl;
            }

            if (!IsStringEqual(SelectText, DefaultSelectText))
            {
                states[9] = SelectText;
            }

            if (!string.IsNullOrEmpty(UpdateImageUrl))
            {
                states[10] = UpdateImageUrl;
            }

            if (!IsStringEqual(UpdateText, DefaultUpdateText))
            {
                states[11] = UpdateText;
            }

            if (ShowCancelButton)
            {
                states[12] = ShowCancelButton;
            }

            if (ShowDeleteButton)
            {
                states[13] = ShowDeleteButton;
            }

            if (ShowEditButton)
            {
                states[14] = ShowEditButton;
            }

            if (ShowSelectButton)
            {
                states[15] = ShowSelectButton;
            }

            return states;
        }

        private static bool IsStringEqual(string value1, string value2)
        {
            return (string.Compare(value1, value2, StringComparison.CurrentCulture) == 0);
        }

        private Control CreateButton(string text, string imageUrl)
        {
            Control button;

            if (ButtonType == GridViewColumnButtonType.Link)
            {
                HyperLink link = new HyperLink();
                link.Text = text;
                link.NavigateUrl = "javascript:void(0)";
                link.ApplyStyle(ControlStyle);

                button = link;
            }
            else if (ButtonType == GridViewColumnButtonType.Image)
            {
                ImageButton imageButton = new ImageButton();

                imageButton.AlternateText = text;

                if (!string.IsNullOrEmpty(imageUrl))
                {
                    imageButton.ImageUrl = Owner.ResolveClientUrl(imageUrl);
                }

                imageButton.ApplyStyle(ControlStyle);

                button = imageButton;
            }
            else
            {
                Button regularButton = new Button();
                regularButton.Text = text;
                regularButton.ApplyStyle(ControlStyle);

                button = regularButton;
            }

            return button;
        }
    }
}