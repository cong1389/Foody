using System;
using System.Data;
using System.Configuration;
using System.Data.Common;
using System.Reflection;
using System.Collections;
using System.Linq;

namespace Cb.DBUtility
{
    public class GenerateQuery
    {

        public static string PARAM_PREFIX
        {
            get
            {
                string re = string.Empty;
                switch (ConfigurationManager.AppSettings["Database"])
                {
                    case "SQLServer":
                        re = "@";
                        break;
                    case "MySQL":
                        re = "?";
                        break;
                }
                return re;
            }
        }



        #region Insert

        #region CommandText
        // make sql query insert
        public static string CommandTextInsert(object obj)
        {

            string insertQuery = "";

            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = obj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            //Generate insert query
            string insertStr = string.Format(@" INSERT INTO {0} (", myType.Name.ToLower());
            string valuesStr = " VALUES (";

            for (int i = 0; i < myFieldInfo.Length; i++)
            {

                // if this field not have minvalue of long or int, set query
                if (!((myFieldInfo[i].FieldType == typeof(int) && (int)myFieldInfo[i].GetValue(obj) == int.MinValue)
                     || (myFieldInfo[i].FieldType == typeof(byte) && (byte)myFieldInfo[i].GetValue(obj) == byte.MinValue)
                     || (myFieldInfo[i].FieldType == typeof(long) && (long)myFieldInfo[i].GetValue(obj) == long.MinValue)
                     || (myFieldInfo[i].Name.IndexOf("Desc") > 0)
                     || (myFieldInfo[i].FieldType.FullName.Contains("System.Collections.Generic.List") && myFieldInfo[i].FieldType.IsGenericType)))
                {
                    insertStr += myFieldInfo[i].Name + ",";
                    valuesStr += PARAM_PREFIX + myFieldInfo[i].Name + ",";
                }
            }
            insertQuery = insertStr.Remove(insertStr.Length - 1, 1) + ")" + valuesStr.Remove(valuesStr.Length - 1, 1) + ")  ; SELECT @@IDENTITY ";
            // end generate insert query

            return insertQuery;

        }

        /// <summary>
        /// Insert With IDENTITY_INSERT SET ON
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static string CommandTextInsertIDENTITY(object obj)
        {

            string insertQuery = "";

            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = obj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            //Generate insert query
            string insertStr = string.Format(@"SET IDENTITY_INSERT {0} ON; INSERT INTO {0} (", myType.Name.ToLower());
            string valuesStr = " VALUES (";

            for (int i = 0; i < myFieldInfo.Length; i++)
            {

                // if this field not have minvalue of long or int, set query
                if (!((myFieldInfo[i].FieldType == typeof(int) && (int)myFieldInfo[i].GetValue(obj) == int.MinValue)
                     || (myFieldInfo[i].FieldType == typeof(byte) && (byte)myFieldInfo[i].GetValue(obj) == byte.MinValue)
                     || (myFieldInfo[i].FieldType == typeof(long) && (long)myFieldInfo[i].GetValue(obj) == long.MinValue)
                     || (myFieldInfo[i].Name.IndexOf("Desc") > 0)
                     || (myFieldInfo[i].FieldType.FullName.Contains("System.Collections.Generic.List") && myFieldInfo[i].FieldType.IsGenericType)))
                {
                    insertStr += myFieldInfo[i].Name + ",";
                    valuesStr += PARAM_PREFIX + myFieldInfo[i].Name + ",";
                }
            }
            insertQuery = insertStr.Remove(insertStr.Length - 1, 1) + ")" + valuesStr.Remove(valuesStr.Length - 1, 1) + ")  ; SET IDENTITY_INSERT " + myType.Name.ToLower() + " OFF;  SELECT @@IDENTITY ";
            // end generate insert query

            return insertQuery;

        }

        /// <summary>
        /// For Max val filed By Identity
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static string CommandTextInsertIDENTITYWithMaxFiels(object obj, string fieldMax)
        {

            string insertQuery = "";
            string identityFieldName = GetIdentityFieldName(obj.GetType().Name);
            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = obj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            //Generate insert query
            string varReturn = string.Empty;
            string insertStr = string.Format(@"SET IDENTITY_INSERT {0} ON; INSERT INTO {0} (", myType.Name.ToLower());
            string valuesStr = " VALUES (";

            for (int i = 0; i < myFieldInfo.Length; i++)
            {

                // if this field not have minvalue of long or int, set query
                if (!((myFieldInfo[i].FieldType == typeof(int) && (int)myFieldInfo[i].GetValue(obj) == int.MinValue)
                     || (myFieldInfo[i].FieldType == typeof(byte) && (byte)myFieldInfo[i].GetValue(obj) == byte.MinValue)
                     || (myFieldInfo[i].FieldType == typeof(long) && (long)myFieldInfo[i].GetValue(obj) == long.MinValue)
                     || (myFieldInfo[i].Name.IndexOf("Desc") > 0)
                     || (myFieldInfo[i].FieldType.FullName.Contains("System.Collections.Generic.List") && myFieldInfo[i].FieldType.IsGenericType)))
                {

                    insertStr += myFieldInfo[i].Name + ",";
                    valuesStr += PARAM_PREFIX + myFieldInfo[i].Name + ",";
                }
                //if is file shoule max value
                else if (fieldMax.Equals(myFieldInfo[i].Name, StringComparison.OrdinalIgnoreCase))
                {
                    varReturn = string.Format("declare {3}re int;select {3}re = MAX({0})+1 FROM {1} WHERE {2} ={3}{2} ; ", myFieldInfo[i].Name, myType.Name.ToLower(), identityFieldName, PARAM_PREFIX);
                    insertStr += myFieldInfo[i].Name + ",";
                    valuesStr += PARAM_PREFIX + "re,";
                }
            }
            insertQuery = varReturn + insertStr.Remove(insertStr.Length - 1, 1) + ")" + valuesStr.Remove(valuesStr.Length - 1, 1) + ")  ; SET IDENTITY_INSERT " + myType.Name.ToLower() + " OFF;  SELECT @re; ";
            // end generate insert query

            return insertQuery;

        }
        #endregion CommandText

        #region PrepareParameters
        // make parameters
        public static void PrepareParametersInsert(DbCommand cm, object obj)
        {

            // get length of string columns from database
            IList stringColumns = GetLengthOfStringColumns(obj.GetType().Name);

            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = obj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            for (int i = 0; i < myFieldInfo.Length; i++)
            {
                //get type of field        
                Type type = myFieldInfo[i].FieldType;

                // if this field not have minvalue of long or int, add parameter
                if (!((myFieldInfo[i].FieldType == typeof(int) && (int)myFieldInfo[i].GetValue(obj) == int.MinValue)
                     || (myFieldInfo[i].FieldType == typeof(byte) && (byte)myFieldInfo[i].GetValue(obj) == byte.MinValue)
                     || (myFieldInfo[i].FieldType == typeof(long) && (long)myFieldInfo[i].GetValue(obj) == long.MinValue)
                     || (myFieldInfo[i].Name.EndsWith("Desc"))))
                {
                    // convert value to DB value
                    object value = DBConvert.ParseToDBValue(myFieldInfo[i].GetValue(obj));

                    //get paramname
                    string paramName = PARAM_PREFIX + myFieldInfo[i].Name;

                    // if type is char
                    if (type == typeof(System.Char))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.AnsiStringFixedLength, LengthOfStringColumns(stringColumns, myFieldInfo[i].Name), value);
                    }
                    // if type is string
                    else if (type == typeof(System.String))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.String, LengthOfStringColumns(stringColumns, myFieldInfo[i].Name), value);
                    }
                    // if type is byte
                    else if (type == typeof(System.Byte))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.Byte, value);
                    }
                    // if type is smallint
                    else if (type == typeof(System.Int16))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Int16, value);
                    }
                    // if type is int
                    else if (type == typeof(System.Int32))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Int32, value);
                    }
                    // if type is long
                    else if (type == typeof(System.Int64))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Int64, value);
                    }
                    // if type is decimal
                    else if (type == typeof(System.Decimal))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Decimal, value);
                    }
                    // if type is double
                    else if (type == typeof(System.Double))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Double, value);
                    }
                    // if type is datetime
                    else if (type == typeof(System.DateTime))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.DateTime, value);
                    }
                    // if type is datetime
                    else if (type == typeof(System.Boolean))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Boolean, value);
                    }

                         // if type is datetime
                    else if (type == typeof(Nullable<System.Boolean>))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Boolean, value);
                    }
                   
                }
            }
        }

        /// <summary>
        /// For Max val filed By Identity
        /// </summary>
        /// <param name="cm"></param>
        /// <param name="obj"></param>
        public static void PrepareParametersInsertWithMaxField(DbCommand cm, object obj, string fieldMax)
        {

            // get length of string columns from database
            IList stringColumns = GetLengthOfStringColumns(obj.GetType().Name);

            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = obj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            for (int i = 0; i < myFieldInfo.Length; i++)
            {
                //get type of field        
                Type type = myFieldInfo[i].FieldType;

                // if this field not have minvalue of long or int, add parameter
                if (!((myFieldInfo[i].FieldType == typeof(int) && (int)myFieldInfo[i].GetValue(obj) == int.MinValue)
                     || (myFieldInfo[i].FieldType == typeof(byte) && (byte)myFieldInfo[i].GetValue(obj) == byte.MinValue)
                     || (myFieldInfo[i].FieldType == typeof(long) && (long)myFieldInfo[i].GetValue(obj) == long.MinValue)
                     || (myFieldInfo[i].Name.EndsWith("Desc"))))
                {
                    // convert value to DB value
                    object value = DBConvert.ParseToDBValue(myFieldInfo[i].GetValue(obj));

                    //get paramname
                    string paramName = PARAM_PREFIX + myFieldInfo[i].Name;

                    // if type is char
                    if (type == typeof(System.Char))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.AnsiStringFixedLength, LengthOfStringColumns(stringColumns, myFieldInfo[i].Name), value);
                    }
                    // if type is string
                    else if (type == typeof(System.String))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.String, LengthOfStringColumns(stringColumns, myFieldInfo[i].Name), value);
                    }
                    // if type is byte
                    else if (type == typeof(System.Byte))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.Byte, value);
                    }
                    // if type is smallint
                    else if (type == typeof(System.Int16))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Int16, value);
                    }
                    // if type is int
                    else if (type == typeof(System.Int32))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Int32, value);
                    }
                    // if type is long
                    else if (type == typeof(System.Int64))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Int64, value);
                    }
                    // if type is decimal
                    else if (type == typeof(System.Decimal))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Decimal, value);
                    }
                    // if type is double
                    else if (type == typeof(System.Double))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Double, value);
                    }
                    // if type is datetime
                    else if (type == typeof(System.DateTime))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.DateTime, value);
                    }
                    // if type is datetime
                    else if (type == typeof(System.Boolean))
                    {
                        DBHelper.AddParameter(cm, paramName, DbType.Boolean, value);
                    }
                   
                }

            }
        }

        #endregion

        #endregion

        #region Update

        #region CommandText
        public static string CommandTextUpdate(object currentObj, string[] primaryKeyNames)
        {
            string updateQuery = "";

            string identityFieldName = GetIdentityFieldName(currentObj.GetType().Name);

            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = currentObj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            //Generate insert query
            string updateClause = string.Format(@" UPDATE {0} SET ", myType.Name.ToLower());
            string whereClause = " WHERE ";

            for (int i = 0; i < myFieldInfo.Length; i++)
            {
                // if the field is not identity field, can update
                if (!(identityFieldName != null && identityFieldName.Equals(myFieldInfo[i].Name, StringComparison.OrdinalIgnoreCase))
                        && (myFieldInfo[i].Name.IndexOf("Desc") < 0) && (!myFieldInfo[i].FieldType.IsGenericType
                    || myFieldInfo[i].FieldType.GetGenericTypeDefinition().Equals(typeof(Nullable<>))))
                    updateClause += myFieldInfo[i].Name + "= " + PARAM_PREFIX + myFieldInfo[i].Name + ",";
            }
            // generate where clause
            if (primaryKeyNames != null)
            {
                foreach (string primaryKeyName in primaryKeyNames)
                {
                    whereClause += primaryKeyName + " = " + PARAM_PREFIX + "Current" + primaryKeyName + " AND ";
                }
            }
            updateQuery = updateClause.Remove(updateClause.Length - 1, 1) + whereClause.Remove(whereClause.Length - 5, 5);

            // end generate update query

            return updateQuery;

        }


        public static string CommandTextUpdate(object currentObj, string[] primaryKeyNames, string[] primaryKeyNames2)
        {
            string updateQuery = "";

            string identityFieldName = GetIdentityFieldName(currentObj.GetType().Name);

            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = currentObj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            //Generate insert query
            string updateClause = string.Format(@" UPDATE {0} SET ", myType.Name.ToLower());
            string whereClause = " WHERE ";

            for (int i = 0; i < myFieldInfo.Length; i++)
            {
                // if the field is not identity field, can update
                if (!(identityFieldName != null && identityFieldName.Equals(myFieldInfo[i].Name, StringComparison.OrdinalIgnoreCase))
                        && (myFieldInfo[i].Name.IndexOf("Desc") < 0) && (!myFieldInfo[i].FieldType.IsGenericType
                    || myFieldInfo[i].FieldType.GetGenericTypeDefinition().Equals(typeof(Nullable<>))))
                    updateClause += myFieldInfo[i].Name + "= " + PARAM_PREFIX + myFieldInfo[i].Name + ",";
            }
            // generate where clause
            if (primaryKeyNames != null)
            {
                foreach (string primaryKeyName in primaryKeyNames)
                {
                    whereClause += primaryKeyName + " = " + PARAM_PREFIX + "Current" + primaryKeyName + " AND ";
                }
            }

            if (primaryKeyNames2 != null)
            {
                foreach (string primaryKeyName2 in primaryKeyNames2)
                {
                    whereClause += primaryKeyName2 + " = " + PARAM_PREFIX + "Current" + primaryKeyName2 + " AND ";
                }
            }
            updateQuery = updateClause.Remove(updateClause.Length - 1, 1) + whereClause.Remove(whereClause.Length - 5, 5);

            // end generate update query

            return updateQuery;

        }
        #endregion

        #region PrepareParameters
        public static void PrepareParametersUpdate(DbCommand cm, object currentObj, object expectedObj, string[] primaryKeyNames)
        {
            //set parameter for current primary key name
            // if the filed is primary key name, dont add param
            foreach (string primaryKeyName in primaryKeyNames)
            {
                FieldInfo field = currentObj.GetType().GetField(primaryKeyName, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public | BindingFlags.IgnoreCase);
                AddParamUpdate(cm, field.FieldType, "Current" + field.Name, currentObj, field.GetValue(currentObj));
            }

            // set parameter for new values
            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = expectedObj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            for (int i = 0; i < myFieldInfo.Length; i++)
            {
                //get type of field        
                Type type = myFieldInfo[i].FieldType;

                if (myFieldInfo[i].Name.IndexOf("Desc") < 0)
                {
                    // convert value to DB value
                    object value = DBConvert.ParseToDBValue(myFieldInfo[i].GetValue(expectedObj));

                    //set paramname
                    AddParamUpdate(cm, type, myFieldInfo[i].Name, currentObj, value);
                }
            }
        }

        public static void PrepareParametersUpdate(DbCommand cm, object currentObj, object expectedObj, string[] primaryKeyNames, string[] primaryKeyNames2)
        {
            //set parameter for current primary key name
            // if the filed is primary key name, dont add param
            foreach (string primaryKeyName in primaryKeyNames)
            {
                FieldInfo field = currentObj.GetType().GetField(primaryKeyName, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public | BindingFlags.IgnoreCase);
                AddParamUpdate(cm, field.FieldType, "Current" + field.Name, currentObj, field.GetValue(currentObj));
            }

            foreach (string primaryKeyName2 in primaryKeyNames2)
            {
                FieldInfo field = currentObj.GetType().GetField(primaryKeyName2, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public | BindingFlags.IgnoreCase);
                AddParamUpdate(cm, field.FieldType, "Current" + field.Name, currentObj, field.GetValue(currentObj));
            }
            // set parameter for new values
            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = expectedObj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            for (int i = 0; i < myFieldInfo.Length; i++)
            {
                //get type of field        
                Type type = myFieldInfo[i].FieldType;

                if (myFieldInfo[i].Name.IndexOf("Desc") < 0)
                {
                    // convert value to DB value
                    object value = DBConvert.ParseToDBValue(myFieldInfo[i].GetValue(expectedObj));

                    //set paramname
                    AddParamUpdate(cm, type, myFieldInfo[i].Name, currentObj, value);
                }
            }
        }
        private static void AddParamUpdate(IDbCommand cm, Type type, string fieldName, object currentObj, object value)
        {
            string paramName = PARAM_PREFIX + fieldName;

            // Get length of string(char, varchar, nvarchar) columns
            IList stringColumns = GetLengthOfStringColumns(currentObj.GetType().Name);

            // if type is char
            if (type == typeof(System.Char))
            {
                DGCDataParameter.AddParameter(cm, paramName, DbType.AnsiStringFixedLength, LengthOfStringColumns(stringColumns, fieldName), value);
            }
            // if type is string
            else if (type == typeof(System.String))
            {
                DGCDataParameter.AddParameter(cm, paramName, DbType.String, LengthOfStringColumns(stringColumns, fieldName), value);
            }
            // if type is byte
            else if (type == typeof(System.Byte))
            {
                DGCDataParameter.AddParameter(cm, paramName, DbType.Byte, value);
            }
            // if type is smallint
            else if (type == typeof(System.Int16))
            {
                DGCDataParameter.AddParameter(cm, paramName, DbType.Int16, value);
            }
            // if type is int
            else if (type == typeof(System.Int32))
            {
                DGCDataParameter.AddParameter(cm, paramName, DbType.Int32, value);
            }
            // if type is long
            else if (type == typeof(System.Int64))
            {
                DGCDataParameter.AddParameter(cm, paramName, DbType.Int64, value);
            }
            // if type is decimal
            else if (type == typeof(System.Decimal))
            {
                DGCDataParameter.AddParameter(cm, paramName, DbType.Decimal, value);
            }
            // if type is double
            else if (type == typeof(System.Double))
            {
                DGCDataParameter.AddParameter(cm, paramName, DbType.Double, value);
            }
            // if type is datetime
            else if (type == typeof(System.DateTime))
            {
                DGCDataParameter.AddParameter(cm, paramName, DbType.DateTime, value);
            }
            // if type is datetime
            else if (type == typeof(System.Boolean) || type == typeof(Nullable<System.Boolean>))
            {
                DGCDataParameter.AddParameter(cm, paramName, DbType.Boolean, value);
            }
        }

        // Return length of a char, varchar, nvarchar column  
        private static int LengthOfStringColumns(IList _stringColumns, string _columnName)
        {
            foreach (DGCParameter param in _stringColumns)
            {
                if (param.ParameterName.Equals(_columnName, StringComparison.OrdinalIgnoreCase))
                    return (int)param.Value;
            }
            return 0;
        }
        #endregion PrepareParameters

        #endregion

        #region Load
        #region CommandText
        // make sql query
        public static string CommandTextLoad(object obj, string[] primaryKeyNames)
        {
            string selectClause = string.Empty, loadQuery = string.Empty;
            string whereClause = " WHERE ";

            //get Type of object
            Type myType = obj.GetType();

            // generate where clause
            if (primaryKeyNames != null)
            {
                foreach (string primaryKeyName in primaryKeyNames)
                {
                    whereClause += primaryKeyName + " = " + PARAM_PREFIX + primaryKeyName + " AND ";
                }
            }

            switch (ConfigurationManager.AppSettings["Database"])
            {
                case "SQLServer":
                    selectClause = string.Format(@" SELECT TOP (1) * FROM {0} ", myType.Name.ToLower());
                    loadQuery = selectClause.Remove(selectClause.Length - 1, 1) + whereClause.Remove(whereClause.Length - 5, 5);
                    break;
                case "MySQL":
                    selectClause = string.Format(@" SELECT * FROM {0} ", myType.Name.ToLower());
                    loadQuery = selectClause.Remove(selectClause.Length - 1, 1) + whereClause.Remove(whereClause.Length - 5, 5) + " LIMIT 1 ";
                    break;
            }

            // end generate load query
            return loadQuery;

        }
        #endregion CommandText

        #region PrepareParameters
        // make parameters
        public static void PrepareParametersLoad(IDbCommand cm, object obj, string[] primaryKeyNames)
        {
            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = obj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            if (primaryKeyNames != null)
            {
                foreach (string primaryKey in primaryKeyNames)
                {
                    for (int i = 0; i < myFieldInfo.Length; i++)
                    {
                        //get paramname
                        string paramName = PARAM_PREFIX + myFieldInfo[i].Name;

                        // if( primaryKey is equal fieldname)  
                        if (primaryKey.Equals(myFieldInfo[i].Name, StringComparison.OrdinalIgnoreCase))
                        {

                            //get type of field        
                            Type type = myFieldInfo[i].FieldType;

                            // convert value to DB value
                            object value = DBConvert.ParseToDBValue(myFieldInfo[i].GetValue(obj));

                            // if type is char
                            if (type == typeof(System.Char))
                            {
                                DGCDataParameter.AddParameter(cm, paramName, DbType.AnsiStringFixedLength, value);
                            }
                            // if type is string
                            else if (type == typeof(System.String))
                            {
                                DGCDataParameter.AddParameter(cm, paramName, DbType.String, value);
                            }
                            // if type is byte
                            else if (type == typeof(System.Byte))
                            {
                                DGCDataParameter.AddParameter(cm, paramName, DbType.Byte, value);
                            }
                            // if type is smallint
                            else if (type == typeof(System.Int16))
                            {
                                DGCDataParameter.AddParameter(cm, paramName, DbType.Int16, value);
                            }
                            // if type is int
                            else if (type == typeof(System.Int32))
                            {
                                DGCDataParameter.AddParameter(cm, paramName, DbType.Int32, value);
                            }
                            // if type is long
                            else if (type == typeof(System.Int64))
                            {
                                DGCDataParameter.AddParameter(cm, paramName, DbType.Int64, value);
                            }
                            // if type is decimal
                            else if (type == typeof(System.Decimal))
                            {
                                DGCDataParameter.AddParameter(cm, paramName, DbType.Decimal, value);
                            }
                            // if type is double
                            else if (type == typeof(System.Double))
                            {
                                DGCDataParameter.AddParameter(cm, paramName, DbType.Double, value);
                            }
                            // if type is datetime
                            else if (type == typeof(System.DateTime))
                            {
                                DGCDataParameter.AddParameter(cm, paramName, DbType.DateTime, value);
                            }
                            break;
                        }
                    }
                }
            }
        }
        #endregion PrepareParameters
        #endregion

        #region List
        #region CommandText
        // make sql query
        public static string CommandTextList(object obj, string whereClause)
        {

            string listQuery = "";

            //get Type of object
            Type myType = obj.GetType();

            //Table Name
            string strTableName = myType.Name.ToLower(); //ConfigurationManager.AppSettings["ReFix"] + myType.Name.Substring(0, myType.Name.Length - 4);

            //Generate insert query
            listQuery = string.Format(@" SELECT * FROM {0} ", strTableName.ToLower()) + whereClause;

            // end generate load query

            return listQuery;

        }
        #endregion CommandText

        #region PrepareParametersList
        // make parameters
        public static void PrepareParametersList(IDbCommand cm, DGCParameter[] parameters)
        {
            // set param for Input Parameters
            if (parameters != null)
            {
                foreach (DGCParameter param in parameters)
                {
                    DGCDataParameter.AddParameter(cm, param.ParameterName, param.DbType, param.Value, param.Direction);
                }
            }
        }

        public static void PrepareParametersListWithSourceColumn(IDbCommand cm, DGCParameter[] parameters)
        {
            // set param for Input Parameters
            if (parameters != null)
            {
                foreach (DGCParameter param in parameters)
                {
                    if (!param.Size.Equals(default(int)))
                        DGCDataParameter.AddParameter(cm, param.ParameterName, param.DbType, param.Size, param.SourceColumn, param.SourceVersion);
                    else
                        DGCDataParameter.AddParameter(cm, param.ParameterName, param.DbType, param.SourceColumn, param.SourceVersion);
                }
            }
        }

        #endregion PrepareParameters
        #endregion

        #region delete
        #region CommandText
        // make sql query
        public static string CommandTextDelete(object obj, string[] primaryKeyNames)
        {

            string deleteQuery = "";

            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = obj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            //Generate delete query
            string deleteClause = string.Format(@" DELETE FROM {0} ", myType.Name.ToLower());
            string whereClause = " WHERE ";

            // generate where clause
            if (primaryKeyNames != null)
            {
                foreach (string primaryKeyName in primaryKeyNames)
                {
                    whereClause += primaryKeyName + " = " + PARAM_PREFIX + primaryKeyName + " AND ";
                }
            }
            deleteQuery = deleteClause.Remove(deleteClause.Length - 1, 1) + whereClause.Remove(whereClause.Length - 5, 5);

            // end generate delete query

            return deleteQuery;

        }
        #endregion CommandText

        #region PrepareParameters
        // make parameters
        public static void PrepareParametersDelete(IDbCommand cm, object obj, string[] primaryKeyNames)
        {
            FieldInfo[] myFieldInfo;

            //get Type of object
            Type myType = obj.GetType();

            // Get the type and fields of FieldInfoClass.
            myFieldInfo = myType.GetFields(BindingFlags.NonPublic | BindingFlags.Instance
              | BindingFlags.Public);

            // if exist any parameters
            if (primaryKeyNames != null)
            {
                foreach (string primaryKeyName in primaryKeyNames)
                {
                    FieldInfo field = myType.GetField(primaryKeyName, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public | BindingFlags.IgnoreCase);

                    //get type of field        
                    Type type = field.FieldType;
                    // convert value to DB value
                    object value = DBConvert.ParseToDBValue(field.GetValue(obj));

                    //get paramname
                    string paramName = PARAM_PREFIX + field.Name;

                    // if type is char
                    if (type == typeof(System.Char))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.AnsiStringFixedLength, value);
                    }
                    // if type is string
                    else if (type == typeof(System.String))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.String, value);
                    }
                    // if type is smallint
                    else if (type == typeof(System.Int16))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.Int16, value);
                    }
                    // if type is byte
                    else if (type == typeof(System.Byte))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.Byte, value);
                    }
                    // if type is int
                    else if (type == typeof(System.Int32))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.Int32, value);
                    }
                    // if type is long
                    else if (type == typeof(System.Int64))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.Int64, value);
                    }
                    // if type is decimal
                    else if (type == typeof(System.Decimal))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.Decimal, value);
                    }
                    // if type is double
                    else if (type == typeof(System.Double))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.Double, value);
                    }
                    // if type is datetime
                    else if (type == typeof(System.DateTime))
                    {
                        DGCDataParameter.AddParameter(cm, paramName, DbType.DateTime, value);
                    }
                }
            }
        }
        #endregion PrepareParameters
        #endregion

        #region Common
        // get List Of char, varchar, nvarchar columns
        /*
        private static IList GetLengthOfStringColumns(string _tableName)
        {
            SqlFactory factory = new SqlFactory();
            // Make command
            DbCommand cm = factory.MakeCommand(string.Format(@"
                            SELECT column_name, data_type, character_octet_length 
                             FROM INFORMATION_SCHEMA.COLUMNS 
                            WHERE table_name='{0}' AND data_type IN ('char', 'varchar', 'nvarchar')", _tableName));

            // execute query          
            IDataReader dre = factory.ExecuteReader(cm);

            IList _params = new ArrayList();

            while (dre.Read())
            {
                _params.Add(new DGCParameter(DBConvert.ParseDBToString(dre, "column_name"), DbType.String, DBConvert.ParseDBToInt(dre, "character_octet_length")));
            }
            dre.Close();

            return _params;

        }
         */

        private static IList GetLengthOfStringColumns(string _tableName)
        {
            IFactory factory = DBHelper.CreateFactory();
            // Make command
            string query = string.Empty;
            switch (ConfigurationManager.AppSettings["Database"])
            {
                case "SQLServer":
                    query = string.Format(@"
                            SELECT column_name, data_type, character_octet_length 
                             FROM INFORMATION_SCHEMA.COLUMNS 
                            WHERE table_name='{0}' AND data_type IN ('char', 'varchar', 'nvarchar')", _tableName);
                    break;
                case "MySQL":
                    query = string.Format(@"
                            SELECT * FROM information_schema.columns 
                            WHERE table_name = '{0}' AND data_type IN ('char','varchar')", _tableName.ToLower());
                    break;
            }
            DbCommand cm = factory.MakeCommand(query);

            // execute query          
            IDataReader dre = factory.ExecuteReader(cm);

            IList _params = new ArrayList();

            while (dre.Read())
            {
                _params.Add(new DGCParameter(DBConvert.ParseDBToString(dre, "column_name"), DbType.String, DBConvert.ParseDBToInt(dre, "character_octet_length")));
            }
            dre.Close();

            return _params;

        }

        //get identity field name
        /*
        private static string GetIdentityFieldName(string _tableName)
        {
            SqlFactory factory = new SqlFactory();
            // Make command
            DbCommand cm = factory.MakeCommand(string.Format(@"
            SELECT c.name
              FROM syscolumns c JOIN sysobjects o 
               ON c.id = o.id
              WHERE  c.status = 128 
              AND o.name = '{0}'", _tableName));

            // execute query          
            try
            {
                return (string)factory.ExecuteScalar(cm);
            }
            catch
            {
                return null;
            }
        }
        */

        private static string GetIdentityFieldName(string _tableName)
        {
            IFactory factory = DBHelper.CreateFactory();
            // Make command
            string query = string.Empty;
            switch (ConfigurationManager.AppSettings["Database"])
            {
                case "SQLServer":
                    query = string.Format(@"SELECT c.name FROM syscolumns c JOIN sysobjects o 
                                    ON c.id = o.id WHERE  c.status = 128  AND o.name = '{0}'", _tableName);
                    break;
                case "MySQL":
                    query = string.Format(@"
                            SHOW COLUMNS FROM {0} WHERE extra = 'auto_increment'", _tableName.ToLower());
                    break;
            }


            DbCommand cm = factory.MakeCommand(query);
            // execute query          
            try
            {
                return (string)factory.ExecuteScalar(cm);
            }
            catch
            {
                return null;
            }
        }
        #endregion
    }
}
