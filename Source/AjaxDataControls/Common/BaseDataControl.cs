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
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace AjaxDataControls
{
    /// <summary>
    /// Base class for creating data controls.
    /// </summary>
    [AspNetHostingPermission(SecurityAction.LinkDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    public abstract class BaseDataControl : ScriptControl
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseDataControl"/> class.
        /// </summary>
        protected BaseDataControl() :base()
        {
        }

        /// <summary>
        /// Gets or sets a value indicating whether the control will use the embedded script of the resource.
        /// For optimization reson we you can choose to not include the script from the resource, 
        /// instead you can combine its scripts with the other scripts to cache it in client.
        /// </summary>
        /// <value>
        /// <c>true</c> to include the scripts from embedded resource; otherwise, <c>false</c>. The default is <c>false</c>.
        /// </value>
        [Category("Behavior")]
        [DefaultValue(false)]
        [Description("Whether the contol will include the scripts from the embedded resource.")]
        [Themeable(false)]
        public bool UseExternalScripts
        {
            [DebuggerStepThrough()]
            get
            {
                object obj = ViewState["UseExternalScripts"];

                return (obj == null) ? false : (bool)obj;
            }
            [DebuggerStepThrough()]
            set
            {
                ViewState["UseExternalScripts"] = value;
            }
        }

        /// <summary>
        /// Creates the control descriptor with the same class name.
        /// </summary>
        /// <returns>Returns the control descriptor.</returns>
        protected ScriptControlDescriptor CreateDescriptor()
        {
            return new ScriptControlDescriptor(this.GetType().FullName, this.ClientID);
        }

        /// <summary>
        /// Returns the proper script depending upon the debug/release mode.
        /// </summary>
        /// <remarks>
        /// The methods returns the minified version of the specified script if the application is running in release mode.
        /// </remarks>
        /// <param name="baseName">Base Name of the JS Resource.</param>
        /// <returns>Returns the script reference.</returns>
        protected ScriptReference GetProperScriptReference(string baseName)
        {
            string injectedResource = string.Concat (
                                                        baseName,
                                                        ScriptManager.GetCurrent(this.Page).IsDebuggingEnabled ? ".debug.js" : ".js"
                                                    );

            return new ScriptReference(this.Page.ClientScript.GetWebResourceUrl(this.GetType(), injectedResource));
        }
    }
}