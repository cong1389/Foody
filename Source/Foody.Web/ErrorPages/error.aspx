<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="error.aspx.cs" Inherits="Cb.Web.ErrorPages.error" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page 404</title>
    <link href="/Images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="/Admin/Images/favicon.ico" rel="shortcut icon" type="image/x-icon" />

    <!-- jQuery 2.1.4 -->
    <script src="/Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>

    <!-- Bootstrap 3.3.4 -->
    <link href="/Styles/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />

    <!-- FontAwesome 4.3.0 -->
    <link href="/Styles/font-awesome.min.css" rel="stylesheet" type="text/css" media="all" />

    <link type="text/css" rel="stylesheet" href="/Admin/Style/ErrorStyle.css" />

    <!-- Bootstrap 3.3.2 JS -->
    <script src="/Styles/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
    <div class="container">
        <div class="row">
            <h1 class="text-center">PNK Media</h1>
            <div class="text-center">
                <img src="/images/ErrorBanner.png" alt="">
            </div>
            <h2 class="text-center">
                <a runat="server" id="hypHomePage">Quay về trang chủ</a></h2>
        </div>
    </div>
</body>
</html>
