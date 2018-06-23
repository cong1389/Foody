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
using System.Globalization;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.Design;


namespace AjaxDataControls
{
    internal sealed class RepeaterDesigner : ControlDesigner
    {
        public RepeaterDesigner()
        {
        }

        public override string GetDesignTimeHtml()
        {
            Repeater repeater = (Repeater)base.Component;

            const int DataSourceLength = 5;

            StringBuilder output = new StringBuilder();
            StringWriter sw = new StringWriter(output, CultureInfo.CurrentCulture);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            if (!string.IsNullOrEmpty(repeater.CssClass))
            {
                htw.AddAttribute(HtmlTextWriterAttribute.Class, repeater.CssClass);
            }

            htw.RenderBeginTag(repeater.RenderAs);
            RenderTemplate(htw, repeater.HeaderTemplate);

            if (repeater.ItemTemplate != null)
            {
                bool hasAlternateTemplate = (repeater.AlternatingItemTemplate != null);
                bool isAlt = false;
                ITemplate template = repeater.ItemTemplate;

                for (int i = 0; i <= DataSourceLength; i++)
                {
                    template = repeater.ItemTemplate;

                    if (hasAlternateTemplate)
                    {
                        if (isAlt)
                        {
                            template = repeater.AlternatingItemTemplate;
                        }
                    }

                    RenderTemplate(htw, template);

                    if (i < DataSourceLength)
                    {
                        RenderTemplate(htw, repeater.SeparatorTemplate);
                    }
                }
            }

            RenderTemplate(htw, repeater.FooterTemplate);

            htw.RenderEndTag();
            htw.Close();

            return output.ToString();
        }

        private static void RenderTemplate(HtmlTextWriter htw, ITemplate template)
        {
            if (template != null)
            {
                using (Control control = new Control())
                {
                    template.InstantiateIn(control);
                    control.RenderControl(htw);
                }
            }
        }
    }
}