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
using System.ComponentModel;
using System.Collections;
using System.Collections.Generic;
using System.Security.Permissions;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

[assembly: WebResource(AjaxDataControls.Repeater.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.Repeater.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    /// <summary>
    /// A data-bound list control that allows custom layout by repeating a specified template for each item displayed in the list.
    /// </summary>
    /// <seealso cref="DataList">DataList Control</seealso>
    /// <seealso cref="GridView">GridView COntrol</seealso>>
    /// <seealso cref="Pager">Pager Control</seealso>>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [Designer(typeof(RepeaterDesigner))]
    [ToolboxData("<{0}:Repeater runat=\"server\"></{0}:Repeater>")]
    [ToolboxBitmap(typeof(Repeater), "Repeater.bmp")]
    [ParseChildren(true)]
    [PersistChildren(false)]
    [DefaultProperty("ItemDataBoundEvent")]
    [Themeable(true)]
    public class Repeater : BaseDataControl
    {
        internal const string ScriptFileBase = "AjaxDataControls.Repeater.Repeater";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        private const float DefaultAnimationDuration = 0.2F;
        private const int DefaultAnimationFps = 20;

        private ITemplate _headerTemplate;
        private ITemplate _itemTemplate;
        private ITemplate _separatorTemplate;
        private ITemplate _alternatingItemTemplate;
        private ITemplate _footerTemplate;

        /// <summary>
        /// Gets or sets the html tag of the repeater.
        /// </summary>
        /// <value>The html tag that the control will be rendered as. The Default value is DIV.</value>
        [Category("Layout")]
        [DefaultValue(HtmlTextWriterTag.Div)]
        [Description("The html tag associated with the control.")]
        public HtmlTextWriterTag RenderAs
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["tag"];

                return (obj == null) ? HtmlTextWriterTag.Div : (HtmlTextWriterTag) obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["tag"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> that defines how the header section of the Repeater control is displayed.
        /// </summary>
        /// <remarks>
        /// Use this property to create a template that controls how the header section of a <b>Repeater</b> control is displayed.
        /// </remarks>
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
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> that defines how items in the Repeater control are displayed.
        /// </summary>
        /// <remarks>
        /// Use this property to create a template that controls how items in the <b>Repeater</b> control are displayed.
        /// </remarks>
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
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> interface that defines how the separator between items is displayed.
        /// </summary>
        /// <remarks>
        /// Use the <b>SeparatorTemplate</b> property to create a template that controls how the separator between items is displayed.
        /// </remarks>
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
        /// Gets or sets the object implementing <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> that defines how alternating items in the control are displayed.
        /// </summary>
        /// <remarks>
        /// Use this property to provide a different appearance for alternating items in the <see cref="Repeater"/> control from what is specified in the <see cref="ItemTemplate"/>.
        /// </remarks>
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
        /// Gets or sets the <see cref="System.Web.UI.ITemplate">System.Web.UI.ITemplate</see> that defines how the footer section of the Repeater control is displayed.
        /// </summary>
        /// <value>The footer template. The default value is a null reference (<b>Nothing</b> in Visual Basic)</value>
        /// <remarks>
        /// Use this property to create a template that controls how the footer section of a <b>Repeater</b> control is displayed.
        /// </remarks>
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
        /// Gets or sets a value indicating whether this <see cref="Repeater"/> is animated when binding data.
        /// </summary>
        /// <remarks>
        /// The Asp.net Ajax Framework Glitz script(s) needs to be present in the page.
        /// </remarks>
        /// <value><c>true</c> if animate; otherwise, <c>false</c>..The default is <c>true</c>.</value>
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
        /// Occurs on the client side when an item is created in the Repeater control.
        /// </summary>
        /// <remarks>
        /// This event is raised when an item is created in the <b>Repeater</b> control.
        /// </remarks>
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
        /// Occurs on the client side when an item in the Repeater control is going to be data-bound.
        /// </summary>
        /// <remarks>
        /// This event is raised when an item in the Repeater control is data-bound.
        /// </remarks>
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
        /// Occurs on the client side when a button is clicked in the Repeater control which has associated commandName.
        /// </summary>
        /// <remarks>
        /// This event is raised when a button in the <b>Repeater</b> control is clicked.
        /// </remarks>
        /// <value>The item command event. The default value is empty function.</value>
        [Category("ClientSideEvents")]
        [Description("Fires when a CommandEvent is generated within Repeater.")]
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
                return RenderAs;
            }
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="Repeater"/> class.
        /// </summary>
        public Repeater() :base()
        {
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

            ScriptDescriptorHelper.AddEvent(desc, "itemCreated", ItemCreatedEvent);
            ScriptDescriptorHelper.AddEvent(desc, "itemDataBound", ItemDataBoundEvent);
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

            return new ScriptReference[]    {
                                                base.GetProperScriptReference(StyleConverter.ScriptFileBase),
                                                base.GetProperScriptReference(ScriptFileBase)
                                            };
        }
    }
}