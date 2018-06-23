<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="top_menu.ascx.cs" Inherits="Cb.Web.Controls.top_menu" %>

<!--top_menu-->
<%@ Register TagPrefix="dgc" TagName="logo_language" Src="~/Controls/logo_language.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_cart" Src="~/Controls/block_cart.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_like" Src="~/Controls/block_like.ascx" %>

<hr class="vertical-space1">
<header id="header" class="horizontal-w  sm-rgt-mn divtop_menu">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1 logo-wrap text-center">
                <div class="col-sm-3 ">
                    <h1 class="logo">
                        <a runat="server" id="hypImgHomePage" class="pull-left">
                            <img runat="server" id="imgLogo" alt="Easy Host" class="img-logo-w1" style="width: 168px" />
                        </a>
                        <span class="logo-sticky hidden">
                            <a runat="server" id="hypImgHomePagesticky">
                                <img runat="server" id="imgLogoSticky" width="60" alt="Easy Host" class="imgLogoSticky" />
                            </a>
                        </span>
                    </h1>
                </div>
                <div class="col-sm-9">
                    <div class="components clearfix">
                        <div class="col-sm-5">
                            <span class="hotline">HOTLINE/WHATSAPP:</span>
                            <span class="hotlineValue">
                                <asp:Literal runat="server" ID="ltrPhoneValue"></asp:Literal></span>
                        </div>

                        <div class="col-sm-4">
                            <div class="pull-left hotline">LIKE US ON:</div>
                            <span class="">
                                <dgc:block_like ID="block_like" runat="server" />
                            </span>
                        </div>

                        <div class="col-sm-3">
                            <div class="">
                                <a class="btnbooking" href="/tour/vn">Book now</a>
                            </div>
                        </div>

                    </div>
                </div>

            </div>

            <div class="col-sm-12 nav-components">
                <div class="hidden components clearfix">
                    <h6></h6>
                </div>
                <nav id="nav-wrap" class="nav-wrap1">
                    <div class="container-fluid">
                        <ul id="nav">

                            <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
                                <ItemTemplate>

                                    <li runat="server" id="liDown" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-6411">
                                        <a runat="server" id="hypName" data-description="share articles">
                                            <asp:Literal runat="server" ID="ltrName"></asp:Literal></a>

                                        <ul class="sub-menu" runat="server" id="ulSub" visible="false">

                                            <asp:Repeater runat="server" ID="rptResultSub2" OnItemDataBound="rptResultSub2_ItemDataBound">
                                                <ItemTemplate>
                                                    <li id="menu-item-9350" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-9350">
                                                        <a runat="server" id="hypNameSub2" data-description="">
                                                            <asp:Literal runat="server" ID="ltrNameSub2"></asp:Literal></a></li>
                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </ul>
                                    </li>

                                </ItemTemplate>
                            </asp:Repeater>

                        </ul>
                    </div>
                </nav>

            </div>
        </div>
    </div>
</header>

<asp:HiddenField runat="server" ID="hddParentNameUrl" Visible="false" />
<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery(function () {
            var header = jQuery("#header.horizontal-w");
            var navHomeY = header.offset().top;
            var isFixed = false;
            var scrolls_pure = parseInt("380");
            var $w = jQuery(window);
            $w.scroll(function (e) {
                var scrollTop = $w.scrollTop();
                var shouldBeFixed = scrollTop > scrolls_pure;
                if (shouldBeFixed && !isFixed) {
                    header.addClass("sticky");
                    isFixed = true;
                }
                else if (!shouldBeFixed && isFixed) {
                    header.removeClass("sticky");
                    isFixed = false;
                }
                e.preventDefault();
            });
        });
    });
</script>
<!--/top_menu-->
