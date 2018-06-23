﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Video.ascx.cs" Inherits="Cb.Web.Pages.GalleryManagement.Video" %>


<!--Video-->
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>
<%@ Register TagPrefix="dgc" TagName="top_menu" Src="~/Controls/top_menu.ascx" %>

<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<section id="main-content" class="">
    <div class="row-wrapper-x">
        <section class="wpb_row   w-animate">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner vc_custom_1455539781302">
                    <div class="wpb_wrapper">
                        <div class="wpb_text_column wpb_content_element  wpb_animate_when_almost_visible wpb_appear">
                            <div class="wpb_wrapper">
                                <hr class="vertical-space2">
                                <h4 style="text-align: center;"><strong>
                                    <asp:Literal runat="server" ID="ltrCateName"></asp:Literal>
                                </strong>
                                </h4>
                                <p style="text-align: center;">
                                    <asp:Literal runat="server" ID="ltrCateBrief"></asp:Literal>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</section>

<section class="container divCate divCateTemplate">
    <div class="wpb_row   w-animate full-row">
        <div class="wpb_column vc_column_container vc_col-sm-12">
            <div class="vc_column-inner vc_custom_1455539811334">
                <div class="wpb_wrapper">

                    <article class="myportfolio-container flat-dark" id="esg-grid-5-1-wrap">
                        <div id="esg-grid-5-1" class="esg-grid" style="background-color: transparent; padding: 0px 0px 0px 0px; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;">

                            <div class="esg-clear-no-height"></div>

                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <ul id="category">
                                        <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
                                            <ItemTemplate>
                                                <li class="filterall filter-web-sites eg-w_jason-wrapper eg-post-id-5874" runat="server" id="liTilte">
                                                    <div class="esg-media-cover-wrapper">
                                                        <div class="esg-entry-media">
                                                            <img runat="server" id="img" data-lazysrc="/Images/notepad-magazine-mockup-psd-1.jpg" alt="">
                                                        </div>
                                                        <div class="esg-entry-cover esg-fade" data-delay="0">                                                          
                                                            <div class="esg-overlay esg-fade eg-w_jason-container" data-delay="0"></div>
                                                            <div class="esg-center eg-post-5874 eg-w_jason-element-32-a esg-slide" data-delay="0.1">                                                               
                                                                <a class="eg-w_jason-element-32 eg-post-5874 esgbox"
                                                                    runat="server" id="hypImg"
                                                                    lgtitle="Portfolio Item 02">
                                                                    <i class="eg-icon-search"></i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <div class="esg-entry-content eg-w_jason-content">
                                                            <div class="esg-content eg-post-5874 eg-w_jason-element-0">
                                                                <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                                                            </div>                                                           
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>

                                    <!--Padding-->
                                    <div class="container">
                                        <div class="woo-template col-md-12 ">
                                            <cc:Pager ID="pager" runat="server" EnableViewState="true" OnCommand="pager_Command"
                                                CompactModePageCount="10" MaxSmartShortCutCount="0" RTL="False" PageSize="9" />
                                        </div>
                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                    </article>

                    <div class="clear"></div>
                    <hr class="vertical-space5">
                </div>
            </div>
        </div>
    </div>
</section>

<!--/Video-->