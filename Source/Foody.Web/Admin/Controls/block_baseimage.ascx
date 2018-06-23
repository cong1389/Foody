<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_baseimage.ascx.cs"
    Inherits="Cb.Web.Admin.Controls.block_baseimage" %>

<!--block_baseimage-->
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<script type="text/javascript">

    function uploadComplete(sender, args) {
        var newFileName = sender.newFileName;
        var arr = newFileName.split("|");
        var fileName = arr[0];
        var pathImage = arr[1];
        jQuery("#<%=imgToCrop.ClientID %>").attr("src", "<%=ImagePath %>" + "/" + fileName);
        jQuery("#<%=hddImageName.ClientID%>").val(fileName);
    }

</script>
<div id="block_baseimage">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <div class="col-xs-6 form-group">
                <div class="form-group" runat="server" id="divImage">
                    <label class="col-sm-8 col-xs-8 control-label">
                        Chọn hình upload</label>
                    <div class="col-sm-4 col-xs-8 checkbox">

                        <div class="checkbox-list" data-error-container="#form_2_services_error">
                            <label>
                                <input type="radio" name="imageType" id="rdImage" runat="server" value="1" checked="true" />
                            </label>
                        </div>

                    </div>
                </div>

                <div class="loadingUploadImage">
                    <asp:Image ID="imgLoader" runat="server" ImageUrl="/Admin/images/loading.gif" />
                </div>
                <asp:Panel ID="pnlCrop" runat="server" Visible="true" CssClass="pnlCrop">
                    <asp:Image ID="imgToCrop" runat="server" CssClass="img-responsive center-block" />
                </asp:Panel>

                <div class="form-group">
                    <label class="col-sm-8 col-xs-8 control-label">
                        Kích thước hình mặc định</label>
                    <div class="col-sm-4 col-xs-8 checkbox">

                        <div class="checkbox-list" data-error-container="#form_2_services_error">
                            <label>
                                <input type="checkbox" name="chkDefault" id="chkDefault" class="chkDefault " runat="server" checked="true" />
                            </label>
                        </div>

                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-4 col-xs-4 control-label">
                        Chọn hình</label>
                    <cc1:AsyncFileUpload CssClass="FileUploadClass" runat="server" ID="AsyncFileUpload1"
                        Width="400px" UploaderStyle="Modern" CompleteBackColor="White" OnClientUploadComplete="uploadComplete"
                        OnUploadedComplete="FileUploadComplete" ThrobberID="imgLoader" />
                </div>

                <div class=" form-inline form-group hidden">
                    <button id="btnRemove" runat="server" visible="false" class="btn btn-success ">
                        <i class="fa fa-trash-o iPadding5"></i>Remove
                    </button>
                    <button id="btnCrop" runat="server" class="btn btn-success" visible="false">
                        <i class="fa fa-crop iPadding5 "></i>Crop & Save
                    </button>

                </div>
                <div class="form-group">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red" />
                </div>
                <div class="form-group boxImageNull ">
                    <asp:Image ID="imgCropped" runat="server" CssClass="img-responsive" />
                </div>
            </div>

            <div class="col-xs-6 form-group" runat="server" id="divImageFont">
                <div class="form-group">
                    <label class="col-sm-8 col-xs-8 control-label">
                        Chọn hình từ Font chữ</label>
                    <div class="col-sm-4 col-xs-8 checkbox">

                        <div class="checkbox-list" data-error-container="#form_2_services_error">
                            <label>
                                <input type="radio" name="imageType" id="rdImageFont" runat="server" value="2" />
                            </label>
                        </div>

                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 col-xs-3 control-label">
                        Tên font</label>
                    <div class="col-sm-9">
                        <input type="text" name="txtFontName" id="txtFontName" runat="server" class="form-control" />
                    </div>
                </div>

            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<input type="hidden" runat="server" id="hddImageName" />
