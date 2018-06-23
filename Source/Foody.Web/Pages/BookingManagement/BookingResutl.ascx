<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookingResutl.ascx.cs" Inherits="Cb.Web.Pages.BookingManagement.BookingResutl" %>

<!--BookingResutl-->
<%--<%@ Register TagPrefix="dgc" TagName="block_booking" Src="~/Controls/block_booking.ascx" %>--%>
<%@ Register TagPrefix="dgc" TagName="top_menu" Src="~/Controls/top_menu.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_right" Src="~/Controls/block_right.ascx" %>
<link href="/Admin/Components/WebOne/css/components.min.css" rel="stylesheet" type="text/css" media="all" />


<div class="header-outer-wrapper " runat="server" id="divBoxTop">
    <dgc:top_menu ID="top_menu" runat="server" />
    <asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>
</div>

<div class="content-outer-wrapper mb31 divBooking " id="divDetail">
    <div class="content-wrapper container main ">
        <div class="page-wrapper single-blog single-sidebar right-sidebar">
            <div class="row gdl-page-row-wrapper">
                <div class="col-sm-9 col-md-9 ">
                    <div class="row">
                        <div class="gdl-page-item mb0 pb20 gdl-package-full twelve columns">
                            <div class="m-heading-1 border-blue m-bordered">
                                <asp:Literal runat="server" ID="ltrResult"></asp:Literal>
                             
                                <p>
                                    An email has been sent to the email address you registered with, please check your email account and follow the instructions in the email.

Depending on your email settings, this activation email may end up in your spam box - please check there if you have not received the email within a minute or so.
                                </p>
                                <p>
                                    <a runat="server" id="hypHome" href="http://cuchitunnels.vn/" target="_blank">Please click here to return to the main site.</a>.
                                </p>
                            </div>

                            <div class="package-media-wrapper gdl-image hidden">
                                <asp:Literal runat="server" ID="orderID_booking"></asp:Literal>
                                <asp:Literal runat="server" ID="sessionID_booking"></asp:Literal>
                                <asp:Literal runat="server" ID="price_booking"></asp:Literal>                              
                                  <asp:Literal runat="server" ID="ltrResponseData"></asp:Literal>                              

                            </div>
                        </div>
                    </div>
                </div>

                <!--Tour trip-->
                <div class="col-sm-3 col-md-3">

                    <dgc:block_right ID="block_right" runat="server" />
                </div>
                <!--Tour trip-->


            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>

<%--<div class="content-outer-wrapper mb31 divBooking " id="divDetail">
    <div class="content-wrapper container main ">
        <div class="page-wrapper single-blog single-sidebar right-sidebar">
            <div class="row gdl-page-row-wrapper">
                <div class="gdl-page-left mb0 twelve columns ">
                    <div class="row">
                        <div class="gdl-page-item mb0 pb20 gdl-package-full twelve columns">
                            <div class="package-media-wrapper gdl-image">

                                  <asp:Literal runat="server" ID="orderID_booking"></asp:Literal>
                                <asp:Literal runat="server" ID="sessionID_booking"></asp:Literal>

                                <asp:Literal runat="server" ID="ltrResult"></asp:Literal>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>--%>

<!--/BookingResutl-->
