using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Collections;

namespace Cb.Utility
{
    public class UserControlViewStateManager : Page
    {
        private struct ControlClass : IComparable
        {
            public Int32 OrdinalIndex;
            public String ControlID;
            public Type Type;

            public Int32 CompareTo(Object obj)
            {
                ControlClass controlClass = (ControlClass)obj;
                return (this.OrdinalIndex.CompareTo(controlClass.OrdinalIndex));
            }
        }

        private ArrayList controlsTable;
        private Int32 LastOrdinalIndex;
        private String InstanceSessionID;

        /// <summary>
        /// .ctor()
        /// </summary>
        public UserControlViewStateManager(String InstanceSessionID)
        {
            this.InstanceSessionID = InstanceSessionID;
            LoadFromSession();
        }

        /// <summary>
        /// Add the control to UserControlViewStateManager
        /// </summary>
        /// <param name="control">Control object</param>
        public void AddControl(Control control)
        {
            if (control == null)
            {
                throw new NullReferenceException();
            }
            if (control.ID == null || control.ID.Equals(String.Empty))
            {
                throw new Exception("controlID must be set.");
            }

            if (controlsTable == null)
            {
                controlsTable = new ArrayList();
                LastOrdinalIndex = 0;
            }

            ControlClass newControl = new ControlClass();

            Boolean IsControlFound = false;
            if (control.ID != null && !control.ID.Equals(String.Empty))
            {
                foreach (ControlClass ctrl in controlsTable)
                {
                    IsControlFound = (ctrl.ControlID.Equals(control.ID));
                    if (IsControlFound)
                    {
                        break;
                    }
                }

                if (IsControlFound)
                {
                    throw new Exception(String.Format("A control with this ID [{0}] already exists.", control.ID));
                }
                else
                {
                    newControl.ControlID = control.ID;
                }
            }

            newControl.OrdinalIndex = LastOrdinalIndex++;
            newControl.Type = control.GetType();
            controlsTable.Add(newControl);

            SaveToSession();
        }

        /// <summary>
        /// Removes the control from UserControlViewStateManager whose ID is passed through the parameter.
        /// </summary>
        /// <param name="index">Control ID.</param>
        public void RemoveControl(String controlID)
        {
            if (controlID == null || controlID.Equals(String.Empty))
            {
                throw new Exception("controlID must be provided.");
            }

            foreach (ControlClass control in controlsTable)
            {
                if (control.ControlID.Equals(controlID))
                {
                    controlsTable.Remove(control);
                    break;
                }
            }

            SaveToSession();
        }

        /// <summary>
        /// Removes the control at the specified index of the UserControlViewStateManager.
        /// </summary>
        /// <param name="index">The zero-based index of the element to remove.</param>
        public void RemoveAt(Int32 index)
        {
            controlsTable.Sort();
            if (controlsTable.Count < index + 1)
            {
                throw new ArgumentOutOfRangeException();
            }
            controlsTable.RemoveAt(index);

            SaveToSession();
        }

        /// <summary>
        /// Re-creates controls already stored in the class
        /// </summary>
        /// <param name="container">Container object to which controls will be added</param>
        public void ReCreateControls(Control container)
        {
            if (controlsTable == null)
            {
                return;
            }

            controlsTable.Sort();
            foreach (ControlClass cachedControl in controlsTable)
            {
                Control control = (Control)Activator.CreateInstance((Type)cachedControl.Type);
                control.ID = cachedControl.ControlID;
                container.Controls.Add(control);
            }
        }

        /// <summary>
        /// Removes all controls
        /// </summary>
        public void Reset()
        {
            controlsTable = null;

            SaveToSession();
        }

        #region Session handling routines

        /// <summary>
        /// Loads Helper-related data already stored in session
        /// </summary>
        private void LoadFromSession()
        {
            if (Session[InstanceSessionID] is ArrayList)
            {
                controlsTable = (ArrayList)Session[InstanceSessionID];

                if (Session[InstanceSessionID + "LastOrdinalIndex"] is Int32)
                {
                    LastOrdinalIndex = Convert.ToInt32(Session[InstanceSessionID + "LastOrdinalIndex"].ToString());
                }
            }
        }

        /// <summary>
        /// Saves Helper-related data to session
        /// </summary>
        private void SaveToSession()
        {
            Session[InstanceSessionID] = controlsTable;
            Session[InstanceSessionID + "LastOrdinalIndex"] = LastOrdinalIndex;
        }

        #endregion
    }
}
