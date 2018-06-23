<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Picture.ascx.cs" Inherits="Cb.Web.Pages.GalleryManagement.Picture" %>

<!--Gallery-->
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>

<div class="header-outer-wrapper no-top-slider" runat="server" id="divBoxTop">
    <asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>
</div>

<section class="divFeaturedvideo blox  borderd w-animate  w-start_animation" style="padding-top: px; padding-bottom: px; background-size: cover; min-height: px; background-color: #f9f9f9;" data-stellar-background-ratio="0.7">
    <div class="max-overlay" style="background-color: "></div>
    <div data-stellar-ratio="1" class="wpb_row vc_row-fluid " style="top: 10px;">
        <div class="container">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space2">
                        <div class="max-title max-title5">
                            <h4 class="hometitle2">
                                <asp:Literal runat="server" ID="ltrHeader"></asp:Literal></h4>
                        </div>
                        <div class="vc_row wpb_row vc_inner vc_row-fluid">
                            <div class="gallery1 mb17 photobox-lightbox">
                                <asp:Repeater runat="server" ID="rptImg" OnItemDataBound="rptImg_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="wpb_column vc_column_container col-sm-3">
                                            <div class='shadow'>
                                                <a runat="server" id="hypImgThumb">
                                                    <div class="b-link-flow b-animate-go">
                                                        <img runat="server" id="img" class="gall-img-responsive"/>
                                                        <div class="b-wrapper">
                                                            <p class="b-from-right b-animate b-delay03">
                                                                <i class="fa fa-arrows-alt fa-3x"></i>
                                                                <img runat="server" id="imgThumb" class="gall-img-responsive" style="display: none !important; visibility: hidden"/>
                                                            </p>
                                                        </div>
                                                    </div>

                                                    <!--Gallery Label-->
                                                    <div class="lbsp_home_portfolio_caption">
                                                        <h3>
                                                            <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                                                        </h3>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <hr class="vertical-space2">
                    </div>
                    <!--Padding-->
                    <cc:Pager ID="pager" runat="server" EnableViewState="true" OnCommand="pager_Command" CompactModePageCount="10" MaxSmartShortCutCount="0" RTL="False" PageSize="9" />

                </div>
            </div>
        </div>
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
                                                            <img runat="server" id="img" />
                                                        </div>
                                                        <div class="esg-entry-cover esg-fade" data-delay="0">                                                           
                                                            <div class="esg-overlay esg-fade eg-w_jason-container" data-delay="0"></div>
                                                            <div class="esg-center eg-post-5874 eg-w_jason-element-32-a esg-slide" data-delay="0.1">                                                              
                                                                <a class="eg-w_jason-element-32 eg-post-5874 esgbox"
                                                                    runat="server" id="hypImg"
                                                                    lgtitle="Portfolio Item 02"><i class="eg-icon-search"></i></a>
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
                                            <cc:Pager ID="pager1" runat="server" EnableViewState="true" OnCommand="pager_Command"
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

<!-- Photo box-->
<script>
    $('.photobox-lightbox').photobox('a');
    // or with a fancier selector and some settings, and a callback:
    $('.photobox-lightbox').photobox('a:first', { thumbs: false, time: 0 }, imageLoaded);
    function imageLoaded() {
        console.log('image has been loaded...');
    }
</script>
