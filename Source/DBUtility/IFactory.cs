using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using System.Data;

namespace Cb.DBUtility
{
    public interface IFactory
    {
        DbConnection MakeConnection(string connectionString);
        DbCommand MakeCommand(string command);
        DbTransaction BeginTransaction();
        void ReleaseTransaction();
        void Release();
        void Rollback();
        void Commit();
        void ExecuteNonQuery(IDbCommand cm);
        IDataReader ExecuteReader(IDbCommand cm);
        object ExecuteScalar(IDbCommand cm);
        DbCommand MakeCommandFromStore(string nameStore);
        DbTransaction GetTransaction();
    }
}
