/**
 * @version $Id:
 * @package Digicom.NET
 * @author Digicom Dev <dev@dgc.vn>
 * @copyright Copyright (C) 2009 by Digicom. All rights reserved.
 * @link http://www.dgc.vn
 */
using System;
using System.Data;
using System.Data.Common;
using System.Reflection;
using System.Collections;

using System.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;

namespace Cb.DBUtility
{
    public class DBHelper
    {
        #region Format Number

        public static byte ToNullableByte(object o)
        {
            if (DBNull.Value == o)
            {
                return byte.MinValue;
            }
            return (byte)o;
        }

        public static short ToSmallInt(object o)
        {
            if (DBNull.Value == o)
            {
                return short.MinValue;
            }
            return (short)o;
        }

        public static int ToNullableInt(object o)
        {
            if (DBNull.Value == o)
            {
                return int.MinValue;
            }
            return Convert.ToInt32(o);
        }

        public static long ToNullableLong(object o)
        {
            if (DBNull.Value == o)
            {
                return long.MinValue;
            }
            return (long)o;
        }

        public static double ToNullableDouble(object o)
        {
            if (DBNull.Value == o)
            {
                return double.MinValue;
            }
            return (double)o;
        }

        public static decimal? ToNullableDecimal(object o)
        {
            if (DBNull.Value == o)
            {
                return null;
            }
            return (decimal)o;
        }

        public static bool? ToNullableBoolean(object o)
        {
            if (DBNull.Value == o)
            {
                return null;
            }
            return (bool)o;
        }

        public static DateTime ToNullableDateTime(object o)
        {
            if (DBNull.Value == o)
            {
                return DateTime.MinValue;
            }
            return (DateTime)o;
        }

        public static string ToNullableString(object o)
        {
            if (DBNull.Value == o)
            {
                return string.Empty;
            }
            return (string)o;
        }


        /// <summary>
        /// Doi so double sang string theo format "999,999.99" (Sau dau '.' là _phanLe chu so thap phan)
        /// Neu _phanLe < 0 thì không định dạng theo format nào cả mà chỉ tra về giá trị _number.ToString().
        /// </summary>
        /// <param name="_number">So double can doi sang string</param>
        /// <param name="_phanLe">So cac so le</param>
        /// <returns></returns>
        public static string NumericFormat(double _number, int _phanLe)
        {
            if (_number == double.MinValue)
            {
                return string.Empty;
            }
            if (_phanLe < 0)
            {
                return _number.ToString();
            }
            System.Globalization.NumberFormatInfo formatInfo = new System.Globalization.NumberFormatInfo();

            double t = Math.Truncate(_number);
            if (Math.Truncate(_number) != _number)
                formatInfo.NumberDecimalDigits = _phanLe;
            else
                formatInfo.NumberDecimalDigits = 0;

            return _number.ToString("N", formatInfo);
        }
        #endregion

        #region Input parameter
        public static DbParameter CreateInputParameter(DbCommand cmd, string parameterName, DbType type, object value)
        {
            DbParameter param = null;
            param = cmd.CreateParameter();
            param.ParameterName = parameterName;
            param.DbType = type;
            param.Value = value;
            return param;
        }
        public static void AddParameter(DbCommand cm, string parameterName, DbType type, int size, object value)
        {
            DbParameter para = cm.CreateParameter();
            para.ParameterName = parameterName;
            para.DbType = type;
            para.Size = size;
            para.Value = value;
            cm.Parameters.Add(para);
        }

        public static void AddParameter(DbCommand cm, string parameterName, DbType type, object value)
        {
            DbParameter para = cm.CreateParameter();
            para.ParameterName = parameterName;
            para.DbType = type;
            para.Value = value != null ? value : DBNull.Value;
            cm.Parameters.Add(para);
        }
        public static void AddParameter(DbCommand cm, ParameterDirection direction, string parameterName, DbType type, int size, object value)
        {
            DbParameter para = cm.CreateParameter();
            para.ParameterName = parameterName;
            para.DbType = type;
            para.Size = size;
            para.Value = value;
            para.Direction = direction;
            cm.Parameters.Add(para);
        }
        #endregion

        #region Read value From DB
        /// <summary>
        /// Set value from database for fields of the object
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="dre"></param>
        /// <param name="type"></param>
        public static void SetValueForObject(object obj, IDataReader dre, Type type)
        {
            for (int i = 0; i < dre.FieldCount; i++)
            {
                //get type of field
                string fieldName = dre.GetName(i);
                PropertyInfo property = type.GetProperty(fieldName, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                if (property == null)
                {
                    continue;
                }
                SetValue(obj, property, dre);
            }
        }

        /// <summary>
        /// Set value from database for fields of the object
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="dre"></param>
        /// <param name="type"></param>
        public static void SetValueForObject(object obj, IDataReader dre, FieldInfo[] myFieldInfo)
        {
            for (int i = 0; i < myFieldInfo.Length; i++)
            {
                //get type of field
                Type type = myFieldInfo[i].FieldType;
                string paramName = myFieldInfo[i].Name;

                // convert value to DB value
                object value = DBConvert.ParseToDBValue(myFieldInfo[i].GetValue(obj));

                // if type is char
                if (type == typeof(System.Char))
                {
                    myFieldInfo[i].SetValue(obj, DBConvert.ParseDBToChar(dre, paramName));
                }
                // if type is string
                else if (type == typeof(System.String))
                {
                    myFieldInfo[i].SetValue(obj, DBConvert.ParseDBToString(dre, paramName));
                }
                // if type is smallint
                else if (type == typeof(System.Int16))
                {
                    myFieldInfo[i].SetValue(obj, DBConvert.ParseDBToSmallInt(dre, paramName));
                }
                // if type is int
                else if (type == typeof(System.Int32))
                {
                    myFieldInfo[i].SetValue(obj, DBConvert.ParseDBToInt(dre, paramName));
                }
                // if type is long
                else if (type == typeof(System.Int64))
                {
                    myFieldInfo[i].SetValue(obj, DBConvert.ParseDBToLong(dre, paramName));
                }
                // if type is decimal
                else if (type == typeof(System.Decimal))
                {
                    myFieldInfo[i].SetValue(obj, DBConvert.ParseDBToDecimal(dre, paramName));
                }
                // if type is double
                else if (type == typeof(System.Double))
                {
                    myFieldInfo[i].SetValue(obj, DBConvert.ParseDBToDouble(dre, paramName));
                }
                // if type is datetime
                else if (type == typeof(System.DateTime))
                {
                    myFieldInfo[i].SetValue(obj, DBConvert.ParseDBToDateTime(dre, paramName));
                }
            }
        }

        /// <summary>
        /// Set value from database for fields of the object
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="dre"></param>
        /// <param name="type"></param>
        private static void SetValue(object obj, PropertyInfo field, IDataReader dre)
        {
            // if type is char
            if (field.PropertyType == typeof(System.Char))
            {
                field.SetValue(obj, DBConvert.ParseDBToChar(dre, field.Name), null);
            }
            // if type is string
            else if (field.PropertyType == typeof(System.String))
            {
                field.SetValue(obj, DBConvert.ParseDBToString(dre, field.Name), null);
            }
            // if type is smallint
            else if (field.PropertyType == typeof(System.Int16))
            {
                field.SetValue(obj, DBConvert.ParseDBToSmallInt(dre, field.Name), null);
            }
            // if type is int
            else if (field.PropertyType == typeof(System.Int32))
            {
                field.SetValue(obj, DBConvert.ParseDBToInt(dre, field.Name), null);
            }
            // if type is long
            else if (field.PropertyType == typeof(System.Int64))
            {
                field.SetValue(obj, DBConvert.ParseDBToLong(dre, field.Name), null);
            }
            // if type is decimal
            else if (field.PropertyType == typeof(System.Decimal))
            {
                field.SetValue(obj, DBConvert.ParseDBToDecimal(dre, field.Name), null);
            }
            // if type is double
            else if (field.PropertyType == typeof(System.Double))
            {
                field.SetValue(obj, DBConvert.ParseDBToDouble(dre, field.Name), null);
            }
            // if type is datetime
            else if (field.PropertyType == typeof(System.DateTime))
            {
                field.SetValue(obj, DBConvert.ParseDBToDateTime(dre, field.Name), null);
            }
        }

        #endregion

        #region Process getsentence
        /// <summary>
        /// Tach chuoi
        /// </summary>
        /// <param name="vrParaph">Chuoi can tach</param>
        /// <param name="vrCount">So tu can tach</param>
        /// <returns>So tu can lay + ...</returns>
        public static string getSentense(string vrParaph, int vrCount)
        {
            char[] strSplit = { ' ', '\r' };
            string[] arrStr = vrParaph.Split(strSplit);

            if (arrStr.Length > vrCount)
            {
                vrParaph = "";
                int i = 0;
                foreach (string vrStr in arrStr)
                {
                    vrParaph = vrParaph + vrStr + " ";
                    i++;
                    if (i > vrCount - 1)
                    {
                        vrParaph = vrParaph + " ...";
                        break;
                    }
                }
                vrParaph = vrParaph.Trim().Replace("\n", "<br>");
                return vrParaph;
            }
            else
            {
                return vrParaph;
            }
        }

        /// <summary>
        /// Tach chuoi
        /// </summary>
        /// <param name="vrParaph">Chuoi can tach</param>
        /// <param name="vrCount">So tu can tach</param>
        /// <returns>So tu can lay + ...</returns>
        public static string getTruncate(string vrParaph, int vrCount)
        {
            char[] strSplit = { ' ', '\r' };
            string[] arrStr = vrParaph.Split(strSplit);

            if (arrStr.Length > vrCount)
            {
                vrParaph = "";
                int i = 0;
                foreach (string vrStr in arrStr)
                {
                    vrParaph = vrParaph + vrStr + " ";
                    i++;
                    if (i > vrCount - 1)
                    {
                        vrParaph = vrParaph + " ...";
                        break;
                    }
                }
                vrParaph = vrParaph.Trim().Replace("\n", "<br>");
                return vrParaph;
            }
            else
            {
                return vrParaph;
            }
        }
        #endregion

        #region Factory

        public static IFactory CreateFactory()
        {
            IFactory factory = new SqlFactory();
            return factory;
        }

        public static void ExcuteNonQuery(string query, DGCParameter[] param)
        {
            IFactory factory = CreateFactory();

            try
            {
                DbCommand cmd = factory.MakeCommand(query);
                GenerateQuery.PrepareParametersList(cmd, param);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("DBHelper", "ExcuteNonQuery(string query, DGCParameter[] param)", ex.Message);
            }

        }

        public static void ExcuteNonQueryWithTransaction(string query, DGCParameter[] param, IFactory factory)
        {
            DbCommand cmd = factory.MakeCommand(query);
            GenerateQuery.PrepareParametersList(cmd, param);
            cmd.ExecuteNonQuery();
        }
        
        public static Database CreateDB()
        {
            return new SqlDatabase(ConfigurationManager.ConnectionStrings["SQLConnString1"].ConnectionString);// DatabaseFactory.CreateDatabase(ConfigurationManager.ConnectionStrings["SQLConnString1"].ConnectionString);
        }

        public static DataTable ExcuteFromCmd(string query, DGCParameter[] parameters)
        {
            DataTable dt = new DataTable();
            Database db = CreateDB();
            try
            {
                DbCommand cmd = db.GetSqlStringCommand(query);
                GenerateQuery.PrepareParametersList(cmd, parameters);
                DataSet ds = db.ExecuteDataSet(cmd);
                dt = ds.Tables[0];
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", "ExcuteFromCmd(string query, DGCParameter[] parameters)", ex.Message);
            }
            return dt;
        }

        public static DataTable ExcuteFromStore(string stroreName, DGCParameter[] parameters)
        {
            DataTable dt = null;
            Database db = CreateDB();
            try
            {
                DbCommand cmd = db.GetStoredProcCommand(stroreName);
                GenerateQuery.PrepareParametersList(cmd, parameters);
                DataSet ds = db.ExecuteDataSet(cmd);
                dt = ds.Tables[0];
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", "ExcuteFromStore(string stroreName, DGCParameter[] parameters)", ex.Message);
            }
            return dt;
        }

        public static void ExcuteFromStoreNonQuery(string stroreName, DGCParameter[] parameters)
        {
            Database db = CreateDB();
            DbCommand cmd = null;
            try
            {
                cmd = db.GetStoredProcCommand(stroreName);
                GenerateQuery.PrepareParametersList(cmd, parameters);
                db.ExecuteNonQuery(cmd);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", "ExcuteFromStore(string stroreName, DGCParameter[] parameters)", ex.Message);
            }
            finally
            {
                cmd.Connection.Close();
                cmd.Dispose();
            }
        }

        public static DataSet ExcuteDataSetFromStore(string stroreName, DGCParameter[] parameters)
        {
            DataSet ds = null;
            Database db = CreateDB();
            try
            {
                DbCommand cmd = db.GetStoredProcCommand(stroreName);
                GenerateQuery.PrepareParametersList(cmd, parameters);
                ds = db.ExecuteDataSet(cmd);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", "ExcuteFromStore(string stroreName, DGCParameter[] parameters)", ex.Message);
            }
            return ds;
        }

        public static int ExcuteIntFromStore(string stroreName, DGCParameter[] parameters)
        {
            DataSet ds = null;
            Database db = CreateDB();
            int ret = 0;
            try
            {
                DbCommand cmd = db.GetStoredProcCommand(stroreName);
                GenerateQuery.PrepareParametersList(cmd, parameters);
                ds = db.ExecuteDataSet(cmd);
                if (ds != null && ds.Tables.Count > 0)
                    ret = ds.Tables.Count;
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", "ExcuteFromStore(string stroreName, DGCParameter[] parameters)", ex.Message);
            }
            return ret;
        }

        public static DataSet ExcuteDataSetFromCmd(string stroreName, DGCParameter[] parameters)
        {
            DataSet ds = null;
            Database db = CreateDB();
            try
            {
                DbCommand cmd = db.GetSqlStringCommand(stroreName);
                GenerateQuery.PrepareParametersList(cmd, parameters);
                ds = db.ExecuteDataSet(cmd);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", "ExcuteFromStore(string stroreName, DGCParameter[] parameters)", ex.Message);
            }
            return ds;
        }

        /// <summary>
        /// Get All by a table in DB with where Clause
        /// </summary>
        /// <param name="obj">a object in Model</param>
        /// <param name="whereClause"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public static DataSet GetAllByDataSet(object obj, string whereClause, DGCParameter[] parameters)
        {
            DataSet ds = null;
            Database db = CreateDB();
            try
            {
                string query = GenerateQuery.CommandTextList(obj, whereClause);
                DbCommand cmd = db.GetSqlStringCommand(query);
                GenerateQuery.PrepareParametersList(cmd, parameters);
                ds = db.ExecuteDataSet(cmd);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("DBHElper", "GetAllByDataSet(object obj, string whereClause, DGCParameter[] parameters)", ex.Message);
            }
            return ds;
        }

        public static DataTable DataTableHasChanges(DataTable dataTable)
        {
            if (dataTable == null)
            {
                return null;
            }
            DataTable changesDataTable = dataTable.GetChanges();
            return changesDataTable;
        }

        public static DataTable makeTable(string tableName)
        {
            // Create a new DataTable.
            DataTable table = new DataTable(tableName);
            // Declare variables for DataColumn and DataRow objects.
            DataColumn column;
            // Create new DataColumn, set DataType, 
            // ColumnName and add to DataTable.    
            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "Value";
            //column.ReadOnly = true;
            //column.Unique = true;
            // Add the Column to the DataColumnCollection.
            table.Columns.Add(column);

            // Create second column.
            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "Name";
            column.AutoIncrement = false;
            column.Caption = "Name";
            column.ReadOnly = false;
            column.Unique = false;
            // Add the column to the table.
            table.Columns.Add(column);
            DataRow row = table.NewRow();
            row["Value"] = string.Empty;
            row["Name"] = "-- Please Select --";
            table.Rows.Add(row);
            return table;
        }

        public static void AddBlankRow(DataTable dt, string fieldText)
        {
            DataRow row = dt.NewRow();
            foreach (DataColumn col in row.Table.Columns)
            {
                if (col.ColumnName.Equals(fieldText, StringComparison.OrdinalIgnoreCase))
                {
                    row[col] = "-- Please Select --";
                }
                //else
                //    row[col] = string.Empty;
            }
            dt.Rows.InsertAt(row, 0);
        }

        public static DataTable makeTablewiththoutblank(string tableName)
        {
            // Create a new DataTable.
            DataTable table = new DataTable(tableName);
            // Declare variables for DataColumn and DataRow objects.
            DataColumn column;
            // Create new DataColumn, set DataType, 
            // ColumnName and add to DataTable.    
            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "Value";
            column.ReadOnly = true;
            column.Unique = true;
            // Add the Column to the DataColumnCollection.
            table.Columns.Add(column);

            // Create second column.
            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "Name";
            column.AutoIncrement = false;
            column.Caption = "Name";
            column.ReadOnly = false;
            column.Unique = false;
            // Add the column to the table.
            table.Columns.Add(column);
            return table;
        }

        public static int ProcessUpdate(DataSet ds, string insert, string update, DGCParameter[] paramInsert, DGCParameter[] paramUpdate)
        {
            Database db = CreateDB();
            int rowsAffected = 0;
            try
            {
                DbCommand cmdInsert = db.GetSqlStringCommand(insert);
                GenerateQuery.PrepareParametersListWithSourceColumn(cmdInsert, paramInsert);
                DbCommand cmdUpdate = db.GetSqlStringCommand(update);
                GenerateQuery.PrepareParametersListWithSourceColumn(cmdUpdate, paramUpdate);
                rowsAffected = db.UpdateDataSet(ds, "Table", cmdInsert, cmdUpdate, null, UpdateBehavior.Transactional);

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", "ExcuteFromCmd(string query, DGCParameter[] parameters)", ex.Message);
            }
            return rowsAffected;
        }

        public static int ProcessUpdate(DataSet ds, string insert, string update, string delete, DGCParameter[] paramInsert, DGCParameter[] paramUpdate, DGCParameter[] paramDelete)
        {
            Database db = CreateDB();
            int rowsAffected = 0;
            try
            {
                DbCommand cmdInsert = db.GetSqlStringCommand(insert);
                GenerateQuery.PrepareParametersListWithSourceColumn(cmdInsert, paramInsert);
                DbCommand cmdUpdate = db.GetSqlStringCommand(update);
                GenerateQuery.PrepareParametersListWithSourceColumn(cmdUpdate, paramUpdate);
                DbCommand cmddelete = db.GetSqlStringCommand(delete);
                GenerateQuery.PrepareParametersListWithSourceColumn(cmddelete, paramDelete);
                rowsAffected = db.UpdateDataSet(ds, "Table", cmdInsert, cmdUpdate, cmddelete, UpdateBehavior.Transactional);

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", "ExcuteFromCmd(string query, DGCParameter[] parameters)", ex.Message);
            }
            return rowsAffected;
        }

        public static int ProcessUpdateStore(DataSet ds, string insert, string update, DGCParameter[] paramInsert, DGCParameter[] paramUpdate, DGCParameter[] paramInsertNotSource)
        {
            return ProcessUpdateStore(ds, insert, update, paramInsert, paramUpdate, paramInsertNotSource, null);
        }

        public static int ProcessUpdateStore(DataSet ds, string insert, string update, DGCParameter[] paramInsert, DGCParameter[] paramUpdate, DGCParameter[] paramInsertNotSource, DGCParameter[] paramUpdateNotSource)
        {
            Database db = CreateDB();
            int rowsAffected = 0;
            try
            {
                DbCommand cmdInsert = db.GetStoredProcCommand(insert);
                GenerateQuery.PrepareParametersListWithSourceColumn(cmdInsert, paramInsert);
                GenerateQuery.PrepareParametersList(cmdInsert, paramInsertNotSource);
                DbCommand cmdUpdate = db.GetStoredProcCommand(update);
                GenerateQuery.PrepareParametersListWithSourceColumn(cmdUpdate, paramUpdate);
                GenerateQuery.PrepareParametersList(cmdUpdate, paramUpdateNotSource);
                rowsAffected = db.UpdateDataSet(ds, "Table", cmdInsert, cmdUpdate, null, UpdateBehavior.Transactional);

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", "ExcuteFromCmd(string query, DGCParameter[] parameters)", ex.Message);
            }
            return rowsAffected;
        }

        public static int ProcessUpdateStore(DataSet ds, string insert, string update, string delete, DGCParameter[] paramInsert, DGCParameter[] paramUpdate, DGCParameter[] paramDelete, DGCParameter[] paramInsertNotSource, DGCParameter[] paramUpdateNotSource)
        {
            Database db = CreateDB();
            int rowsAffected = 0;
            try
            {
                DbCommand cmdInsert = db.GetStoredProcCommand(insert);
                GenerateQuery.PrepareParametersListWithSourceColumn(cmdInsert, paramInsert);
                GenerateQuery.PrepareParametersList(cmdInsert, paramInsertNotSource);
                DbCommand cmdUpdate = db.GetStoredProcCommand(update);
                GenerateQuery.PrepareParametersListWithSourceColumn(cmdUpdate, paramUpdate);
                GenerateQuery.PrepareParametersList(cmdUpdate, paramUpdateNotSource);
                DbCommand cmdDelete = db.GetStoredProcCommand(delete);
                GenerateQuery.PrepareParametersListWithSourceColumn(cmdDelete, paramDelete);
                rowsAffected = db.UpdateDataSet(ds, "Table", cmdInsert, cmdUpdate, cmdDelete, UpdateBehavior.Transactional);
            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("Generic<T>", "ExcuteFromCmd(string query, DGCParameter[] parameters)", ex.Message);
            }
            return rowsAffected;
        }

        public static int ProcessUpdateStoreWithTransaction(DataSet ds, string insert, string update, string delete, DGCParameter[] paramInsert, DGCParameter[] paramUpdate, DGCParameter[] paramDelete, DGCParameter[] paramInsertNotSource, DGCParameter[] paramUpdateNotSource, IFactory factory)
        {
            Database db = CreateDB();
            int rowsAffected = 0;

            DbCommand cmdInsert = factory.MakeCommandFromStore(insert);
            GenerateQuery.PrepareParametersListWithSourceColumn(cmdInsert, paramInsert);
            GenerateQuery.PrepareParametersList(cmdInsert, paramInsertNotSource);
            DbCommand cmdUpdate = factory.MakeCommandFromStore(update);
            GenerateQuery.PrepareParametersListWithSourceColumn(cmdUpdate, paramUpdate);
            GenerateQuery.PrepareParametersList(cmdUpdate, paramUpdateNotSource);
            DbCommand cmdDelete = factory.MakeCommandFromStore(delete);
            GenerateQuery.PrepareParametersListWithSourceColumn(cmdDelete, paramDelete);
            rowsAffected = db.UpdateDataSet(ds, "Table", cmdInsert, cmdUpdate, cmdDelete, factory.GetTransaction());


            return rowsAffected;
        }
        #endregion
    }
}
