<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_bookingprice.ascx.cs" Inherits="Cb.Web.Controls.block_bookingprice" %>

<!--block_bookingprice-->
<div class="table-scrollable">
    <asp:Literal runat="server" ID="ltrTable"></asp:Literal>
    <table class="table table-bordered table-hover">
        <thead>
            <tr class="text-center">
                <asp:Literal runat="server" ID="ltrHeader"></asp:Literal>
            </tr>
        </thead>
        <tbody>
            <asp:Literal runat="server" ID="ltrRows"></asp:Literal>
           
        </tbody>
    </table>
</div>
<!--/block_bookingprice-->
