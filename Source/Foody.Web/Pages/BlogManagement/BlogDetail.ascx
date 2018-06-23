<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BlogDetail.ascx.cs" Inherits="Cb.Web.Pages.BlogManagement.BlogDetail" %>

<!--BlogDetail-->
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>
<%@ Register TagPrefix="dgc" TagName="blog_left" Src="~/Controls/blog_left.ascx" %>

<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<section class="container page-content">
    <hr class="vertical-space2">

     <section class="cntt-w wpb_column vc_column_container vc_col-md-9">

        <article class="blog-single-post">
            <div class="post-trait-w">
                <h2>
                    <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></h2>
                <img runat="server" id="img" class="landscape full" width="1100" height="732">
            </div>
            <div class="post post-8758 type-post status-publish format-standard has-post-thumbnail hentry category-cloud-computing category-it-news category-networking">
                <asp:Literal runat="server" ID="ltrDetail"></asp:Literal>
            </div>
        </article>

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
