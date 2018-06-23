using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.DBUtility;
using System.Globalization;
using Cb.Localization;

namespace Cb.Utility
{
    public class FormatHelper
    {
        #region Format DVT

        private static string FormatDonvi(double value, string donvi)
        {
            string result = string.Empty;
            if (donvi.Equals("04")) // Đơn vị lượng SJC
            {
                // Làm tròn 2 số lẻ
                result = DBHelper.NumericFormat(value, 2);
                // Cắt đi các chữ số không cần thiết
                if (result.LastIndexOf('.') >= 0)
                {
                    while (result.LastIndexOf('0') == result.Length - 1 || result.LastIndexOf('.') == result.Length - 1)
                    {
                        result = result.Substring(0, result.Length - 1); // Nếu kí tự cuối cùng bằng 0 thì cắt bỏ    
                    }
                }
                return result;
            }
            else // Các đơn vị khác thì không lấy phần lẻ
            {
                return DBHelper.NumericFormat(value, 0);
            }
        }
        private static string FormatTrieu(double value, string donvi)
        {
            double tempValue = (double)(value / 1000000);
            return string.Format("{0} triệu", tempValue);
        }
        private static string FormatTrieuVang(double value, string donvi)
        {
            if (value % 1000000 == 0) // Neu chia het cho 1 trieu
            {
                double tempValue = (double)(value / 1000000);
                return string.Format("{0} triệu", tempValue);
            }
            // Nếu khong la phan nguyen cua trieu
            return FormatDonvi(value, donvi);
        }
        private static string FormatTi(double value, string donvi)
        {
            if (value % 10000000 == 0)
            {
                return string.Format("{0} tỉ", DBHelper.NumericFormat(value / 1000000000, 2));
            }
            if (value % 1000000 == 0) // Nếu là phần nguyên của triệu
            {
                string result = string.Empty;
                int tempValue = (int)(value / 1000000000);
                result = string.Format("{0} tỉ", tempValue);
                value = value % 1000000000;
                value = (int)(value / 1000000);
                return (value > 0) ? string.Format("{0} {1} triệu", result, value) : string.Format("{0}", result);
            }
            // Nếu không là phần nguyên của triệu
            return FormatDonvi(value, donvi);
        }
        /// <summary>
        /// Format cac don vi tinh tien trong Chondat
        /// </summary>
        /// <param name="value"></param>
        /// <param name="donvi"></param>
        /// <returns></returns>
        private static string FormatPrice(double value, string donvi)
        {
            // Tỉ
            if (value >= 1000000000)
            {
                return FormatTi(value, donvi);
            }
            else if (value >= 1000000)
            {
                return FormatTrieu(value, donvi);
            }
            else
            {
                return FormatDonvi(value, donvi);
            }
        }
        public static string FormatUSD(double _value)
        {
            string result = string.Empty;
            string[] usd = _value.ToString().Split('.');
            if (usd.Length == 2)
                result = "." + usd[1];
            int count = 0;
            for (int i = usd[0].Length - 1; i >= 0; i--)
            {
                if (count == 3)
                {
                    result = usd[0][i].ToString() + "," + result;
                    count = 1;
                }
                else
                {
                    result = usd[0][i].ToString() + result;
                    count++;
                }
            }
            return result;
        }
        /// <summary>
        /// Format cac don vi tinh tien trong Chondat
        /// </summary>
        /// <param name="value"></param>
        /// <param name="donvi"></param>
        /// <returns></returns>
        public static string FormatDonviTinh(double value, string donvi)
        {
            if (value == double.MinValue)
            {
                return string.Empty;
            }
            double realValue = double.MinValue;
            string text = string.Empty;
            switch (donvi)
            {
                case "00":  // VND
                    realValue = value;
                    text = "VND";
                    break;
                case "01": // Triệu VND
                    realValue = 1000000 * value;
                    text = "VND";
                    break;
                case "02":  // Tỉ VND
                    realValue = 1000000000 * value;
                    text = "VND";
                    break;
                case "03":  // USD
                    realValue = value;
                    text = "USD";
                    realValue = Math.Round(realValue, 2, MidpointRounding.AwayFromZero);
                    break;
                case "04":  // Lượng SJC
                    realValue = value;
                    text = "lượng SJC";
                    break;
                default:
                    break;
            }
            realValue = Math.Round(realValue, 2);
            return string.Format("{0} {1}", FormatPrice(realValue, donvi), text);
        }


        #endregion

        #region Format DVT Enum
        /// <summary>
        /// Format cac don vi tinh tien trong Chondat
        /// </summary>
        /// <param name="value"></param>
        /// <param name="donvi"></param>
        /// <returns></returns>
        public static string FormatDonviTinh(double value, enuCostId donvi)
        {
            if (value == double.MinValue)
            {
                return string.Empty;
            }
            double realValue = double.MinValue;
            string text = string.Empty;
            switch (donvi)
            {
                case enuCostId.dong:  // VND
                    realValue = value;
                    text = LocalizationUtility.GetText("enuCostId_dong");
                    break;
                case enuCostId.trieudong: // Triệu VND
                    realValue = 1000000 * value;
                    text = LocalizationUtility.GetText("enuCostId_dong");
                    break;
                case enuCostId.tidong:  // Tỉ VND
                    realValue = 1000000000 * value;
                    text = LocalizationUtility.GetText("enuCostId_dong"); ;
                    break;
                //case enuCostId.usd:  // USD
                //    realValue = value;
                //    text = LocalizationUtility.GetText("enuCostId_usd");
                //    realValue = Math.Round(realValue, 2, MidpointRounding.AwayFromZero);
                //    break;
                //case enuCostId.luongSJC:  // Lượng SJC
                //    realValue = value;
                //    text = LocalizationUtility.GetText("enuCostId_luongSJC");
                //    break;
                default:
                    break;
            }
            realValue = Math.Round(realValue, 2);
            return string.Format("{0} {1}", realValue.ToString("#,000"), text);
            //return string.Format("{0} {1}", FormatPrice(realValue, donvi), text);
        }

        private static string FormatPrice(double value, enuCostId donvi)
        {
            // Tỉ
            if (value >= 1000000000)
            {
                return FormatTi(value, donvi);
            }
            else if (value >= 1000000)
            {
                return FormatTrieu(value, donvi);
            }
            else
            {
                return FormatDonvi(value, donvi);
            }
        }

        private static string FormatTi(double value, enuCostId donvi)
        {
            string unit_ti = LocalizationUtility.GetText("enuCostId_tidong");//ti hoac billion
            string unit_trieu = LocalizationUtility.GetText("enuCostId_trieudong");//trieu hoac million
            if (value % 10000000 == 0)
            {
                return string.Format("{0} {1}", DBHelper.NumericFormat(value / 1000000000, 2), unit_ti);
            }
            if (value % 1000000 == 0) // Nếu là phần nguyên của triệu
            {
                string result = string.Empty;
                int tempValue = (int)(value / 1000000000);
                result = string.Format("{0} {1}", tempValue, unit_ti);
                value = value % 1000000000;
                value = (int)(value / 1000000);
                return (value > 0) ? string.Format("{0} {1} {2}", result, value, unit_trieu) : string.Format("{0}", result);
            }
            // Nếu không là phần nguyên của triệu
            return FormatDonvi(value, donvi);
        }

        private static string FormatTrieu(double value, enuCostId donvi)
        {
            string unit_trieu = LocalizationUtility.GetText("enuCostId_trieudong");//trieu hoac million
            double tempValue = (double)(value / 1000000);
            return string.Format("{0} {1}", tempValue, unit_trieu);
        }
        private static string FormatTrieuVang(double value, enuCostId donvi)
        {
            if (value % 1000000 == 0) // Neu chia het cho 1 trieu
            {
                string unit_trieu = LocalizationUtility.GetText("enuCostId_trieudong");//trieu hoac million
                double tempValue = (double)(value / 1000000);
                return string.Format("{0} {1}", tempValue, unit_trieu);
            }
            // Nếu khong la phan nguyen cua trieu
            return FormatDonvi(value, donvi);
        }

        private static string FormatDonvi(double value, enuCostId donvi)
        {
            string result = string.Empty;
            //if (donvi == enuCostId.luongSJC) // Đơn vị lượng SJC
            //{
            //    // Làm tròn 2 số lẻ
            //    result = DBHelper.NumericFormat(value, 2);
            //    // Cắt đi các chữ số không cần thiết
            //    if (result.LastIndexOf('.') >= 0)
            //    {
            //        while (result.LastIndexOf('0') == result.Length - 1 || result.LastIndexOf('.') == result.Length - 1)
            //        {
            //            result = result.Substring(0, result.Length - 1); // Nếu kí tự cuối cùng bằng 0 thì cắt bỏ    
            //        }
            //    }
            //    return result;
            //}
            //else // Các đơn vị khác thì không lấy phần lẻ
            //{
                return DBHelper.NumericFormat(value, 0);
            //}
        }

        public static double GetRealValue(double value, enuCostId donvi)
        {
            double realValue = double.MinValue;

            switch (donvi)
            {
                case enuCostId.dong:  // VND
                    realValue = value;
                    break;
                case enuCostId.trieudong: // Triệu VND
                    realValue = 1000000 * value;
                    break;
                case enuCostId.tidong:  // Tỉ VND
                    realValue = 1000000000 * value;
                    break;

            }
            realValue = Math.Round(realValue, 2);
            return realValue;
        }

        public static string FormatDonviTinh(double value, enuCostId donvi, CultureInfo ci)
        {
            if (value == double.MinValue)
            {
                return string.Empty;
            }
            double realValue = double.MinValue;
            string text = string.Empty;
            switch (donvi)
            {
                case enuCostId.dong:  // VND
                    realValue = value;
                    text = LocalizationUtility.GetText("enuCostId_dong");
                    break;
                case enuCostId.trieudong: // Triệu VND
                    realValue = 1000000 * value;
                    text = LocalizationUtility.GetText("enuCostId_dong");
                    break;
                case enuCostId.tidong:  // Tỉ VND
                    realValue = 1000000000 * value;
                    text = LocalizationUtility.GetText("enuCostId_dong"); ;
                    break;
                //case enuCostId.usd:  // USD
                //    realValue = value;
                //    text = LocalizationUtility.GetText("enuCostId_usd");
                //    realValue = Math.Round(realValue, 2, MidpointRounding.AwayFromZero);
                //    break;
                //case enuCostId.luongSJC:  // Lượng SJC
                //    realValue = value;
                //    text = LocalizationUtility.GetText("enuCostId_luongSJC");
                //    break;
                default:
                    break;
            }
            realValue = Math.Round(realValue, 2);
            return string.Format("{0} {1}", realValue.ToString("#,000", ci), text);
            //return string.Format("{0} {1}", FormatPrice(realValue, donvi), text);
        }
        #endregion
    }
}
