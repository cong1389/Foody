<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_right.ascx.cs" Inherits="Cb.Web.Controls.block_right" %>

<!--block_right--->
<!--Customize Tours-->

<div class="widget" runat="server" id="divCustomTour" style="display: none">
    <div class="subtitle-wrap">
        <h4 class="subtitle">Customize Tours</h4>
    </div>
    <div class="">
        <asp:Literal runat="server" ID="ltrCustomTours"></asp:Literal>
    </div>
</div>

<!--/Customize Tours-->

<!--Need Help--->
<div class="widget" runat="server">
    <div class="subtitle-wrap">
        <h4 class="subtitle">Need Help?</h4>
    </div>
    <div class="">
        <p>We would be more than happy to help you. Our team advisor are 24/7 at your service to help you.</p>
        <div class="faq-box">
            <i class="fa fa-crosshairs" style="color: #cc0033;"></i>
            <a href="/contact/vn" rel="nofollow">F.A.Qs</a>
        </div>
        <address class="contact-details">
            <span class="contact-phone"><span class="fa fa-headphones " style="color: #cc0033;"></span>
                <asp:Literal runat="server" ID="ltrPhoneValue"></asp:Literal></span><br>
            <a class="contact-email" runat="server" id="hypEmail" rel="nofollow">
                <span class="fa fa-envelope " style="color: #cc0033;"></span>
                <asp:Literal runat="server" ID="ltrEmail"></asp:Literal></a>
        </address>
    </div>
</div>
<!--/Need Help--->


<div class="widget" runat="server">
    <div class="subtitle-wrap">
        <h4 class="subtitle">How to book tour ?</h4>
    </div>
    <div class="">
         <asp:Literal runat="server" ID="ltrHowToBook"></asp:Literal>
    </div>
</div>
<!--/block_right--->
