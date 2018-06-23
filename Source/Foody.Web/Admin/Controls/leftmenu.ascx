<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="leftmenu.ascx.cs" Inherits="Cb.Web.Admin.Controls.leftmenu" %>
<!--leftmenu--->
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar" style="height: auto;">
        <!-- Sidebar user panel -->
        <div class="user-panel">

            <div class="block-left">
                <div class="img-logo hidden">
                    <a runat="server" id="hypLogo">
                        <img class="logo-admin" runat="server" id="imgLogo" src="/Admin/Images/Logo_admin.png" alt="Logo" />
                        <p class="admin-name txt-up txt-bold">admin</p>
                    </a>
                </div>

                <div class="left-icon"></div>

                <div class="block-menu-icon">

                    <!---Cấu hình-->
                    <div class="icon-parent">
                        <i class="fa fa-cogs"></i>
                        <p class="title-menu txt-bold">Cấu hình</p>
                        <img class="plug" src="/Admin/Images/plus.png" alt="plug" />
                    </div>
                    <div class="child-0">
                        <div class="title-parent">
                            <p><a runat="server" id="hypPage"><i class="fa fa-lg fa-fw fa-cog"></i>Cấu hình chung</a></p>
                        </div>
                        <div class="title-parent">
                            <p><a runat="server" id="hypManageUser"><i class="fa fa-lg fa-fw fa-user"></i>Thông tin tài khoản</a></p>
                        </div>
                        <div class="title-parent hidden">
                            <p><a runat="server" id="hypSeo"><i class="fa fa-lg fa-fw  fa-random"></i>Robots file</a></p>
                        </div>
                        <div class="title-parent">
                            <p><a runat="server" id="hypConfiguration"><i class="fa fa-lg fa-fw fa-arrows-alt"></i>Kích thước hình - Email</a></p>
                        </div>
                        <div class="title-parent">
                            <p><a runat="server" id="hypClearCache" onserverclick="hypClearCache_ServerClick"><i class="fa fa-refresh fa-fw"></i>Xóa cache</a></p>
                        </div>
                    </div>
                    <!---/Cấu hình-->

                    <!---Sản phẩm - bài viết-->
                    <div class="icon-parent">
                        <i class="fa fa-th"></i>
                        <p class="title-menu txt-bold">Sản phẩm - bài viết </p>
                        <img class="plug" src="/Admin/Images/plus.png" alt="plug" />
                    </div>
                    <div class="child-0 show-cur" style="display: block;">
                        <div class="title-parent">
                            <p><a runat="server" id="hypManageCategories"><i class="fa fa-lg fa-fw fa-tags"></i>Danh mục sản phẩm</a></p>
                        </div>
                        <div class="title-parent">
                            <p><a runat="server" id="hypManageItem"><i class="fa fa-lg fa-fw fa-tag"></i>Sản phẩm</a></p>
                        </div>
                        <div class="title-parent">
                            <p><a runat="server" id="hypSlide"><i class="fa fa-lg fa-fw fa-folder-open"></i>Slider - Partner</a></p>
                        </div>
                        <div class="title-parent">
                            <p><a runat="server" id="hypContentStatic"><i class="fa fa-lg fa-fw fa-folder-open"></i>Nội dung tĩnh</a></p>
                        </div>
                    </div>
                    <!---/Sản phẩm - bài viết-->

                    <!---Booking-->
                    <div class="icon-parent">
                        <i class="fa fa-cogs"></i>
                        <p class="title-menu txt-bold">Booking </p>
                        <img class="plug" src="/Admin/Images/plus.png" alt="plug" />
                    </div>
                    <div class="child-0">
                        <div class="title-parent">
                            <p><a runat="server" id="hypManageBooking"><i class="fa fa-lg fa-fw fa-tag"></i>Manage Booking</a></p>
                            <p class="hidden"><a runat="server" id="hypManageBookingPrice"><i class="fa fa-lg fa-fw fa-tag"></i>Booking Price</a></p>

                            <p><a runat="server" id="hypManageBookingGroup"><i class="fa fa-lg fa-fw fa-tag"></i>Booking Group</a></p>
                            <p class="hidden"><a runat="server" id="hypManageCountry"><i class="fa fa-lg fa-fw fa-tag"></i>Management country</a></p>

                            <p><a runat="server" id="hypExchageRate"><i class="fa fa-lg fa-fw fa-tag"></i>Exchage Rate</a></p>

                        </div>
                    </div>
                    <!---/Booking-->

                </div>
            </div>

        </div>
        <!-- search form -->

    </section>
    <!-- /.sidebar -->
</aside>
