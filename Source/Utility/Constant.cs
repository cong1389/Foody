/**
 * @version $Id:
 * @package Cybervn.NET
 * @author Cybervn Dev <dev@dgc.vn>
 * @copyright Copyright (C) 2009 by Cybervn. All rights reserved.
 * @link http://www.Cybervn.com
 */

using System;
using Cb.DBUtility;
using System.Configuration;

namespace Cb.Utility
{
    public static class Constant
    {
        public static int CurrentLanguage = 1;
        public static class UI
        {
            //lang 
            public const string admin_lang_Vi = "Tiếng Việt";
            public const string admin_lang_En = "English";

            //System message
            public const string msg_account_username_empty = "Vui lòng nhập tên đăng nhập.\n Tên đăng nhập phải nhiều hơn 4 ký tự và nhỏ hơn 50 ký tự";
            public const string msg_account_password_empty = "Vui lòng nhập mật khẩu.\n Mật khẩu phải nhiều hơn 7 ký tự và nhỏ hơn 50 ký tự";
            public const string msg_account_password_short = "Mật khẩu phải nhiều hơn 7 ký tự và nhỏ hơn 50 ký tự";
            public const string msg_account_login_eror = "Tên đăng nhập hay mật khẩu không đúng";
            public const string msg_account_password_current_empty = "Vui lòng nhập mật khẩu hiện tại";
            public const string msg_account_password_new_empty = "Vui lòng nhập mật khẩu mới";
            public const string msg_account_password_re_empty = "Vui lòng nhập xác nhận mật khẩu mới";
            public const string msg_account_password_new_short = "Mật khẩu phải nhiều hơn 7 ký tự và nhỏ hơn 50 ký tự";
            public const string msg_account_password_re_invalid = "Xác nhận mật khẩu mới không đúng.Vui lòng nhập lại";
            public const string msg_account_password_new_wrong = "Mật khẩu hiện tại không đúng.";

            //Message infor
            public const string admin_msg_sendmail_success = "Bạn đã gởi thông tin liên hệ đến admin.";
            public const string admin_msg_sendmail_fail = "Thông tin liên hệ của Bạn chưa được gởi đến admin.";
            public const string admin_msg_save_success = "Lưu dữ liệu thành công.";
            public const string admin_msg_import_success = "Import dữ liệu thành công.";
            public const string admin_msg_delete_success = "Xóa dữ liệu thành công.";
            public const string admin_msg_upload_success = "Upload dữ liệu thành công.";
            public const string admin_msg_import_fail = "Lỗi import dữ liệu.";
            public const string admin_msg_delete_fail = "Lỗi xóa dữ liệu.";
            public const string admin_msg_save_fail = "Lỗi lưu dữ liệu.";
            public const string admin_msg_upload_fail = "Lỗi upload dữ liệu.";
            public const string admin_msg_no_selected_item = "Vui lòng chọn một mẫu tin!";
            public const string admin_msg_confirm_delete_item = "Bạn thật sự muốn xóa mẫu tin đã chọn?";

            //alert
            public const string alert_empty_username = "Vui lòng nhập tên đăng nhập.Tên đăng nhập phải nhiều hơn 4 ký tự và nhỏ hơn 50 ký tự";
            public const string alert_empty_name = "Vui lòng nhập tên (Tab tiếng việt).";
            public const string alert_empty_name_outsite = "Vui lòng nhập tên.";
            public const string alert_empty_name_contact_outsite = "Vui lòng nhập tên liên hệ.";
            public const string alert_empty_name_en = "Vui lòng nhập tên (Tab tiếng Anh).";
            public const string alert_empty_name_english = "Vui lòng nhập tên tiếng anh.";
            public const string alert_empty_password = "Vui lòng nhập mật khẩu.Mật khẩu phải nhiều hơn 7 ký tự và nhỏ hơn 50 ký tự";
            public const string alert_empty_password2 = "Vui lòng nhập mật khẩu xác nhận.Mật khẩu phải nhiều hơn 7 ký tự và nhỏ hơn 50 ký tự";
            public const string alert_invalid_password2 = "Vui lòng kiểm tra lại mật khẩu.Cả 2 mật khẩu phải giống nhau";
            public const string alert_empty_security_code = "Vui lòng nhập mã an toàn";
            public const string alert_invalid_security_code = "Mã an toàn sai.";
            public const string alert_empty_email = "Vui lòng nhập địa chỉ email.";
            public const string alert_invalid_email = "Địa chỉ email không hợp lệ.";
            public const string alert_invalid_phone = "Điện thoại không hợp lệ.";
            public const string alert_invalid_mobile = "Mobile không hợp lệ.";
            public const string alert_invalid_fax = "Fax không hợp lệ.";
            public const string alert_invalid_username = "Tên đăng nhập đã tồn tại!";
            public const string alert_invalid_delete_productcategory_exist_child = "Không thể xóa vì đã tồn tại danh mục con hoặc thông tin liên quan";
            public const string alert_invalid_parent_productcategory = "Không thể chọn nhóm sản phẩm là chính nó hoặc là danh mục con của nó";

            //title admin
            public const string admin_addnew = "Thêm mới";
            public const string admin_delete = "Xóa";
            public const string admin_edit = "Sửa";
            //public const string admin_publish = "Hiển thị";
            public const string admin_unpublish = "Khóa lại";
            public const string admin_search = "Tìm kiếm";
            public const string admin_save = "Lưu";
            public const string admin_apply = "Lưu và tiếp tục";
            public const string admin_cancel = "Huỷ";
            public const string admin_postdate = "Ngày cập nhật";
            public const string admin_ordering = "Sắp xếp";
            public const string admin_linkurl = "Liên kết";
            public const string admin_position = "Vị trí";
            public const string admin_image = "Hình";
            public const string admin_image_small = "Hình nhỏ (130 x 130)";
            public const string admin_image_big = "Hình lớn (210 x 190)";
            public const string admin_img_del = "Xóa hình";
            //public const string admin_name = "Tên";
            public const string admin_name_english = "Tên tiếng anh";
            public const string admin_name_contact = "Tên liên hệ";
            public const string admin_detail = "Chi tiết";
            public const string admin_code = "Mã khách hàng";
            public const string admin_use = "Cách sử dụng";
            public const string admin_more_detail = "Thông tin thêm";
            public const string admin_more_detail_en = "More detail";
            //public const string admin_name_en = "Name";
            public const string admin_detail_en = "Detail";
            public const string admin_brief = "Mô tả ngắn";
            public const string admin_brief_en = "Brief";
            public const string admin_Category = "Danh mục sản phẩm";
            public const string admin_Alt = "Alt";
            public const string admin_Up = "Di chuyển lên";
            public const string admin_Down = "Di chuyển xuống";
            public const string admin_Upload = "Upload";
            public const string admin_Download = "Download";
            public const string admin_File = "File";
            public const string admin_import = "Import";
            public const string admin_Directory = "Thư mục";
            public const string admin_update_date = "Ngày cập nhật";
            public const string admin_from_year = "Từ năm";
            public const string admin_to_year = "Đến năm";
            public const string admin_refesh = "Refesh";
            public const string admin_banner = "Banner";
            public const string admin_type_project = "Loại web site";

            //user
            public const string admin_users_header_title = "Quản Lý Thành Viên";
            public const string admin_user_name = "Tên đăng nhập";
            public const string admin_user_fullname = "Họ tên";
            public const string admin_user_email = "Địa chỉ email";
            //public const string admin_user_permission_label = "Nhóm quyền";
            public const string admin_users_header_title_edit = "Thông tin thành viên";
            //public const string admin_user_username = "Tên đăng nhập";
            public const string admin_user_password = "Mật khẩu";
            public const string admin_user_confirmpassword = "Xác nhận mật khẩu";
            //public const string admin_user_address = "Địa chỉ";
            public const string admin_user_phone = "Điện thoại";
            public const string admin_user_mobile = "Mobile";
            public const string admin_user_city = "Tỉnh";
            public const string admin_user_security = "Mã an toàn";

            //config
            public const string admin_config_meta_tags_l = "Meta tags";
            public const string admin_config_title_l = "Cấu hình";
            public const string admin_config_site_l = "Website";
            public const string admin_config_sitename_l = "Tên website";
            public const string admin_config_metadata_l = "Metadata";
            public const string admin_config_metadesc_l = "Meta Description";
            public const string admin_config_metakey_l = "Meta Keywords";
            public const string admin_config_email_l = "Email";
            public const string admin_config_skypeId = "Skype ID";
            public const string admin_config_yahooId = "Yahoo ID";
            public const string admin_config_phone = "Điện thoại";
            public const string admin_config_fax = "Fax";

        }

        public static class DSC
        {
            public static readonly int Session120 = DBConvert.ParseInt(ConfigurationManager.AppSettings["Session120"]);

            public static readonly int IdXmlPageAdmin = DBConvert.ParseInt(ConfigurationManager.AppSettings["IdXmlPageAdmin"]);
            public static readonly int IdXmlPagePublish = DBConvert.ParseInt(ConfigurationManager.AppSettings["IdXmlPagePublish"]);
            public static readonly int IdXmlPageRobots = DBConvert.ParseInt(ConfigurationManager.AppSettings["IdXmlPageRobots"]);
            public static readonly int IdXmlBannerPostion = DBConvert.ParseInt(ConfigurationManager.AppSettings["IdXmlBannerPostion"]);

            public static readonly int IdRootProductCategory = DBConvert.ParseInt(ConfigurationManager.AppSettings["IdRootProductCategory"]);
            public static readonly string AdvUploadFolder = ConfigurationManager.AppSettings["LogoUpload"];

            public static readonly string NoImage = ConfigurationManager.AppSettings["SrcNoImage"];
        }

        public static class DB
        {
            public const char ListSeparator = ',';
            public const char FieldSeparator = ';';
            public const string CategoryPathSeparator = ":";
            public const string NullString = "NULL";
            public static readonly DateTime DBDateTimeMinValue = new DateTime(1900, 1, 1);
            public static readonly DateTime DBDateTimeMaxValue = new DateTime(2079, 6, 5);
            public const int MaxPriceRangeValue = int.MaxValue;
            public const string AnonymousUsername = "Anonymous";
            public const string Position_Banner = "1";
            public const string Position_Left = "2";
            public const string Position_Right = "3";
            public const string Position_Slide = "4";

            //language
            public const string langVn = "vn";
            public const string langEng = "eng";
            public const byte LangId = 1;
            public const byte LangId_En = 2;
        }

        public static class Security
        {
            public const string SymmetricInstance = "RijndaelManaged";
            public const string AdminRole = "Nhà quản trị";
            public const string AdminUserRole = "Người dùng";
            public const string AdminModRole = "Người quản lý";
            public const string AdminRoleValue = "1";
            public const string AdminModRoleValue = "2";
            public const string AdminUserRoleValue = "3";
        }

        public static class Configuration
        {
            public const string sitename = "config_sitename";
            public const string email = "config_email";
            public const string phone = "config_phone";
            public const string fax = "config_fax";
            public const string skypeid = "config_skypeid";
            public const string yahooid = "config_yahooid";

            public const string config_address_en = "config_address_en";
            public const string config_address_vi = "config_address_vi";
            public const string config_company_name_vi = "config_company_name_vi";
            public const string config_company_name_en = "config_company_name_en";

            public const string config_address1_vi = "config_address1_vi";

            public const string config_logoHeader = "config_logoHeader";
            public const string config_logoFooter = "config_logoFooter";

            public const string config_title = "title";
            public const string config_metaDescription = "metaDescription";
            public const string config_metaKeyword = "metaKeyword";

            public const string config_fbfanpage = "config_fbfanpage";
            public const string config_googleplus = "googleplus";
            public const string config_twitter = "twitter";

            public const string config_h1 = "config_h1";
            public const string config_h2 = "config_h2";
            public const string config_h3 = "config_h3";

            public const string config_analytic = "config_analytic";
            public const string config_fblike = "config_fblike";
            public const string config_fbfanpageLarge = "config_fbfanpageLarge";

            public const string config_vchat = "vchat";

            public const string config_linkedIn = "config_linkedin";
            public const string config_pinterest = "config_pinterest";
            public const string config_reddit = "config_reddit";

            public const string config_latitude = "config_latitude";//Vĩ độ
            public const string config_longitude = "config_longitude";//Kinh độ

            public const string config_footer = "config_footer";//footer
        }


        public static class Cache
        {
            public const double expireInMinutes = 1440; //24 hours
        }

        public static class Calculation
        {
            public const int percision = 2;
        }
        public static class RegularExpressionString
        {
            public const string validatePhone = "((\\(\\d{3,4}\\)|\\d{3,4}-)\\d{4,9}(-\\d{1,5}|\\d{0}))|(\\d{4,12})";
            public const string validateEmail = "^([\\w-]+(?:\\.[\\w-]+)*)@((?:[\\w-]+\\.)*\\w[\\w-]{0,66})\\.([a-z]{2,6}(?:\\.[a-z]{2})?)$";
            public const string validateNumber = "^[-]?\\d*\\.?\\d*$";
        }
    }

    public enum RoleType
    {
        Administrator = 1,
        AdminUser = 2,
        CompanyUser = 3
    }

    public enum enuCostId
    {
        All_none = int.MinValue,
        dong = 1,
        trieudong,
        tidong
    }

    public enum enuUnitId
    {
        m2,
        hecta
    }

    public enum enuSize
    {
        small,
        large
    }

    public enum enuStatus
    {
        All = int.MinValue,
        Activity = 0,
        Finish
    }

    public enum enuTypeProduct
    {
        None,
        All,
        ByCategory,
        New,
        Best,
        Hot,
        Search
    }

    public enum enuTypeMessage
    {
        None = int.MinValue,
        Regist = 1,
        IdeaCenter,
        ForgotPass,
        ForgotPassFail,
        Contact,
    }

    public enum enuTypeOrderProduct
    {
        PdcatOrdering_Desc_POdering_Desc = 1,
        POdering_Desc
    }

    public enum enuRoleUser
    {
        All_none = int.MinValue,
        /// <summary>
        /// Nhà quản trị </summary>
        admin = 1,
        /// <summary>
        /// Quản lý </summary>
        mod,
        /// <summary>
        /// Người dùng thường </summary>
        user
    }

    public enum enuChat
    {
        All_none = int.MinValue,
        /// <summary>
        /// yahoo </summary>
        yahoo = 1,
        /// <summary>
        /// skype </summary>
        skype
    }

    public enum enuViewType
    {
        list, grid, map
    }
}

