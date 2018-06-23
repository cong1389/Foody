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
using System.Diagnostics.CodeAnalysis;
using System.Globalization;
using System.ComponentModel;
using System.Collections.Generic;
using System.Security.Permissions;
using System.Drawing;
using System.Drawing.Design;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.Design;

[assembly: WebResource(AjaxDataControls.GridView.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.GridView.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// Specifies the direction in which to sort the GridView Rows.
    /// </summary>
    public enum GridViewSortOrder : int
    {
        /// <summary>
        /// Do not sort.
        /// </summary>
        None = 0,
        /// <summary>
        /// Sort from smallest to largest. For example, from A to Z.
        /// </summary>
        Ascending = 1,
        /// <summary>
        /// Sort from largest to smallest. For example, from Z to A.
        /// </summary>
        Descending = 2
    }

    /// <summary>
    /// Displays the values of a data source in a table where each column represents a column and each row represents a record. The GridView control allows you to select, sort, and edit these items.
    /// </summary>
    /// <seealso cref="Repeater">Repeater Control</seealso>
    /// <seealso cref="DataList">DataList Control</seealso>
    /// <seealso cref="Pager">Pager Control</seealso>>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [Designer(typeof(GridViewDesigner))]
    [ToolboxData("<{0}:GridView runat=\"server\"></{0}:GridView>")]
    [ToolboxBitmap(typeof(GridView), "GridView.bmp")]
    [PersistChildren(false)]
    [DefaultProperty("Columns")]
    [Themeable(true)]
    public class GridView : BaseDataControl
    {
        internal const string ScriptFileBase = "AjaxDataControls.GridView.GridView";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private const int DefaultIntegerProperty = -1;
        private const int DefaultDragOpacity = 70;
        private const float DefaultAnimationDuration = 0.2F;
        private const int DefaultAnimationFps = 20;

        private TableItemStyle _headerStyle;
        private TableItemStyle _rowStyle;
        private TableItemStyle _alternatingRowStyle;
        private TableItemStyle _footerStyle;
        private TableItemStyle _selectedRowStyle;
        private TableItemStyle _editRowStyle;
        private TableItemStyle _emptyDataRowStyle;

        private ITemplate _emptyDataTemplate;
        private GridViewColumnCollection _columns;

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
                    return -1;
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
                    return -1;
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
        /// Gets or sets the horizontal alignment of the GridView control within its container.
        /// </summary>
        /// <value>The horizontal align. The default value is NotSet.</value>
        [Category("Layout")]
        [DefaultValue(HorizontalAlign.NotSet)]
        [Description("The horizontal alignment of the control.")]
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
        /// Gets or sets a value indicating whether a <see cref="GridViewCommandColumn"/> column with a Delete button for each data row is automatically added to a GridView control.
        /// </summary>
        /// <value>
        /// <c>true</c> to automatically add a <see cref="GridViewCommandColumn"/> with a Delete button for each data row; otherwise, <c>false</c>. The default is <c>false</c>.
        /// </value>
        [Category("Behavior")]
        [DefaultValue(false)]
        [Description("Whether the delete button is generated automatically at runtime.")]
        [Themeable(false)]
        public bool AutoGenerateDeleteButton
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["autoGenerateDeleteButton"];

                return (obj == null) ? false : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["autoGenerateDeleteButton"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether a <see cref="GridViewCommandColumn"/> column with a Edit button for each data row is automatically added to a GridView control.
        /// </summary>
        /// <value>
        /// <c>true</c> to automatically add a <see cref="GridViewCommandColumn"/> with a Edit button for each data row; otherwise, <c>false</c>. The default is <c>false</c>.
        /// </value>
        [Category("Behavior")]
        [DefaultValue(false)]
        [Description("Whether the edit button is generated automatically at runtime.")]
        [Themeable(false)]
        public bool AutoGenerateEditButton
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["autoGenerateEditButton"];

                return (obj == null) ? false : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["autoGenerateEditButton"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether a <see cref="GridViewCommandColumn"/> column with a Select button for each data row is automatically added to a GridView control.
        /// </summary>
        /// <value>
        /// <c>true</c> to automatically add a <see cref="GridViewCommandColumn"/> with a Select button for each data row; otherwise, <c>false</c>. The default is <c>false</c>.
        /// </value>
        [Category("Behavior")]
        [DefaultValue(false)]
        [Description("Whether the select button is generated automatically at runtime.")]
        [Themeable(false)]
        public bool AutoGenerateSelectButton
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["autoGenerateSelectButton"];

                return (obj == null) ? false : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["autoGenerateSelectButton"] = value;
            }
        }

        /// <summary>
        /// Gets or sets an the name of the primary key field for the row displayed in a <b>GridView</b> control.
        /// </summary>
        /// <remarks>
        /// Use the <b>DataKeyName</b> property to specify the field that represent the primary key of the data source.
        /// </remarks>
        /// <value>The name of the key field in the data source specified by DataSource.</value>
        [Category("Data")]
        [DefaultValue("")]
        [Description("The field in the data source used to populate the DataKeys collection.")]
        [Themeable(false)]
        public string DataKeyName
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["dataKeyName"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["dataKeyName"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the user-defined content for the empty data row rendered when a GridView control is bound to a data source that does not contain any records.
        /// </summary>
        /// <remarks>
        /// The empty data row is displayed in a GridView control when the data source that is bound to the control does not contain any records. You can define your own custom user interface (UI) for the empty data row by using the <b>EmptyDataTemplate</b> property. To specify a custom template for the empty data row, first place &lt;EmptyDataTemplate&gt; tags between the opening and closing tags of the GridView control. You can then list the contents of the template between the opening and closing &lt;EmptyDataTemplate&gt; tags. To control the style of the empty data row, use the <see cref="EmptyDataRowStyle"/> property. Alternatively, you can use the built-in UI for the empty data row by setting the <see cref="EmptyDataText"/> property instead of this property.
        /// </remarks>
        /// <value>A <see cref="System.Web.UI.ITemplate"/> that contains the custom content for the empty data row. The default value is a null reference (<b>Nothing</b> in Visual Basic), which indicates that this property is not set.</value>
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [Themeable(false)]
        public ITemplate EmptyDataTemplate
        {
            [DebuggerStepThrough()]
            get
            {
                return _emptyDataTemplate;
            }
            [DebuggerStepThrough()]
            set
            {
                _emptyDataTemplate = value;
            }
        }

        /// <summary>
        /// Gets or sets the text to display in the empty data row rendered when a GridView control is bound to a data source that does not contain any records.
        /// </summary>
        /// <remarks>
        /// The empty data row is displayed in a GridView control when the data source that is bound to the control does not contain any records. Use the <b>EmptyDataText</b> property to specify the text to display in the empty data row. Alternatively, you can define your own custom user interface (UI) for the empty data row by setting the <see cref="EmptyDataTemplate"/> property instead of this property.
        /// </remarks>
        /// <value>The text to display in the empty data row. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]
        [Description("The text shown in the empty data row if no EmptyDataTemplate is defined.")]
        public string EmptyDataText
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["emptyDataText"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["emptyDataText"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the index of the row to edit.
        /// </summary>
        /// <remarks>
        /// Use the <b>EditIndex</b> property to programmatically specify or determine which row in a <b>GridView</b> control to edit. When this property is set to the index of a row in the control, that row enters edit mode. In edit mode, each column field in the row that is not read-only displays the appropriate input control for the field's data type, such as a TextBox control. This allows the user to modify the field's value. To exit edit mode, set this property to -1.
        /// </remarks>
        /// <value>The zero-based index of the row to edit. The default is -1, which indicates that no row is being edited.</value>
        [DefaultValue(DefaultIntegerProperty)]
        [Description("The index of the row shown in edit mode.")]
        [Themeable(false)]
        public int EditIndex
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
        /// Gets or sets the index of the selected row in the <b>GridView</b> control.
        /// </summary>
        /// <remarks>
        /// Use the <b>SelectedIndex</b> property to determine the index of the currently selected row in a GridView control. You can also use this property to programmatically select a row in the control. To clear the selection of a row, set this property to -1. The appearance of the currently selected row can be customized by using the <see cref="SelectedRowStyle"/> property. To access the currently selected row, use the SelectedRow property of the client side.
        /// </remarks>
        /// <value>The zero-based index of the selected row in a GridView control. The default is -1, which indicates that no row is currently selected.</value>
        [DefaultValue(DefaultIntegerProperty)]
        [Description("The index of the currently selected row.")]
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
        /// Gets or sets the sort column which is associated to sort the data source.
        /// </summary>
        /// <value>The column that the data source is currently sorted. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Behavior")]
        [DefaultValue("")]
        [Description("The column used to sort the data source to which the GridView is binding.")]
        [Themeable(false)]
        public string SortColumn
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["sortColumn"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["sortColumn"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the sort order of the data source.
        /// </summary>
        /// <remarks>
        /// Use the SortOrder property to determine whether the <see cref="SortColumn"/> being sorted is sorted in ascending or descending order.
        /// </remarks>
        /// <value>One of the <see cref="GridViewSortOrder"/> values. The default is <b>GridViewSortOrder.Ascending</b>.</value>
        [Category("Behavior")]
        [DefaultValue(GridViewSortOrder.Ascending)]
        [Description("The order in which to sort the column.")]
        [Themeable(false)]
        public GridViewSortOrder SortOrder
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["sortOrder"];

                return (obj == null) ? GridViewSortOrder.Ascending : (GridViewSortOrder)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["sortOrder"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the sort order ascending image URL.
        /// </summary>
        /// <value>The image URL which indicates the column is currently sorted in ascending order. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Editor(typeof(ImageUrlEditor), typeof(UITypeEditor))]
        [Description("The image that will be shown to indicate the ascending order.")]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string SortOrderAscendingImageUrl
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["sortOrderAscendingImageUrl"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["sortOrderAscendingImageUrl"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the sort order descending image URL.
        /// </summary>
        /// <value>The image URL which indicates the column is currently sorted in descending order. The default is an empty string (""), which indicates that this property is not set.</value>
        [Category("Appearance")]
        [DefaultValue("")]
        [Editor(typeof(ImageUrlEditor), typeof(UITypeEditor))]
        [Description("The image that will be shown to indicate the descending order.")]
        [SuppressMessage("Microsoft.Design", "CA1056:UriPropertiesShouldNotBeStrings")]
        public string SortOrderDescendingImageUrl
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["sortOrderDescendingImageUrl"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["sortOrderDescendingImageUrl"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the drag opacity of the column that is being dragged.
        /// </summary>
        /// <value>The drag opacity. The default is 70.</value>
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
            [SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters")]
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
        /// Gets or sets a value indicating whether this <b>GridView</b> is animated when binding data.
        /// </summary>
        /// <remarks>
        /// The Asp.net Ajax Framework Glitz script(s) needs to be present in the page.
        /// </remarks>
        /// <value><c>true</c> if animate; otherwise, <c>false</c>.</value>
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
        /// Gets or sets a value indicating whether header row is shown.
        /// </summary>
        /// <remarks>
        /// Use the <b>ShowHeader</b> property to specify whether a <b>GridView</b> control displays the header row. To control the appearance of the header row, use the <see cref="HeaderStyle"/> property.
        /// </remarks>
        /// <value><c>true</c> to display the header row; otherwise, <c>false</c>. The default is <c>true</c>.</value>
        [Category("Appearance")]
        [DefaultValue(true)]
        [Description("Whether to show the control's header.")]
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
        /// Gets or sets a value indicating whether footer row is shown.
        /// </summary>
        /// <remarks>
        /// Use the <b>ShowFooter</b> property to specify whether a <b>GridView</b> control displays the footer row. To control the appearance of the footer row, use the <see cref="FooterStyle"/> property.
        /// </remarks>
        /// <value><c>true</c> to display the footer row; otherwise, <c>false</c>. The default is <c>false</c>.</value>
        [Category("Appearance")]
        [DefaultValue(false)]
        [Description("Whether to show the control's footer.")]
        public bool ShowFooter
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["showFooter"];

                return (obj == null) ? false : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["showFooter"] = value;
            }
        }

        /// <summary>
        /// Gets a reference to the <see cref="System.Web.UI.WebControls.TableItemStyle" /> object that allows you to set the appearance of the header row in a GridView control.
        /// </summary>
        /// <value>A reference to the <b>TableItemStyle</b> that represents the style of the header row in a <b>GridView</b> control.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to header within the columns.")]
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
        /// Gets a reference to the <see cref="System.Web.UI.WebControls.TableItemStyle" /> object that allows you to set the appearance of the data rows in a GridView control.
        /// </summary>
        /// <value>A reference to the <b>TableItemStyle</b> that represents the style of the data rows in a <b>GridView</b> control.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to rows.")]
        public TableItemStyle RowStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_rowStyle == null)
                {
                    _rowStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_rowStyle).TrackViewState();
                }

                return _rowStyle;
            }
        }

        /// <summary>
        /// Gets a reference to the <see cref="System.Web.UI.WebControls.TableItemStyle" /> object that allows you to set the appearance of alternating data rows in a GridView control.
        /// </summary>
        /// <value>A reference to the <b>TableItemStyle</b> that represents the style of alternating data rows in a <b>GridView</b> control.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to alternating rows.")]
        public TableItemStyle AlternatingRowStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_alternatingRowStyle == null)
                {
                    _alternatingRowStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_alternatingRowStyle).TrackViewState();
                }

                return _alternatingRowStyle;
            }
        }

        /// <summary>
        /// Gets a reference to the <see cref="System.Web.UI.WebControls.TableItemStyle" /> object that allows you to set the appearance of the footer row in a GridView control.
        /// </summary>
        /// <value>A reference to the <b>TableItemStyle</b> that represents the style of the footer row in a <b>GridView</b> control.</value>
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
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_footerStyle).TrackViewState();
                }

                return _footerStyle;
            }
        }

        /// <summary>
        /// Gets a reference to the <see cref="System.Web.UI.WebControls.TableItemStyle" /> object that allows you to set the appearance of the selected row in a GridView control.
        /// </summary>
        /// <value>A reference to the <b>TableItemStyle</b> that represents the style of the selected row in a <b>GridView</b> control.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to selected rows.")]
        public TableItemStyle SelectedRowStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_selectedRowStyle == null)
                {
                    _selectedRowStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_selectedRowStyle).TrackViewState();
                }

                return _selectedRowStyle;
            }
        }

        /// <summary>
        /// Gets a reference to the <see cref="System.Web.UI.WebControls.TableItemStyle" /> object that allows you to set the appearance of the row selected for editing in a GridView control.
        /// </summary>
        /// <value>A reference to the <b>TableItemStyle</b> that represents the style of the row being edited in a <b>GridView</b> control.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to rows in edit mode.")]
        public TableItemStyle EditRowStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_editRowStyle == null)
                {
                    _editRowStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_editRowStyle).TrackViewState();
                }

                return _editRowStyle;
            }
        }

        /// <summary>
        /// Gets a reference to the <see cref="System.Web.UI.WebControls.TableItemStyle" /> object that allows you to set the appearance of the empty data row rendered when a GridView control is bound to a data source that does not contain any records.
        /// </summary>
        /// <value>A reference to the <b>TableItemStyle</b> that allows you to set the appearance of the null row.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to the row that contain the EmptyDataTemplate.")]
        public TableItemStyle EmptyDataRowStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_emptyDataRowStyle == null)
                {
                    _emptyDataRowStyle = new TableItemStyle();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_emptyDataRowStyle).TrackViewState();
                }

                return _emptyDataRowStyle;
            }
        }

        /// <summary>
        /// Gets a collection of <see cref="GridViewBaseColumn"/> objects that represent the columns in a GridView control.
        /// </summary>
        /// <remarks>
        /// The Columns property (collection) is used to store all the explicitly declared columns that get rendered in the GridView control. You can also use the Columns collection to programmatically manage the collection of column fields.
        /// </remarks>
        /// <seealso cref="GridViewBoundColumn"/>
        /// <seealso cref="GridViewButtonColumn"/>
        /// <seealso cref="GridViewCheckBoxColumn"/>
        /// <seealso cref="GridViewCommandColumn"/>
        /// <seealso cref="GridViewHyperLinkColumn"/>
        /// <seealso cref="GridViewImageColumn"/>
        /// <seealso cref="GridViewTemplateColumn"/>
        /// <value>A <see cref="GridViewColumnCollection"/> that contains all the columns in the GridView control.</value>
        [Category("Misc")]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Visible)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DefaultValue(null)]
        [Browsable(false)]
        [Description("The set of columns to be shown in the control.")]
        [Themeable(false)]
        public GridViewColumnCollection Columns
        {
            [DebuggerStepThrough()]
            get
            {
                if (_columns == null)
                {
                    _columns = new GridViewColumnCollection(this);
                }

                return _columns;
            }
        }

        /// <summary>
        /// Occurs after the columns are loaded from Ajax Profile Service.
        /// </summary>
        /// <value>The columns loaded from profile event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires after the columns are loaded from Profile.")]
        [Themeable(false)]
        public string ColumnsLoadedFromProfileEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["columnsLoadedFromProfileEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["columnsLoadedFromProfileEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs after the columns are saved to Ajax Profile Service.
        /// </summary>
        /// <value>The columns saved to profile event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires after the columns are saved in Profile.")]
        [Themeable(false)]
        public string ColumnsSavedToProfileEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["columnsSavedToProfileEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["columnsSavedToProfileEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs when user starts dragging of an column in the GridView control.
        /// </summary>
        /// <value>The column drag start event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when column is dragged.")]
        [Themeable(false)]
        public string ColumnDragStartEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["columnDragStartEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["columnDragStartEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs when user drops a column in the GridView control.
        /// </summary>
        /// <value>The column dropped event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when an column is dropped.")]
        [Themeable(false)]
        public string ColumnDroppedEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["columnDroppedEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["columnDroppedEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs when the a Column header is clicked to change the Sort column or order.
        /// </summary>
        /// <value>The sort command event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when a Sort CommandEvent is generated within the GridView.")]
        [Themeable(false)]
        public string SortCommandEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["sortCommandEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["sortCommandEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when a different row is selected GridView through select command.
        /// </summary>
        /// <value>The selected index changed event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when the current selection changes")]
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
        /// Occurs on the client side when the Edit button is clicked for a row in the GridView control.
        /// </summary>
        /// <value>The edit command event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when an Edit CommandEvent is generated within GridView.")]
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
        /// Occurs on the client side when the Update button is clicked for a row in the GridView control.
        /// </summary>
        /// <value>The update command event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when an Update CommandEvent is generated within GridView.")]
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
        /// Occurs on the client side when the Cancel button is clicked for a row in the GridView control.
        /// </summary>
        /// <value>The cancel command event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when a Cancel CommandEvent is generated within GridView.")]
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
        /// Occurs on the client side when the Delete button is clicked for a row in the GridView control.
        /// </summary>
        /// <value>The delete command event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when a Delete CommandEvent is generated within GridView.")]
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
        /// Occurs on the client side when any button is clicked in the GridView control which has associated commandName.
        /// </summary>
        /// <value>The row command event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when a CommandEvent is generated within GridView.")]
        [Themeable(false)]
        public string RowCommandEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["rowCommandEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["rowCommandEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when a row in the GridView control is created.
        /// </summary>
        /// <value>The row created event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when an row is created.")]
        [Themeable(false)]
        public string RowCreatedEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["rowCreatedEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["rowCreatedEvent"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when a row in the GridVie control is going to be data-bound.
        /// </summary>
        /// <value>The row data bound event.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when an row is going to be data bounded.")]
        [Themeable(false)]
        public string RowDataBoundEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["rowDataBoundEvent"];

                return (obj == null) ? string.Empty : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["rowDataBoundEvent"] = value;
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
        /// Initializes a new instance of the <see cref="GridView"/> class.
        /// </summary>
        public GridView() : base()
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

            if ((_columns != null) && (_columns.Count > 0))
            {
                desc.AddScriptProperty("columns", _columns.ToJSConstructor());
            }

            if (AutoGenerateDeleteButton)
            {
                desc.AddProperty("autoGenerateSelectButton", AutoGenerateDeleteButton);
            }

            if (AutoGenerateEditButton)
            {
                desc.AddProperty("autoGenerateEditButton", AutoGenerateEditButton);
            }

            if (AutoGenerateSelectButton)
            {
                desc.AddProperty("autoGenerateSelectButton", AutoGenerateSelectButton);
            }

            if (!ShowHeader)
            {
                desc.AddProperty("showHeader", ShowHeader);
            }

            if (ShowFooter)
            {
                desc.AddProperty("showFooter", ShowFooter);
            }

            ScriptDescriptorHelper.AddProperty(desc, "dataKeyName", DataKeyName);
            ScriptDescriptorHelper.AddTempateHtml(desc, "emptyDataTemplate", EmptyDataTemplate);
            ScriptDescriptorHelper.AddProperty(desc, "emptyDataText", EmptyDataText);

            ScriptDescriptorHelper.AddProperty(desc, "sortColumn", SortColumn);

            if (EditIndex != DefaultIntegerProperty)
            {
                desc.AddProperty("editIndex", EditIndex);
            }

            if (SelectedIndex != DefaultIntegerProperty)
            {
                desc.AddProperty("selectedIndex", SelectedIndex);
            }

            if (SortOrder != GridViewSortOrder.Ascending)
            {
                desc.AddScriptProperty("sortOrder", typeof(GridViewSortOrder).FullName + "." + SortOrder.ToString());
            }

            if (!string.IsNullOrEmpty(SortOrderAscendingImageUrl))
            {
                desc.AddProperty("sortOrderAscendingImageUrl", this.Page.ResolveClientUrl(SortOrderAscendingImageUrl));
            }

            if (!string.IsNullOrEmpty(SortOrderDescendingImageUrl))
            {
                desc.AddProperty("sortOrderDescendingImageUrl", this.Page.ResolveClientUrl(SortOrderDescendingImageUrl));
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

            ScriptDescriptorHelper.AddStyle(desc, "headerStyle", HeaderStyle);
            ScriptDescriptorHelper.AddStyle(desc, "rowStyle", RowStyle);
            ScriptDescriptorHelper.AddStyle(desc, "alternatingRowStyle", AlternatingRowStyle);
            ScriptDescriptorHelper.AddStyle(desc, "footerStyle", FooterStyle);
            ScriptDescriptorHelper.AddStyle(desc, "selectedRowStyle", SelectedRowStyle);
            ScriptDescriptorHelper.AddStyle(desc, "editRowStyle", EditRowStyle);
            ScriptDescriptorHelper.AddStyle(desc, "emptyDataRowStyle", EmptyDataRowStyle);

            ScriptDescriptorHelper.AddEvent(desc, "columnsLoadedFromProfile", ColumnsLoadedFromProfileEvent);
            ScriptDescriptorHelper.AddEvent(desc, "columnsSavedToProfile", ColumnsSavedToProfileEvent);
            ScriptDescriptorHelper.AddEvent(desc, "columnDragStart", ColumnDragStartEvent);
            ScriptDescriptorHelper.AddEvent(desc, "columnDropped", ColumnDroppedEvent);
            ScriptDescriptorHelper.AddEvent(desc, "sortCommand", SortCommandEvent);
            ScriptDescriptorHelper.AddEvent(desc, "selectedIndexChanged", SelectedIndexChangedEvent);
            ScriptDescriptorHelper.AddEvent(desc, "editCommand", EditCommandEvent);
            ScriptDescriptorHelper.AddEvent(desc, "updateCommand", UpdateCommandEvent);
            ScriptDescriptorHelper.AddEvent(desc, "cancelCommand", CancelCommandEvent);
            ScriptDescriptorHelper.AddEvent(desc, "deleteCommand", DeleteCommandEvent);
            ScriptDescriptorHelper.AddEvent(desc, "rowCommand", RowCommandEvent);
            ScriptDescriptorHelper.AddEvent(desc, "rowCreated", RowCreatedEvent);
            ScriptDescriptorHelper.AddEvent(desc, "rowDataBound", RowDataBoundEvent);

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

            ScriptReference[] baseScripts = new ScriptReference[] 
                                            {
                                                base.GetProperScriptReference(StyleConverter.ScriptFileBase),
                                                base.GetProperScriptReference(ScriptFileBase)
                                            };

            ScriptReference[] columnScripts = Columns.GetScriptReferences();

            List<ScriptReference> scripts = new List<ScriptReference>();

            scripts.AddRange(baseScripts);
            scripts.AddRange(columnScripts);

            //We also need to inject the BoundColumn so that it is even rendered if the user does
            //not define the column collection
            scripts.Add(base.GetProperScriptReference(GridViewBoundColumn.ScriptFileBase));

            return scripts;
        }

        /// <summary>
        /// Restores view-state information from a previous request that was saved with the <see cref="M:System.Web.UI.WebControls.WebControl.SaveViewState"/> method.
        /// </summary>
        /// <param name="savedState">An object that represents the control state to restore.</param>
        protected override void LoadViewState(object savedState)
        {
            if (savedState != null)
            {
                Pair pair = savedState as Pair;

                if (pair != null)
                {
                    base.LoadViewState(pair.First);
                    ((IStateManager)Columns).LoadViewState(pair.Second);
                }
                else
                {
                    base.LoadViewState(savedState);
                }
            }
        }

        /// <summary>
        /// Saves any state that was modified after the <see cref="M:System.Web.UI.WebControls.Style.TrackViewState"/> method was invoked.
        /// </summary>
        /// <returns>
        /// An object that contains the current view state of the control; otherwise, if there is no view state associated with the control, null.
        /// </returns>
        protected override object SaveViewState()
        {
            if (_columns == null)
            {
                return base.SaveViewState();
            }
            else
            {
                return new Pair(base.SaveViewState(), ((IStateManager)_columns).SaveViewState());
            }
        }

        /// <summary>
        /// Causes the control to track changes to its view state so they can be stored in the object's <see cref="P:System.Web.UI.Control.ViewState"/> property.
        /// </summary>
        protected override void TrackViewState()
        {
            base.TrackViewState();

            if (_columns != null)
            {
                ((IStateManager)_columns).TrackViewState();
            }
        }
    }
}