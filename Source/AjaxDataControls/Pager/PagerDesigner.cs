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
    internal sealed class PagerDesigner : ControlDesigner
    {
        public PagerDesigner()
        {
        }

        public override string GetDesignTimeHtml()
        {
            const int pageCount = 10;
            const int currentPage = 1;

            Pager pager = (Pager)base.Component;

            StringBuilder output = new StringBuilder();
            StringWriter sw = new StringWriter(output, CultureInfo.CurrentCulture);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            if (pager.ControlStyle != null)
            {
                pager.ControlStyle.AddAttributesToRender(htw);
            }

            htw.RenderBeginTag(HtmlTextWriterTag.Div);

            if (pager.ShowInfo)
            {
                htw.EnterStyle(pager.InfoStyle, HtmlTextWriterTag.Span);
                    htw.Write(string.Format(CultureInfo.InvariantCulture, "Page {0} of {1}", currentPage, pageCount));
                htw.ExitStyle(pager.InfoStyle, HtmlTextWriterTag.Span);
            }

            if (pager.ShowFirstAndLast)
            {
                htw.EnterStyle(pager.OtherPageStyle, HtmlTextWriterTag.Span);
                    htw.AddAttribute(HtmlTextWriterAttribute.Href, "javascript:void(0)");
                    htw.RenderBeginTag(HtmlTextWriterTag.A);
                        htw.Write(pager.FirstPageText);
                    htw.RenderEndTag();
                htw.ExitStyle(pager.OtherPageStyle, HtmlTextWriterTag.Span);
            }

            if (pager.ShowPreviousAndNext)
            {
                htw.EnterStyle(pager.OtherPageStyle, HtmlTextWriterTag.Span);
                    htw.AddAttribute(HtmlTextWriterAttribute.Href, "javascript:void(0)");
                    htw.RenderBeginTag(HtmlTextWriterTag.A);
                        htw.Write(pager.PreviousPageText);
                    htw.RenderEndTag();
                htw.ExitStyle(pager.OtherPageStyle, HtmlTextWriterTag.Span);
            }

            if (pager.ShowNumeric)
            {
                for (int i = 1; i <= pageCount; i++)
                {
                    if (i == currentPage)
                    {
                        htw.EnterStyle(pager.CurrentPageStyle, HtmlTextWriterTag.Span);
                            htw.Write(i.ToString(CultureInfo.InvariantCulture));
                        htw.EnterStyle(pager.CurrentPageStyle, HtmlTextWriterTag.Span);
                    }
                    else
                    {
                        htw.EnterStyle(pager.OtherPageStyle, HtmlTextWriterTag.Span);
                            htw.AddAttribute(HtmlTextWriterAttribute.Href, "javascript:void(0)");
                            htw.RenderBeginTag(HtmlTextWriterTag.A);
                                htw.Write(i.ToString(CultureInfo.InvariantCulture));
                            htw.RenderEndTag();
                        htw.EnterStyle(pager.OtherPageStyle, HtmlTextWriterTag.Span);
                    }
                }
            }

            if (pager.ShowPreviousAndNext)
            {
                htw.EnterStyle(pager.OtherPageStyle, HtmlTextWriterTag.Span);
                    htw.AddAttribute(HtmlTextWriterAttribute.Href, "javascript:void(0)");
                    htw.RenderBeginTag(HtmlTextWriterTag.A);
                        htw.Write(pager.NextPageText);
                    htw.RenderEndTag();
                htw.EnterStyle(pager.OtherPageStyle, HtmlTextWriterTag.Span);
            }

            if (pager.ShowFirstAndLast)
            {
                htw.EnterStyle(pager.OtherPageStyle, HtmlTextWriterTag.Span);
                    htw.AddAttribute(HtmlTextWriterAttribute.Href, "javascript:void(0)");
                    htw.RenderBeginTag(HtmlTextWriterTag.A);
                        htw.Write(pager.LastPageText);
                    htw.RenderEndTag();
                htw.EnterStyle(pager.OtherPageStyle, HtmlTextWriterTag.Span);
            }

            htw.RenderEndTag();
            htw.Close();

            return output.ToString();
        }
    }
}