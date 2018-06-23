<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CartView.ascx.cs" Inherits="Cb.Web.Pages.Cart.CartView" %>

<!--CartView--->
<%@ Register TagPrefix="dgc" TagName="block_breakumb" Src="~/Controls/block_breakumb.ascx" %>
<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<div id="content-wrapper" class="is-vc">

    <article id="post-2337" class=" divProduct">
        <dgc:block_breakumb ID="block_breakumb1" runat="server" />
        <div class="container">
            <div class="row">
                <main id="main-wrapper" class="col-md-12">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>

                            <article id="post-2195" class="page-single post-2195 page type-page status-publish hentry">

                                <div class="post-content">
                                    <div class="woocommerce">
                                        <div>

                                            <table class="shop_table shop_table_responsive cart" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th class="product-remove">&nbsp;STT</th>
                                                        <th class="product-remove">&nbsp;</th>
                                                        <th class="product-thumbnail">&nbsp;</th>
                                                        <th class="product-name">Product</th>
                                                        <th class="product-price">Price</th>
                                                        <th class="product-quantity">Quantity</th>
                                                        <th class="product-subtotal">Total</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater ID="rptResult" runat="server" OnItemDataBound="rptResult_ItemDataBound">
                                                        <ItemTemplate>
                                                            <tr class="cart_item">
                                                                <td>
                                                                    <asp:Literal ID="ltrSTT" runat="server" /></td>
                                                                <td class="product-remove">
                                                                    <a class="remove" runat="server" id="hypDelete" onserverclick="hypDelete_OnClick" clientidmode="Static">x</a>
                                                                    <asp:HiddenField ID="hdfDelete" runat="server" ClientIDMode="Static" />
                                                                </td>
                                                                <td class="product-thumbnail">
                                                                    <img width="90" height="90" runat="server" id="img"
                                                                        class="attachment-shop_thumbnail size-shop_thumbnail wp-post-image"
                                                                        sizes="(max-width: 90px) 100vw, 90px">
                                                                </td>

                                                                <td class="product-name" data-title="Product">
                                                                    <asp:Literal ID="ltrName" runat="server" />
                                                                </td>

                                                                <td class="product-price" data-title="Price">
                                                                    <span class="woocommerce-Price-amount amount">
                                                                        <asp:Literal ID="ltrPrice" runat="server" />
                                                                    </span>
                                                                </td>

                                                                <td class="product-quantity" data-title="Quantity">
                                                                    <div class="quantity">
                                                                        <input runat="server" id="txtQuantity" type="text" value="1" name="demo_vertical" class="touchpin">
                                                                    </div>
                                                                </td>

                                                                <td class="product-subtotal" data-title="Total">
                                                                    <span class="woocommerce-Price-amount amount">
                                                                        <asp:Literal ID="ltrAmount" runat="server" />
                                                                    </span>
                                                                </td>
                                                            </tr>

                                                        </ItemTemplate>
                                                    </asp:Repeater>

                                                    <tr>
                                                        <td colspan="7" class="actions">

                                                            <div class="coupon hidden">

                                                                <label for="coupon_code">Coupon:</label>
                                                                <input type="text" name="coupon_code" class="input-text" id="coupon_code" value="" placeholder="Coupon code">
                                                                <input type="submit" class="button" name="apply_coupon" value="Apply Coupon">
                                                            </div>
                                                            <a runat="server" id="hypUpdate" class="button" onserverclick="hypUpdate_OnClick">Cập nhật</a>
                                                        </td>
                                                    </tr>

                                                </tbody>
                                            </table>


                                        </div>

                                        <div class="cart-collaterals">

                                            <div class="cart_totals calculated_shipping">

                                                <h2>Cart Totals</h2>

                                                <table cellspacing="0" class="shop_table shop_table_responsive">

                                                    <tbody>
                                                        <tr class="order-total">
                                                            <th>Total</th>
                                                            <td data-title="Total">
                                                                <strong>
                                                                    <span class="woocommerce-Price-amount amount">
                                                                        <asp:Literal ID="ltrTotal" runat="server" />
                                                                    </span>
                                                                </strong>
                                                            </td>
                                                        </tr>


                                                    </tbody>
                                                </table>

                                                <div class="wc-proceed-to-checkout">
                                                    <a onserverclick="hypCheckOut_ServerClick" runat="server" id="hypCheckOut" class="checkout-button button alt wc-forward">Proceed to Checkout</a>
                                                </div>


                                            </div>

                                        </div>

                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                            </article>

                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="rptResult" />
                        </Triggers>
                    </asp:UpdatePanel>
                </main>
            </div>
        </div>

    </article>

</div>

<script>
    jQuery(document).ready(function () {
        jQuery(".touchpin").TouchSpin({
            verticalbuttons: true,
            verticalupclass: 'glyphicon glyphicon-plus',
            verticaldownclass: 'glyphicon glyphicon-minus',
            initval: 0,
            max: 9000000000
        });
    });


</script>
<!--/CartView--->
