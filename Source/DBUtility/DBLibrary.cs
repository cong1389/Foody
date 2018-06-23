using System;
using System.Data;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Security.Permissions;
using Microsoft.Win32;
using System.Net.Mail;
using System.Drawing;
using System.Windows.Forms;
using System.Drawing.Imaging;
using System.Configuration;

[assembly: RegistryPermissionAttribute(SecurityAction.RequestMinimum,
    ViewAndModify = "HKEY_CURRENT_USER")]

namespace Cb.DBUtility
{
    public class DBLibrary : IDisposable
    {
        public bool connok;
        public SqlConnection conn;
        public string mConnectString = "";

        #region Contructor
        public DBLibrary(string Connect)
        {
            mConnectString = Connect;
        }

        public DBLibrary()
        {
            mConnectString = ConfigurationManager.ConnectionStrings["SQLConnString1"].ConnectionString;
        }
        #endregion

        #region IDisposable Members
        public void Dispose()
        {
            GC.Collect();
        }
        #endregion

        /// Ghi vào EvenLog Windows
        /// </summary>     
        private void WriteToEventLog(Exception objError)
        {
            //*********************************************************************
            //* Purpose:Writing error to the windows event log                    *
            //* Input parameters:                                                 *
            //*                         objError----Exception object                     *
            //* Returns :                                                                                    *
            //*                        nothing                                            *
            //* *******************************************************************            

            System.Diagnostics.EventLog objEventLog = new System.Diagnostics.EventLog();
            objEventLog.Source = "DataAccess Error ....";
            objEventLog.WriteEntry(objError.Message.ToString());
            objEventLog.Dispose();
        }

        /// Kiểm tra kết nối tới Server       
        /// </summary>      
        /// <param name=Tra ve 0 : Ok></param>
        /// <param name=Tra ve -1 : server Khong ton tai></param>
        /// <param name=default -2: khac></param>
        /// <returns>Return the numbers of rows affected</returns>
        public int CheckConnect(string Server, string DataBase, string UserName, string PassWord)
        {
            string Connnectstring = string.Format(
                "server ={0};database={1};uid={2};pwd={3}", Server,
                DataBase, UserName, PassWord);
            try
            {
                SqlConnection con = new SqlConnection(Connnectstring);
                con.Open();
                return 0;//OK
            }
            catch (SqlException obj)
            {
                switch (obj.Number)
                {
                    case 53: return -1; ;//server không tồn tại
                    default: return -2;//Khac;
                }
            }
        }

        public int CheckConnect(string Server, string DataBase, string UserName, string PassWord, bool Windows)
        {
            string Connnectstring = "";
            if (!Windows)
            {
                Connnectstring = string.Format(
                  "server ={0};database={1};uid={2};pwd={3}", Server,
                  DataBase, UserName, PassWord);
            }
            else
            {
                Connnectstring = string.Format("server= {0};database={1};Integrated Security=SSPI", Server, DataBase);
            }

            try
            {
                SqlConnection con = new SqlConnection(Connnectstring);
                con.Open();
                return 0;//OK
            }
            catch (SqlException obj)
            {
                switch (obj.Number)
                {
                    case 53: return -1; ;//server không tồn tại
                    default: return -2;//Khac;
                }
            }
        }

        /// Lấy giờ Server
        /// </summary>  
        public string GetCurrentDate()
        {
            string lngay = "";
            try
            {
                using (SqlConnection lcon = new SqlConnection(mConnectString))
                {
                    SqlCommand cmd = new SqlCommand("select  getdate()", lcon);


                    lcon.Open();
                    lngay = ((DateTime)cmd.ExecuteScalar()).ToShortDateString();
                    lcon.Close();
                    cmd.Dispose();
                }
            }
            catch (Exception obj)
            {
                throw new Exception("Lỗi kết nối :" + obj.ToString());
            }
            return lngay;

        }

        /// Thực thi truy vấn với SQL (INSERT,UPDATE,DELETE)       
        /// </summary>
        /// <param name="strConnect"></param>
        /// <param name="ProcName"></param>
        /// <returns>Return the numbers of rows affected</returns>
        public int RunProc(string ProcName)
        {
            //*********************************************************************
            //* Purpose: Executing  Stored Procedures where UPDATE, INSERT        *
            //*          and DELETE statements are expected but does not          *
            //*          work for select statement is expected.                   *
            //* Input parameters:                                                 *
            //*                      strConnect----Connection string                     *
            //*               ProcName ---StoredProcedures name                   *
            //* Returns :                                                                                    *
            //*                      nothing                                                          *
            //* *******************************************************************            
            string strCommandText = ProcName;
            //create a new Connection object using the connection string
            SqlConnection objConnect = new SqlConnection(mConnectString);
            //create a new Command using the CommandText and Connection object
            SqlCommand objCommand = new SqlCommand(strCommandText, objConnect);
            int returnvalue = -1;
            try
            {
                objConnect.Open();
                returnvalue = objCommand.ExecuteNonQuery();
            }
            catch (Exception objError)
            {
                //write error to the windows event log
                //WriteToEventLog(objError);
                throw new Exception(objError.ToString());
            }
            finally
            {
                objConnect.Close();
                objConnect.Dispose();
                objCommand.Dispose();

            }
            return returnvalue;
        }

        /// Trả về DataView khi thực hiện thủ tục truy vấn (Truyền 3 đối số)
        /// </summary>
        /// <param name="strConnect">Connection string</param>
        /// <param name="ProcName">StoredProcedures name</param>
        /// <param name="TableName">Table name sting</param>
        /// <returns>DataTable contains data</returns>
        public DataView GetDataView(string ProcName, string TableName)
        {

            //*********************************************************************
            //* Purpose: Getting DataReader for the given Procedure               *
            //* Input parameters:                                                 *
            //*                      strConnect----Connection string                     *
            //*               ProcName ---StoredProcedures name                          *
            //*               DataSetTable--DataSetTable name sting               *
            //* Returns :                                                                                    *
            //*                      DataView contains data                       *
            //* ******************************************************************* 

            string strCommandText = ProcName;

            //create a new Connection object using the connection string
            SqlConnection objConnect = new SqlConnection(mConnectString);
            //create a new Command using the CommandText and Connection object
            SqlCommand objCommand = new SqlCommand(strCommandText, objConnect);
            //declare a variable to hold a DataAdaptor object
            SqlDataAdapter objDataAdapter = new SqlDataAdapter();
            DataTable tb;

            try
            {
                //open the connection and execute the command
                objConnect.Open();
                objDataAdapter.SelectCommand = objCommand;
                //objDataReader = objCommand.ExecuteReader()
                tb = new DataTable(TableName);
                objDataAdapter.Fill(tb);
            }
            catch (Exception objError)
            {
                //write error to the windows event log
                //WriteToEventLog(objError);
                throw new Exception(objError.ToString());
            }
            finally
            {
                objConnect.Close();
                objConnect.Dispose();
                objCommand.Dispose();
                objDataAdapter.Dispose();
            }
            return tb.DefaultView;
        }

        /// Trả về DataTable khi thực hiện thủ tục truy vấn (Truyền 3 đối số)
        /// </summary>
        /// <param name="strConnect">Connection string</param>
        /// <param name="ProcName">StoredProcedures name</param>
        /// <param name="TableName">Table name sting</param>
        /// <returns>DataTable contains data</returns>
        public DataTable GetDataTable(string ProcName, string TableName)
        {
            //*********************************************************************
            //* Purpose: Getting DataReader for the given Procedure               *
            //* Input parameters:                                                 *
            //*                      strConnect----Connection string                     *
            //*               ProcName ---StoredProcedures name                          *
            //*               TableName--DataSetTable name sting               *
            //* Returns :                                                                                    *
            //*                      DataView contains data                       *
            //* *******************************************************************            
            string strCommandText = ProcName;
            //create a new Connection object using the connection string
            SqlConnection objConnect = new SqlConnection(mConnectString);
            //create a new Command using the CommandText and Connection object
            SqlCommand objCommand = new SqlCommand(strCommandText, objConnect);
            //declare a variable to hold a DataAdaptor object
            SqlDataAdapter objDataAdapter = new SqlDataAdapter();
            DataTable objDataTable;
            try
            {
                //open the connection and execute the command
                objConnect.Open();
                objDataAdapter.SelectCommand = objCommand;
                //objDataReader = objCommand.ExecuteReader()
                objDataTable = new DataTable(TableName);
                objDataAdapter.Fill(objDataTable);
            }
            catch (Exception objError)
            {
                //write error to the windows event log
                //WriteToEventLog(objError);
                throw new Exception(objError.ToString());
            }
            finally
            {
                objConnect.Close();
                objConnect.Dispose();
                objCommand.Dispose();
                objDataAdapter.Dispose();
            }
            return objDataTable;

        }

        /// Thực thi Transaction (Truyền 3 đối số)
        /// </summary>     
        public void RunProc_transaction(string SQL1, string SQL2)
        {
            using (SqlConnection connection =
            new SqlConnection(mConnectString))
            {
                SqlCommand command = connection.CreateCommand();
                SqlTransaction transaction = null;

                try
                {
                    // BeginTransaction() Requires Open Connection
                    connection.Open();

                    transaction = connection.BeginTransaction();

                    // Assign Transaction to Command
                    command.Transaction = transaction;

                    // Execute 1st Command
                    command.CommandText = SQL1;
                    command.ExecuteNonQuery();

                    // Execute 2nd Command
                    command.CommandText = SQL2;
                    command.ExecuteNonQuery();

                    transaction.Commit();
                }
                catch (Exception obj)
                {
                    transaction.Rollback();
                    throw new Exception(obj.ToString());
                }
                finally
                {
                    connection.Close();
                }


            }
        }

        /// Thực thi Transaction (Truyền 4 đối số)
        /// </summary>     
        public void RunProc_transaction(string SQL1, string SQL2, string SQL3)
        {
            using (SqlConnection connection =
            new SqlConnection(mConnectString))
            {
                SqlCommand command = connection.CreateCommand();
                SqlTransaction transaction = null;

                try
                {
                    // BeginTransaction() Requires Open Connection
                    connection.Open();

                    transaction = connection.BeginTransaction();

                    // Assign Transaction to Command
                    command.Transaction = transaction;

                    // Execute 1st Command
                    command.CommandText = SQL1;
                    command.ExecuteNonQuery();

                    // Execute 2nd Command
                    command.CommandText = SQL2;
                    command.ExecuteNonQuery();

                    // Execute 3rd Command
                    command.CommandText = SQL3;
                    command.ExecuteNonQuery();


                    transaction.Commit();
                }
                catch (Exception obj)
                {
                    transaction.Rollback();
                    throw new Exception(obj.ToString());
                }
                finally
                {
                    connection.Close();
                }


            }
        }

        /// Tìm chuỗi dữ liệu dòng đầu tiên của cột đầu tiên 
        /// </summary>
        /// <param name="strConnect"></param>
        /// <param name="strSQL"></param>
        /// <returns></returns>
        public string Timten(string strSQL)
        {
            object returnvalue;

            using (SqlConnection lcon = new SqlConnection(mConnectString))
            {
                SqlCommand cmd = new SqlCommand(strSQL, lcon);

                try
                {
                    lcon.Open();
                    returnvalue = cmd.ExecuteScalar();
                    lcon.Close();
                    cmd.Dispose();
                }
                catch (Exception obj)
                {
                    throw new Exception("Lỗi truy vấn :" + obj.ToString());

                }
            }

            if (returnvalue != null && returnvalue != DBNull.Value)
                return returnvalue.ToString();
            else
                return "";
        }

        /// Trả về kết quả dòng đầu tiên của cột đầu tiên
        /// </summary>
        /// <param name="strConnect"></param>
        /// <param name="strSQL"></param>
        /// <returns></returns>
        public object GetObject(string strSQL)
        {
            object lketqua;
            using (SqlConnection lcon = new SqlConnection(mConnectString))
            {
                SqlCommand cmd = new SqlCommand(strSQL, lcon);

                try
                {
                    lcon.Open();
                    lketqua = cmd.ExecuteScalar();
                    lcon.Close();
                    cmd.Dispose();
                }
                catch (Exception obj)
                {
                    throw new Exception("Lỗi truy vấn :" + obj.ToString());
                }
            }
            return lketqua;
        }

        /// Trả về kết quả dòng đầu tiên của cột đầu tiên kiểu số kiểu double
        /// </summary>
        /// <param name="strConnect"></param>
        /// <param name="strSQL"></param>
        /// <returns></returns>
        public double Timso(string strSQL)
        {
            object returnvalue;
            //			
            using (SqlConnection lcon = new SqlConnection(mConnectString))
            {
                SqlCommand cmd = new SqlCommand(strSQL, lcon);

                try
                {
                    lcon.Open();
                    returnvalue = cmd.ExecuteScalar();
                    lcon.Close();
                    cmd.Dispose();
                }
                catch (Exception obj)
                {
                    throw new Exception("Lỗi truy vấn :" + obj.ToString());
                }
            }
            if (returnvalue == null || returnvalue == DBNull.Value)
                return 0;

            return Convert.ToDouble(returnvalue);

        }

        /// Trả về kết quả dòng đầu tiên của cột đầu tiên kiểu số kiểu int
        /// </summary>
        /// <param name="strConnect"></param>
        /// <param name="strSQL"></param>
        /// <returns></returns>
        public int Timso_int(string strSQL)
        {
            object returnvalue;
            using (SqlConnection lcon = new SqlConnection(mConnectString))
            {
                SqlCommand cmd = new SqlCommand(strSQL, lcon);

                try
                {
                    lcon.Open();
                    returnvalue = cmd.ExecuteScalar();
                    lcon.Close();
                    cmd.Dispose();
                }
                catch (Exception obj)
                {
                    throw new Exception("Lỗi truy vấn :" + obj.ToString());
                }
            }
            if (returnvalue == null || returnvalue == DBNull.Value)
                return 0;

            return Convert.ToInt32(returnvalue);

        }
        public double Timso_double(string strSQL)
        {
            object returnvalue;
            using (SqlConnection lcon = new SqlConnection(mConnectString))
            {
                SqlCommand cmd = new SqlCommand(strSQL, lcon);

                try
                {
                    lcon.Open();
                    returnvalue = cmd.ExecuteScalar();
                    lcon.Close();
                    cmd.Dispose();
                }
                catch (Exception obj)
                {
                    throw new Exception("Lỗi truy vấn :" + obj.ToString());
                }
            }
            if (returnvalue == null || returnvalue == DBNull.Value)
                return 0;

            return Convert.ToDouble(returnvalue);

        }
        /// Đếm số dòng khi thực hiện truy vấn SQL
        /// </summary>
        /// <param name="lfilexml"></param>
        /// <param name="ltablename"></param>
        /// <returns></returns>
        public int CountRecord(string strSQL)
        {
            return GetDataTable(strSQL, "countrc").Rows.Count;
        }

        public DataTable AutoNumberedTable(DataTable SourceTable)
        {
            DataTable ResultTable = new DataTable();
            DataColumn AutoNumberColumn = new DataColumn();
            AutoNumberColumn.ColumnName = "STT";
            AutoNumberColumn.DataType = typeof(int);
            AutoNumberColumn.AutoIncrement = true;
            AutoNumberColumn.AutoIncrementSeed = 1;
            AutoNumberColumn.AutoIncrementStep = 1;
            ResultTable.Columns.Add(AutoNumberColumn);
            ResultTable.Merge(SourceTable);
            return ResultTable;

        }


        private List<string> GetParameter(string Chuoi)
        {
            int vitri = Chuoi.IndexOf('@');
            if (vitri == -1)
                return null;
            string lchuoi = Chuoi.Substring(vitri).Replace(',', ' ').Replace(')', ' ').Replace('(', ' ');
            string tmp = "";
            bool isget = false;
            List<string> lmang = new List<string>();
            vitri = 0;
            foreach (char c in lchuoi)
            {
                if (c == '@')
                {
                    isget = true;
                    vitri++;
                }
                else
                {
                    if (c == ' ')
                    {
                        if (tmp != "")
                            lmang.Add("@" + tmp);
                        isget = false;
                        tmp = "";
                    }
                    else
                    {
                        if (isget)
                            tmp += c.ToString();
                    }
                }

            }
            if (vitri > lmang.Count)
            {
                lmang.Add("@" + tmp);
            }
            return lmang;
        }
        public DataTable GetDataTable(string Sql, params object[] ListParam)
        {
            DataTable tb = new DataTable();
            SqlConnection objConnect = new SqlConnection(mConnectString);
            SqlCommand objCommand = new SqlCommand(Sql, objConnect);
            List<string> lmang = GetParameter(Sql);
            if (lmang != null)
            {
                if (lmang.Count > ListParam.Length)
                    throw new Exception("Giá trị tham số truyền không đủ : \n" + Sql);
                for (int i = 0; i < lmang.Count; i++)
                    objCommand.Parameters.AddWithValue(lmang[i], ListParam[i]);
            }
            try
            {
                using (SqlDataAdapter adt = new SqlDataAdapter(objCommand))
                {
                    adt.Fill(tb);
                }
            }
            catch (Exception objError)
            {
                throw new Exception(objError.ToString());
            }
            finally
            {
                objConnect.Close();
                objConnect.Dispose();
                objCommand.Dispose();
            }
            return tb;
        }


        public bool SendEmail_(string UserName, string Password, string MailTo, string Subject, string Body, string SmtpServer)
        {
            bool value = false;
            try
            {
                System.Net.NetworkCredential _Credential = new System.Net.NetworkCredential(UserName, Password);
                System.Net.Mail.MailMessage _MailMessage = new MailMessage();
                _MailMessage.To.Add(MailTo);
                _MailMessage.Subject = Subject;
                _MailMessage.From = new System.Net.Mail.MailAddress(UserName);
                _MailMessage.Body = Body;

                //Chup anh man hinh Error
                Bitmap bmpScreenshot;
                Graphics gfxScreenshot;
                bmpScreenshot = new Bitmap(Screen.PrimaryScreen.Bounds.Width, Screen.PrimaryScreen.Bounds.Height, PixelFormat.Format32bppArgb);
                gfxScreenshot = Graphics.FromImage(bmpScreenshot);
                gfxScreenshot.CopyFromScreen(Screen.PrimaryScreen.Bounds.X, Screen.PrimaryScreen.Bounds.Y, 0, 0, Screen.PrimaryScreen.Bounds.Size, CopyPixelOperation.SourceCopy);
                bmpScreenshot.Save(Application.StartupPath + "\\image.png", ImageFormat.Png);
                string ImagePath = Application.StartupPath + "\\image.png";
                /////
                Attachment attach = new Attachment(ImagePath);
                _MailMessage.Attachments.Add(attach);

                System.Net.Mail.SmtpClient _SmtpClient = new System.Net.Mail.SmtpClient(SmtpServer);// ("smtp.gmail.com");
                _SmtpClient.UseDefaultCredentials = false;
                _SmtpClient.Credentials = _Credential;
                //IF USING GMAIL THEN ENABLE
                //_SmtpClient.EnableSsl = true;
                //_SmtpClient.Port = 587;
                _SmtpClient.Send(_MailMessage);
                value = true;
            }
            catch (Exception)
            {
                value = false;
            }
            return value;
        }

        public bool SendEmail_(string UserName, string Password, string MailTo, string Subject, string Body, string SmtpServer, string FilePath)
        {
            bool value = false;
            try
            {
                System.Net.NetworkCredential _Credential = new System.Net.NetworkCredential(UserName, Password);
                System.Net.Mail.MailMessage _MailMessage = new MailMessage();
                _MailMessage.To.Add(MailTo);
                _MailMessage.Subject = Subject;
                _MailMessage.From = new System.Net.Mail.MailAddress(UserName);
                _MailMessage.Body = Body;

                //Chup anh man hinh Error
                //Bitmap bmpScreenshot;
                //Graphics gfxScreenshot;
                //bmpScreenshot = new Bitmap(Screen.PrimaryScreen.Bounds.Width, Screen.PrimaryScreen.Bounds.Height, PixelFormat.Format32bppArgb);
                //gfxScreenshot = Graphics.FromImage(bmpScreenshot);
                //gfxScreenshot.CopyFromScreen(Screen.PrimaryScreen.Bounds.X, Screen.PrimaryScreen.Bounds.Y, 0, 0, Screen.PrimaryScreen.Bounds.Size, CopyPixelOperation.SourceCopy);
                //bmpScreenshot.Save(Application.StartupPath + "\\image.png", ImageFormat.Png);
                //string ImagePath = Application.StartupPath + "\\image.png";
                /////
                Attachment attach = new Attachment(FilePath);
                _MailMessage.Attachments.Add(attach);

                System.Net.Mail.SmtpClient _SmtpClient = new System.Net.Mail.SmtpClient(SmtpServer);// ("smtp.gmail.com");
                _SmtpClient.UseDefaultCredentials = false;
                _SmtpClient.Credentials = _Credential;
                //IF USING GMAIL THEN ENABLE
                //_SmtpClient.EnableSsl = true;
                //_SmtpClient.Port = 587;
                //IF USING Yahoo THEN ENABLE
                //_SmtpClient.EnableSsl = true;
                //_SmtpClient.Port = 465;
                _SmtpClient.Send(_MailMessage);
                value = true;
            }
            catch (Exception)
            {
                value = false;
            }
            return value;
        }





    }
}