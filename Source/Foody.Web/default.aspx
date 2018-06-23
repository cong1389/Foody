<%@ Page Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true"
    EnableEventValidation="false" ViewStateEncryptionMode="Never" ValidateRequest="False"
    CodeBehind="default.aspx.cs" EnableTheming="false" StylesheetTheme="" Theme=""
    Inherits="Cb.Web._default" Culture="auto:en-us" UICulture="auto:en-us" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ContentPlaceHolderID="mainContent" ID="content" runat="server">
    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></cc1:ToolkitScriptManager>
    <asp:PlaceHolder ID="phdContent" runat="server"></asp:PlaceHolder>
</asp:Content>





