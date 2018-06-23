using System;
using System.Collections.Generic;
using System.Data;
using System.Collections;
using System.Linq;
using System.Text;

namespace Cb.DBUtility
{
    public class DGCParameter
    {

        private string parameterName;
        private DbType dbType;
        private int size;
        private object value;
        private ParameterDirection direction;
        private string sourceColumn;
        private DataRowVersion sourceVersion;



        public DGCParameter() { }

        public DGCParameter(string parameterName, DbType type, object value)
        {
            this.parameterName = parameterName;
            this.dbType = type;
            this.value = value;
            this.direction = ParameterDirection.Input;
        }
        public DGCParameter(string parameterName, DbType type, int size, object value)
        {
            this.parameterName = parameterName;
            this.dbType = type;
            this.value = value;
            this.size = size;
            this.direction = ParameterDirection.Input;
        }

        public DGCParameter(string parameterName, DbType type, object value, ParameterDirection direction)
        {
            this.parameterName = parameterName;
            this.dbType = type;
            this.value = value;
            this.direction = direction;
        }

        public DGCParameter(string parameterName, DbType type, string sourceColumn, DataRowVersion sourceVersion)
        {
            this.parameterName = parameterName;
            this.dbType = type;
            this.sourceColumn = sourceColumn;
            this.sourceVersion = sourceVersion;
        }
      
        public DGCParameter(string parameterName, DbType type, int size,string sourceColumn, DataRowVersion sourceVersion)
        {
            this.parameterName = parameterName;
            this.dbType = type;
            this.sourceColumn = sourceColumn;
            this.sourceVersion = sourceVersion;
            this.size = size;
        }

        public string ParameterName
        {
            get { return this.parameterName; }
            set { this.parameterName = value; }
        }
        public DbType DbType
        {
            get { return this.dbType; }
            set { this.dbType = value; }
        }
        public int Size
        {
            get { return this.size; }
            set { this.size = value; }
        }
        public object Value
        {
            get { return this.value; }
            set { this.value = value; }
        }

        public ParameterDirection Direction
        {
            get { return direction; }
            set { direction = value; }
        }

        public DataRowVersion SourceVersion
        {
            get { return sourceVersion; }
            set { sourceVersion = value; }
        }

        public string SourceColumn
        {
            get { return sourceColumn; }
            set { sourceColumn = value; }
        }

    }

    /// <summary>
    /// Summary description for DataParameter.
    /// </summary>
    public class DGCDataParameter
    {

        #region Fields
        public const byte NameLength = 100;
        public const byte AddressLength = 100;
        public const byte CharacterLength = 1;
        public const byte UserNameLength = 50;
        #endregion Fields

        public DGCDataParameter() { }

        public static void AddParameter(IDbCommand cm, string parameterName, DbType type, int size, object value)
        {
            IDbDataParameter para = cm.CreateParameter();
            para.ParameterName = parameterName;
            para.DbType = type;
            para.Size = size;
            para.Value = value != null ? value : DBNull.Value;
            cm.Parameters.Add(para);
        }

        public static void AddParameter(IDbCommand cm, string parameterName, DbType type, object value)
        {
            IDbDataParameter para = cm.CreateParameter();
            para.ParameterName = parameterName;
            para.DbType = type;
            para.Value = value != null ? value : DBNull.Value;
            cm.Parameters.Add(para);
        }

        public static void AddParameter(IDbCommand cm, string parameterName, DbType type, object value, ParameterDirection direction)
        {
            IDbDataParameter para = cm.CreateParameter();
            para.ParameterName = parameterName;
            para.DbType = type;
            para.Value = value != null ? value : DBNull.Value;
            para.Direction = direction;
            cm.Parameters.Add(para);
        }

        public static void AddParameter(IDbCommand cm, ParameterDirection direction, string parameterName, DbType type, int size, object value)
        {
            IDbDataParameter para = cm.CreateParameter();
            para.ParameterName = parameterName;
            para.DbType = type;
            para.Size = size;
            para.Value = value;
            para.Direction = direction;
            cm.Parameters.Add(para);
        }

        public static void AddParameter(IDbCommand cm, IDbDataParameter _param)
        {
            IDbDataParameter para = cm.CreateParameter();
            para.ParameterName = _param.ParameterName;
            para.DbType = _param.DbType;
            para.Value = _param.Value;
            para.Size = _param.Size;
            cm.Parameters.Add(para);
        }

        public static void AddParameter(IDbCommand cm, ParameterDirection direction, string parameterName, DbType type, object value)
        {
            IDbDataParameter para = cm.CreateParameter();
            para.ParameterName = parameterName;
            para.DbType = type;
            para.Value = value != null ? value : DBNull.Value;
            para.Direction = direction;
            cm.Parameters.Add(para);
        }

       
        public static void AddParameter(IDbCommand cm, string parameterName, DbType type, string sourceColumn, DataRowVersion sourceVersion)
        {
            IDbDataParameter para = cm.CreateParameter();
            para.ParameterName = parameterName;
            para.DbType = type;
            para.SourceColumn = sourceColumn;
            para.SourceVersion = sourceVersion;
            cm.Parameters.Add(para);
        }

        public static void AddParameter(IDbCommand cm, string parameterName, DbType type, int size, string sourceColumn, DataRowVersion sourceVersion)
        {
            IDbDataParameter para = cm.CreateParameter();
            para.ParameterName = parameterName;
            para.DbType = type;
            para.SourceColumn = sourceColumn;
            para.SourceVersion = sourceVersion;
            para.Size = size;
            cm.Parameters.Add(para);
        }
    }
}
