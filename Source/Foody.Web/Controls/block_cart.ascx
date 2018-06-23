<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_cart.ascx.cs"
    Inherits="Cb.Web.Controls.block_cart" %>

<script type="text/javascript">
    function BuyProduct(productId, price) {
      
        jQuery.ajax({
            type: "POST",
            url: "/WebServices/Service.asmx/BuyProduct",
            data: "{'productId': '" + productId + "' ,'quantity': '" + jQuery("#txtQuantity").val() + "'}",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                jQuery(".cartNumber").html(result.d[2]);
            },
            error: function (x) {
                alert(args);
            }
        });
    }
</script>

<span class="divCart">
    <a runat="server" id="hypCartView" class="header-cart google-plus">
        <i class="fa-google-plus"></i>
        <span class="header_cart_span cartNumber">0</span>
    </a>
</span>
<%--<li class="mini-cart">
    <a runat="server" id="hypCartView" class="mini-cart-link">
        <i class="fa fa-shopping-basket"></i>
        <span class="mini-cart-number">0</span></a>

</li>--%>

