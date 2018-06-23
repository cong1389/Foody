using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Globalization;
using System.Reflection;


namespace Cb.DBUtility
{
    public class DBConvert
    {
        private const Int16 SMALLINT_MIN_VALUE = Int16.MinValue;
        private const byte BYTE_MIN_VALUE = byte.MinValue;
        private const int INT_MIN_VALUE = int.MinValue;
        private const long LONG_MIN_VALUE = long.MinValue;
        private const double DOUBLE_MIN_VALUE = double.MinValue;
        private const decimal DECIMAL_MIN_VALUE = decimal.MinValue;
        private static DateTime DATETIME_MIN_VALUE = DateTime.MinValue;
        private static TimeSpan TIMESPAN_MIN_VALUE = TimeSpan.MinValue;
        private static char CHAR_MIN_VALUE = char.MinValue;

        #region Parse Value Before Save To DB
        /// <summary>
        /// Parse a object value to data type
        /// </summary>
        /// <param name="value">A int value to parse</param>
        /// <returns>A object value</returns>
        public static object ParseToDBValue(object _value)
        {
            if (_value == null) return null;

            Type type = _value.GetType();

            if (type == typeof(System.Char))
            {
                return ParseToDBValue((char)_value);
            }
            if (type == typeof(System.String))
            {
                return ParseToDBValue((string)_value);
            }
            if (type == typeof(System.Byte))
            {
                return ParseToDBValue((Byte)_value);
            }
            if (type == typeof(System.Int16))
            {
                return ParseToDBValue((Int16)_value);
            }
            if (type == typeof(System.Int32))
            {
                return ParseToDBValue((int)_value);
            }
            if (type == typeof(System.Int64))
            {
                return ParseToDBValue((long)_value);
            }
            if (type == typeof(System.Decimal))
            {
                return ParseToDBValue((decimal)_value);
            }
            if (type == typeof(System.Double))
            {
                return ParseToDBValue((double)_value);
            }
            if (type == typeof(System.DateTime))
            {
                return ParseToDBValue((DateTime)_value);
            }
            if (type == typeof(System.Boolean))
            {
                return ParseToDBValue((bool)_value);
            }
            return null;
        }
        /// <summary>
        /// Parse a int16 value to data type
        /// </summary>
        /// <param name="value">A int value to parse</param>
        /// <returns>A object value</returns>
        public static object ParseToDBValue(Int16 value)
        {
            return (value == SMALLINT_MIN_VALUE) ? DBNull.Value : (object)value;
        }
        /// <summary>
        /// Parse a int value to data type
        /// </summary>
        /// <param name="value">A int value to parse</param>
        /// <returns>A object value</returns>
        public static object ParseToDBValue(int value)
        {
            return (value == INT_MIN_VALUE) ? DBNull.Value : (object)value;
        }
        /// <summary>
        /// Parse a long value to data type
        /// </summary>
        /// <param name="value">A long value to parse</param>
        /// <returns>A object value</returns>
        public static object ParseToDBValue(long value)
        {
            return (value == LONG_MIN_VALUE) ? DBNull.Value : (object)value;
        }
        /// <summary>
        /// Parse a double value to data type
        /// </summary>
        /// <param name="value">A double value to parse</param>
        /// <returns>A object value</returns>
        public static object ParseToDBValue(double value)
        {
            return (value == DOUBLE_MIN_VALUE) ? DBNull.Value : (object)value;
        }
        /// <summary>
        /// Parse a decimal value to data type
        /// </summary>
        /// <param name="value">A decimal value to parse</param>
        /// <returns>A object value</returns>
        public static object ParseToDBValue(decimal value)
        {
            return (value == DECIMAL_MIN_VALUE) ? DBNull.Value : (object)value;
        }
        /// <summary>
        /// Parse a DateTime value to data type
        /// </summary>
        /// <param name="value">A DateTime value to parse</param>
        /// <returns>A object value</returns>
        public static object ParseToDBValue(DateTime value)
        {
            return (value == DATETIME_MIN_VALUE) ? DBNull.Value : (object)value;
        }
        /// <summary>
        /// Parse a string value to data type
        /// </summary>
        /// <param name="value">A string value to parse</param>
        /// <returns>A object value</returns>
        public static object ParseToDBValue(string value)
        {
            return (value == null || value == string.Empty) ? DBNull.Value : (object)value;
        }
        /// <summary>
        /// Parse a char value to data type
        /// </summary>
        /// <param name="value">A char value to parse</param>
        /// <returns>A object value</returns>
        public static object ParseToDBValue(char value)
        {
            return (value == CHAR_MIN_VALUE) ? DBNull.Value : (object)value;
        }
        /// <summary>
        /// Parse a bool value to data type
        /// </summary>
        /// <param name="value">A int value to parse</param>
        /// <returns>A object value</returns>
        public static object ParseToDBValue(bool value)
        {
            return (object)value;
        }

        #endregion

        #region Parse Data Value to Value Type
        public static byte ParseDBToByte(IDataReader dre, string column)
        {
            int check = INT_MIN_VALUE;
            byte result = BYTE_MIN_VALUE;
            try
            {
                check = dre.IsDBNull(dre.GetOrdinal(column)) ? BYTE_MIN_VALUE : 1;
                if (check > 0)
                {
                    result = byte.Parse(dre.GetString(dre.GetOrdinal(column)));
                }
            }
            catch (Exception e)
            {
                //Cb.Debug.DebugPrint("DbConvert function ParseDBToInt", e.Message);
            }
            return result;
        }

        public static int ParseDBToInt(IDataReader dre, string column)
        {
            int result = INT_MIN_VALUE;
            try
            {
                result = dre.IsDBNull(dre.GetOrdinal(column)) ?
                INT_MIN_VALUE : int.Parse(dre.GetInt32(dre.GetOrdinal(column)).ToString());
            }
            catch (Exception e)
            {
                //Cb.Debug.DebugPrint("DbConvert function ParseDBToInt", e.Message);
            }
            return result;
        }
        public static Int16 ParseDBToSmallInt(IDataReader dre, string column)
        {

            Int16 result = SMALLINT_MIN_VALUE;
            try
            {
                result = dre.IsDBNull(dre.GetOrdinal(column)) ?
                SMALLINT_MIN_VALUE : dre.GetInt16(dre.GetOrdinal(column));
            }
            catch (Exception e)
            {
                //Cb.Debug.DebugPrint("DbConvert function ParseDBToSmallInt", e.Message);
            }
            return result;
        }
        public static long ParseDBToLong(IDataReader dre, string column)
        {
            long result = long.MinValue;
            try
            {
                result = dre.IsDBNull(dre.GetOrdinal(column)) ?
                LONG_MIN_VALUE : dre.GetInt64(dre.GetOrdinal(column));
            }
            catch (Exception e)
            {
                //Cb.Debug.DebugPrint("DbConvert function ParseDBToLong", e.Message);
            }
            return result;
        }
        public static double ParseDBToDouble(IDataReader dre, string column)
        {
            double result = double.MinValue;
            try
            {
                result = dre.IsDBNull(dre.GetOrdinal(column)) ?
                DOUBLE_MIN_VALUE : dre.GetDouble(dre.GetOrdinal(column));
            }
            catch (Exception e)
            {
                //Cb.Debug.DebugPrint("DbConvert function ParseDBToDouble", e.Message);
            }
            return result;
        }
        public static decimal ParseDBToDecimal(IDataReader dre, string column)
        {
            decimal result = decimal.MinValue;
            try
            {
                result = dre.IsDBNull(dre.GetOrdinal(column)) ?
                DECIMAL_MIN_VALUE : dre.GetDecimal(dre.GetOrdinal(column));
            }
            catch (Exception e)
            {
                //Cb.Debug.DebugPrint("DbConvert function ParseDBToDecimal", e.Message);
            }
            return result;
        }
        public static DateTime ParseDBToDateTime(IDataReader dre, string column)
        {
            DateTime result = DateTime.MinValue;
            try
            {
                result = dre.IsDBNull(dre.GetOrdinal(column)) ?
                DATETIME_MIN_VALUE : dre.GetDateTime(dre.GetOrdinal(column));
            }
            catch (Exception e)
            {
                //Cb.Debug.DebugPrint("DbConvert function ParseDBToDateTime", e.Message);
            }
            return result;
        }
        public static string ParseDBToString(IDataReader dre, string column)
        {
            string result = string.Empty;
            try
            {
                result = dre.IsDBNull(dre.GetOrdinal(column)) ?
                  string.Empty : dre.GetString(dre.GetOrdinal(column));
            }
            catch (Exception e)
            {
                //Cb.Debug.DebugPrint("DbConvert function ParseDBToString", e.Message);
            }
            return result;
        }
        public static char ParseDBToChar(IDataReader dre, string column)
        {
            char result = char.MinValue;
            try
            {
                result = dre.IsDBNull(dre.GetOrdinal(column)) ?
                CHAR_MIN_VALUE : char.Parse(dre.GetString(dre.GetOrdinal(column)));
            }
            catch (Exception e)
            {
                //Cb.Debug.DebugPrint("DbConvert function ParseDBToChar", e.Message);
            }
            return result;
        }


        public static object ParseDBToObject(IDataReader dre, PropertyInfo property)
        {
            object result = null;
            Type t = property.PropertyType;

            switch (Type.GetTypeCode(t))
            {
                case TypeCode.Int32:
                    result = INT_MIN_VALUE;
                    break;
                case TypeCode.String:
                    result = string.Empty;
                    break;
                case TypeCode.Double:
                    result = DOUBLE_MIN_VALUE;
                    break;
                case TypeCode.DateTime:
                    result = DATETIME_MIN_VALUE;
                    break;
                case TypeCode.Decimal:
                    result = DECIMAL_MIN_VALUE;
                    break;
                case TypeCode.Int16:
                    result = SMALLINT_MIN_VALUE;
                    break;
                case TypeCode.Byte:
                    result = BYTE_MIN_VALUE;
                    break;
                case TypeCode.Char:
                    result = TIMESPAN_MIN_VALUE;
                    break;
                case TypeCode.Boolean:
                    result = false;
                    break;
            }

            try
            {
                //truong hop ten file giong ten properties va them chu Desc
                if (HasCoulmn(dre, property.Name) && !dre.IsDBNull(dre.GetOrdinal(property.Name)))
                    result = dre.GetValue(dre.GetOrdinal(property.Name));
                else
                {
                    string propertyNameDesc = property.Name.Replace("Desc", string.Empty);
                    if (HasCoulmn(dre, propertyNameDesc) && !dre.IsDBNull(dre.GetOrdinal(propertyNameDesc)))
                        result = dre.GetValue(dre.GetOrdinal(propertyNameDesc));
                }

            }
            catch (Exception ex)
            {
                Write2Log.WriteLogs("DBConvert", "ParseDBToObject(IDataReader dre, PropertyInfo property)", ex.Message);
            }
            if (result != null && result.GetType() == typeof(byte[]))
            {
                result = ConvertByteArrToObject((byte[])result, Type.GetTypeCode(t));
            }
            return result;
        }

        private static object ConvertByteArrToObject(byte[] o, TypeCode t)
        {
            object re = o;
            switch (t)
            {

                case TypeCode.String:
                    re = System.Text.UTF8Encoding.UTF8.GetString(o);
                    break;

            }
            return re;
        }

        private static bool HasCoulmn(IDataReader dre, string column)
        {
            bool re = false;
            try
            {
                re = dre.GetOrdinal(column) >= 0;
            }
            catch (Exception ex)
            {
                re = false;
            }
            return re;
        }
        # endregion

        #region Parse 1 Value To other value type
        public static string ParseString(byte value)
        {
            return (value == BYTE_MIN_VALUE) ? string.Empty : value.ToString();
        }
        public static string ParseString(Int16 value)
        {
            return (value == SMALLINT_MIN_VALUE) ? string.Empty : value.ToString();
        }
        public static string ParseString(int value)
        {
            return (value == INT_MIN_VALUE) ? string.Empty : value.ToString();
        }
        public static string ParseString(long value)
        {
            return (value == LONG_MIN_VALUE) ? string.Empty : value.ToString();
        }
        public static string ParseString(double value)
        {
            return (value == DOUBLE_MIN_VALUE) ? string.Empty : value.ToString();
        }
        public static string ParseString(decimal value)
        {
            return (value == DECIMAL_MIN_VALUE) ? string.Empty : value.ToString();
        }
        public static string ParseString(DateTime value, string format)
        {
            return (value == DATETIME_MIN_VALUE) ? string.Empty : value.ToString(format);
        }
        public static string ParseString(char value)
        {
            return (value == CHAR_MIN_VALUE) ? string.Empty : value.ToString();
        }
        public static string ParseString(object value)
        {
            string result;
            try
            {
                Type t = value.GetType();
                switch (Type.GetTypeCode(t))
                {
                    case TypeCode.Byte:
                        result = ParseString((byte)value);
                        break;
                    case TypeCode.Char:
                        result = ParseString((char)value);
                        break;
                    case TypeCode.Decimal:
                        result = ParseString((decimal)value);
                        break;
                    case TypeCode.Double:
                        result = ParseString((double)value);
                        break;
                    case TypeCode.Int16:
                        result = ParseString((Int16)value);
                        break;
                    case TypeCode.Int32:
                        result = ParseString((int)value);
                        break;
                    case TypeCode.Int64:
                        result = ParseString((long)value);
                        break;
                    default:

                        result = value.ToString();

                        break;
                }
            }
            catch (Exception ex)
            {
                result = string.Empty;
            }
            return result;
        }
        public static byte ParseByte(string value)
        {
            byte result;
            value = value.Replace(",", "").Trim();
            try { result = byte.Parse(value); }
            catch { result = BYTE_MIN_VALUE; }
            return result;
        }



        public static byte ParseByte(object value)
        {
            byte result;
            try { result = value != null ? Convert.ToByte(value) : byte.MinValue; }
            catch { result = byte.MinValue; }
            return result;
        }
        public static Int16 ParseSmallInt(string value)
        {
            Int16 result;
            value = value.Replace(",", "").Trim();
            try { result = Int16.Parse(value); }
            catch { result = SMALLINT_MIN_VALUE; }
            return result;
        }
        public static int ParseInt(string value)
        {
            int result;
            value = value.Replace(",", "").Trim();
            try { result = int.Parse(value); }
            catch { result = INT_MIN_VALUE; }
            return result;
        }

        public static int ParseInt(object value)
        {
            int result;
            //value = value.Replace(",", "").Trim();
            try { result = value != null ? Convert.ToInt32(value) : INT_MIN_VALUE; }
            catch { result = INT_MIN_VALUE; }
            return result;
        }

        public static long ParseLong(string value)
        {
            long result;
            value = value.Replace(",", "").Trim();
            try { result = long.Parse(value); }
            catch { result = LONG_MIN_VALUE; }
            return result;
        }
        public static double ParseDouble(string value)
        {
            double result;
            //value = value.Replace(",", "").Trim();
            try { result = double.Parse(value); }
            catch { result = DOUBLE_MIN_VALUE; }
            return result;
        }


        public static double ParseDouble(object value)
        {
            double result;
            try { result = Convert.ToDouble(value); }
            catch { result = DOUBLE_MIN_VALUE; }
            return result;
        }

        public static decimal ParseDecimal(string value)
        {
            decimal result;
            value = value.Replace(",", "").Trim();
            try { result = decimal.Parse(value); }
            catch { result = DECIMAL_MIN_VALUE; }
            return result;
        }

        public static decimal ParseDecimal(object value)
        {
            decimal result;
            //value = value.Replace(",", "").Trim();
            try { result = value != null ? Convert.ToDecimal(value) : DECIMAL_MIN_VALUE; }
            catch { result = DECIMAL_MIN_VALUE; }
            return result;
        }

        public static DateTime ParseDateTime(string value, string format)
        {
            DateTime result;
            DateTimeFormatInfo info;
            info = (DateTimeFormatInfo)CultureInfo.CurrentUICulture.DateTimeFormat.Clone();
            info.ShortDatePattern = format;
            info.FullDateTimePattern = format;
            try { result = DateTime.Parse(value, info); }
            catch { result = DATETIME_MIN_VALUE; }
            return result;
        }

        public static bool ParseBool(object value)
        {
            bool result;
            try { result = value != null ? Convert.ToBoolean(value) : false; }
            catch { result = false; }
            return result;
        }

        public static bool? ParseNullableBool(object value)
        {
            bool? result;
            try { result = (Nullable<Boolean>)value; }
            catch { result = null; }
            return result;
        }

        public static double ParseDoubleToPorC(string value)
        {
            double result;
            value = value.Replace("%", "").Trim();
            value = value.Replace("₫", "").Trim();
            value = value.Replace("$", "").Trim();
            try { result = double.Parse(value); }
            catch { result = DOUBLE_MIN_VALUE; }
            return result;
        }

        public static string trimLangue(string value)
        {
            //string result="";
            value = value.Replace(".", "").Trim();
            value = value.Replace(",", "").Trim();
            value = value.Replace("/", "").Trim();
            value = value.Replace("?", "").Trim();
            value = value.Replace("html", "").Trim();
            return value;
            //return (result==value) ? string.Empty : value.ToString();
        }
        #endregion
    }
}
