using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace Cb.Model.Xml
{
    [Serializable()]
    public class XMLConfigs : CollectionBase
    {
        /// <summary>Notifies when the collection has been modified.</summary>
        public event EventHandler OnItemsChanged;

        /// <summary>Notifies that an item has been added.</summary>
        public event XMLConfigHandler OnItemAdd;

        /// <summary>Notifies that items have been added.</summary>
        public event XMLConfigHandler OnItemsAdd;

        /// <summary>Notifies that an item has been removed.</summary>
        public event XMLConfigHandler OnItemRemove;

        /// <summary>
        ///	 <para>
        ///	   Initializes a new instance of <see cref='XMLConfig'/>.
        ///	</para>
        /// </summary>
        public XMLConfigs()
        {

        }

        /// <summary>
        ///	 <para>
        ///	   Initializes a new instance of <see cref='XMLConfig'/> based on another <see cref='XMLConfig'/>.
        ///	</para>
        /// </summary>
        /// <param name='value'>
        ///	   A <see cref='XMLConfig'/> from which the contents are copied
        /// </param>
        public XMLConfigs(XMLConfigs value)
        {
            this.AddRange(value);
        }

        /// <summary>
        ///	 <para>
        ///	   Initializes a new instance of <see cref='XMLConfig'/> containing any array of <see cref='XMLConfig'/> objects.
        ///	</para>
        /// </summary>
        /// <param name='value'>
        ///	   A array of <see cref='XMLConfig'/> objects with which to intialize the collection
        /// </param>
        public XMLConfigs(XMLConfig[] value)
        {
            this.AddRange(value);
        }

        /// <summary>
        /// <para>Represents the entry at the specified index of the <see cref='XMLConfig'/>.</para>
        /// </summary>
        /// <param name='index'><para>The zero-based index of the entry to locate in the collection.</para></param>
        /// <value>
        ///	<para> The entry at the specified index of the collection.</para>
        /// </value>
        /// <exception cref='System.ArgumentOutOfRangeException'><paramref name='index'/> is outside the valid range of indexes for the collection.</exception>
        public XMLConfig this[int index]
        {
            get { return ((XMLConfig)(List[index])); }
            set { List[index] = value; }
        }

        /// <summary>
        ///	<para>Adds a <see cref='XMLConfig'/> with the specified value to the 
        ///	<see cref='XMLConfig'/> .</para>
        /// </summary>
        /// <param name='value'>The <see cref='XMLConfig'/> to add.</param>
        /// <returns>
        ///	<para>The index at which the new element was inserted.</para>
        /// </returns>
        /// <seealso cref='XMLConfigs.AddRange'/>
        public int Add(XMLConfig value)
        {
            int ndx = List.Add(value);
            if (OnItemAdd != null) { OnItemAdd(this, new XMLConfigArgs(value)); }
            if (OnItemsChanged != null) { OnItemsChanged(value, EventArgs.Empty); }
            return ndx;
        }

        /// <summary>
        /// <para>Copies the elements of an array to the end of the <see cref='XMLConfig'/>.</para>
        /// </summary>
        /// <param name='value'>
        ///	An array of type <see cref='XMLConfig'/> containing the objects to add to the collection.
        /// </param>
        /// <returns>
        ///   <para>None.</para>
        /// </returns>
        /// <seealso cref='XMLConfigs.Add'/>
        public void AddRange(XMLConfig[] value)
        {
            for (int i = 0; i < value.Length; i++)
            {
                this.Add(value[i]);
            }
            if (OnItemsAdd != null) { OnItemsAdd(this, new XMLConfigArgs(value)); }
            if (OnItemsChanged != null) { OnItemsChanged(value, EventArgs.Empty); }
        }

        /// <summary>
        ///	 <para>
        ///	   Adds the contents of another <see cref='XMLConfig'/> to the end of the collection.
        ///	</para>
        /// </summary>
        /// <param name='value'>
        ///	A <see cref='XMLConfig'/> containing the objects to add to the collection.
        /// </param>
        /// <returns>
        ///   <para>None.</para>
        /// </returns>
        /// <seealso cref='XMLConfigs.Add'/>
        public void AddRange(XMLConfigs value)
        {
            for (int i = 0; i < value.Count; i++)
            {
                this.Add(value[i]);
            }
            if (OnItemsAdd != null) { OnItemsAdd(this, new XMLConfigArgs(value)); }
            if (OnItemsChanged != null) { OnItemsChanged(value, EventArgs.Empty); }
        }

        /// <summary>
        /// <para>Gets a value indicating whether the 
        ///	<see cref='XMLConfig'/> contains the specified <see cref='XMLConfig'/>.</para>
        /// </summary>
        /// <param name='value'>The <see cref='XMLConfig'/> to locate.</param>
        /// <returns>
        /// <para><see langword='true'/> if the <see cref='XMLConfig'/> is contained in the collection; 
        ///   otherwise, <see langword='false'/>.</para>
        /// </returns>
        /// <seealso cref='XMLConfigs.IndexOf'/>
        public bool Contains(XMLConfig value)
        {
            return List.Contains(value);
        }

        /// <summary>
        /// <para>Copies the <see cref='XMLConfig'/> values to a one-dimensional <see cref='System.Array'/> instance at the 
        ///	specified index.</para>
        /// </summary>
        /// <param name='array'><para>The one-dimensional <see cref='System.Array'/> that is the destination of the values copied from <see cref='XMLConfig'/> .</para></param>
        /// <param name='index'>The index in <paramref name='array'/> where copying begins.</param>
        /// <returns>
        ///   <para>None.</para>
        /// </returns>
        /// <exception cref='System.ArgumentException'><para><paramref name='array'/> is multidimensional.</para> <para>-or-</para> <para>The number of elements in the <see cref='XMLConfig'/> is greater than the available space between <paramref name='arrayIndex'/> and the end of <paramref name='array'/>.</para></exception>
        /// <exception cref='System.ArgumentNullException'><paramref name='array'/> is <see langword='null'/>. </exception>
        /// <exception cref='System.ArgumentOutOfRangeException'><paramref name='arrayIndex'/> is less than <paramref name='array'/>'s lowbound. </exception>
        /// <seealso cref='System.Array'/>
        public void CopyTo(XMLConfig[] array, int index)
        {
            List.CopyTo(array, index);
        }

        /// <summary>
        ///	<para>Returns the index of a <see cref='XMLConfig'/> in 
        ///	   the <see cref='XMLConfig'/> .</para>
        /// </summary>
        /// <param name='value'>The <see cref='XMLConfig'/> to locate.</param>
        /// <returns>
        /// <para>The index of the <see cref='XMLConfig'/> of <paramref name='value'/> in the 
        /// <see cref='XMLConfig'/>, if found; otherwise, -1.</para>
        /// </returns>
        /// <seealso cref='XMLConfigs.Contains'/>
        public int IndexOf(XMLConfig value)
        {
            return List.IndexOf(value);
        }

        /// <summary>
        /// <para>Inserts a <see cref='XMLConfig'/> into the <see cref='XMLConfigs'/> at the specified index.</para>
        /// </summary>
        /// <param name='index'>The zero-based index where <paramref name='value'/> should be inserted.</param>
        /// <param name=' value'>The <see cref='XMLConfig'/> to insert.</param>
        /// <returns><para>None.</para></returns>
        /// <seealso cref='XMLConfigs.Add'/>
        public void Insert(int index, XMLConfig value)
        {
            List.Insert(index, value);
            if (OnItemAdd != null) { OnItemAdd(this, new XMLConfigArgs(value)); }
            if (OnItemsChanged != null) { OnItemsChanged(value, EventArgs.Empty); }
        }

        /// <summary>
        ///	<para> Removes a specific <see cref='XMLConfig'/> from the 
        ///	<see cref='XMLConfigs'/> .</para>
        /// </summary>
        /// <param name='value'>The <see cref='XMLConfig'/> to remove from the <see cref='XMLConfigs'/> .</param>
        /// <returns><para>None.</para></returns>
        /// <exception cref='System.ArgumentException'><paramref name='value'/> is not found in the Collection. </exception>
        public void Remove(XMLConfig value)
        {
            List.Remove(value);
            if (OnItemRemove != null) { OnItemRemove(this, new XMLConfigArgs(value)); }
            if (OnItemsChanged != null) { OnItemsChanged(value, EventArgs.Empty); }
        }

        /// Event arguments for the XMLConfigs collection class.
        public class XMLConfigArgs : EventArgs
        {
            private XMLConfigs t;

            /// Default constructor.
            public XMLConfigArgs()
            {
                t = new XMLConfigs();
            }

            /// Initializes with a XMLConfig.
            /// Data object.
            public XMLConfigArgs(XMLConfig t)
                : this()
            {
                this.t.Add(t);
            }

            /// Initializes with a collection of XMLConfig objects.
            /// Collection of data.
            public XMLConfigArgs(XMLConfigs ts)
                : this()
            {
                this.t.AddRange(ts);
            }

            /// Initializes with an array of XMLConfig objects.
            /// Array of data.
            public XMLConfigArgs(XMLConfig[] ts)
                : this()
            {
                this.t.AddRange(ts);
            }

            /// Gets or sets the data of this argument.
            public XMLConfigs XMLConfigs
            {
                get { return t; }
                set { t = value; }
            }
        }

        /// XMLConfigs event handler.
        public delegate void XMLConfigHandler(object sender, XMLConfigArgs e);
    }
}
