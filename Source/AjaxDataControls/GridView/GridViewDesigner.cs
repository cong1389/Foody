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
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.Design;


namespace AjaxDataControls
{
    internal sealed class GridViewDesigner : ControlDesigner
    {
        public GridViewDesigner()
        {
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        public override string GetDesignTimeHtml()
        {
            const string sampleData = "abc";
            const int columnCount = 3;
            const int rowCount = 5;

            GridView grid = (GridView) base.Component;

            GridViewColumnCollection columns = grid.Columns;
            bool clearColumns = false;
            int i;

            if (columns.Count == 0)
            {
                clearColumns = true;

                for (i = 1; i <= columnCount; i++)
                {
                    GridViewBaseColumn column = new GridViewBoundColumn();

                    column.HeaderText = string.Format(CultureInfo.CurrentCulture, "Column {0}", i);
                    columns.Add(column);
                }
            }

            Table table = new Table();
            table.ApplyStyle(grid.ControlStyle);

            if (grid.ShowHeader)
            {
                TableHeaderRow trHeader = new TableHeaderRow();
                table.Rows.Add(trHeader);

                trHeader.ApplyStyle(grid.HeaderStyle);

                TableHeaderCell th;

                for (i = 0; i < columns.Count; i++)
                {
                    th = new TableHeaderCell();
                    trHeader.Cells.Add(th);
                    columns[i].RenderHeader(th);
                }
            }

            bool isAlt = false;
            Style style;
            TableRow tr;
            TableCell td;

            for (i = 1; i <= rowCount; i++)
            {
                style = grid.RowStyle;

                if ((isAlt) && (!grid.AlternatingRowStyle.IsEmpty))
                {
                    style = grid.AlternatingRowStyle;
                }

                isAlt = !isAlt;

                tr = new TableRow();
                table.Rows.Add(tr);
                tr.ApplyStyle(style);

                for (int j = 0; j < columns.Count; j++)
                {
                    td = new TableCell();
                    tr.Cells.Add(td);

                    columns[j].RenderData(td, sampleData);
                }
            }

            if (grid.ShowFooter)
            {
                TableFooterRow trFooter = new TableFooterRow();
                table.Rows.Add(trFooter);

                trFooter.ApplyStyle(grid.FooterStyle);

                TableCell tdFooter;

                for (i = 0; i < columns.Count; i++)
                {
                    tdFooter = new TableHeaderCell();
                    trFooter.Cells.Add(tdFooter);
                    columns[i].RenderFooter(tdFooter);
                }
            }

            if (clearColumns)
            {
                grid.Columns.Clear();
            }

            StringBuilder output = new StringBuilder();
            StringWriter sw = new StringWriter(output, CultureInfo.CurrentCulture);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            table.RenderControl(htw);
            htw.Close();

            return output.ToString();
        }
    }
}