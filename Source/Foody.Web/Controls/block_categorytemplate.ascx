﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_categorytemplate.ascx.cs" Inherits="Cb.Web.Controls.block_categorytemplate" %>

<!--block_categorytemplate-->
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>
<%--<%@ Register TagPrefix="dgc" TagName="block_categorypagetemplate" Src="~/Controls/block_categorypagetemplate.ascx" %>--%>

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
                                    <%--<asp:Literal runat="server" ID="ltrCateName"></asp:Literal>--%>
                                    <asp:Literal runat="server" ID="ltrCateNameTitle"></asp:Literal>
                                </strong>
                                </h4>
                                <p style="text-align: center;">
                                    <asp:Literal runat="server" ID="ltrCategoryBrief"></asp:Literal>
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

                            <article class="esg-filters esg-singlefilters" style="margin-bottom: 30px; text-align: center;">
                                <div class="esg-navigationbutton esg-left  esg-fgc-5" style="margin-left: 2.5px !important; margin-right: 2.5px !important;"><i class="eg-icon-left-open"></i></div>
                                <div class="esg-filter-wrapper  esg-fgc-5" style="margin-left: 2.5px; margin-right: 2.5px;">
                                    <a runat="server" id="hypTitle1"></a>
                                    <div class="esg-filterbutton selected esg-allfilter" data-filter="filterall" data-fid="-1">
                                        <span>
                                            <asp:Literal runat="server" ID="ltrAll"></asp:Literal></span>
                                    </div>

                                    <asp:Repeater runat="server" ID="rptCategory" OnItemDataBound="rptCategory_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="esg-filterbutton" runat="server" id="divTitle">
                                                <span>
                                                    <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></span>
                                                <span class="esg-filter-checked">
                                                    <i class="eg-icon-ok-1"></i></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <div class="eg-clearfix"></div>

                                </div>

                                <!--drp cate-->
                                <div class="esg-sortbutton-wrapper  esg-fgc-4">
                                    <asp:DropDownList ID="drpCategory" runat="server" CssClass="dropdown" OnSelectedIndexChanged="drpCategory_onchange"
                                        AutoPostBack="True">
                                    </asp:DropDownList>
                                </div>

                                <!--drp sort-->
                                <div class="esg-sortbutton-wrapper  esg-fgc-4">
                                    <asp:DropDownList ID="drpSort" runat="server" CssClass="dropdown" OnSelectedIndexChanged="drpSort_onchange"
                                        AutoPostBack="True">
                                        <asp:ListItem Value="1" Text="Từ A-Z"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Từ Z-A"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="esg-navigationbutton esg-right  esg-fgc-5" style="margin-left: 2.5px !important; margin-right: 2.5px !important;">
                                    <i class="eg-icon-right-open"></i>
                                </div>
                            </article>

                            <div class="esg-clear-no-height"></div>

                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <ul id="category">
                                        <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
                                            <ItemTemplate>
                                                <li class="filterall filter-web-sites eg-w_jason-wrapper eg-post-id-5874" runat="server" id="liTilte">
                                                    <div class="esg-media-cover-wrapper">
                                                        <div class="esg-entry-media">
                                                            <span class="onsale" runat="server" id="divIsSale">Sale!</span>
                                                            <img runat="server" id="img" data-lazysrc="/Images/notepad-magazine-mockup-psd-1.jpg" alt="">
                                                        </div>
                                                        <div class="esg-entry-cover esg-fade" data-delay="0">
                                                            <div class="esg-overlay esg-fade eg-w_jason-container" data-delay="0"></div>
                                                            <div class="esg-center eg-post-5874 eg-w_jason-element-32-a esg-slide" data-delay="0.1">
                                                                <a class="eg-w_jason-element-32 eg-post-5874 esgbox" runat="server" id="hypImg" lgtitle="Portfolio Item 02"><i class="eg-icon-search"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="esg-entry-content eg-w_jason-content">
                                                            <div class="esg-content eg-post-5874 eg-w_jason-element-0">
                                                                <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                                                            </div>
                                                            <span class="price">
                                                                <asp:Literal runat="server" ID="ltrPrice"></asp:Literal>
                                                            </span>
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

<cc1:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender1" TargetControlID="UpdatePanel1"
    runat="server">
    <Animations>
                    <OnUpdating>
                       <Parallel duration="0">
                          
                            <EnableAction AnimationTarget="drpCategory_onchange" Enabled="false" />       
                                      <EnableAction AnimationTarget="drpSort_onchange" Enabled="false" />
                        </Parallel>
                    </OnUpdating>    
                    <OnUpdated>
                        <Parallel duration="0">
                            
                            <EnableAction AnimationTarget="drpCategory_onchange" Enabled="true" />   
                             <EnableAction AnimationTarget="drpSort_onchange" Enabled="true" />                   
                        </Parallel>
                    </OnUpdated>     
    </Animations>
</cc1:UpdatePanelAnimationExtender>

