<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Testimonial.ascx.cs" Inherits="Cb.Web.Pages.TestimonialManagement.Testimonial" %>

<!--Service-->
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>

<!--Category-->
<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<section class="container">

    <section class="wpb_row  ">
        <div class="wpb_column vc_column_container vc_col-sm-12">
            <div class="vc_column-inner ">

                <div class="wpb_wrapper">
                    <hr class="vertical-space2">
                    <div class="subtitle-element subtitle-element3">
                        <h4>Testimonial</h4>
                    </div>
                    <hr class="vertical-space1">
                    <div class="testimonial">

                        <div class="testimonial-list">

                            <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
                                <ItemTemplate>
                                    <div class="media">
                                        <div class="media-left">
                                            <img class="media-object img-circle" runat="server" id="Img" alt="...">
                                            <h5>
                                                <asp:Literal runat="server" ID="ltrTourCode"></asp:Literal>
                                            </h5>
                                        </div>
                                        <div class="media-body">
                                            <h3 class="widget-title"><span>
                                                <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></span></h3>

                                            <p>
                                                <asp:Literal runat="server" ID="ltrDate"></asp:Literal></p>

                                            <div class="star-list" style="color: #d99e00;"><span aria-hidden="true" class="glyphicon glyphicon-star"></span><span aria-hidden="true" class="glyphicon glyphicon-star"></span><span aria-hidden="true" class="glyphicon glyphicon-star"></span><span aria-hidden="true" class="glyphicon glyphicon-star"></span><span aria-hidden="true" class="glyphicon glyphicon-star"></span></div>

                                            <p>
                                                <asp:Literal runat="server" ID="ltrBrief"></asp:Literal></p>

                                            <a runat="server" id="hypContinus">Readmore</a>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>
                    </div>
                </div>

            </div>
        </div>

    </section>

</section>


<!--Padding-->
<cc:Pager ID="pager" runat="server" EnableViewState="true" OnCommand="pager_Command" CompactModePageCount="10" MaxSmartShortCutCount="0" RTL="False" PageSize="9" />
