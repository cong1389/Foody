<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="topmenu.ascx.cs" Inherits="Cb.Web.Admin.Controls.topmenu" %>
<!--topmenu--->
<header class="main-header">
    <script type="text/javascript">
        function submitButton(task) {
            //            alert(task);
            //            var frm = document.getElementById('aspnetForm');
            //            //            if (checkSelectedItem('preview')) {
            //            submitForm(frm, task);
            //            }
        }
    </script>

    <!-- Logo -->
    <a runat="server" id="hypAdmin" class="logo hidden-xs">
        <!-- mini logo for sidebar mini 50x50 pixels -->
        <span class="logo-mini"><b>Adm</b></span>
        <!-- logo for regular state and mobile devices -->
        <span class="logo-lg"><b>
            <img src="/Admin/Images/Logo_admin.png" class="img-circle" alt="User Image" />Admin</b>
        </span>
    </a>

    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top" role="navigation">

        <!-- Sidebar toggle button-->
        <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button"><span class="sr-only">Toggle navigation</span> </a>

        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav ">
                <!-- Preview -->
                <li class="user-menu">
                    <a runat="server" id="hypkPreview" title="Preview" target="_blank">
                        <i class="fa fa-external-link"><span class="hidden-xs">
                            <asp:Literal runat="server" ID="ltrWebsite" Text="ltrWebsite"></asp:Literal>
                        </span></i>
                    </a>
                </li>

                <!-- User Account: style can be found in dropdown.less -->
                <li class="dropdown user user-menu "><a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <i class=" fa fa-user">
                        <asp:Literal runat="server" ID="ltrUserName"></asp:Literal></i>
                </a>
                    <ul class="dropdown-menu">
                        <!-- User image -->
                        <li class="user-header">
                            <i class="fa fa-child fa-3x"></i>
                            <p>
                                <asp:Literal runat="server" ID="ltrFullName"></asp:Literal>
                                <small>
                                    <asp:Literal runat="server" ID="ltrEmail"></asp:Literal>
                                </small>
                            </p>
                        </li>
                        <!-- Menu Footer-->
                        <li class="user-footer">
                            <div class="pull-right">
                                <a runat="server" id="hypLogOut" class="btn btn-default btn-flat bg-green-haze">
                                    <asp:Literal runat="server" ID="ltrSignOut" Text="ltrSignOut"></asp:Literal>
                                </a>
                            </div>
                        </li>
                    </ul>
                </li>
                <!-- Language -->
                <li class="tasks-menu"><a runat="server" id="hypVN" class="dropdown-toggle">
                    <i class="fa fa-flag-o"></i><span class="label label-danger">VN</span> </a>
                </li>
                <li class="tasks-menu"><a runat="server" id="hypEng" class="dropdown-toggle">
                    <i class="fa fa-flag-o"></i><span class="label label-danger">Eng</span> </a>
                </li>
            </ul>
        </div>
    </nav>
</header>
