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
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace AjaxDataControls
{
    /// <summary>
    /// The base class which represent a column of <see cref="GridView"/> Control.
    /// </summary>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [ParseChildren(true)]
    [TypeConverter(typeof(ExpandableObjectConverter))]
    [DefaultProperty("HeaderText")]
    public abstract class GridViewBaseColumn : IStateManager, IDisposable
    {
        private int _columnId;
        private string _headerText = string.Empty;
        private string _footerText = string.Empty;
        private string _sortField = string.Empty;
        private bool _allowDragAndDrop = true;
        private bool _visible = true;

        private TableItemStyle _headerStyle;
        private TableItemStyle _footerStyle;
        private TableItemStyle _itemStyle;
        private Style _controlStyle;

        private GridView _owner;

        private bool _isTrackingViewState;

        private bool _isDisposed;

        /// <summary>
        /// Gets or sets the ID of the column which is used to uniquely identify the column.
        /// </summary>
        /// <value>The ID of the column.</value>
        [Browsable(false)]
        [EditorBrowsable(EditorBrowsableState.Never)]
        [Description("Unique identifier of the column to identify it among the other columns in the collection.")]
        [SuppressMessage("Microsoft.Naming", "CA1706:ShortAcronymsShouldBeUppercase")]
        public int ColumnID
        {
            [DebuggerStepThrough()]
            get
            {
                return _columnId;
            }
            [DebuggerStepThrough()]
            [SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters")]
            set
            {
                if (value < 0)
                {
                    throw new ArgumentOutOfRangeException("value", value, "Column ID must be positive integer.");
                }

                _columnId = value;
            }
        }

        /// <summary>
        /// Gets or sets the text that is displayed in the header item of a <see cref="GridView"/>.
        /// </summary>
        /// <remarks>
        /// Use the <b>HeaderText</b> property to identify a field in a data control with a friendly name. The most common application of the <b>HeaderText</b> property is to provide meaningful column names for data-bound fields in a <see cref="GridView"/> control.
        /// </remarks>
        /// <value>A string that is displayed in the header item of the <see cref="GridViewBaseColumn"/>.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]
        [Description("The text within the header of this column.")]
        public string HeaderText
        {
            [DebuggerStepThrough()]
            get
            {
                return _headerText;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_headerText != value)
                {
                    _headerText = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the text that is displayed in the footer item of a <see cref="GridView"/>.
        /// </summary>
        /// <remarks>
        /// Use the <b>FooterText</b> property to add notes or comments to a data control field, or for other data related to the field.
        /// </remarks>
        /// <value>A string that is displayed in the footer item of the <see cref="GridViewBaseColumn"/>.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]
        [Description("The text within the footer of this column.")]
        public string FooterText
        {
            [DebuggerStepThrough()]
            get
            {
                return _footerText;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_footerText != value)
                {
                    _footerText = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets a sort field that is used by a data source control to sort its data.
        /// </summary>
        /// <value>The sort field in the data source that is used by a data source control to sort data. The default value is an empty string ("").</value>
        [Category("Data")]
        [DefaultValue("")]
        [Description("The data source field name which is used to to sort this column")]
        public string SortField
        {
            [DebuggerStepThrough()]
            get
            {
                return _sortField;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_sortField != value)
                {
                    _sortField = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether drag and drop is supported for this column.
        /// </summary>
        /// <remarks>
        /// The Asp.net Ajax Framework Drag Drop script(s) needs to be present in the page.
        /// </remarks>
        /// <value><c>true</c> if drag and drop is allowed; otherwise, <c>false</c>.The default is <c>true</c>.</value>
        [Category("Behavior")]
        [DefaultValue(true)]
        [Description("Whether to allow drag and drop of this column.")]
        public bool AllowDragAndDrop
        {
            [DebuggerStepThrough()]
            get
            {
                return _allowDragAndDrop;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_allowDragAndDrop != value)
                {
                    _allowDragAndDrop = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether the column is rendered.
        /// </summary>
        /// <remarks>
        /// Use the <b>Visible</b> property to show or hide <see cref="GridViewBaseColumn"/> objects in a <see cref="GridView"/> control.
        /// </remarks>
        /// <value><c>true</c> if visible; otherwise, <c>false</c>. The default value is <c>true</c>.</value>
        [Category("Behavior")]
        [DefaultValue(true)]
        [Description("Whether the column is visible or not.")]
        public bool Visible
        {
            [DebuggerStepThrough()]
            get
            {
                return _visible;
            }
            [DebuggerStepThrough()]
            set
            {
                if (_visible != value)
                {
                    _visible = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the style of the header of the column.
        /// </summary>
        /// <remarks>
        /// The <b>HeaderStyle</b> property governs the appearance of any text displayed in the header item of a type derived from <see cref="GridViewBaseColumn"/>.
        /// </remarks>
        /// <value>A <see cref="System.Web.UI.WebControls.TableItemStyle"/> that governs the appearance of the <see cref="GridViewBaseColumn"/> header item.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to header within this colum.")]
        public TableItemStyle HeaderStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_headerStyle == null)
                {
                    _headerStyle = new TableItemStyle();

                    if (IsTrackingViewState)
                    {
                        ((IStateManager)_headerStyle).TrackViewState();
                    }
                }

                return _headerStyle;
            }
        }

        /// <summary>
        /// Gets or sets the style of the footer of the column.
        /// </summary>
        /// <remarks>
        /// The <b>FooterStyle</b> property governs the appearance of any text displayed in the footer item of a type derived from <see cref="GridViewBaseColumn"/>.
        /// </remarks>
        /// <value>A <see cref="System.Web.UI.WebControls.TableItemStyle"/> that governs the appearance of the <see cref="GridViewBaseColumn"/> footer item.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to footer within this column.")]
        public TableItemStyle FooterStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_footerStyle == null)
                {
                    _footerStyle = new TableItemStyle();

                    if (IsTrackingViewState)
                    {
                        ((IStateManager)_footerStyle).TrackViewState();
                    }
                }

                return _footerStyle;
            }
        }

        /// <summary>
        /// Gets the style of any text-based content displayed by the column.
        /// </summary>
        /// <remarks>
        /// The <b>ItemStyle</b> property governs the appearance of any text data displayed by a type derived from <see cref="GridViewBaseColumn"/>. For example, when you bind a <see cref="GridViewBoundColumn">BoundColumn</see> control to text data, you can use the ItemStyle property to alter the appearance of the text that is displayed.
        /// </remarks>
        /// <value>A <see cref="System.Web.UI.WebControls.TableItemStyle"/> that governs the appearance of the text displayed in a <see cref="GridViewBaseColumn"/>.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to rows within this field.")]
        public TableItemStyle ItemStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_itemStyle == null)
                {
                    _itemStyle = new TableItemStyle();

                    if (IsTrackingViewState)
                    {
                        ((IStateManager)_itemStyle).TrackViewState();
                    }
                }

                return _itemStyle;
            }
        }

        /// <summary>
        /// Gets or sets the style of the controls contained by the column.
        /// </summary>
        /// <value>A <see cref="System.Web.UI.WebControls.Style"/> that governs the appearance of controls contained by the column.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to each control within this column.")]
        public Style ControlStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_controlStyle == null)
                {
                    _controlStyle = new TableItemStyle();

                    if (IsTrackingViewState)
                    {
                        ((IStateManager)_controlStyle).TrackViewState();
                    }
                }

                return _controlStyle;
            }
        }

        /// <summary>
        /// Gets the base name of the script file without the extension.
        /// </summary>
        /// <remarks>
        /// This method will return the base name without the .debug.js or .js extension of the associated script file of this column.
        /// </remarks>
        /// <value>The name of the script file base name.</value>
        protected abstract string ScriptBaseFileName
        {
            get;
        }

        /// <summary>
        /// The owner <see cref="GridView"/> of this column.
        /// </summary>
        /// <value>The owner GridView which holds this column.</value>
        protected GridView Owner
        {
            [DebuggerStepThrough()]
            get
            {
                return _owner;
            }
        }

        /// <summary>
        /// When implemented by a class, gets a value indicating whether a server control is tracking its view state changes.
        /// </summary>
        /// <value></value>
        /// <returns>true if a server control is tracking its view state changes; otherwise, false.</returns>
        protected virtual bool IsTrackingViewState
        {
            [DebuggerStepThrough()]
            get
            {
                return _isTrackingViewState;
            }
        }

        internal string CreateScript
        {
            [DebuggerStepThrough()]
            get
            {
                string script = BuildDescriptor().CreateScript;

                //Need to remove the last ;
                if (script.EndsWith(";"))
                {
                    script = script.Substring(0, script.Length - 1);
                }

                return script;
            }
        }

        internal ScriptReference ScriptReference
        {
            [DebuggerStepThrough()]
            get
            {
                string injectedResource = string.Concat(
                                                            ScriptBaseFileName,
                                                            ScriptManager.GetCurrent(this.Owner.Page).IsDebuggingEnabled ? ".debug.js" : ".js"
                                                        );

                return new ScriptReference(this.Owner.Page.ClientScript.GetWebResourceUrl(this.GetType(), injectedResource));
            }
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="GridViewBaseColumn"/> class.
        /// </summary>
        protected GridViewBaseColumn()
        {
        }

        /// <summary>
        /// Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <summary>
        /// Releases unmanaged and - optionally - managed resources
        /// </summary>
        /// <param name="disposing"><c>true</c> to release both managed and unmanaged resources; <c>false</c> to release only unmanaged resources.</param>
        protected virtual void Dispose(bool disposing)
        {
            if (!_isDisposed)
            {
                if (disposing)
                {
                    if (_headerStyle != null)
                    {
                        _headerStyle.Dispose();
                    }

                    if (_footerStyle != null)
                    {
                        _footerStyle.Dispose();
                    }

                    if (_itemStyle != null)
                    {
                        _itemStyle.Dispose();
                    }

                    if (_controlStyle != null)
                    {
                        _controlStyle.Dispose();
                    }
                }
            }

            _isDisposed = true;
        }

        /// <summary>
        /// Releases unmanaged resources and performs other cleanup operations before the
        /// <see cref="GridViewBaseColumn"/> is reclaimed by garbage collection.
        /// </summary>
        ~GridViewBaseColumn()
        {
            Dispose(false);
        }

        /// <summary>
        /// Renders the header. Used by the designer to render the column header in the design time.
        /// </summary>
        /// <remarks>
        /// This method should be used to show the rendered data in the Designer for the custom column. You do need this method otherwise.
        /// </remarks>
        /// <param name="container">The container.</param>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public virtual void RenderHeader(TableCell container)
        {
            if (container == null)
            {
                throw new ArgumentNullException("container");
            }

            if (!string.IsNullOrEmpty(SortField))
            {
                if (!string.IsNullOrEmpty(HeaderText))
                {
                    HyperLink link = new HyperLink();
                    link.Text = HeaderText;
                    link.NavigateUrl = "javascript:void(0)";
                    container.Controls.Add(link);

                    if (SortField == Owner.SortColumn)
                    {
                        string sortImageUrl = (Owner.SortOrder == GridViewSortOrder.Descending) ? Owner.SortOrderDescendingImageUrl : Owner.SortOrderAscendingImageUrl;

                        if (!string.IsNullOrEmpty(sortImageUrl))
                        {
                            sortImageUrl = Owner.ResolveClientUrl(sortImageUrl);

                            Image img = new Image();
                            img.ImageUrl = sortImageUrl;
                            img.AlternateText = string.Empty;
                            container.Controls.Add(link);
                        }
                    }
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(HeaderText))
                {
                    container.Text = HeaderText;
                }
            }

            container.ApplyStyle(HeaderStyle);
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
        public abstract void RenderData(TableCell container, string data);

        /// <summary>
        /// Renders the footer. Used by the designer to render the column footer in the design time.
        /// </summary>
        /// <remarks>
        /// This method should be used to show the rendered data in the Designer for the custom column. You do need this method otherwise.
        /// </remarks>
        /// <param name="container">The container.</param>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public virtual void RenderFooter(TableCell container)
        {
            if (container == null)
            {
                throw new ArgumentNullException("container");
            }

            if (!string.IsNullOrEmpty(FooterText))
            {
                container.Text = FooterText;
            }

            container.ApplyStyle(FooterStyle);
        }

        /// <summary>
        /// Sets the owner. Used by the control internally.
        /// </summary>
        /// <param name="owner">The owner.</param>
        [EditorBrowsable(EditorBrowsableState.Never)]
        protected internal void SetOwner(GridView owner)
        {
            _owner = owner;
        }

        /// <summary>
        /// Builds the descriptor for this column.
        /// </summary>
        /// <returns>Returns the descriptor embedding all the properties of this column.</returns>
        protected virtual GridViewColumnScriptDescriptor BuildDescriptor()
        {
            GridViewColumnScriptDescriptor desc = CreateDescriptor();

            desc.AddProperty("columnID", ColumnID);
            AddStyle(desc, "controlStyle", ControlStyle);
            AddStyle(desc, "headerStyle", HeaderStyle);
            AddStyle(desc, "itemStyle", ItemStyle);
            AddStyle(desc, "footerStyle", FooterStyle);

            AddProperty(desc, "headerText", HeaderText);
            AddProperty(desc, "footerText", FooterText);
            AddProperty(desc, "sortField", SortField);

            desc.AddProperty("allowDragAndDrop", AllowDragAndDrop);

            if (!Visible)
            {
                desc.AddProperty("visible", Visible);
            }

            return desc;
        }

        /// <summary>
        /// When implemented by a class, loads the server control's previously saved view state to the control.
        /// </summary>
        /// <param name="state">An <see cref="T:System.Object"/> that contains the saved view state values for the control.</param>
        protected virtual void LoadViewState(object state)
        {
            if (state != null)
            {
                object[] states = (object[])state;

                if (states[0] != null)
                {
                    ColumnID = (int)states[0];
                }

                if (states[1] != null)
                {
                    HeaderText = (string)states[1];
                }

                if (states[2] != null)
                {
                    FooterText = (string)states[2];
                }

                if (states[3] != null)
                {
                    SortField = (string)states[3];
                }

                if (states[4] != null)
                {
                    AllowDragAndDrop = (bool)states[4];
                }

                if (states[5] != null)
                {
                    Visible = (bool)states[5];
                }

                if (states[6] != null)
                {
                    ((IStateManager) HeaderStyle).LoadViewState(states[6]); 
                }

                if (states[7] != null)
                {
                    ((IStateManager) FooterStyle).LoadViewState(states[7]);
                }

                if (states[8] != null)
                {
                    ((IStateManager) ItemStyle).LoadViewState(states[8]);
                }

                if (states[9] != null)
                {
                    ((IStateManager) ControlStyle).LoadViewState(states[9]);
                }
            }
        }

        /// <summary>
        /// When implemented by a class, saves the changes to a server control's view state to an <see cref="T:System.Object"/>.
        /// </summary>
        /// <returns>
        /// The <see cref="T:System.Object"/> that contains the view state changes.
        /// </returns>
        protected virtual object SaveViewState()
        {
            object[] states = new object[10];

            if (ColumnID != 0)
            {
                states[0] = ColumnID;
            }

            if (!string.IsNullOrEmpty(HeaderText))
            {
                states[1] = HeaderText;
            }

            if (!string.IsNullOrEmpty(FooterText))
            {
                states[2] = FooterText;
            }

            if (!string.IsNullOrEmpty(SortField))
            {
                states[3] = SortField;
            }

            if (!AllowDragAndDrop)
            {
                states[4] = AllowDragAndDrop;
            }

            if (!Visible)
            {
                states[5] = Visible;
            }

            if (!HeaderStyle.IsEmpty)
            {
                states[6] = ((IStateManager)HeaderStyle).SaveViewState();
            }

            if (!FooterStyle.IsEmpty)
            {
                states[7] = ((IStateManager)FooterStyle).SaveViewState();
            }

            if (!ItemStyle.IsEmpty)
            {
                states[8] = ((IStateManager)ItemStyle).SaveViewState();
            }

            if (!ControlStyle.IsEmpty)
            {
                states[9] = ((IStateManager)ControlStyle).SaveViewState();
            }

            return states;
        }

        /// <summary>
        /// When implemented by a class, instructs the server control to track changes to its view state.
        /// </summary>
        protected virtual void TrackViewState()
        {
            if (_headerStyle != null)
            {
                ((IStateManager)_headerStyle).TrackViewState();
            }

            if (_footerStyle != null)
            {
                ((IStateManager)_footerStyle).TrackViewState();
            }

            if (_itemStyle != null)
            {
                ((IStateManager)_itemStyle).TrackViewState();
            }

            if (_controlStyle != null)
            {
                ((IStateManager)_controlStyle).TrackViewState();
            }

            _isTrackingViewState = true;
        }

        /// <summary>
        /// Adds the property if the value is not blank.
        /// </summary>
        /// <param name="descriptor">The descriptor.</param>
        /// <param name="propertyName">Name of the property.</param>
        /// <param name="propertyValue">The property value.</param>
        [SuppressMessage("Microsoft.Design", "CA1011:ConsiderPassingBaseTypesAsParameters")]
        protected static void AddProperty(GridViewColumnScriptDescriptor descriptor, string propertyName, string propertyValue)
        {
            if (descriptor == null)
            {
                throw new ArgumentNullException("descriptor");
            }

            if (!string.IsNullOrEmpty(propertyValue))
            {
                descriptor.AddProperty(propertyName, propertyValue);
            }
        }

        /// <summary>
        /// Adds theevent if the value is not blank.
        /// </summary>
        /// <param name="descriptor">The descriptor.</param>
        /// <param name="eventName">Name of the event.</param>
        /// <param name="eventValue">The event value.</param>
        [SuppressMessage("Microsoft.Design", "CA1011:ConsiderPassingBaseTypesAsParameters")]
        protected static void AddEvent(GridViewColumnScriptDescriptor descriptor, string eventName, string eventValue)
        {
            if (descriptor == null)
            {
                throw new ArgumentNullException("descriptor");
            }

            if (!string.IsNullOrEmpty(eventValue))
            {
                descriptor.AddEvent(eventName, eventValue);
            }
        }

        /// <summary>
        /// Converts a Server side style object in script descriptor.
        /// </summary>
        /// <param name="descriptor">The descriptor.</param>
        /// <param name="propertyName">Name of the property.</param>
        /// <param name="style">The style.</param>
        [SuppressMessage("Microsoft.Design", "CA1011:ConsiderPassingBaseTypesAsParameters")]
        protected static void AddStyle(GridViewColumnScriptDescriptor descriptor, string propertyName, Style style)
        {
            if (descriptor == null)
            {
                throw new ArgumentNullException("descriptor");
            }

            string value = StyleConverter.Convert(style);

            if (!string.IsNullOrEmpty(value))
            {
                descriptor.AddScriptProperty(propertyName, value);
            }
        }

        /// <summary>
        /// Converts a Server side style object in script descriptor.
        /// </summary>
        /// <param name="descriptor">The descriptor.</param>
        /// <param name="propertyName">Name of the property.</param>
        /// <param name="style">The style.</param>
        [SuppressMessage("Microsoft.Design", "CA1011:ConsiderPassingBaseTypesAsParameters")]
        protected static void AddStyle(GridViewColumnScriptDescriptor descriptor, string propertyName, TableItemStyle style)
        {
            if (descriptor == null)
            {
                throw new ArgumentNullException("descriptor");
            }

            string value = StyleConverter.Convert(style);

            if (!string.IsNullOrEmpty(value))
            {
                descriptor.AddScriptProperty(propertyName, value);
            }
        }

        /// <summary>
        /// Adds the image url in descriptor.
        /// </summary>
        /// <param name="descriptor">The descriptor.</param>
        /// <param name="propertyName">Name of the property.</param>
        /// <param name="imageUrl">The image URL.</param>
        [SuppressMessage("Microsoft.Design", "CA1011:ConsiderPassingBaseTypesAsParameters")]
        [SuppressMessage("Microsoft.Design", "CA1054:UriParametersShouldNotBeStrings")]
        protected void AddImage(ScriptComponentDescriptor descriptor, string propertyName, string imageUrl)
        {
            if (descriptor == null)
            {
                throw new ArgumentNullException("descriptor");
            }

            if (!string.IsNullOrEmpty(imageUrl))
            {
                descriptor.AddProperty(propertyName, Owner.Page.ResolveClientUrl(imageUrl));
            }
        }

        private GridViewColumnScriptDescriptor CreateDescriptor()
        {
            return new GridViewColumnScriptDescriptor(this.GetType().FullName);
        }

        /// <summary>
        /// When implemented by a class, gets a value indicating whether a server control is tracking its view state changes.
        /// </summary>
        /// <value></value>
        /// <returns>true if a server control is tracking its view state changes; otherwise, false.</returns>
        bool IStateManager.IsTrackingViewState
        {
            [DebuggerStepThrough()]
            get
            {
                return IsTrackingViewState;
            }
        }

        /// <summary>
        /// When implemented by a class, loads the server control's previously saved view state to the control.
        /// </summary>
        /// <param name="state">An <see cref="T:System.Object"/> that contains the saved view state values for the control.</param>
        void IStateManager.LoadViewState(object state)
        {
            LoadViewState(state);
        }

        /// <summary>
        /// When implemented by a class, saves the changes to a server control's view state to an <see cref="T:System.Object"/>.
        /// </summary>
        /// <returns>
        /// The <see cref="T:System.Object"/> that contains the view state changes.
        /// </returns>
        object IStateManager.SaveViewState()
        {
            return SaveViewState();
        }

        /// <summary>
        /// When implemented by a class, instructs the server control to track changes to its view state.
        /// </summary>
        void IStateManager.TrackViewState()
        {
            TrackViewState();
        }
    }
}
