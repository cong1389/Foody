using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Configuration;
using System.Windows.Forms;
using System.Web;

namespace Cb.DBUtility
{
    public static class Write2Log
    {
        public static string LogFolder = Path.Combine(HttpContext.Current.Request.PhysicalApplicationPath, "log");
        public static string LogFileName = "error.log";
        public static void WriteLogs(string sClassName, string sFunctionName, string sError)
        {
            try
            {

                if (!Directory.Exists(Write2Log.LogFolder))
                {
                    Directory.CreateDirectory(Write2Log.LogFolder);
                }
                StreamWriter swFromFile = new StreamWriter(Path.Combine(Write2Log.LogFolder, Write2Log.LogFileName), true);
                swFromFile.WriteLine("--------------------------------------------------------------------------------");
                swFromFile.WriteLine("[Date & Time]\t\t" + DateTime.Now + "");
                swFromFile.WriteLine("[Classes Name]\t\t" + sClassName.Trim() + "");
                swFromFile.WriteLine("[Functions Name]\t" + sFunctionName.Trim() + "");
                swFromFile.WriteLine("[Description Error]\t" + sError.Trim() + "");
                swFromFile.Flush();
                swFromFile.Close();
            }
            catch { }
        }
    }
}
