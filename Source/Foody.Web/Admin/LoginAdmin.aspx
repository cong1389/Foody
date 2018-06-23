<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginAdmin.aspx.cs" Inherits="Cb.Web.Admin.LoginAdmin" %>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>PNK  | Đăng nhập</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <link href="/Admin/Images/favicon.ico" rel="shortcut icon" type="image/x-icon" />

    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&amp;subset=all" rel="stylesheet" type="text/css" />

    <!--font awesome-->
    <link href="/Admin/Components/App/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/Admin/Components/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />

    <!--uniform-->
    <link href="/Admin/Components/WebOne/css/uniform.default.css" rel="stylesheet" type="text/css" media="all" />

    <!--bootstrap-switch-->
    <link href="/Admin/Components/WebOne/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" media="all" />

    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <link href="/Admin/Components/WebOne/css/select2.min.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/Admin/Components/WebOne/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />

    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN THEME GLOBAL STYLES -->
    <link href="/Admin/Components/WebOne/css/components.min.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/Admin/Components/WebOne/css/plugins.min.css" rel="stylesheet" type="text/css" media="all" />

    <!-- BEGIN PAGE LEVEL STYLES -->
    <link href="/Admin/Components/WebOne/css/login-5.min.css" rel="stylesheet" type="text/css" media="all" />

    <link href="/Admin/Style/LoginAdmin.css" rel="stylesheet" type="text/css" media="all" />

    <!-- custom js -->
    <script type="text/javascript" src="/admin/javascript/functions.js"></script>

</head>
<!-- END HEAD -->

<body class=" login">
    <form id="frmLogin" runat="server" name="frmLogin">
        <div class="user-login-5">
            <div class="row bs-reset">
                <div class="col-md-6 bs-reset">
                    <div class="login-bg" style="background-image: url(/Admin/Images/bg1.jpg)">
                        <img class="login-logo" runat="server" id="imgLogo">
                    </div>



                </div>
                <div class="col-md-6 login-container bs-reset">
                    <div class="login-content">
                        <h1>Admin Login</h1>

                        <div class="row">
                            <div class="col-xs-6">
                                <input runat="server" id="txtUserName" class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off"
                                    placeholder="Tên đăng nhập" name="username" required validationgroup="gLogin" />
                                <%--  <asp:RequiredFieldValidator ID="reqTxtUserName" ControlToValidate="txtUserName" ValidationGroup="gLogin"
                                    SetFocusOnError="true" runat="server" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                            <div class="col-xs-6">
                                <input runat="server" id="txtPassword" class="form-control form-control-solid placeholder-no-fix" type="password" autocomplete="off"
                                    placeholder="Mật khẩu" name="password" required validationgroup="gLogin" onkeypress ="checkEnterLogin(event);" />

                                <%-- <asp:RequiredFieldValidator ID="reqTxtPassword" ControlToValidate="txtPassword" ValidationGroup="gLogin" SetFocusOnError="true" runat="server" Display="Dynamic"></asp:RequiredFieldValidator>
                                &nbsp; <a href="#" onclick="return ClickForgotPass();">
                                    <asp:Literal ID="ltrForgotPass" runat="server"></asp:Literal></a>--%>
                            </div>
                        </div>
                        <div class="msgError">
                            <asp:Literal runat="server" ID="ltrMsg"></asp:Literal>
                        </div>
                        <div class="alert alert-danger display-hide">
                            <button class="close" data-close="alert"></button>
                            <span>Enter any username and password. </span>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="rem-password hidden">
                                    <p>
                                        Remember Me
                                           
                                        <input type="checkbox" class="rem-checkbox" />
                                    </p>
                                </div>
                            </div>
                            <div class="col-sm-8 text-right ">
                                <div class="forgot-password hidden">
                                    <a href="javascript:;" id="forget-password" class="forget-password">Forgot Password?</a>
                                </div>
                                <div style="margin-top: 15px;">
                                    <asp:Button ID="btnLogin" ValidationGroup="gLogin" runat="server" CssClass="btn blue form-group " Text="Đăng nhập" />
                                    <%--<button class="btn blue" type="submit" id="btnLogin" runat="server" validationgroup="gLogin" onclick="btnLogin_Click">Đăng nhập</button>--%>
                                </div>
                            </div>
                        </div>

                        <!-- BEGIN FORGOT PASSWORD FORM -->
                        <div class="forget-form hidden">
                            <h3 class="font-green">Forgot Password ?</h3>
                            <p>Enter your e-mail address below to reset your password. </p>
                            <div class="form-group">
                                <input class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="Email" name="email" />
                            </div>
                            <div class="form-actions">
                                <button type="button" id="back-btn" class="btn grey btn-default">Back</button>
                                <button type="submit" class="btn blue btn-success uppercase pull-right">Submit</button>
                            </div>
                        </div>
                        <!-- END FORGOT PASSWORD FORM -->
                    </div>
                    <div class="login-footer">
                        <div class="row bs-reset">
                            <div class="col-xs-4 bs-reset">
                                <ul class="login-social">
                                    <li>
                                        <a href="javascript:;">
                                            <i class="fa fa-facebook-square"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                            <i class="fa fa-google-plus"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                            <i class="fa fa-twitter-square"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-xs-8 bs-reset">
                                <div class="login-copyright text-right">
                                    <p>Copyright 2016 - All right reserved</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Không xài-->
        <div class="hidden">
            <asp:DropDownList ID="drpRole" runat="server"></asp:DropDownList>
            <input type="checkbox" name="rem" id="rem" runat="server" />
            <input type="hidden" id="hidOnChangePass" name="hidOnChangePass" runat="server" /><label
                for="ctl02_ctl01_ctl00_chkRemember"><asp:Literal ID="ltrRememberPass" runat="server"></asp:Literal></label>
            <div id="trSecurityCode" runat="server">
                <asp:TextBox ID="txt_Security_Code" runat="server" Columns="8" MaxLength="6" Style="float: left"></asp:TextBox>
                <asp:Image ID="img_Security_Code" runat="server" Style="margin-bottom: -5px;" />
                <asp:CustomValidator ID="cus_Same_Security_Code" runat="server" ValidationGroup="gLogin"
                    OnServerValidate="ValidateCheckSameSecurityCodeServer"></asp:CustomValidator>
            </div>

        </div>
        <!--/Không xài-->
    </form>

    <!--jquery-->
    <script src="/Admin/Components/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>

    <!--bootstrap-->
    <script src="/Admin/Components/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

    <!--cookie-->
    <script src="/Admin/Components/WebOne/js/js.cookie.min.js" type="text/javascript"></script>

    <script src="/Admin/Components/WebOne/js/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>

    <script src="/Admin/Components/WebOne/js/jquery.slimscroll.min.js" type="text/javascript"></script>

    <script src="/Admin/Components/WebOne/js/jquery.blockui.min.js" type="text/javascript"></script>

    <script src="/Admin/Components/WebOne/js/jquery.uniform.min.js" type="text/javascript"></script>

    <script src="/Admin/Components/WebOne/js/bootstrap-switch.min.js" type="text/javascript"></script>

    <script src="/Admin/Components/WebOne/js/jquery.validate.min.js" type="text/javascript"></script>

    <script src="/Admin/Components/WebOne/js/additional-methods.min.js" type="text/javascript"></script>

    <script src="/Admin/Components/WebOne/js/select2.full.min.js" type="text/javascript"></script>

    <script src="/Admin/Components/WebOne/js/app.min.js" type="text/javascript"></script>

    <%--<script src="/Admin/Components/WebOne/js/jquery.backstretch.min.js" type="text/javascript"></script>--%>

    <script src="/Admin/Components/WebOne/js/login-5.min.js" type="text/javascript"></script>
</body>

</html>
