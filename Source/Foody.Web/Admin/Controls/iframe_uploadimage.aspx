<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="iframe_uploadimage.aspx.cs"
    Inherits="Cb.Web.Admin.Controls.iframe_uploadimage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<html>
<head id="Head1" runat="server">
    <link rel="stylesheet" type="text/css" href="/admin/Style/style.css">
    <link href="/Admin/Components/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/Admin/Components/App/ionicons/ionicons.min.css" rel="stylesheet" />
    <link href="/Admin/Components/App/css/content.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePartialRendering="true" />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div style="display: none;">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                        <blockquote>
                            <p>
                                Upload hình, audio
                            </p>
                            <footer>Hình ảnh <cite title="Source Title">jpg, jpeg, png, gif, bmp</cite></footer>
                            <footer>Audio <cite title="Source Title">mp3</cite></footer>
                            <br />
                            <asp:FileUpload ID="fuImage" Width="300px" runat="server" CssClass="" AllowMultiple="true" />
                        </blockquote>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                        <blockquote>
                            <p>
                                Upload video
                            </p>
                            <footer>
                                Video lấy từ 
                                <abbr title="Đường dẫn Share Youtube chỉ lấy ID cuối cùng sau dấu '/'https://youtu.be/ UOh9FWZqRSg">
                                    Video</abbr>
                            </footer>
                            <br />
                            <input type="text" name="txtIdVideo" id="txtIdVideo" runat="server" class="form-control" />
                        </blockquote>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div id="uploadImage">
                        <asp:Button ID="btnUploadImage" runat="server" Text="Lưu" OnClick="btnUploadImage_Click"
                            ValidationGroup="vg" CssClass="btn btn-success btn-lg" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green" Text=""></asp:Label>
                    </div>
                </div>
                <br />
                <!--AjaxFileUpload-->
                <asp:Label ID="lbMsg" runat="server" ForeColor="Green" Text=""></asp:Label>
                <asp:AjaxFileUpload ID="upLoad" runat="server" MaximumNumberOfFiles="10" Width="100%"
                    CssClass="col-sm-6 " OnUploadComplete="upload_UploadComplete" OnClientUploadCompleteAll="ReloadGridView" OnUploadStart="upload_OnUploadStart" />
                <!--End AjaxFileUpload-->
                <asp:GridView ID="grdImage" runat="server" EmptyDataText="No files found!" AutoGenerateColumns="False"
                    AllowPaging="true" PageSize="4" Width="100%" OnPageIndexChanging="grdImage_PageIndexChanging"
                    OnRowDataBound="grdImage_RowDataBound" OnRowDeleting="grdImage_RowDeleting" DataKeyNames="Id"
                    CssClass="table table-bordered table-hover tbl-news" Height="100px">
                    <AlternatingRowStyle /><HeaderStyle CssClass="txt-bold tbl-title " />
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="STT" HeaderStyle-Width="6%" />
                        <asp:BoundField DataField="Name" HeaderText="Tên file" HeaderStyle-Width="35%" />
                        <asp:TemplateField HeaderText="Ảnh" HeaderStyle-Width="30%">
                            <ItemTemplate>
                                <asp:Image ID="colImage" runat="server" CssClass="baseImageGrid" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="imagepath" HeaderText="Đường dẫn lưu hình" HeaderStyle-Width="20%"
                            HtmlEncode="false" />
                        <asp:CommandField ShowDeleteButton="True" ControlStyle-Font-Bold="true" DeleteImageUrl="/Admin/images/thung-rac.png"
                            ButtonType="Image" HeaderText="Xóa" />
                        <asp:TemplateField HeaderText="Ảnh" HeaderStyle-Width="30%" Visible="false">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelected" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Right" CssClass="GridPager" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
<script type="text/javascript">
    function ReloadGridView() {
        $get('<%= this.btnUploadImage.ClientID %>').click();
    }
</script>
