<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_breakumb.ascx.cs" Inherits="Cb.Web.Controls.block_breakumb" %>

<!--block_breakumb-->

<div class="breadcrumb" runat="server" id="divBreakcrumb">
    <div class="container-fluid">
        <ul>
            <li>
                <a runat="server" id="hypHome">Trang chủ</a>
            </li>
            <asp:Literal runat="server" ID="ltrResult"></asp:Literal>
        </ul>
    </div>
</div>


<!--/block_breakumb-->

