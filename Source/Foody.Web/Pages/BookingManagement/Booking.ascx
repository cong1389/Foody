<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Booking.ascx.cs" Inherits="Cb.Web.Pages.BookingManagement.Booking" %>

<!--Category-->
<%@ Register TagPrefix="dgc" TagName="block_booking" Src="~/Controls/block_booking.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_right" Src="~/Controls/block_right.ascx" %>

<div class="header-outer-wrapper " runat="server" id="divBoxTop">  
    <asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>
</div>
<hr class="vertical-space">
<div class="content-outer-wrapper mb31 divBooking " id="divDetail">
    <div class="content-wrapper container main ">
        <div class="page-wrapper single-blog single-sidebar right-sidebar">
            <div class="row gdl-page-row-wrapper">
                <div class="col-sm-9 col-md-9 ">
                    <div class="row">
                        <div class="gdl-page-item mb0 pb20 gdl-package-full twelve columns">
                            <div class="package-media-wrapper gdl-image">                              

                                <dgc:block_booking ID="block_booking" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>

                <!--Tour trip-->
                <div class=" portlet light bordered col-sm-3 col-md-3">                   

                    <dgc:block_right ID="block_right" runat="server" />
                </div>
                <!--Tour trip-->


            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>




