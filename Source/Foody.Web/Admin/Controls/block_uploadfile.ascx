<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_uploadfile.ascx.cs"
    Inherits="Cb.Web.Admin.Controls.block_uploadfile" %>

<!--block_baseimage-->
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<script type="text/javascript">

    function FileUpload1_OnClientUploadComplete(sender, args) {
        var newFileName = sender.newFileName1;
        var arr = newFileName.split("|");
        var fileName = arr[0];
        var pathImage = arr[1];
        jQuery("#<%=txtFilename.ClientID%>").val(fileName);
        jQuery("#<%=hddNameFileUpload.ClientID%>").val(fileName);
    }

</script>
<div>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="col-xs-6 form-group">
                <div class="form-group  ">
                    <label class="col-sm-4 col-xs-4 control-label">
                        File Name</label>
                    <div class="col-sm-8 col-xs-8 checkbox">
                        <asp:TextBox runat="server" ID="txtFilename" placeholder="File Name" CssClass="form-control" ReadOnly/>

                    </div>
                </div>

                <div class="form-group ">

                    <div class="form-group">
                        <label class="col-sm-4 col-xs-4 control-label">
                            Chọn File PDF hoặc Word</label>
                        <div class="col-sm-8 col-xs-8 checkbox">
                            <cc1:AsyncFileUpload CssClass="FileUploadClass" runat="server" ID="fileUpload1" Width="400px" UploaderStyle="Modern" CompleteBackColor="White" OnClientUploadComplete="FileUpload1_OnClientUploadComplete"
                                OnUploadedComplete="FileUpload1_OnUploadedComplete" ThrobberID="imgLoader" />
                        </div>
                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</div>

<cc1:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender1" TargetControlID="UpdatePanel2"
    runat="server">
    <Animations>
                    <OnUpdating>
                       <Parallel duration="0">                       
                            <EnableAction AnimationTarget="FileUpload1_OnUploadedComplete" Enabled="false" />       
                                     
                        </Parallel>
                    </OnUpdating>    
                    <OnUpdated>
                        <Parallel duration="0">                          
                            <EnableAction AnimationTarget="FileUpload1_OnUploadedComplete" Enabled="true" />                    
                        </Parallel>
                    </OnUpdated>     
    </Animations>
</cc1:UpdatePanelAnimationExtender>


<input type="hidden" runat="server" id="hddNameFileUpload" />
