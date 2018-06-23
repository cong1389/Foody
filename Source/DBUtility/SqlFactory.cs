using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Data.Common;

namespace Cb.DBUtility
{

    public class SqlFactory : IFactory
    {

        #region Fields
        private string connectionString;
        private DbConnection connection;
        private DbTransaction transaction;
        #endregion Fields

        #region Contructors
        public SqlFactory()
        {
            ConnectionString = ConfigurationManager.ConnectionStrings["SQLConnString1"].ConnectionString;
            connection = MakeConnection();
        }
        #endregion Contructors

        #region Properties
        public static SqlFactory Default
        {
            get { return new SqlFactory(); }
        }

        public string ConnectionString
        {
            set
            {
                this.connectionString = value;
            }
        }
        public DbConnection Connection
        {
            get
            {
                //Debug.Assert(connection != null);
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                return connection;
            }
        }
        #endregion Properties

        #region Methods

        public DbConnection MakeConnection(string connectionString)
        {
            if (connection == null || connection.State == ConnectionState.Closed)
            {
                connection = new SqlConnection(connectionString);
                connection.Open();
            }
            return connection;
        }
        private DbConnection MakeConnection()
        {
            if (connection == null || connection.State == ConnectionState.Closed)
            {
                connection = new SqlConnection(connectionString);
                connection.Open();
            }
            return connection;
        }
        private DbTransaction MakeTransaction()
        {
            if (transaction == null)
            {
                transaction = connection.BeginTransaction();
            }
            return transaction;
        }
        public DbCommand MakeCommand(string command)
        {
            connection = this.MakeConnection();
            DbCommand cm = new SqlCommand(command, connection as SqlConnection);
            if (transaction != null) cm.Transaction = transaction;

            return cm;
        }
        public DbTransaction BeginTransaction()
        {
            return (transaction = Connection.BeginTransaction());
        }
        public void ReleaseTransaction()
        {
            //        if ( transaction != null )
            //          transaction.Dispose();
            transaction = null;
        }
        public void Release()
        {
            ReleaseTransaction();
            if (connection != null)
            {
                connection.Close();
                connection.Dispose();
            }
        }
        public void Rollback()
        {
            if (transaction != null)
                transaction.Rollback();
        }
        public void Commit()
        {
            if (transaction != null)
                transaction.Commit();
        }
        public void ExecuteNonQuery(IDbCommand cm)
        {
            try
            {
                cm.ExecuteNonQuery();
            }

            finally
            {
                cm.Dispose();
            }
        }
        public IDataReader ExecuteReader(IDbCommand cm)
        {
            IDataReader dre = null;
            try
            {
                dre = cm.ExecuteReader();
            }

            finally
            {
                cm.Dispose();
            }
            return dre;
        }
        public object ExecuteScalar(IDbCommand cm)
        {
            object result = null;
            try
            {
                result = cm.ExecuteScalar();
            }
            finally
            {
                cm.Dispose();
            }
            return result;
        }


        public DbCommand MakeCommandFromStore(string nameStore)
        {
            connection = this.MakeConnection();
            DbCommand cm = new SqlCommand(nameStore, connection as SqlConnection);
            cm.CommandType = CommandType.StoredProcedure;
            if (transaction != null) cm.Transaction = transaction;

            return cm;
        }

        public DbTransaction GetTransaction()
        {
            return transaction;
        }
        #endregion Methods



    }
}
