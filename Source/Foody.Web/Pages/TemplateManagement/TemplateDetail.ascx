<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TemplateDetail.ascx.cs" Inherits="Cb.Web.Pages.TemplateManagement.TemplateDetail" %>

<!--CategoryDetail-->
<script src="/Scripts/previewframe.js" type="text/javascript"></script>

<!-- header -->
<div id="top-head" class="topmenu">
    <section id="TrangChu" class="full-page menu-top scroll-page">
        <div class="controll-des-mobile">
            <div class="container">
                <div class="row">
                    <div class="vc_col-sm-6 controll">
                        <a runat="server" id="hypBack" title="Trở lại">Trở lại trang chủ</a>
                        <a href="" title="Mua hàng">Mua hàng</a>
                        <ul class="device-preview-controls">
                            <li>
                                <a id="desktopPreview" class="pull-right" title="Desktop" style="height: 29px; width: 26px; display: block;">
                                    <span class="active icon-ctr ipad-item"></span>
                                </a>
                            </li>
                            <li>
                                <a id="mobilePreview" class="pull-right" href="#" title="Mobile" style="height: 30px; width: 32px; display: block;">
                                    <span class="icon-ctr dek-item"></span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<!-- end header -->

<div id="PageContainer">
    <div class="container">
        <div class="row">
            <div class="devivePreview">
                <div id="previewFrameContainer" class="devivePreview_container">

                    <iframe runat="server" name="previewFrame" id="previewFrame" class="previewFrame devivePreview_frame" scrolling="auto"></iframe>

                </div>
            </div>
        </div>
    </div>
</div>





