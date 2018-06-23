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
using System.Collections.Generic;
using System.Security.Permissions;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

[assembly: WebResource(AjaxDataControls.DataList.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.DataList.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// Specifies the direction in which items of a DataList control are displayed.
    /// </summary>
    public enum DataListRepeatDirection : int
    {
        /// <summary>
        /// Items of a DataList are displayed vertically in columns from top to bottom, and then left to right, until all items are rendered.
        /// </summary>
        Vertical = 0,
        /// <summary>
        /// Items of a DateList are displayed horizontally in rows from left to right, then top to bottom, until all items are rendered.
        /// </summary>
        Horizontal = 1
    }

    /// <summary>
    /// A data bound list control that displays items using templates.
    /// </summary>
    /// <seealso cref="Repeater">Repeater Control</seealso>
    /// <seealso cref="GridView">GridView Control</seealso>
    /// <seealso cref="Pager">Pager Control</seealso>>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [Designer(typeof(DataListDesigner))]
    [ToolboxData("<{0}:DataList runat=\"server\"></{0}:DataList>")]
    [ToolboxBitmap(typeof(DataList), "DataList.bmp")]
    [ParseChildren(true)]
    [PersistChildren(false)]
    [Themeable(true)]
    public class DataList : BaseDataControl
    {
        internal const string ScriptFileBase = "AjaxDataControls.DataList.DataList";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private const int DefaultIntegerProperty = -1;
        private const int DefaultDragOpacity = 70;
        private const float DefaultAnimationDuration = 0.2F;
        private const int DefaultAnimationFps = 20;

        private ITemplate _headerTemplate;
        private ITemplate _itemTemplate;
        private ITemplate _separatorTemplate;
        private ITemplate _alternatingItemTemplate;
        private ITemplate _footerTemplate;
        private ITemplate _selectedItemTemplate;
        private ITemplate _editItemTemplate;

        private TableItemStyle _headerStyle;
        private TableItemStyle _itemStyle;
        private TableItemStyle _separatorStyle;
        private TableItemStyle _alternatingItemStyle;
        private TableItemStyle _footerStyle;
        private TableItemStyle _selectedItemStyle;
        private TableItemStyle _editItemStyle;

        /// <summary>
        /// Gets or sets the amount of space between the contents of a cell and the cell's border.
        /// </summary>
        /// <value>The amount of space (in pixels) between the contents of a cell and the cell's border. The default value is -1, which indicates that this property is not set.</value>
        [Category("Layout")]
        [DefaultValue(-1)]
        [Description("The padding withen cells.")]
        public int CellPadding
        {
            [DebuggerStepThrough()]
            get
            {
                if (!base.ControlStyleCreated)
                {
                    return DefaultIntegerProperty;
                }

                return ((TableStyle)base.ControlStyle).CellPadding;
            }
            [DebuggerStepThrough()]
            set
            {
                ((TableStyle)base.ControlStyle).CellPadding = value;
            }
        }

        /// <summary>
        /// Gets or sets the amount of space between cells.
        /// </summary>
        /// <value>The amount of space (in pixels) between cells. The default value is 0.</value>
        [Category("Layout")]
        [DefaultValue(0)]
        [Description("The spacing between cells.")]
        public int CellSpacing
        {
            [DebuggerStepThrough()]
            get
            {
                if (!base.ControlStyleCreated)
                {
                    return DefaultIntegerProperty;
                }

                return ((TableStyle)base.ControlStyle).CellSpacing;
            }
            [DebuggerStepThrough()]
            set
            {
                ((TableStyle)base.ControlStyle).CellSpacing = value;
            }
        }

        /// <summary>
        /// Gets or sets the horizontal alignment of the DataList control within its container.
        /// </summary>
        /// <value>The horizontal align. The default value is NotSet.</value>
        [Category("Layout")]
        [DefaultValue(HorizontalAlign.NotSet)]
        [Description("The horizontal alignment of the control. The default value is NotSet.")]
        public HorizontalAlign HorizontalAlign
        {
            [DebuggerStepThrough()]
            get
            {
                if (!base.ControlStyleCreated)
                {
                    return HorizontalAlign.NotSet;
                }

                return ((TableStyle)base.ControlStyle).HorizontalAlign;
            }
            [DebuggerStepThrough()]
            set
            {
                ((TableStyle)base.ControlStyle).HorizontalAlign = value;
            }
        }

        /// <summary>
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for the heading section of the DataList control.
        /// </summary>
        /// <value>The header template. The default value is a null reference (<b>Nothing</b> in Visual Basic)</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [Themeable(false)]
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
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for the items in the DataList control.
        /// </summary>
        /// <value>The item template. The default value is a null reference (<b>Nothing</b> in Visual Basic)</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [Themeable(false)]
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
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for the separator between the items of the DataList control.
        /// </summary>
        /// <value>The separator template. The default value is a null reference (<b>Nothing</b> in Visual Basic)</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [Themeable(false)]
        public ITemplate SeparatorTemplate
        {
            [DebuggerStepThrough()]
            get
            {
                return _separatorTemplate;
            }
            [DebuggerStepThrough()]
            set
            {
                _separatorTemplate = value;
            }
        }

        /// <summary>
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for alternating items in the DataList.
        /// </summary>
        /// <value>The alternating item template. The default value is a null reference (<b>Nothing</b> in Visual Basic)</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [Themeable(false)]
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
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for the footer section of the DataList control.
        /// </summary>
        /// <value>The footer template. The default value is a null reference (<b>Nothing</b> in Visual Basic)</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [Themeable(false)]
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
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for the selected item in the DataList control.
        /// </summary>
        /// <value>The selected item template. The default value is a null reference (<b>Nothing</b> in Visual Basic)</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [Themeable(false)]
        public ITemplate SelectedItemTemplate
        {
            [DebuggerStepThrough()]
            get
            {
                return _selectedItemTemplate;
            }
            [DebuggerStepThrough()]
            set
            {
                _selectedItemTemplate = value;
            }
        }

        /// <summary>
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> for the item selected for editing in the DataList control.
        /// </summary>
        /// <value>The edit item template. The default value is a null reference (<b>Nothing</b> in Visual Basic)</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [Themeable(false)]
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
        /// Gets or sets a value indicating whether the header section is displayed in the DataList control.
        /// </summary>
        /// <value><c>true</c> to show the header section; otherwise, <c>false</c>.The default is <c>true</c>.</value>
        [Category("Appearance")]
        [DefaultValue(true)]
        [Description("Whether to show the DataList header.")]
        public bool ShowHeader
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["showHeader"];

                return (obj == null) ? true : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["showHeader"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether the footer section is displayed in the DataList control.
        /// </summary>
        /// <value><c>true</c> to show the footer section; otherwise, <c>false</c>.The default is <c>true</c>.</value>
        [Category("Appearance")]
        [DefaultValue(true)]
        [Description("Whether to show the DataList footer.")]
        public bool ShowFooter
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["showFooter"];

                return (obj == null) ? true : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["showFooter"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether drag and drop is supported between the items of the DataList.
        /// </summary>
        /// <remarks>
        /// The Asp.net Ajax Framework Drag Drop script(s) needs to be present in the page.
        /// </remarks>
        /// <value><c>true</c> if drag and drop is allowed; otherwise, <c>false</c>.The default is <c>true</c>.</value>
        [Category("Behavior")]
        [DefaultValue(false)]
        [Description("Whether to allow drag and drop between the items.")]
        public bool AllowDragAndDrop
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["allowDragAndDrop"];

                return (obj == null) ? false : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["allowDragAndDrop"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the drag opacity of the dragging item.
        /// </summary>
        /// <value>The drag opacity. The default value is 70.</value>
        [Category("Appearance")]
        [DefaultValue(DefaultDragOpacity)]
        [Description("The opacity of the drag visual.")]
        public int DragOpacity
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["dragOpacity"];

                return (obj == null) ? DefaultDragOpacity : (int)obj;
            }
            [DebuggerStepThrough()]
            [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters")]
            set
            {
                if ((value < 0) || (value > 100))
                {
                    throw new ArgumentOutOfRangeException("value", value, "Drag opacity must be 0-100.");
                }

                if (DefaultDragOpacity != value)
                {
                    ViewState["dragOpacity"] = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="DataList"/> is animated when binding data.
        /// </summary>
        /// <remarks>
        /// The Asp.net Ajax Framework Glitz script(s) needs to be present in the page.
        /// </remarks>
        /// <value><c>true</c> to animate; otherwise, <c>false</c>.The default is <c>true</c></value>
        [Category("Appearance")]
        [DefaultValue(true)]
        [Description("Whether the control animate fade in effect when databinding is complete.")]
        public bool Animate
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["animate"];

                return (obj == null) ? true : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["animate"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the animation duration in seconds.
        /// </summary>
        /// <value>The animation duration. The default value is 0.3 seconds</value>
        [Category("Appearance")]
        [DefaultValue(DefaultAnimationDuration)]
        [Description("Specify the time duration of the animation in second.")]
        public float AnimationDuration
        {
            get
            {
                object obj = ViewState["animationDuration"];

                return (obj == null) ? DefaultAnimationDuration : (float)obj;
            }
            [SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters")]
            set
            {
                if (value < 0)
                {
                    throw new ArgumentOutOfRangeException("value", value, "Animation duration must be positive value.");
                }

                ViewState["animationDuration"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the animation frames per second.
        /// </summary>
        /// <value>The animation frame per second. The default value is 25.</value>
        [Category("Appearance")]
        [DefaultValue(DefaultAnimationFps)]
        [Description("Gets/sets the frame per second of the animation.")]
        public int AnimationFps
        {
            get
            {
                object obj = ViewState["animationFps"];

                return (obj == null) ? DefaultAnimationFps : (int)obj;
            }
            [SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters")]
            set
            {
                if (value < 0)
                {
                    throw new ArgumentOutOfRangeException("value", value, "Animation fps must be positive value.");
                }

                ViewState["animationFps"] = value;
            }
        }

        /// <summary>
        /// Gets the style properties for the heading section of the DataList control.
        /// </summary>
        /// <value>The header style. The default value is empty style.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to header.")]
        public TableItemStyle HeaderStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_headerStyle == null)
                {
                    _headerStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_headerStyle).TrackViewState();
                }

                return _headerStyle;
            }
        }

        /// <summary>
        /// Gets the style properties for the items in the DataList control.
        /// </summary>
        /// <value>The item style. The default value is empty style.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to items.")]
        public TableItemStyle ItemStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_itemStyle == null)
                {
                    _itemStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_itemStyle).TrackViewState();
                }

                return _itemStyle;
            }
        }

        /// <summary>
        /// Gets the style properties of the separator between each item in the DataList control.
        /// </summary>
        /// <value>The separator style. The default value is empty style.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to separator items.")]
        public TableItemStyle SeparatorStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_separatorStyle == null)
                {
                    _separatorStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_separatorStyle).TrackViewState();
                }

                return _separatorStyle;
            }
        }

        /// <summary>
        /// Gets the style properties for alternating items in the DataList control.
        /// </summary>
        /// <value>The alternating item style. The default value is empty style.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to alternating alternating items.")]
        public TableItemStyle AlternatingItemStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_alternatingItemStyle == null)
                {
                    _alternatingItemStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_alternatingItemStyle).TrackViewState();
                }

                return _alternatingItemStyle;
            }
        }

        /// <summary>
        /// Gets the style properties for the footer section of the DataList control.
        /// </summary>
        /// <value>The footer style. The default value is empty style.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to footer.")]
        public TableItemStyle FooterStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_footerStyle == null)
                {
                    _footerStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_footerStyle).TrackViewState();
                }

                return _footerStyle;
            }
        }

        /// <summary>
        /// Gets the style properties for the selected item in the DataList control.
        /// </summary>
        /// <value>The selected item style. The default value is empty style.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to selected items.")]
        public TableItemStyle SelectedItemStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_selectedItemStyle == null)
                {
                    _selectedItemStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_selectedItemStyle).TrackViewState();
                }

                return _selectedItemStyle;
            }
        }

        /// <summary>
        /// Gets the style properties for the item selected for editing in the DataList control.
        /// </summary>
        /// <value>The edit item style. The default value is empty style.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to items in edit mode.")]
        public TableItemStyle EditItemStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_editItemStyle == null)
                {
                    _editItemStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_editItemStyle).TrackViewState();
                }

                return _editItemStyle;
            }
        }

        /// <summary>
        /// Gets or sets the number of columns to display in the DataList control.
        /// </summary>
        /// <value>The number of columns to display in the DataList control. The default value is 0, which indicates that the items in the DataList control are displayed in a single row or column, based on the value of the <see cref="RepeatDirection"/> property.</value>
        [Category("Layout")]
        [DefaultValue(0)]
        [Description("The number of columns to be used to format the layout.")]
        public int RepeatColumns
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["repeatColumns"];

                return (obj == null) ? 0 : (int)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["repeatColumns"] = value;
            }
        }

        /// <summary>
        /// Gets or sets whether the DataList control displays vertically or horizontally.
        /// </summary>
        /// <value>The repeat direction. The default is Vertical.</value>
        [Category("Layout")]
        [DefaultValue(DataListRepeatDirection.Vertical)]
        [Description("The direction in which the items are laid out.")]
        public DataListRepeatDirection RepeatDirection
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["repeatDirection"];

                return (obj == null) ? DataListRepeatDirection.Vertical : (DataListRepeatDirection)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["repeatDirection"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the index number of the selected item in the DataList control to edit.
        /// </summary>
        /// <remarks>To unselect an item, set the EditItemIndex property to -1.</remarks>
        /// <value>The index number of the selected item in the DataList control to edit.</value>
        [DefaultValue(DefaultIntegerProperty)]
        [Description("The index of the item shown in edit mode.")]
        [Themeable(false)]
        public int EditItemIndex
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["editItemIndex"];

                return (obj == null) ? DefaultIntegerProperty : (int)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["editItemIndex"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the index of the selected item in the DataList control.
        /// </summary>
        /// <remarks>
        /// To deselect an item, set the SelectedIndex property to -1.
        /// </remarks>
        /// <value>The index of the selected item in the DataList control.</value>
        [DefaultValue(DefaultIntegerProperty)]
        [Description("The index of the currently selected item.")]
        [Themeable(false)]
        public int SelectedIndex
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["selectedIndex"];

                return (obj == null) ? DefaultIntegerProperty : (int)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["selectedIndex"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the key field in the data source specified by the DataSource property in the client side.
        /// </summary>
        /// <value>The name of the key field in the data source specified by DataSource.</value>
        [Category("Data")]
        [DefaultValue("")]
        [Description("The field in the data source used to populate the DataKeys collection.")]
        [Themeable(false)]
        public string DataKeyField
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["dataKeyField"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["dataKeyField"] = value;
            }
        }

        /// <summary>
        /// Occurs when user starts dragging of an item in the DataList control.
        /// </summary>
        /// <value>The item drag start event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when item is dragged.")]
        [DefaultValue("")]
        [Themeable(false)]
        public string ItemDragStartEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["itemDragStartEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["itemDragStartEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs when user drops an item in the DataList control.
        /// </summary>
        /// <value>The item dropped event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when an item is dropped.")]
        [DefaultValue("")]
        [Themeable(false)]
        public string ItemDroppedEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["itemDroppedEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["itemDroppedEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when an item in the DataList control is created.
        /// </summary>
        /// <value>The item created event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when an item is created.")]
        [DefaultValue("")]
        [Themeable(false)]
        public string ItemCreatedEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["itemCreatedEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["itemCreatedEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when an item in the DataList control is going to be data-bound.
        /// </summary>
        /// <value>The item data bound event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when an item is going to be data bounded.")]
        [DefaultValue("")]
        [Themeable(false)]
        public string ItemDataBoundEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["itemDataBoundEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["itemDataBoundEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when a different item is selected in a DataList control through select command.
        /// </summary>
        /// <value>The selected index changed event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when the current selection changes")]
        [DefaultValue("")]
        [Themeable(false)]
        public string SelectedIndexChangedEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["selectedIndexChangedEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["selectedIndexChangedEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when the Edit button is clicked for an item in the DataList control.
        /// </summary>
        /// <value>The edit command event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when an Edit CommandEvent is generated within DataList.")]
        [DefaultValue("")]
        [Themeable(false)]
        public string EditCommandEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["editCommandEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["editCommandEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when the Update button is clicked for an item in the DataList control.
        /// </summary>
        /// <value>The update command event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when an Update CommandEvent is generated within DataList.")]
        [DefaultValue("")]
        [Themeable(false)]
        public string UpdateCommandEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["updateCommandEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["updateCommandEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when the Cancel button is clicked for an item in the DataList control.
        /// </summary>
        /// <value>The cancel command event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when a Cancel CommandEvent is generated within DataList.")]
        [DefaultValue("")]
        [Themeable(false)]
        public string CancelCommandEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["cancelCommandEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["cancelCommandEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when the Delete button is clicked for an item in the DataList control.
        /// </summary>
        /// <value>The delete command event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when a Delete CommandEvent is generated within DataList.")]
        [DefaultValue("")]
        [Themeable(false)]
        public string DeleteCommandEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["deleteCommandEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["deleteCommandEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when a button which has associated commandName is clicked in the DataList control.
        /// </summary>
        /// <value>The item command event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when a CommandEvent is generated within DataList.")]
        [DefaultValue("")]
        [Themeable(false)]
        public string ItemCommandEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["itemCommandEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["itemCommandEvent"] = value;
            }
        }

        /// <summary>
        /// Gets the <see cref="T:System.Web.UI.HtmlTextWriterTag"/> value that corresponds to this Web server control. This property is used primarily by control developers.
        /// </summary>
        /// <value></value>
        /// <returns>One of the <see cref="T:System.Web.UI.HtmlTextWriterTag"/> enumeration values.</returns>
        protected override HtmlTextWriterTag TagKey
        {
            [DebuggerStepThrough()]
            get
            {
                return HtmlTextWriterTag.Table;
            }
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="DataList"/> class.
        /// </summary>
        public DataList() : base()
        {
        }

        /// <summary>
        /// Creates the style object that is used internally by the <see cref="T:System.Web.UI.WebControls.WebControl"/> class to implement all style related properties. This method is used primarily by control developers.
        /// </summary>
        /// <returns>
        /// A <see cref="T:System.Web.UI.WebControls.Style"/> that is used to implement all style-related properties of the control.
        /// </returns>
        protected override Style CreateControlStyle()
        {
            return new TableStyle(this.ViewState);
        }

        /// <summary>
        /// Gets the script descriptors.
        /// </summary>
        /// <returns>Returns the ScriptDescriptors which are associated with this control</returns>
        protected override IEnumerable<ScriptDescriptor> GetScriptDescriptors()
        {
            ScriptControlDescriptor desc = CreateDescriptor();

            ScriptDescriptorHelper.AddTempateHtml(desc, "headerTemplate", HeaderTemplate);
            ScriptDescriptorHelper.AddTempateHtml(desc, "itemTemplate", ItemTemplate);
            ScriptDescriptorHelper.AddTempateHtml(desc, "separatorTemplate", SeparatorTemplate);
            ScriptDescriptorHelper.AddTempateHtml(desc, "alternatingItemTemplate", AlternatingItemTemplate);
            ScriptDescriptorHelper.AddTempateHtml(desc, "footerTemplate", FooterTemplate);
            ScriptDescriptorHelper.AddTempateHtml(desc, "selectedItemTemplate", SelectedItemTemplate);
            ScriptDescriptorHelper.AddTempateHtml(desc, "editItemTemplate", EditItemTemplate);

            ScriptDescriptorHelper.AddStyle(desc, "headerStyle", HeaderStyle);
            ScriptDescriptorHelper.AddStyle(desc, "itemStyle", ItemStyle);
            ScriptDescriptorHelper.AddStyle(desc, "separatorStyle", SeparatorStyle);
            ScriptDescriptorHelper.AddStyle(desc, "alternatingItemStyle", AlternatingItemStyle);
            ScriptDescriptorHelper.AddStyle(desc, "footerStyle", FooterStyle);
            ScriptDescriptorHelper.AddStyle(desc, "selectedItemStyle", SelectedItemStyle);
            ScriptDescriptorHelper.AddStyle(desc, "editItemStyle", EditItemStyle);

            if (!ShowHeader)
            {
                desc.AddProperty("showHeader", ShowHeader);
            }

            if (!ShowFooter)
            {
                desc.AddProperty("showFooter", ShowFooter);
            }

            if (AllowDragAndDrop)
            {
                desc.AddProperty("allowDragAndDrop", AllowDragAndDrop);
            }

            if (DragOpacity != DefaultDragOpacity)
            {
                desc.AddProperty("dragOpacity", DragOpacity);
            }

            if (Animate)
            {
                if (AnimationDuration != DefaultAnimationDuration)
                {
                    desc.AddProperty("animationDuration", AnimationDuration);
                }

                if (AnimationFps != DefaultAnimationFps)
                {
                    desc.AddProperty("animationFps", AnimationFps);
                }
            }
            else
            {
                desc.AddProperty("animate", Animate);
            }

            if (RepeatColumns > 0)
            {
                desc.AddProperty("repeatColumns", RepeatColumns);
            }

            if (RepeatDirection != DataListRepeatDirection.Vertical)
            {
                desc.AddScriptProperty("repeatDirection", typeof(DataListRepeatDirection).FullName + "." + RepeatDirection.ToString());
            }

            if (EditItemIndex != DefaultIntegerProperty)
            {
                desc.AddProperty("editItemIndex", EditItemIndex);
            }

            if (SelectedIndex != DefaultIntegerProperty)
            {
                desc.AddProperty("selectedIndex", SelectedIndex);
            }

            ScriptDescriptorHelper.AddProperty(desc, "dataKeyField", DataKeyField);

            ScriptDescriptorHelper.AddEvent(desc, "itemDragStart", ItemDragStartEvent);
            ScriptDescriptorHelper.AddEvent(desc, "itemDropped", ItemDroppedEvent);
            ScriptDescriptorHelper.AddEvent(desc, "itemDataBound", ItemDataBoundEvent);
            ScriptDescriptorHelper.AddEvent(desc, "selectedIndexChanged", SelectedIndexChangedEvent);
            ScriptDescriptorHelper.AddEvent(desc, "editCommand", EditCommandEvent);
            ScriptDescriptorHelper.AddEvent(desc, "updateCommand", UpdateCommandEvent);
            ScriptDescriptorHelper.AddEvent(desc, "cancelCommand", CancelCommandEvent);
            ScriptDescriptorHelper.AddEvent(desc, "deleteCommand", DeleteCommandEvent);
            ScriptDescriptorHelper.AddEvent(desc, "itemCommand", ItemCommandEvent);

            yield return desc;
        }

        /// <summary>
        /// Gets the script references.
        /// </summary>
        /// <returns>Returns the ScriptReferences which are associated with this control</returns>
        protected override IEnumerable<ScriptReference> GetScriptReferences()
        {
            if (UseExternalScripts)
            {
                return null;
            }

            return new ScriptReference[] {
                                            base.GetProperScriptReference(StyleConverter.ScriptFileBase),
                                            base.GetProperScriptReference(ScriptFileBase)
                                         };
        }
    }
}