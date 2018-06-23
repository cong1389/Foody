<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CategoryDetail.ascx.cs" Inherits="Cb.Web.Pages.CategoryManagement.CategoryDetail" %>

<!--CategoryDetail-->
<%@ Register TagPrefix="dgc" TagName="block_like" Src="~/Controls/block_like.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_programtour" Src="~/Controls/block_programtour.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_bookingprice" Src="~/Controls/block_bookingprice.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_googlemap_detail" Src="~/Controls/block_googlemap_detail.ascx" %>

<!--rating-->
<link href="/assets/my-includes/bootstrap-rating/star-rating.min.css" media="all" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='/assets/my-includes/bootstrap-rating/star-rating.min.js'></script>
<script type='text/javascript' src='/assets/my-includes/bootstrap-rating/themes/krajee-svg/theme.js'></script>
<script type='text/javascript' src='/assets/my-includes/bootstrap-rating/themes/locales/es.js'></script>

<link href="/Admin/Components/WebOne/css/plugins.min.css" rel="stylesheet" type="text/css" media="all" />
<link href="/Admin/Components/WebOne/css/components.min.css" rel="stylesheet" type="text/css" media="all" />


<!--Elevatezoom-->
<script type='text/javascript' src='/assets/wp-content/plugins/elevatezoom/jquery.elevateZoom-3.0.8.min.js'></script>
<link rel="stylesheet" href="http://www.elevateweb.co.uk/wp-content/themes/radial/jquery.fancybox.css" />
<script src="http://www.elevateweb.co.uk/wp-content/themes/radial/jquery.fancybox.pack.js" type="text/javascript"></script>

<%--<script type="text/javascript" src="http://webnus.biz/themes/easyweb/host/wp-content/plugins/js_composer/assets/js/dist/js_composer_front.min.js?ver=4.9.2"></script>--%>
<script type="text/javascript" src="http://webnus.biz/themes/easyweb/host/wp-content/plugins/essential-grid/public/assets/js/jquery.themepunch.tools.min.js?ver=2.0.9.1"></script>

<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<section class="container divDetail divCate">
    <!-- Start Page Content -->
    <hr class="vertical-space">

    <section id="content_left" class="woo-template col-md-8 ">

        <div id="product-67" class="post-67 product type-product status-publish has-post-thumbnail product_cat-accessories webnus-has-gallery shipping-taxable purchasable product-type-simple product-cat-accessories instock">

            <div class="images">
                <!--zoom-->
                <div class="zoom-wrapper row">
                    <div class="zoom-left">
                        <span style="display: none" class="onsale" runat="server" id="divIsSale">Sale!</span>
                        <asp:Literal runat="server" ID="ltrImgFirst"></asp:Literal>

                        <div id="gallery_01">
                            <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
                                <ItemTemplate>
                                    <asp:Literal runat="server" ID="ltrResutl"></asp:Literal>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>
                    </div>
                </div>
                <!--zoom-->
                <div id="anpsdownload-31" class="widget widget_anpsdownload">
                    <%--<h3 class="title text-uppercase">Social</h3>--%>
                    <%--<dgc:block_like id="block_like1" runat="server" />--%>
                </div>
            </div>

            <div class="summary entry-summary">
                <h1 class="product_title entry-title">
                    <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                </h1>

                <ul class="star">
                    <li class="">Tour Code: 
                        <asp:Literal runat="server" ID="ltrTourCode"></asp:Literal></li>
                    <li class="">Length: 
                        <asp:Literal runat="server" ID="ltrLength"></asp:Literal></li>
                    <li class="">Start From: 
                        <asp:Literal runat="server" ID="ltrStartFrom"></asp:Literal></li>
                    <li class="">Tour Type: 
                        <asp:Literal runat="server" ID="ltrTourType"></asp:Literal></li>
                </ul>

                <div>
                    <span class="price">
                        <asp:Literal runat="server" ID="ltrPrice"></asp:Literal>
                    </span>
                </div>

                <div itemprop="description">
                    <asp:Literal runat="server" ID="ltrBrief"></asp:Literal>
                </div>

                <article class="our-team3 clearfix">
                    <figure>
                        <img src="http://cuchitunnels.vn/Images/tchotel_2016_LL_TM-11655-2.jpg">
                    </figure>
                    <div class="tdetail">

                        <asp:UpdatePanel ID="udpAddToCard" runat="server" Visible="false">
                            <ContentTemplate>
                                <div class="cart pull-left">
                                    <div class="quantity hidden">
                                        <input id="txtQuantity" type="number" step="1" min="1" max="" name="quantity" value="1" title="Qty" class="input-text qty text" size="4">
                                    </div>
                                    
                                    <a class="button blue  small bordered-bot" href="/booking/vn" runat="server" id="hypBookingNow"><i class="li_truck"></i>Book now</a>
                                    <button type="submit" class="single_add_to_cart_button button alt" runat="server" id="imgBuy" visible="false">Add to cart</button>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <div class="clearfix"></div>
                        <div class="">
                            <dgc:block_like ID="block_like1" runat="server" />
                        </div>
                    </div>
                </article>

                <div class="clearfix"></div>

            </div>

            <!-- .summary -->
            <div class="woocommerce-tabs wc-tabs-wrapper">
                <ul class="tabs wc-tabs">
                    <li class="description_tab"><a href="#tab-Highlight">Highlight</a></li>
                    <li class="reviews_tab"><a href="#tab-Itinerary">Itinerary</a></li>
                    <li class="reviews_tab"><a href="#tab-Price">Price & Bookings</a></li>
                    <li class="reviews_tab"><a href="#tab-Reviews">Reviews</a></li>
                    <li class="reviews_tab"><a href="#tab-Video">Video</a></li>
                    <li class="reviews_tab"><a href="#tab-Maps">Maps</a></li>
                </ul>
                <div class="panel entry-content wc-tab" id="tab-Highlight">
                    <asp:Literal runat="server" ID="ltrDetail"></asp:Literal>
                </div>
                <div class="panel entry-content wc-tab" id="tab-Itinerary">
                    <dgc:block_programtour ID="block_programtour" runat="server" />
                    <asp:Literal runat="server" ID="ltrDetailedItinerary"></asp:Literal>
                </div>
                <div class="panel entry-content wc-tab" id="tab-Price">
                    <dgc:block_bookingprice ID="block_bookingprice" runat="server" />
                    <asp:Literal runat="server" ID="ltrPriceServices"></asp:Literal>
                </div>
                <div class="panel entry-content wc-tab" id="tab-Reviews">
                    <div class=" divRate">
                        <div class="boxRate ">
                            <input id="input-id" type="text" class="rating" data-size="md" data-show-clear="false" data-show-caption="false" />
                        </div>
                        <div class="col-xs-7" style="font-size: 43px;">
                            <asp:Literal runat="server" ID="ltrViewCount"></asp:Literal>
                        </div>
                    </div>
                </div>
                <div class="panel entry-content wc-tab" id="tab-Video">
                    <div class="embed-responsive embed-responsive-16by9 videobox">
                        <iframe runat="server" id="ifrVideo" class="embed-responsive-item" frameborder="0" allowfullscreen="true"></iframe>
                    </div>
                </div>
                <div class="panel entry-content wc-tab" id="tab-Maps">
                    <dgc:block_googlemap_detail ID="block_googlemap_detail" runat="server" />
                </div>
            </div>

            <%--<div class="wpb_wrapper">
                <section class="wpb_row  ">
                    <div class="wpb_column vc_column_container vc_col-sm-12">
                        <div class="vc_column-inner ">
                            <div class="wpb_wrapper">
                                <hr class="vertical-space1">
                                <div class="wpb_tabs wpb_content_element" data-interval="0">
                                    <div class="wpb_wrapper webnus-tabs wpb_tour_tabs_wrapper ui-tabs vc_clearfix">
                                        <ul class="wpb_tabs_nav ui-tabs-nav vc_clearfix">
                                            <li>
                                                <a href="#tab_1">Highlight
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#tab_2">Itinerary
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#tab_3">Price & Bookings
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#tab_4">Reviews
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#tab_5">Video
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#tab_6">Maps
                                                </a>
                                            </li>
                                        </ul>
                                        <div id="tab_1" class="wpb_tab ui-tabs-panel wpb_ui-tabs-hide vc_clearfix">

                                            <asp:Literal runat="server" ID="ltrDetail"></asp:Literal>

                                        </div>
                                        <div id="tab_2" class="wpb_tab ui-tabs-panel wpb_ui-tabs-hide vc_clearfix">

                                            <dgc:block_programtour ID="block_programtour" runat="server" />
                                            <asp:Literal runat="server" ID="ltrDetailedItinerary"></asp:Literal>

                                        </div>
                                        <div id="tab_3" class="wpb_tab ui-tabs-panel wpb_ui-tabs-hide vc_clearfix">

                                            <dgc:block_bookingprice ID="block_bookingprice" runat="server" />
                                            <asp:Literal runat="server" ID="ltrPriceServices"></asp:Literal>

                                        </div>

                                        <div id="tab_4" class="wpb_tab ui-tabs-panel wpb_ui-tabs-hide vc_clearfix">

                                            <div class="col-xs-12 divRate">
                                                <div class="boxRate col-xs-12">
                                                    <input id="input-id" type="text" class="rating" data-size="md" data-show-clear="false" data-show-caption="false" />
                                                </div>
                                                <div class="col-xs-7" style="font-size: 43px;">
                                                    <asp:Literal runat="server" ID="ltrViewCount"></asp:Literal>
                                                </div>
                                            </div>

                                        </div>

                                        <div id="tab_5" class="wpb_tab ui-tabs-panel wpb_ui-tabs-hide vc_clearfix">

                                            <div class="embed-responsive embed-responsive-16by9 videobox">
                                                <iframe runat="server" id="ifrVideo" class="embed-responsive-item" src="https://www.youtube.com/embed/zJJ_tz-_cX4" frameborder="0" allowfullscreen="true"></iframe>
                                            </div>

                                        </div>

                                        <div id="tab_6" class="wpb_tab ui-tabs-panel wpb_ui-tabs-hide vc_clearfix">

                                            <dgc:block_googlemap_detail ID="block_googlemap_detail" runat="server" />

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>--%>
        </div>
        <!-- #product-67 -->

    </section>
    <aside id="sidebar_right" class="col-md-3 col-md-offset-1 sidebar divProductHot">
        <div id="default-widget-area" class="widget-area">
            <ul class="xoxo">
                <li id="woocommerce_top_rated_products-2" class="widget-container woocommerce widget_top_rated_products">
                    <h3 class="widget-title"><span>Top Hot Products</span></h3>
                    <div class="sidebar-line"><span></span></div>
                    <ul class="product_list_widget">

                        <asp:Repeater runat="server" ID="rptProductHot" OnItemDataBound="rptProductHot_ItemDataBound">
                            <ItemTemplate>
                                <li>
                                    <a runat="server" id="hypTitle">
                                        <span style="display: none" class="onsale" runat="server" id="divIsSale">Sale!</span>
                                        <img width="120" height="160" runat="server" id="img" class="attachment-shop_thumbnail size-shop_thumbnail wp-post-image" alt="1218-450x600-450x600"
                                            sizes="(max-width: 120px) 100vw, 120px">
                                        <span class="product-title">
                                            <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                                        </span>
                                    </a>
                                    <div class="amount col-sm-9">
                                        <span class="price">
                                            <asp:Literal runat="server" ID="ltrPrice"></asp:Literal>
                                        </span>
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>

                    </ul>
                </li>
                <li id="woocommerce_product_categories-2" class="widget-container woocommerce widget_product_categories">
                    <h3 class="widget-title"><span>Product Sales</span></h3>
                    <div class="sidebar-line"><span></span></div>
                    <ul class="product_list_widget">

                        <asp:Repeater runat="server" ID="rptProductSale" OnItemDataBound="rptProductHot_ItemDataBound">
                            <ItemTemplate>
                                <li>
                                    <a runat="server" id="hypTitle">
                                        <img width="120" height="160" runat="server" id="img" class="attachment-shop_thumbnail size-shop_thumbnail wp-post-image" alt="1218-450x600-450x600"
                                            sizes="(max-width: 120px) 100vw, 120px">
                                        <span class="product-title">
                                            <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                                        </span>
                                    </a>
                                    <div class="amount col-sm-9">
                                        <span class="price">
                                            <asp:Literal runat="server" ID="ltrPrice"></asp:Literal>
                                        </span>
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>

                    </ul>
                </li>
            </ul>
        </div>
    </aside>
    <div class="clear"></div>
</section>



<script>
    jQuery(document).ready(function () {
        jQuery("#input-id").rating();
        //var heigthLeft = $('#slider1_container').height();
        ////alert(heigthLeft);
        //$('.divInfoTour ').css('height', heigthLeft + 47.6);
        //map = new google.maps.Map(document.getElementById('ctl00_mainContent_ctl00_block_googlemap_detail_GMap1'), '');
        //google.maps.event.trigger(map, 'resize');

        // initialize with defaults

       

        // with plugin options (do not attach the CSS class "rating" to your input if using this approach)
        // $("#input-id").rating({ 'size': 'md' }, cap);

       // SetSlideDetail();


    });


</script>
