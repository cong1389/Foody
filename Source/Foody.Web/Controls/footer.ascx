<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="footer.ascx.cs" Inherits="Cb.Web.Controls.footer" %>

<!--footer-->
<%@ Register TagPrefix="dgc" TagName="block_like" Src="~/Controls/block_like.ascx" %>
<footer id="footer">

    <section class="container footer-in">
        <div class="row">
            <div class="col-md-3">
                <div class="widget">
                    <h5 class="subtitle">
                        <a runat="server" id="hypLogoFooter">
                            <img runat="server" id="logoFooter" class="img-logo-w3"></a></h5>
                    <div class="textwidget">
                        <p>
                            <asp:Literal runat="server" ID="ltrContactDetail"></asp:Literal>
                        </p>
                        <p>
                        </p>
                    </div>
                </div>
                <div class="side-list">
                    <a href="/about-us/vn">
                        <asp:Literal runat="server" ID="ltrFooterContact"></asp:Literal>
                    </a>
                </div>
            </div>
            <div class="col-md-3">
                <div class="widget">
                    <h5 class="subtitle">
                        <asp:Literal runat="server" ID="ltrLastNews"></asp:Literal></h5>
                    <div class="side-list">
                        <ul>
                            <asp:Repeater runat="server" ID="rptLastBlog" OnItemDataBound="rptLastBlog_ItemDataBound">
                                <ItemTemplate>
                                    <li>
                                        <a runat="server" id="hypImg">
                                            <img runat="server" id="img" class="landscape full tabs-img" width="164" height="124"></a>
                                        <h5>
                                            <a runat="server" id="hypTitle">
                                                <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></a></h5>
                                        <p class="date">
                                            <asp:Literal runat="server" ID="ltrDate"></asp:Literal>
                                        </p>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>

                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="widget">
                    <h5 class="subtitle">
                        <asp:Literal runat="server" ID="ltrAddressHeader"></asp:Literal></h5>

                    <ul>
                        <li class="cat-item cat-item-45">
                            <a href="#">
                                <asp:Literal runat="server" ID="ltrAddressName"></asp:Literal>
                            </a>
                            <asp:Literal runat="server" ID="ltrAddressValue"></asp:Literal>
                        </li>
                        <li class="cat-item cat-item-45">
                            <a href="#">
                                <asp:Literal runat="server" ID="ltrPhoneName"></asp:Literal>
                            </a>
                            <asp:Literal runat="server" ID="ltrPhoneValue"></asp:Literal>
                        </li>
                        <li class="cat-item cat-item-45">
                            <a href="#">Fax
                            </a>
                            <asp:Literal runat="server" ID="ltrFax"></asp:Literal>
                        </li>
                        <li class="cat-item cat-item-45">
                            <a href="#">Email
                            </a>
                            <asp:Literal runat="server" ID="ltrEmail"></asp:Literal>
                        </li>
                    </ul>

                    <%-- <strong style="color: #eee">
                        <i class="fa fa-map-marker"></i>
                        <asp:Literal runat="server" ID="ltrAddressName"></asp:Literal>:
                                <asp:Literal runat="server" ID="ltrAddressValue"></asp:Literal>
                    </strong>--%>
                    <%--<br>--%>
                    <%-- <strong style="color: #eee">
                        <i class="fa fa-phone"></i>
                        <asp:Literal runat="server" ID="ltrPhoneName"></asp:Literal>: 
                                <asp:Literal runat="server" ID="ltrPhoneValue"></asp:Literal></strong>
                    <br>--%>

                    <%--<strong style="color: #eee">
                        <i class="fa fa-envelope"></i>
                        <asp:Literal runat="server" ID="Literal1">Email</asp:Literal>: 
                                <asp:Literal runat="server" ID="ltrEmail"></asp:Literal></strong>--%>
                </div>
            </div>
            <div class="col-md-3">
                <div class="widget">
                    <h5 class="subtitle">
                        <asp:Literal runat="server" ID="ltrContactSocial"></asp:Literal></h5>
                    <div class="socialfollow">
                        <dgc:block_like ID="block_like" runat="server" />
                        <div class="clear"></div>
                    </div>

                    <div class="widget-subscribe-form" >
                        <input class="widget-subscribe-email" type="text" name="email" placeholder="Your e-mail">
                        <button class="widget-subscribe-submit" type="submit">SUBSCRIBE </button>
                    </div>

                </div>
            </div>
            <%-- <div class="col-md-3">
                <div class="widget">
                    <h5 class="subtitle">
                        <asp:Literal runat="server" ID="ltrReciveEmail"></asp:Literal></h5>
                    <form class="widget-subscribe-form" action="http://feedburner.google.com/fb/a/mailverify" method="post" target="popupwindow" onsubmit="window.open('http://feedburner.google.com/fb/a/mailverify?uri=', 'popupwindow', 'scrollbars=yes,width=550,height=520');return true">
                        <input type="hidden" value="" name="uri"><input type="hidden" name="loc" value="en_US"><p>Join our mailing list to receive news and announcements</p>
                        <input class="widget-subscribe-email" type="text" name="email">
                        <button class="widget-subscribe-submit" type="submit">SUBSCRIBE </button>
                    </form>
                </div>
            </div>--%>
        </div>
    </section>

    <section class="footbot text-center">
        <div class="container">
            <div class="col-md-12 center-block">
                <div class="footer-navi ">
                    <asp:Literal runat="server" ID="ltrConfig_footer"></asp:Literal>
                </div>
            </div>

        </div>
    </section>
</footer>
