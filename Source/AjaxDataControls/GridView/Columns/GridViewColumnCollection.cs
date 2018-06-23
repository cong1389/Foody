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
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.ComponentModel;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;


namespace AjaxDataControls
{
    /// <summary>
    /// Represents a collection of <see cref="GridViewBaseColumn"/> objects in a <see cref="GridView"/> control.
    /// </summary>
    [AspNetHostingPermission(SecurityAction.Demand, Level = AspNetHostingPermissionLevel.Minimal)]
    [AspNetHostingPermission(SecurityAction.InheritanceDemand, Level = AspNetHostingPermissionLevel.Minimal)]
    public sealed class GridViewColumnCollection : CollectionBase, IEnumerable<GridViewBaseColumn>, IStateManager
    {
        private GridView _owner;

        private bool _isTrackingViewState;

        /// <summary>
        /// Gets or sets the <see cref="GridViewBaseColumn"/> at the specified index.
        /// </summary>
        /// <value></value>
        public GridViewBaseColumn this[int index]
        {
            [DebuggerStepThrough()]
            get
            {
                return (GridViewBaseColumn)InnerList[index];
            }
            [DebuggerStepThrough()]
            set
            {
                InnerList[index] = value;
            }
        }

        internal GridViewColumnCollection(GridView owner)
        {
            _owner = owner;
        }

        /// <summary>
        /// Adds a column.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        public int Add(GridViewBaseColumn value)
        {
            if (value == null)
            {
                throw new ArgumentNullException("value");
            }

            value.SetOwner(_owner);
            int index = InnerList.Add(value);

            if (value.ColumnID == 0)
            {
                value.ColumnID = (index + 1);
            }

            return index;
        }

        /// <summary>
        /// Determines whether it contains the specified column.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns>
        /// 	<c>true</c> if [contains] [the specified value]; otherwise, <c>false</c>.
        /// </returns>
        public bool Contains(GridViewBaseColumn value)
        {
            return InnerList.Contains(value);
        }

        /// <summary>
        /// Returns the Indexes of the specified column.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        public int IndexOf(GridViewBaseColumn value)
        {
            return InnerList.IndexOf(value);
        }

        /// <summary>
        /// Inserts the columns in specified index.
        /// </summary>
        /// <param name="index">The index.</param>
        /// <param name="value">The value.</param>
        public void Insert(int index, GridViewBaseColumn value)
        {
            if (value == null)
            {
                throw new ArgumentNullException("value");
            }

            value.SetOwner(_owner);
            InnerList.Insert(index, value);
            value.ColumnID = InnerList.Count;

            if (value.ColumnID == 0)
            {
                value.ColumnID = InnerList.Count;
            }
        }

        /// <summary>
        /// Removes the specified column.
        /// </summary>
        /// <param name="value">The value.</param>
        public void Remove(GridViewBaseColumn value)
        {
            if (value == null)
            {
                throw new ArgumentNullException("value");
            }

            value.SetOwner(null);
            InnerList.Remove(value);
        }

        /// <summary>
        /// Copies the column to the specified array.
        /// </summary>
        /// <param name="array">The array.</param>
        /// <param name="index">The index.</param>
        public void CopyTo(GridViewBaseColumn[] array, int index)
        {
            ((ICollection) this).CopyTo(array, index);
        }

        /// <summary>
        /// Returns an enumerator that iterates through the collection.
        /// </summary>
        /// <returns>
        /// A <see cref="T:System.Collections.Generic.IEnumerator`1"/> that can be used to iterate through the collection.
        /// </returns>
        public new IEnumerator<GridViewBaseColumn> GetEnumerator()
        {
            foreach (GridViewBaseColumn column in InnerList)
            {
                yield return column;
            }
        }

        internal ScriptReference[] GetScriptReferences()
        {
            List<ScriptReference> list = new List<ScriptReference>(InnerList.Count);

            foreach (GridViewBaseColumn column in InnerList)
            {
                list.Add(column.ScriptReference);
            }

            return list.ToArray();
        }

        internal string ToJSConstructor()
        {
            StringBuilder output = new StringBuilder();

            output.Append("[");

            for(int i = 0; i < InnerList.Count; i++)
            {
                if (i > 0)
                {
                    output.Append(", ");
                }

                output.Append(((GridViewBaseColumn) InnerList[i]).CreateScript);
            }

            output.Append("]");

            return output.ToString();
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
                return _isTrackingViewState;
            }
        }

        /// <summary>
        /// When implemented by a class, loads the server control's previously saved view state to the control.
        /// </summary>
        /// <param name="state">An <see cref="T:System.Object"/> that contains the saved view state values for the control.</param>
        void IStateManager.LoadViewState(object state)
        {
            if (state != null)
            {
                Pair pair = state as Pair;

                if (pair != null)
                {
                    ArrayList indexes = (ArrayList)pair.First;
                    ArrayList states = (ArrayList)pair.Second;

                    for (int i = 0; i < indexes.Count; i++)
                    {
                        int index = (int)indexes[i];
                        ((IStateManager)InnerList[index]).LoadViewState(states[i]);
                    }
                }
            }
        }

        /// <summary>
        /// When implemented by a class, saves the changes to a server control's view state to an <see cref="T:System.Object"/>.
        /// </summary>
        /// <returns>
        /// The <see cref="T:System.Object"/> that contains the view state changes.
        /// </returns>
        object IStateManager.SaveViewState()
        {
            if (InnerList.Count == 0)
            {
                return null;
            }

            ArrayList indexes = new ArrayList(InnerList.Count);
            ArrayList states = new ArrayList(InnerList.Count);

            for (int i = 0; i < InnerList.Count; i++)
            {
                object state = ((IStateManager)InnerList[i]).SaveViewState();
                indexes.Add(i);
                states.Add(state);
            }

            return new Pair(indexes, states);
        }

        /// <summary>
        /// When implemented by a class, instructs the server control to track changes to its view state.
        /// </summary>
        void IStateManager.TrackViewState()
        {
            if (InnerList.Count > 0)
            {
                for (int i = 0; i < InnerList.Count; i++)
                {
                    ((IStateManager)InnerList[i]).TrackViewState();
                }
            }

            _isTrackingViewState = true;
        }
    }
}
