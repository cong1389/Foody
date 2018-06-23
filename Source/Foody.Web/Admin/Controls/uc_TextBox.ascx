<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="uc_TextBox.ascx.cs" Inherits="Cb.Web.Admin.Controls.uc_TextBox" %>

<!--uc_TextBox--->
<div class="form-group">
    <label class="col-sm-2 control-label">
        <asp:Literal runat="server" ID="ltrName"></asp:Literal>
    </label>
    <div class="col-sm-10">
        <asp:TextBox runat="server" ID="txtValue" ClientIDMode="Static" class="form-control form-group"></asp:TextBox>
        <%--<input type="text" class="form-control form-group" runat="server" id="txtValue" >--%>
    </div>
</div>
<!--/uc_TextBox--->
