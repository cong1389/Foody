<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_categoryhome.ascx.cs" Inherits="Cb.Web.Controls.block_categoryhome" %>

<!--block_categoryhome-->
<section runat="server" id="secCategory" class="divCate divCateHome blox w-animate w-start_animation" style="padding-top: px; padding-bottom: px; background-size: cover; min-height: px; background-color: #fff;">
    <div class="max-overlay" style="background-color: "></div>
    <div class="wpb_row vc_row-fluid full-row">
        <div class="container">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space2">
                        <div class="max-title max-title5">
                            <h4>
                                <asp:Literal runat="server" ID="ltrLastWork"></asp:Literal></h4>
                        </div>
                        <div class="container latestposts-three">
                            <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
                                <ItemTemplate>
                                    <div class="col-md-3 col-sm-3">
                                        <article class="latest-b2">
                                            <a runat="server" id="hypImg">
                                                <figure class="latest-b2-img">
                                                   <span style="display:none" class="onsale" runat="server" id="divIsSale">Sale!</span>
                                                     <img runat="server" id="img" class="landscape thumbnail latestfromblog" width="720" height="388">
                                                </figure>
                                                <div class="latest-b2-cont">

                                                    <div class="max-title max-title4">
                                                        <h6>
                                                            <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></h6>
                                                    </div>
                                                    <h6 class="latest-b2-cat datework">
                                                        <asp:Literal runat="server" ID="ltrDate"></asp:Literal>
                                                    </h6>

                                                    <span class="price">                                                                                                         
                                                        <asp:Literal runat="server" ID="ltrPrice"></asp:Literal>
                                                    </span>

                                                    <div class="latest-b2-metad2 ">
                                                        <span class="latest-b2-date ">
                                                            <asp:Literal runat="server" ID="ltrBrief"></asp:Literal>
                                                        </span>
                                                    </div>
                                                </div>
                                            </a>
                                        </article>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>
                        <hr class="vertical-space2">
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!--/block_categoryhome-->
