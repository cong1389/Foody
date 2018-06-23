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


[assembly: WebResource(AjaxDataControls.GridViewButtonColumn.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.GridViewButtonColumn.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// Specifies the different types of buttons that can be rendered in a <see cref="GridView"/> control.
    /// </summary>
    public enum GridViewColumnButtonType : int
    {
        /// <summary>
        /// A command button.
        /// </summary>
        Button = 0,
        /// <summary>
        /// A button that displays an image. 
        /// </summary>
        Image = 1,
        /// <summary>
        /// A hyperlink-style button.
        /// </summary>
        Link = 2
    }

    /// <summary>
    /// Represents a column that is displayed as a button in a <see cref="GridView"/> control.
    /// </summary>
    /// <seealso cref="GridView"/>
    /// <seealso cref="GridViewBoundColumn"/>
    /// <seealso cref="GridViewCheckBoxColumn"/>
    /// <seealso cref="GridViewCommandColumn"/>
    /// <seealso cref="GridViewHyperLinkColumn"/>
    /// <seealso cref="GridViewImageColumn"/>
    /// <seealso cref="GridViewTemplateColumn"/>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [ParseChildren(true)]
    [TypeConverter(typeof(ExpandableObjectConverter))]
    public class GridViewButtonColumn : GridViewBaseColumn
    {
        internal const string ScriptFileBase = "AjaxDataControls.GridView.Columns.GridViewButtonColumn";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private GridViewColumnButtonType _buttonType = GridViewColumnButtonType.Link;
        private string _commandName = string.Empty;
        private string _dataTextField = string.Empty;
        private string _dataTextFormatString = string.Empty;
        private string _imageUrl = string.Empty;
        private string _text = string.Empty;

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
        /// Gets or sets a string that represents the action to perform when a button in a <see cref="GridViewButtonColumn"/> object is clicked.
        /// </summary>
        /// <remarks>
        /// Use the CommandName property to associate a command name, such as "Add" or "Remove", with the buttons in the <see cref="GridViewButtonColumn"/> object. You can set the CommandName property to any string that identifies the action to perform when the command button is clicked. You can then programmatically determine the command name in an event handler and perform the appropriate actions.
        /// </remarks>
        /// <value>The name of the action to perform when a button in the <see cref="GridViewButtonColumn"/> is clicked.</value>
        [Category("Behavior")]
        [DefaultValue("")]
        public string CommandName
        {
            [DebuggerStepThrough()]
            get
            {
                return _commandName;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_commandName != value)
                {
                    _commandName = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the name of the data field for which the value is bound to the Text property of the Button control that is rendered by the <see cref="GridViewButtonColumn"/> object.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewButtonColumn"/> object is set to the <see cref="GridViewColumnButtonType">Button</see> or <see cref="GridViewColumnButtonType">Link</see> value, use the <see cref="DataTextField"/> property to specify the name of the field to bind to the <see cref="GridViewButtonColumn"/> object. The values of the field are then displayed as the text for the buttons in the <see cref="GridViewButtonColumn"/> object. Optionally, you can format the displayed text by setting the <see cref="DataTextFormatString"/> property. Instead of using the <see cref="DataTextField"/> property to bind a <see cref="GridViewButtonColumn"/> object to a field from a data source, you can use the <see cref="Text"/> property to display static text for the text of the buttons in the <see cref="GridViewButtonColumn"/> object. When the <see cref="Text"/> property is used, each button shares the same caption.
        /// </remarks>
        /// <value>The name of the field to bind to the <see cref="GridViewButtonColumn"/>. The default is an empty string (""), which indicates that the DataTextField property is not set.</value>
        [Category("Data")]
        [DefaultValue("")]
        public string DataTextField
        {
            get
            {
                return _dataTextField;
            }
            set
            {
                if (_dataTextField != value)
                {
                    _dataTextField = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the string that specifies the display format for the value of the column.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataTextFormatString</b> property to specify a custom display format for the values that are displayed in the <see cref="GridViewButtonColumn"/> object. If the <b>DataTextFormatString</b> property is not set, the value for the field is displayed without any special formatting.
        /// </remarks>
        /// <value>A format string that specifies the display format for the value of the field. The default is an empty string (""), which indicates that no special formatting is applied to the field value.</value>
        [Category("Data")]
        [DefaultValue("")]
        public string DataTextFormatString
        {
            get
            {
                return _dataTextFormatString;
            }
            set
            {
                if (_dataTextFormatString != value)
                {
                    _dataTextFormatString = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the image to display for each button in the <see cref="GridViewButtonColumn"/> object.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewButtonColumn"/> object is set to the <see cref="GridViewColumnButtonType">Image</see> value, use the <b>ImageUrl</b> property to specify the image to display for each button. This image can be in any file format (.jpg, .gif, .bmp, and so on), as long as the client browser supports that format.
        /// </remarks>
        /// <value>The image to display for each button in the <see cref="GridViewButtonColumn"/>. The default is an empty string (""), which indicates that the ImageUrl property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Editor(typeof(ImageUrlEditor), typeof(UITypeEditor))]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string ImageUrl
        {
            [DebuggerStepThrough()]
            get
            {
                return _imageUrl;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_imageUrl != value)
                {
                    _imageUrl = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the static caption that is displayed for each button in the <see cref="GridViewButtonColumn"/> object.
        /// </summary>
        /// <remarks>
        /// When the <see cref="ButtonType"/> property of a <see cref="GridViewButtonColumn"/> object is set to the <see cref="GridViewColumnButtonType">Button</see> or <see cref="GridViewColumnButtonType">Link</see> value, use sthe <b>Text</b> property to display static text for the caption of the buttons in the <see cref="GridViewButtonColumn"/>. Each button shares the same caption. Instead of using the <b>Text</b> property to display static text in a <see cref="GridViewButtonColumn"/> object, you can use the <see cref="DataTextField"/> property to bind the <see cref="GridViewButtonColumn"/> to a field in a data source. The values of the field are then displayed as the caption of the buttons.
        /// </remarks>
        /// <value>The caption displayed for each button in the <see cref="GridViewButtonColumn"/>. The default is an empty string ("").</value>
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
        /// Initializes a new instance of the <see cref="GridViewButtonColumn"/> class.
        /// </summary>
        public GridViewButtonColumn() : base()
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

            string buttonText = string.IsNullOrEmpty(data) ? Text : data;

            if (string.IsNullOrEmpty(buttonText))
            {
                buttonText = string.Empty;
            }

            if (ButtonType == GridViewColumnButtonType.Link)
            {
                if (!string.IsNullOrEmpty(buttonText))
                {
                    HyperLink link = new HyperLink();
                    link.Text = buttonText;
                    link.NavigateUrl = "javascript:void(0)";
                    container.Controls.Add(link);
                    link.ApplyStyle(ControlStyle);
                }
            }
            else if (ButtonType == GridViewColumnButtonType.Image)
            {
                Image img = new Image();
                img.AlternateText = buttonText;

                if (!string.IsNullOrEmpty(ImageUrl))
                {
                    img.ImageUrl = Owner.ResolveClientUrl(ImageUrl);
                }

                container.Controls.Add(img);
                img.ApplyStyle(ControlStyle);
            }
            else
            {
                Button button = new Button();
                button.Text = buttonText;
                container.Controls.Add(button);
                button.ApplyStyle(ControlStyle);
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

            AddProperty(desc, "commandName", CommandName);
            AddProperty(desc, "dataTextField", DataTextField);
            AddProperty(desc, "dataTextField", DataTextFormatString);
            AddProperty(desc, "text", Text);

            AddImage(desc, "imageUrl", ImageUrl);

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
                    CommandName = (string)states[2];
                }

                if (states[3] != null)
                {
                    DataTextField = (string)states[3];
                }

                if (states[4] != null)
                {
                    DataTextFormatString = (string)states[4];
                }

                if (states[5] != null)
                {
                    ImageUrl = (string)states[5];
                }

                if (states[6] != null)
                {
                    Text = (string)states[6];
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
            object[] states = new object[7];

            states[0] = base.SaveViewState();

            if (ButtonType != GridViewColumnButtonType.Link)
            {
                states[1] = ButtonType;
            }

            if (!string.IsNullOrEmpty(CommandName))
            {
                states[2] = CommandName;
            }

            if (!string.IsNullOrEmpty(DataTextField))
            {
                states[3] = DataTextField;
            }

            if (!string.IsNullOrEmpty(DataTextFormatString))
            {
                states[4] = DataTextFormatString;
            }

            if (!string.IsNullOrEmpty(ImageUrl))
            {
                states[5] = ImageUrl;
            }

            if (!string.IsNullOrEmpty(Text))
            {
                states[6] = Text;
            }

            return states;
        }
    }
}