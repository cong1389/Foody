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
using System.ComponentModel;
using System.Collections.Generic;
using System.Security.Permissions;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

[assembly: WebResource(AjaxDataControls.Pager.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.Pager.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// A helper control which works with the other data controls to show paged data.
    /// </summary>
    /// <seealso cref="Repeater">Repeater Control</seealso>
    /// <seealso cref="DataList">DataList Control</seealso>
    /// <seealso cref="GridView">GridView Control</seealso>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [Designer(typeof(PagerDesigner))]
    [ToolboxData("<{0}:Pager runat=\"server\"></{0}:Pager>")]
    [ToolboxBitmap(typeof(Pager), "Pager.ico")]
    [DefaultProperty("PageIndex")]
    [Themeable(true)]
    public class Pager : BaseDataControl
    {
        internal const string ScriptFileBase = "AjaxDataControls.Pager.Pager";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private const string DefaultFirstPageText = "<<";
        private const string DefaultPreviousPageText = "<";
        private const string DefaultNextPageText = ">";
        private const string DefaultLastPageText = ">>";

        private const int DefaultPageSize = 10;
        private const int DefaultPageIndex = 0;
        private const int DefaultSliderSize = 8;

        private Style _infoStyle;
        private Style _currentPageStyle;
        private Style _otherPageStyle;

        /// <summary>
        /// Gets the style properties for the info section of the Pager control.
        /// </summary>
        /// <value>The info style. The default value is empty style.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to info section.")]
        public Style InfoStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_infoStyle == null)
                {
                    _infoStyle = new Style();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_infoStyle).TrackViewState();
                }

                return _infoStyle;
            }
        }

        /// <summary>
        /// Gets the style properties for the current page element of the Pager control.
        /// </summary>
        /// <value>The current page style. The default value is empty style.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to current page.")]
        public Style CurrentPageStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_currentPageStyle == null)
                {
                    _currentPageStyle = new Style();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_currentPageStyle).TrackViewState();
                }

                return _currentPageStyle;
            }
        }

        /// <summary>
        /// Gets the style properties for the other elements which includes the First/Last, Previous/Next, Numeric elements of the Pager control.
        /// </summary>
        /// <value>The other page style. The default value is empty style.</value>
        [Browsable(true)]
        [Category("Styles")]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Description("The style applied to other elements.")]
        public Style OtherPageStyle
        {
            [DebuggerStepThrough()]
            get
            {
                if (_otherPageStyle == null)
                {
                    _otherPageStyle = new Style();
                }

                if (IsTrackingViewState)
                {
                    ((IStateManager)_otherPageStyle).TrackViewState();
                }

                return _otherPageStyle;
            }
        }

        /// <summary>
        /// Gets or sets the first page link button text.
        /// </summary>
        /// <value>The first text. The default value is &lt;&lt;.</value>
        [Category("Appearance")]
        [DefaultValue(DefaultFirstPageText)]
        [Localizable(true)]
        [Description("The text to be used on the first page link button.")]
        public string FirstPageText
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["firstPageText"];

                return (obj == null) ? DefaultFirstPageText : (string) obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["firstPageText"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the previous page link button text.
        /// </summary>
        /// <value>The previous text. The default value is &lt;.</value>
        [Category("Appearance")]
        [DefaultValue(DefaultPreviousPageText)]
        [Localizable(true)]
        [Description("The text to be used on the previous page link button.")]
        public string PreviousPageText
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["previousPageText"];

                return (obj == null) ? DefaultPreviousPageText : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["previousPageText"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the next page link button text.
        /// </summary>
        /// <value>The next text. The default value is &gt;.</value>
        [Category("Appearance")]
        [DefaultValue(DefaultNextPageText)]
        [Localizable(true)]
        [Description("The text to be used on the next page link button.")]
        public string NextPageText
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["nextPageText"];

                return (obj == null) ? DefaultNextPageText : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["nextPageText"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the last page link button text.
        /// </summary>
        /// <value>The last text. The default value is &gt;&gt;.</value>
        [Category("Appearance")]
        [DefaultValue(DefaultLastPageText)]
        [Localizable(true)]
        [Description("The text to be used on the last page link button.")]
        public string LastPageText
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["lastPageText"];

                return (obj == null) ? DefaultLastPageText : (string)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["lastPageText"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether to show the info section.
        /// </summary>
        /// <value><c>true</c> if the info section is rendered; otherwise, <c>false</c>.The default is <c>false</c>.</value>
        [Category("Appearance")]
        [DefaultValue(false)]
        [Description("Whether to show the info section.")]
        public bool ShowInfo
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["showInfo"];

                return (obj == null) ? false : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["showInfo"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether to show the first and last link button.
        /// </summary>
        /// <value><c>true</c> if first and last link button is rendered; otherwise, <c>false</c>..The default is <c>true</c>.</value>
        [Category("Appearance")]
        [DefaultValue(true)]
        [Description("Whether to show the the first and last link buttons.")]
        public bool ShowFirstAndLast
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["showFirstAndLast"];

                return (obj == null) ? true : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["showFirstAndLast"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether to show the previous and next link button.
        /// </summary>
        /// <value>
        /// <c>true</c> if previous and next link button is rendered; otherwise, <c>false</c>..The default is <c>false</c>.
        /// </value>
        [Category("Appearance")]
        [DefaultValue(false)]
        [Description("Whether to show the the previous and next link buttons.")]
        public bool ShowPreviousAndNext
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["showPreviousAndNext"];

                return (obj == null) ? false : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["showPreviousAndNext"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether to show the numeric page link buttons.
        /// </summary>
        /// <value><c>true</c> if numeric page buttons are rendered; otherwise, <c>false</c>..The default is <c>true</c>.</value>
        [Category("Appearance")]
        [DefaultValue(true)]
        [Description("Whether to show the numeric page number link buttons.")]
        public bool ShowNumeric
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["showNumeric"];

                return (obj == null) ? true : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["showNumeric"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether the pager will rendered in slider mode.
        /// </summary>
        /// <value><c>true</c> if slider behavior is enabled; otherwise, <c>false</c>..The default is <c>true</c>.</value>
        [Category("Behavior")]
        [DefaultValue(true)]
        [Description("Whether the pager will using sliding behavior or shows all the numeric pages.")]
        public bool UseSlider
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["useSlider"];

                return (obj == null) ? true : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["useSlider"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the size of the slider. This is used to show the maximum number of numeric buttons.
        /// </summary>
        /// <value>The size of the slider. The default value is 8.</value>
        [Category("Behavior")]
        [DefaultValue(DefaultSliderSize)]
        [Description("The maximum number of numeric page buttons that will be rendered.")]
        public int SliderSize
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["sliderSize"];

                return (obj == null) ? DefaultSliderSize : (int)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["sliderSize"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the size of each page. This is used to show the maximum number of records on a page.
        /// </summary>
        /// <value>The size of the page. The default value is 10.</value>
        [Category("Behavior")]
        [DefaultValue(DefaultPageSize)]
        [Description("The number of records to display on a page.")]
        public int PageSize
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["pageSize"];

                return (obj == null) ? DefaultPageSize : (int)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["pageSize"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the index of the current page.
        /// </summary>
        /// <value>The index of the page. The default value is 0.</value>
        [Category("Behavior")]
        [DefaultValue(DefaultPageIndex)]
        [Description("The currently selcted page index.")]
        public int PageIndex
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["pageIndex"];

                return (obj == null) ? DefaultPageIndex : (int)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["pageIndex"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether to hide the pager if all the records fits in a single page.
        /// </summary>
        /// <value><c>true</c> if control is not rendered in single page; otherwise, <c>false</c>..The default is <c>true</c>.</value>
        [Category("Behavior")]
        [DefaultValue(true)]
        [Description("Whether to show the control if all the records fits in a single page.")]
        public bool HideOnSinglePage
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["hideOnSinglePage"];

                return (obj == null) ? true : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["hideOnSinglePage"] = value;
            }
        }

        /// <summary>
        /// Occurs on the client side when any page button is clicked in the Pager control.
        /// </summary>
        /// <value>The page change event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [DefaultValue("")]
        [Description("Fires when a page button is clicked.")]
        [Themeable(false)]
        public string PageChangedEvent
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["pageChangeEvent"];

                return (obj == null) ? string.Empty : (string) obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["pageChangeEvent"] = value;
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
                return HtmlTextWriterTag.Div;
            }
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="Pager"/> class.
        /// </summary>
        public Pager() : base()
        {
        }

        /// <summary>
        /// Gets the script descriptors.
        /// </summary>
        /// <returns>Returns the ScriptDescriptors which are associated with this control</returns>
        protected override IEnumerable<ScriptDescriptor> GetScriptDescriptors()
        {
            ScriptControlDescriptor desc = CreateDescriptor();

            ScriptDescriptorHelper.AddStyle(desc, "infoStyle", InfoStyle);
            ScriptDescriptorHelper.AddStyle(desc, "currentPageStyle", CurrentPageStyle);
            ScriptDescriptorHelper.AddStyle(desc, "otherPageStyle", OtherPageStyle);

            if (FirstPageText != DefaultFirstPageText)
            {
                desc.AddProperty("firstPageText", FirstPageText);
            }

            if (PreviousPageText != DefaultPreviousPageText)
            {
                desc.AddProperty("previousPageText", PreviousPageText);
            }

            if (NextPageText != DefaultNextPageText)
            {
                desc.AddProperty("nextPageText", NextPageText);
            }

            if (LastPageText != DefaultLastPageText)
            {
                desc.AddProperty("lastPageText", LastPageText);
            }

            if (ShowInfo)
            {
                desc.AddProperty("showInfo", ShowInfo);
            }

            if (!ShowFirstAndLast)
            {
                desc.AddProperty("showFirstAndLast", ShowFirstAndLast);
            }

            if (ShowPreviousAndNext)
            {
                desc.AddProperty("showPreviousAndNext", ShowPreviousAndNext);
            }

            if (!ShowNumeric)
            {
                desc.AddProperty("showNumeric", ShowNumeric);
            }

            if (PageSize != DefaultPageSize)
            {
                desc.AddProperty("pageSize", PageSize);
            }

            if (PageIndex != DefaultPageIndex)
            {
                desc.AddProperty("pageIndex", DefaultPageIndex);
            }

            if (!UseSlider)
            {
                desc.AddProperty("useSlider", UseSlider);
            }

            if (SliderSize != DefaultSliderSize)
            {
                desc.AddProperty("sliderSize", SliderSize);
            }

            if (!HideOnSinglePage)
            {
                desc.AddProperty("hideOnSinglePage", HideOnSinglePage);
            }

            ScriptDescriptorHelper.AddEvent(desc, "pageChanged", PageChangedEvent);

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

            return new ScriptReference[]    {
                                                base.GetProperScriptReference(StyleConverter.ScriptFileBase),
                                                base.GetProperScriptReference(ScriptFileBase)
                                            };
        }
    }
}