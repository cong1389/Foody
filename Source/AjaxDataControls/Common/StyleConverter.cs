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
using System.Drawing;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

[assembly: WebResource(AjaxDataControls.StyleConverter.ScriptReleaseFile, "text/javascript")]
[assembly: WebResource(AjaxDataControls.StyleConverter.ScriptDebugFile, "text/javascript")]


namespace AjaxDataControls
{
    internal static class StyleConverter
    {
        internal const string ScriptFileBase = "AjaxDataControls.Common.Common";
        internal const string ScriptReleaseFile = ScriptFileBase + ".js";
        internal const string ScriptDebugFile = ScriptFileBase + ".debug.js";

        public static string Convert(Style style)
        {
            if (style.IsEmpty)
            {
                return string.Empty;
            }

            string backColor = string.Empty;
            string borderColor = string.Empty;
            string borderStyle = string.Empty;
            string borderWidth = string.Empty;
            string cssClass = string.Empty;
            string foreColor = string.Empty;
            string height = string.Empty;
            string width = string.Empty;

            if (style.BackColor != Color.Empty)
            {
                backColor = ColorTranslator.ToHtml(style.BackColor);
            }

            if (style.BorderColor != Color.Empty)
            {
                backColor = ColorTranslator.ToHtml(style.BorderColor);
            }

            if (style.BorderStyle != BorderStyle.NotSet)
            {
                borderStyle = style.BorderStyle.ToString();
            }

            if (style.BorderWidth != Unit.Empty)
            {
                borderWidth = style.BorderWidth.ToString(CultureInfo.InvariantCulture);
            }

            if (!string.IsNullOrEmpty(style.CssClass))
            {
                cssClass = style.CssClass;
            }

            if (style.ForeColor != Color.Empty)
            {
                foreColor = ColorTranslator.ToHtml(style.ForeColor);
            }

            if (style.Height != Unit.Empty)
            {
                height = style.Height.ToString(CultureInfo.InvariantCulture);
            }

            if (style.Width != Unit.Empty)
            {
                width = style.Width.ToString(CultureInfo.InvariantCulture);
            }

            return string.Format(CultureInfo.InvariantCulture, "new AjaxDataControls.Style('{0}', '{1}', '{2}', '{3}', '{4}', {5}, '{6}', '{7}', '{8}')", backColor, borderColor, borderStyle, borderWidth, cssClass, Convert(style.Font), foreColor, height, width);
        }

        public static string Convert(TableItemStyle style)
        {
            if (style.IsEmpty)
            {
                return string.Empty;
            }

            string backColor = string.Empty;
            string borderColor = string.Empty;
            string borderStyle = string.Empty;
            string borderWidth = string.Empty;
            string cssClass = string.Empty;
            string foreColor = string.Empty;
            string height = string.Empty;
            string width = string.Empty;
            string horizontalAlign = string.Empty;
            string verticalAlign = string.Empty;
            string wrap = style.Wrap.ToString(CultureInfo.InvariantCulture).ToLowerInvariant();

            if (style.BackColor != Color.Empty)
            {
                backColor = ColorTranslator.ToHtml(style.BackColor);
            }

            if (style.BorderColor != Color.Empty)
            {
                backColor = ColorTranslator.ToHtml(style.BorderColor);
            }

            if (style.BorderStyle != BorderStyle.NotSet)
            {
                borderStyle = style.BorderStyle.ToString();
            }

            if (style.BorderWidth != Unit.Empty)
            {
                borderWidth = style.BorderWidth.ToString(CultureInfo.InvariantCulture);
            }

            if (!string.IsNullOrEmpty(style.CssClass))
            {
                cssClass = style.CssClass;
            }

            if (style.ForeColor != Color.Empty)
            {
                foreColor = ColorTranslator.ToHtml(style.ForeColor);
            }

            if (style.Height != Unit.Empty)
            {
                height = style.Height.ToString(CultureInfo.InvariantCulture);
            }

            if (style.Width != Unit.Empty)
            {
                width = style.Width.ToString(CultureInfo.InvariantCulture);
            }

            if (style.HorizontalAlign != HorizontalAlign.NotSet)
            {
                horizontalAlign = style.HorizontalAlign.ToString().ToLowerInvariant();
            }

            if (style.VerticalAlign != VerticalAlign.NotSet)
            {
                verticalAlign = style.VerticalAlign.ToString().ToLowerInvariant();
            }

            return string.Format(CultureInfo.InvariantCulture, "new AjaxDataControls.TableItemStyle('{0}', '{1}', '{2}', '{3}', '{4}', {5}, '{6}', '{7}', '{8}', '{9}', '{10}', {11})", backColor, borderColor, borderStyle, borderWidth, cssClass, Convert(style.Font), foreColor, height, width, horizontalAlign, verticalAlign, wrap);
        }

        private static string Convert(FontInfo font)
        {
            if (font == null)
            {
                return "null";
            }

            string family = string.Empty;
            string size = string.Empty;
            string weight = string.Empty;
            string style = string.Empty;
            string textDecoration = string.Empty;

            if (!string.IsNullOrEmpty(font.Name))
            {
                family = font.Name;
            }

            if ((font.Names != null) && (font.Names.Length > 0))
            {
                family += ", " + string.Join(", ", font.Names);
            }

            if (font.Size.IsEmpty)
            {
                size = font.Size.ToString(CultureInfo.InvariantCulture);
            }

            if (font.Bold)
            {
                weight = "bold";
            }

            if (font.Italic)
            {
                style = "italic";
            }

            if (font.Underline)
            {
                textDecoration = "underline";
            }

            if (font.Overline)
            {
                if (textDecoration.Length > 0)
                {
                    textDecoration += " ";
                }

                textDecoration += "overline";
            }

            if (font.Strikeout)
            {
                if (textDecoration.Length > 0)
                {
                    textDecoration += " ";
                }

                textDecoration += "line-through";
            }

            return string.Format(CultureInfo.InvariantCulture, "new AjaxDataControls.FontInfo('{0}', '{1}', '{2}', '{3}', '{4}')", family, size, weight, style, textDecoration);
        }
    }
}