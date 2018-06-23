<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_productrelate.ascx.cs"
    Inherits="Cb.Web.Controls.block_productrelate" %>

<!--block_productrelate-->

<div class="vc_row wpb_row vc_row-fluid vc_custom_1450769414071 wpb_padding" runat="server" id="divProductRelease">
    <div class="wpb_column vc_column_container vc_col-sm-12">
        <div class="vc_column-inner ">
            <div class="wpb_wrapper">
                <div class="st-heading style-1 text-center">
                    <h3 class="box-title">
                        <a runat="server" id="hypAll">
                            <asp:Literal runat="server" ID="ltrProductRelate"></asp:Literal></a>
                    </h3>
                    <div class="box-content hidden"><strong>We are the Expert</strong> on this Field, Better Building Solutions.</div>
                </div>

                <div class="st-portfolio divCate">
                    <div class="portfolioHolder portfolioc7bad122a6666a2e4d48b17258409b04 row" data-layout="fitRows" style="position: relative; height: 270px;">
                        <div id="owl-example" class="owl-carousel">
                            <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
                                <ItemTemplate>
                                    <div>
                                        <div class="post-item building">
                                            <div class="portfolio-container style-1">
                                                <div class="portfolio-image">
                                                    <img width="600" height="400"
                                                        runat="server" id="img" class="attachment-slicetheme-portfolio size-slicetheme-portfolio wp-post-image" alt="portfolio12"
                                                        sizes="(max-width: 600px) 100vw, 600px"><div class="zoom-overlay"></div>
                                                </div>
                                                <div class="portfolio-content">
                                                    <h4>
                                                        <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></h4>
                                                    <div class="portfolio-link">
                                                        <a runat="server" id="hypContinus">
                                                            <asp:Literal runat="server" ID="ltrContinus"></asp:Literal></a>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>

                <div class="ssb-share packslide">
                    <a target="_blank" class="fb" runat="server" id="hypFB">
                        <span class="icon"></span>
                        <span class="count">0</span>
                    </a>
                    <a target="_blank" class="gplus" runat="server" id="hypGooglePlus"><span class="icon"></span><span class="count">1</span></a>
                    <a target="_blank" class="twitter" runat="server" id="hypTwitter"><span class="icon"></span><span class="count">0</span></a>
                    <a target="_blank" class="linkedin" runat="server" id="hypLinkedIn"><span class="icon"></span><span class="count">0</span></a>
                    <a target="_blank" class="pinterest" runat="server" id="hypPinTerest"><span class="icon"></span><span class="count">1</span></a>
                    <a target="_blank" class="reddit" runat="server" id="hypReddit"><span class="icon"></span><span class="count">0</span></a>
                </div>
                <!-----------------------------------fb coment-------------------------------------------------------------------------------------------->
                <div id="Div1" class="clear" runat="server">
                </div>
                <div class="comment" id="divcoment" runat="server">
                    <div class="fb-comments" data-href="<%=hypLinkCommentFB %>" data-num-posts="2" data-width="640">
                    </div>
                </div>
                <!-----------------------------------/fb coment-------------------------------------------------------------------------------------------->

            </div>
        </div>
    </div>
</div>
