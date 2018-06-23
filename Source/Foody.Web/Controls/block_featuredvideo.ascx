<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_featuredvideo.ascx.cs" Inherits="Cb.Web.Controls.block_featuredvideo" %>

<!--block_featuredvideo-->
<section runat="server" id="secCategory" class="divFeaturedvideo lox w-animate w-start_animation" data-stellar-background-ratio="0.7">    
    <div data-stellar-ratio="1" class="wpb_row vc_row-fluid " style="top: 10px;">
        <div class="container">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space2">
                        <div class="max-title max-title5">
                            <h4 class="hometitle2">Tour Video</h4>
                        </div>
                        <div class="vc_row wpb_row vc_inner vc_row-fluid">
                            <asp:Repeater runat="server" ID="rptVideoTop" OnItemDataBound="rptVideoTop_ItemDataBound">
                                <ItemTemplate>

                                    <div class="wpb_column vc_column_container vc_col-sm-4 vc_col-lg-4 vc_col-md-4 vc_col-xs-6">
                                        <div class="vc_column-inner ">
                                            <div class="wpb_wrapper">
                                                <hr class="vertical-space2">
                                                <article class="our-team4">
                                                    <figure>
                                                        <img runat="server" id="img">
                                                        <figcaption>
                                                            <h2>
                                                                <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                                                            </h2>
                                                            <h5>
                                                                <asp:Literal runat="server" ID="ltrBrief"></asp:Literal></h5>
                                                        </figcaption>

                                                    </figure>

                                                    <div class="social-team">
                                                        <a runat="server" id="hypVideo"
                                                            class="fancybox-media videolb video-play-btn" rel="media-gallery">
                                                            <i class="fa-play" style=""></i></a>
                                                    </div>
                                                </article>
                                                <hr class="vertical-space2">
                                            </div>
                                        </div>
                                    </div>

                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <hr class="vertical-space1">
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="container hidden">
    <div class="row">
        <div class="six columns feature-media-item-class feature-media-item-class-4">
            <div class="gdl-header-wrapper ">
                <i class="icon-facetime-video"></i>
                <h3 class="gdl-header-title">Featured Video</h3>
            </div>
            <div class="clear"></div>
            <div class="feature-media-wrapper">
                <div class="feature-media-thumbnail">
                    <div class="fluid-width-video-wrapper">
                        <iframe runat="server" id="ifrTop" width="100%" height="250px" allowfullscreen="true" ></iframe>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="feature-media-content-wrapper">
                    <h4 class="feature-media-title">More Cycling Adventure Videos</h4>
                    <div class="feature-media-content">
                        <asp:Repeater runat="server" ID="rptVideo">
                            <ItemTemplate>
                                <li><i class="fa fa-angle-double-right"></i><a runat="server" id="hypTitle" target="_blank">
                                    <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                                </a></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

            </div>
        </div>
        <div class="six columns blog-item-class blog-item-class-5 mb40 divTipTravel">
            <div class="gdl-header-wrapper navigation-on">
                <i class="icon-th-list"></i>
                <h3 class="gdl-header-title">Tips Before Travel</h3>
            </div>
            <div class="blog-item-holder">
                <asp:Repeater runat="server" ID="rptBlog">
                    <ItemTemplate>
                        <div class="gdl-blog-list">
                            <div class="blog-medium-media-wrapper">
                                <div class="blog-media-wrapper gdl-image">
                                    <a runat="server" id="hypImg">
                                        <img runat="server" id="img" /></a>
                                </div>
                            </div>
                            <div class="blog-content-wrapper">
                                <h2 class="blog-title"><a runat="server" id="hypTitle">
                                    <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></a></h2>
                                <div class="blog-date">
                                    <a runat="server" id="hypDate"><span class="head">Posted On </span>
                                        <asp:Literal runat="server" ID="ltrDate"></asp:Literal></a>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>
</div>
<!--/block_featuredvideo-->
