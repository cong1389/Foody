<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Blog.ascx.cs" Inherits="Cb.Web.Pages.BlogManagement.Blog" %>

<!--Blog-->
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>
<%@ Register TagPrefix="dgc" TagName="blog_left" Src="~/Controls/blog_left.ascx" %>

<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<section class="divBlog container page-content">
    <hr class="vertical-space2">
    <section class="cntt-w wpb_column vc_column_container vc_col-md-9">

        <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
            <ItemTemplate>
                <article id="post-8758" class="blog-post blgtyp2 post-8758 post type-post status-publish format-standard has-post-thumbnail hentry category-cloud-computing category-it-news category-networking">
                    <div class="col-md-5 alpha boxFixImg_Blog_309_243">
                        <a runat="server" id="hypImg" title="Live support, key of an endless satisfaction">
                            <img runat="server" id="img" class="landscape thumbnail blog2_thumb" width="420" height="330"></a>
                    </div>
                    <div class="col-md-7 omega">
                        <div class="postmetadata">
                            <h6 class="blog-date">
                                <asp:Literal runat="server" ID="ltrDate"></asp:Literal></h6>
                        </div>
                        <h3><a runat="server" id="hypTitle">
                            <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                        </a></h3>
                        <p>
                            <asp:Literal runat="server" ID="ltrBrief"></asp:Literal>
                        </p>
                        <a class="readmore" runat="server" id="hypContinus">
                            <asp:Literal runat="server" ID="ltrContinus"></asp:Literal></a>
                    </div>
                    <hr class="vertical-space1">
                </article>

            </ItemTemplate>
        </asp:Repeater>

        <!--Padding-->
        <div class="wp-pagenavi">
            <cc:Pager ID="pager" runat="server" EnableViewState="true" OnCommand="pager_Command" CompactModePageCount="10" MaxSmartShortCutCount="0" RTL="False" PageSize="9" />
        </div>

        <hr class="vertical-space">
    </section>

    <aside class="sidebar wpb_column vc_column_container  vc_col-md-3 ">
        <dgc:blog_left ID="blog_left" runat="server" />
    </aside>

</section>


<style>
    @media only screen and (min-width: 961px) {
        .has-header-type11 #headline {
            padding-top: 0px !important;
        }
    }
</style>
