<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_uploadvideo.ascx.cs" Inherits="Cb.Web.Admin.Controls.block_uploadvideo" %>

<!--Admin block_uploadvideo-->
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<div id="block_baseimage" class="panel-heading">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="col-xs-12">
                <blockquote>
                    Video lấy từ  Youtube                    
                    <footer>
                        Đường dẫn Embed Youtube                       
                    </footer>
                </blockquote>

                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2 control-label">
                        Embed</label>
                    <div class="col-sm-3">
                        <%-- <asp:TextBox runat="server" ID="txtID" Rows="1" placeholder="Meta Title"
                            CssClass="form-group col-sm-8" />--%>
                        <input type="text" name="txtID" id="txtID" runat="server" class="form-control" />
                        <asp:RequiredFieldValidator ID="reqv_txtNameEn" ControlToValidate="txtID" Text="Nhập ID Youtube"
                            runat="server" ValidationGroup="ID" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <button validationgroup="ID" id="btn_Save" runat="server" text="Lưu" cssclass="btn btn-info"
                        onserverclick="btnSaveVideo_Click" title="Lưu">
                        <i class="fa fa-floppy-o fa-2x"></i>
                        <asp:Literal ID="ltrAdminSave" runat="server"></asp:Literal>
                    </button>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red" />
                </div>

            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>

