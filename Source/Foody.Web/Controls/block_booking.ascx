<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_booking.ascx.cs" Inherits="Cb.Web.Controls.block_booking" %>

<!--block_booking-->
<%@ Register TagPrefix="dgc" TagName="block_bookingprice" Src="~/Controls/block_bookingprice.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_sessiontimeout" Src="~/Controls/block_sessiontimeout.ascx" %>

<%--<script type="text/javascript" src="http://cuchitunnels.vn/assets/wp-includes/js/jquery/jqueryc1d8.js?ver=1.11.3"></script>--%>
<!-- bootstrap-touchspin -->
<script type="text/javascript" src="/Admin/Components/bootstrap-touchspin/bootstrap.touchspin.js"></script>
<link rel="stylesheet" type="text/css" href="/Admin/Components/bootstrap-touchspin/bootstrap.touchspin.css" />

<!-- bootstrap-wizard-->
<script type="text/javascript" src="/Admin/Components/bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
<script src="/Admin/Components/WebOne/js/form-wizard.min.js" type="text/javascript"></script>

<!-- BEGIN PAGE LEVEL PLUGINS -->
<link href="/Admin/Components/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<link href="/Admin/Components/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
<script src="/Admin/Components/select2/js/select2.full.min.js" type="text/javascript"></script>
<script src="/Admin/Components/WebOne/js/jquery.validate.min.js" type="text/javascript"></script>

<script src="/Admin/Components/bootstrap-tabdrop/js/bootstrap-tabdrop.js" type="text/javascript"></script>
<link href="/Admin/Components/WebOne/css/plugins.min.css" rel="stylesheet" type="text/css" media="all" />
<link href="/Admin/Components/WebOne/css/components.min.css" rel="stylesheet" type="text/css" media="all" />
<script src="/Admin/Components/WebOne/js/app.min.js" type="text/javascript"></script>

<link rel="stylesheet" href="/assets/wp-content/plugins/Jquery-ui/jquery-ui.css" />

<!-- bootstrap-select.min -->
<link rel="stylesheet" href="/Admin/Components/bootstrap-select/bootstrap-select.min.css" />
<script src="/Admin/Components/bootstrap-select/bootstrap-select.min.js"></script>

<!--Flag icon-->
<link href="/Styles/flag-icon.min.css" rel="stylesheet" type="text/css" media="all" />
<%--<link href="/Styles/docs.css" rel="stylesheet" type="text/css" media="all" />--%>
<script src="/Styles/docs.js"></script>

<%--<iframe id="widgetMataf" src="https://www.mataf.net/vi/widget/conversiontab-USD-VND?list=&amp;a=100" style="border: none; overflow:hidden; background-color: transparent; height: 290px; width: 300px"></iframe>--%>

<%--<iframe id="widgetMataf" runat="server"></iframe>--%>

<div class="divblock_booking portlet light bordered" id="form_wizard_1">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-credit-card font-red"></i>
            <span class="caption-subject font-red bold uppercase">Booking - <span class="step-title">Step 1 of 4 </span>
            </span>
        </div>

    </div>
    <div class="portlet-body form">
        <form class="form-horizontal" id="submit_form">
            <div class="form-wizard">
                <div class="form-body mt-element-step">

                    <ul class="nav nav-pills nav-justified steps step-line">
                        <li class=" mt-step-col first done">
                            <a href="#tab1" data-toggle="tab" class="step">
                                <div class=" mt-step-title">
                                    <div class="mt-step-number bg-white"><i class="fa fa-credit-card"></i></div>
                                    <div class="mt-step-content font-grey-cascade">
                                        <h4>1. Review Order</h4>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class=" mt-step-col   ">
                            <a href="#tab2" data-toggle="tab" class="step">
                                <div class=" mt-step-title">
                                    <div class="mt-step-number bg-white"><i class="fa fa-user"></i></div>
                                    <div class="desc mt-step-content font-grey-cascade">
                                        <h4>2. Secure Checkout</h4>
                                    </div>
                                </div>
                            </a>
                        </li>

                        <li class=" mt-step-col last">
                            <a href="#tab3" data-toggle="tab" class="step">
                                <div class=" mt-step-title">
                                    <div class="mt-step-number bg-white"><i class="fa fa-rocket"></i></div>
                                    <div class="mt-step-content font-grey-cascade">
                                        <h4>3. Other Info</h4>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <%-- <li class=" mt-step-col last">
                            <a href="#tab4" data-toggle="tab" class="step">
                                <div class=" mt-step-title">
                                    <div class="mt-step-number bg-white"><i class="fa fa-info-circle"></i></div>
                                    <div class="mt-step-content font-grey-cascade">
                                        <h4>4. Booking Completed</h4>
                                    </div>
                                </div>
                            </a>
                        </li>--%>
                    </ul>
                    <div id="Div1" class="progress progress-striped" role="progressbar">
                        <div class="progress-bar progress-bar-success"></div>
                    </div>
                    <div class="tab-content">
                        <div class="alert alert-danger display-none">
                            <button class="close" data-dismiss="alert"></button>
                            You have some form errors. Please check below.
                        </div>
                        <div class="alert alert-success display-none">
                            <button class="close" data-dismiss="alert"></button>
                            Your form validation is successful!
                        </div>
                        <div class="tab-pane active" id="tab1">
                            <h4 class="form-section">Enter Booking Detail</h4>
                            <div class="row">
                                <div class="col-md-12 ">
                                    <div class="form-group">
                                        <label>Request tour</label>
                                        <input type="text" readonly name="tourTitle" runat="server" id="txtRequestTour" class="form-control" value="Essential Mekong Delta – 2 days" required="required" aria-required="true">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Departure Date (MM/dd/yyyy)</label>
                                        <div class='input-group date' id='datetimepicker1'>
                                            <input type='text' class="form-control" id="txtExpectedDepartureDate" runat="server" placeholder="mm/dd/yyyy" />
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Tour group</label>
                                        <asp:DropDownList ID="drpTourGroup" runat="server" CssClass="form-control" disabled>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6 hidden">
                                    <div class="form-group">
                                        <label>Price class</label>
                                        <asp:DropDownList ID="drpPriceClass" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row">

                                <!--/span-->
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>No. of adults</label>
                                        <input id="txtNumberAduts" runat="server" type="text" value="1" name="demo_vertical" class="touchpin form-control">
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>No. of child</label>
                                        <input id="txtNumberChild" runat="server" type="text" value="0" name="demo_vertical" class="touchpin form-control" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>No. of infant</label>
                                        <input id="txtNumberInfant" runat="server" type="text" value="0" name="demo_vertical" class="touchpin form-control" />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label">Select Payment</label>
                                        <select class="form-control " data-live-search="true" data-size="8" id="drpPaymentType" runat="server">
                                            <option value="1">By Cash</option>
                                            <option value="2" selected>By Visa/MasterCard/JCB</option>
                                            <option value="3">By Paypal</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label"></label>
                                        <div class="clearfix payment-methods">
                                            <span class="visa" title="Visa"></span>
                                            <span title="Master card"></span>
                                            <span class="paypalt" title="Paypal"></span>
                                            <span class="jcba" title="jcba"></span>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>

                            <div class="row">
                                <section class="three-fourth">
                                    <div id="booking" class="booking col-sm-12">
                                        <table id="cart" class='portlet box yellow'>
                                            <thead>
                                                <tr>
                                                    <th>Type
                                                    </th>
                                                    <th class="name">Name
                                                    </th>
                                                    <th>Total price
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr style="background-color: rgba(255,255,255,0.7);">
                                                    <td data-th="Type">
                                                        <span class="bt-content">Tour</span>
                                                    </td>
                                                    <td>
                                                        <span class="bt-content" id="spanTourName" runat="server">adafsd</span>
                                                    </td>
                                                    <td class="total">
                                                        <span class="bt-content">
                                                            <strong class="left"></strong>
                                                            <span class="right" id="spanPrice"></span>
                                                            <br>
                                                        </span>

                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>
                                        <table id="cart" style="margin-top: 10px;" class='table table-bordered'>
                                            <tbody>
                                                <tr class="total">
                                                    <td class="text-right portlet " style="white-space: nowrap; width: 75%">
                                                        <strong>COST:</strong>
                                                    </td>
                                                    <td class="text-right danger" style="color: #37A8A3; font-weight: bold; width: 100px; font-family: Oxygen; font-size: 16px;">
                                                        <span class="right" id="spanCost"></span>
                                                    </td>
                                                </tr>
                                                <tr class="total">
                                                    <td class="text-right portlet " style="white-space: nowrap; width: 75%">
                                                        <strong>Tax 10% &amp; Service Charge 5%:</strong>
                                                    </td>
                                                    <td class="text-right danger" style="color: #37A8A3; font-weight: bold; width: 100px; font-family: Oxygen; font-size: 16px;">
                                                        <span class="right" id="spanTax"></span>
                                                    </td>
                                                </tr>
                                                <tr class="total">
                                                    <td class="text-right portlet " style="white-space: nowrap; width: 75%">
                                                        <strong>FINAL COST (USD):</strong>
                                                    </td>
                                                    <td class="text-right danger" style="color: #F37021; font-weight: bold; width: 100px; font-family: Oxygen; font-size: 16px;">
                                                        <span class="right" id="spanFinalCost"></span>
                                                    </td>
                                                </tr>
                                                <tr class="total">
                                                    <td class="text-right portlet " style="white-space: nowrap; width: 75%">
                                                        <strong>Exchange to (VND):</strong>
                                                    </td>
                                                    <td class="text-right danger" style="color: #F37021; font-weight: bold; width: 100px; font-family: Oxygen; font-size: 16px;">
                                                        <span class="right" id="spanExchangeVND"></span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <div class="row">
                                            <table class='portlet box yellow text-center'>
                                                <thead>
                                                    <tr>
                                                        <th class="text-center">Currency converter</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr style="background-color: rgba(255,255,255,0.7);">
                                                        <td data-th="Type">
                                                            <label class="control-label">1$</label>= 
                                                             <label class="control-label">
                                                                 <span class="right" id="spanExchangeCurrent"></span>
                                                             </label>
                                                        </td>
                                                    </tr>

                                                </tbody>
                                            </table>

                                        </div>

                                        <div class="row">
                                            <div class="">
                                                <div class="form-group">
                                                    <div class="alert alert-danger">
                                                        <h4><i class="fa fa-chain-broken fa-fw"></i>By law, we only accept VNĐ for payment for any international transaction</h4>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </section>
                            </div>


                        </div>
                        <div class="tab-pane " id="tab2">

                            <h4 class="form-section">Enter Contact Detail</h4>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label">First name</label>
                                        <input runat="server" id="txtFirstName" type="text" name="hoten" value="" class="form-control" placeholder="Enter your first name" required aria-required="true">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label">Last name</label>
                                        <input runat="server" id="txtLastName" type="text" name="hoten" value="" class="form-control" placeholder="Enter your last name" required aria-required="true">
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->



                            <%-- <div class="form-inline margin-bottom-10">--%>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label">Country</label>
                                        <select class="bs-select form-control " data-live-search="true" data-size="8" id="drpCountry" runat="server"></select>
                                    </div>

                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label">Phone number</label>
                                        <div class="input-icon">
                                            <i class="fa fa-phone font-blue"></i>
                                            <asp:TextBox name="number" runat="server" ID="txtPhoneNumber" class="form-control " placeholder="Enter your phone number" required="required" aria-required="true" />

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--</div>--%>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label">City</label>

                                        <select class="form-control" data-live-search="true" data-size="8" id="drpCity" runat="server"></select>
                                    </div>

                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label">E-mail</label>
                                        <div class="input-icon">
                                            <i class="fa fa-envelope font-blue"></i>
                                            <asp:TextBox type="email" name="input_group" runat="server" ID="txtEmail" class="form-control " placeholder="Enter your email address" required="required" aria-required="true" />
                                        </div>

                                    </div>
                                </div>
                            </div>



                            <div class="row">
                                <div class="col-md-12">
                                </div>

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Pick-up Location</label>
                                        <asp:TextBox ID="txtPickUpLocation" runat="server" TextMode="MultiLine" placeholder="Pick up Location (Hotel's Name & Address)" CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>
                                <!--/span-->

                                <!--/span-->
                                <div class="col-md-6 hidden">
                                    <div class="form-group">
                                        <label>Country</label>
                                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->

                        </div>

                        <div class="tab-pane" id="tab3">
                            <h4 class="form-section">Customer Information</h4>
                            <div class="row">
                                <div class="col-md-12 ">
                                    <div class="form-group">
                                        <label>Distance Biking(km)</label>
                                        <select name="paymentMe" class="form-control" runat="server" id="drpDistance">
                                            <option value="">[Select]</option>
                                            <option value="25-35 km">25-35 km</option>
                                            <option value="35-55 km">35-55 km</option>
                                            <option value="55-85 km">55-85 km</option>
                                        </select>
                                    </div>
                                </div>


                            </div>
                            <div class="row " runat="server" id="divTourByHour">
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Flight Arrival No</label>
                                        <asp:TextBox ID="txtFlightArrivalNo" runat="server" TextMode="MultiLine" placeholder="Flight Arrival No" CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Flight Arrival Time</label>
                                        <asp:TextBox ID="txtFlightArrialTime" runat="server" TextMode="MultiLine" placeholder="Flight Arrival Time" CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <div class="row " runat="server" id="divTourByHour_Arrival">
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Flight Arrival Date</label>
                                        <asp:TextBox ID="txtFlightArrivalDate" runat="server" TextMode="MultiLine" placeholder="Flight Arrival Date" CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Flight Departure Time</label>
                                        <asp:TextBox ID="txtFlightDepartureTime" runat="server" TextMode="MultiLine" placeholder="Flight Departure Time" CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <div class="row" runat="server" id="divTourByHour_Departure">
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Flight Departure Date</label>
                                        <asp:TextBox ID="txtFlightDepartureDate" runat="server" TextMode="MultiLine" placeholder="Flight Departure Date" CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Customer’s Personal Requirement Information</label>
                                        <asp:TextBox ID="txtCustomerHeight" runat="server" TextMode="MultiLine" placeholder="Customer’s Height" CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-12 ">
                                    <div class="form-group">
                                        <label>Customer’s Age (List All)</label>
                                        <asp:TextBox ID="txtCustomerAge" runat="server" TextMode="MultiLine" placeholder="Customer’s Age " CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>


                            </div>

                            <div class="row hidden">
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Hotel’s Name</label>
                                        <asp:TextBox ID="txtHotelName" runat="server" TextMode="MultiLine" placeholder="Hotel’s Name" CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Hotel’s Address</label>
                                        <asp:TextBox ID="txtHotelAddress" runat="server" TextMode="MultiLine" placeholder="Hotel’s Address" CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>

                            </div>

                            <div class="row" runat="server" id="divTourByHour_TypeHotel">
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Type of hotels</label>
                                        <select name="hotel_type" class="form-control" runat="server" id="drpHotel">
                                            <option value="">[Select]</option>
                                            <option value="2">2 star</option>
                                            <option value="3">3 star</option>
                                            <option value="4">4 star</option>
                                            <option value="5">5 star</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Arrival port</label>
                                        <select name="arrival_port" class="form-control" runat="server" id="drpArrival">
                                            <option value="">[Select]</option>
                                            <option value="Ha Noi [Noi Bai International Airport]">Ha Noi [Noi Bai International Airport]</option>
                                            <option value="Da Nang [Da Nang International Airport]">Da Nang [Da Nang International Airport]</option>
                                            <option value="Ho Chi Minh [Tan Son Nhat International Airport]">Ho Chi Minh [Tan Son Nhat International Airport]</option>
                                        </select>
                                    </div>
                                </div>

                            </div>
                            <div class="row" runat="server" id="divTourByHour_TypeRoom">
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Room type</label>
                                        <select name="roomType" required="required" class="validation-field form-control" aria-required="true" runat="server" id="drpRoomType">
                                            <option value="0" selected="selected">Standard room</option>
                                            <option value="1">Superior room</option>
                                            <option value="2">Deluxe room</option>
                                            <option value="3">Suite room</option>
                                            <option value="4">Other</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Others room</label>
                                        <input type="text" name="otherRoom" value="" maxlength="100" class="form-control form-control" placeholder="" runat="server" id="txtRoomOther">
                                    </div>
                                </div>

                            </div>
                            <div class="row" runat="server" id="divTourByHour_BedType">
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Bed type</label>
                                        <select name="bedType" required="required" class="validation-field form-control" aria-required="true" runat="server" id="drpBedType">
                                            <option value="0" selected="selected">Single</option>
                                            <option value="1">Double</option>
                                            <option value="2">Twin</option>
                                            <option value="3">Triple</option>
                                            <option value="4">Quard</option>
                                            <option value="5">Family</option>
                                            <option value="6">Other</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Others bed</label>
                                        <input type="text" name="otherBed" value="" maxlength="100" class="form-control form-control" placeholder="" runat="server" id="txtBedOther">
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-6 ">
                                    <div class="form-group">
                                        <label>Do you need our visa service?</label>
                                        <div class="col-md-12  radio-list">
                                            <label class="radio-inline">
                                                <div class="radio">
                                                    <span>
                                                        <input type="radio" name="visa_service" value="1" runat="server" id="rdVisaYes"></span>
                                                </div>
                                                Yes
                                            </label>
                                            <label class="radio-inline ">
                                                <div class="radio">
                                                    <span class="checked">
                                                        <input type="radio" name="visa_service" value="0" runat="server" id="rdVisaNo" checked></span>
                                                </div>
                                                No
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 hidden">
                                    <div class="form-group">
                                        <label>Others bed</label>

                                    </div>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-md-12 ">
                                    <div class="form-group">
                                    </div>
                                </div>


                            </div>

                            <div class="row">
                                <div class="col-md-12 ">
                                    <div class="form-group">
                                        <label>Height's Information</label>
                                        <asp:TextBox ID="txtSpecialRequest" runat="server" TextMode="MultiLine" placeholder="Height's Information" CssClass="form-control "></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <%--<div class="tab-pane" id="tab4">
                            <h4 class="form-section">Booking Completed</h4>
                            

                        </div>--%>
                    </div>
                </div>
                <div class="form-actions">
                    <div class="row">
                        <div class="col-md-offset-3 col-md-9">
                            <a href="javascript:;" class="btn btn-outline blue button-previous">
                                <i class="fa fa-angle-double-left"></i>Back </a>

                            <a href="javascript:;" class="btn blue button-next">Continue<i class="fa fa-angle-double-right"></i></a>

                            <asp:Button ID="btnSend" runat="server" class="button theme-skin  medium  " Text="Check Out Now"
                                OnClick="btnSend_ServerClick" />
                            <%-- <a href="javascript:;" class="btn blue button-submit">Submit
                                                           
                                                        <i class="fa fa-check"></i>
                            </a>--%>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<dgc:block_bookingprice ID="block_bookingprice" runat="server" Visible="false" />

<script>

    $(document).ready(function () {
        GetBooking_Price();
        GetExchangeCurrent();

        $('#<%=txtExpectedDepartureDate.ClientID%>').datepicker();

        //Change value
        $('#<%=drpPriceClass.ClientID%>').change(function () {
            GetBooking_Price();
        });
        $('#<%=drpTourGroup.ClientID%>').change(function () {
            GetBooking_Price();
        });

        var txtNumberAduts = $("#<%=txtNumberAduts.ClientID%>");
        txtNumberAduts.on("change", function () {
            GetBooking_Price();
        });

        var txtNumberChild = $("#<%=txtNumberChild.ClientID%>");
        txtNumberChild.on("change", function () {
            GetBooking_Price();
        });

        var txtNumberInfant = $("#<%=txtNumberInfant.ClientID%>");
        txtNumberInfant.on("change", function () {
            GetBooking_Price();
        });

        //Change country
        $('#<%=txtPhoneNumber.ClientID%>').val('00 ' + $('#<%=drpCountry.ClientID%> option:selected').val());
        GetCity();
        $('#<%=drpCountry.ClientID%>').change(function () {
            countryId = $('#<%=drpCountry.ClientID%> option:selected').val();
            $('#<%=txtPhoneNumber.ClientID%>').val(countryId);

            GetCity();
        });

        //Chance city
        $('#<%=hddDrpCityValue.ClientID%>').val($('#<%=drpCountry.ClientID%> option:selected').val());
        $('#<%=drpCity.ClientID%>').change(function () {
            cityId = $('#<%=drpCity.ClientID%> option:selected').val();
            $('#<%=hddDrpCityValue.ClientID%>').val(cityId);

          //  GetCity();
        });

    });

    function GetBooking_Price() {
        var param = {};
        param.productId = $('#<%=hddProductId.ClientID%>').val();
        param.priceClass = $('#<%=drpPriceClass.ClientID%> option:selected').text();
        param.groupType = $('#<%=drpTourGroup.ClientID%> option:selected').text();
        param.adults = $('#<%=txtNumberAduts.ClientID%>').val();
        param.child = $('#<%=txtNumberChild.ClientID%>').val();
        param.infant = $('#<%=txtNumberInfant.ClientID%>').val();

        jQuery.ajax({
            type: "POST",
            url: "/WebServices/Service.asmx/GetBooking_Person",
            data: JSON.stringify(param),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (result) {
                var price = result.d[0];
                var finalCost = result.d[2];
                var exchangeCost = result.d[3];


                $("#spanPrice").html('$ ' + price);
                $("#spanCost").html('$ ' + price);

                $("#spanTax").html('$ ' + result.d[1]);
                $("#spanFinalCost").html('$ ' + finalCost);
                $("#spanExchangeVND").html('VND ' + exchangeCost);


                $('#<%=hddPriceSumValue.ClientID%>').val(exchangeCost);
            },
            error: function (x) {
                alert("error:" + x.responseText);
            }
        });
    }

    function GetCity() {
        var param = {};
        param.phoneCode = $('#<%=drpCountry.ClientID%>').val();

        jQuery.ajax({
            type: "POST",
            url: "/WebServices/Service.asmx/GetCity",
            data: JSON.stringify(param),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (data) {
                $('#<%=drpCity.ClientID%>').empty();
                $.each(data.d, function (key, value) {
                 
                   $('#<%=drpCity.ClientID%>').append("<option value='" + this['Value'] + "'>" + this['Text'] + "</option>");

                });
            },
            error: function (x) {
                alert("error:" + x.responseText);
            }
        });
    }


    //Get exchange currency
    function GetExchangeCurrent() {
        jQuery.ajax({
            type: "POST",
            url: "/WebServices/Service.asmx/GetExchangeRate",
            data: "",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (result) {
                //$("#spanExchangeCurrent").html(FormatHelper.FormatDonviTinh(DBConvert.ParseDouble(result.d), enuCostId.dong, new CultureInfo("vi-VN")));
                $("#spanExchangeCurrent").html('VND ' + result.d);
            },
            error: function (x) {
                alert("error:" + x.responseText);
            }
        });
    }
</script>

<asp:HiddenField runat="server" ID="hddProductId" />
<asp:HiddenField runat="server" ID="hddPriceSumValue" />
<asp:HiddenField runat="server" ID="hddDrpCityValue" />


<%--<dgc:block_sessiontimeout ID="block_sessiontimeout" runat="server" />--%>

<!--/block_booking-->
