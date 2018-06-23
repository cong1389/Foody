<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_edituser.ascx.cs"
    Inherits="Web.Admin.Pages.User.admin_edituser" %>

<!--admin_edituser-->
<%@ Register TagPrefix="dgc" TagName="block_baseimage" Src="~/Admin/Controls/block_baseimage.ascx" %>

<script type="text/javascript">

    var txtFullName = document.getElementById('<%=txtFullName.ClientID%>');
    var txtEmail = document.getElementById('<%=txtEmail.ClientID%>');
    var drpPermission = document.getElementById('<%=drpPermission.ClientID%>');

    function CheckUserName(src, args) {
        var txtUsername = document.getElementById('<%=txtUsername.ClientID%>');
        args.IsValid = checkLength(txtUsername.value, 5, 50);
    }
    function CheckPassWord(src, args) {
        var txtPassword = document.getElementById('<%=txtPassword.ClientID%>');
        args.IsValid = checkLength(txtPassword.value, 8, 50);
    }

    function OnChangePer() {

    }
    window.onload = OnChangePer;

</script>
<style>
    
</style>

<!-- Event btn-->
<section class="content-header ulBtn btnEdit">
    <div class="row ">
        <div class="col-xs-12">
            <button validationgroup="adminproductCategory" id="btn_Apply" runat="server" text="Cập nhật"
                value="Cập nhật" cssclass="btn " onserverclick="btnApply_Click" title="Cập nhật" visible="false">
                <i class="fa fa-check-square-o fa-2x"></i>
                <asp:Literal ID="ltrAdminApply" runat="server" Text="ltrAdminApply"></asp:Literal>
            </button>

            <button validationgroup="adminproductCategory" id="btn_Save" runat="server" onserverclick="btnSave_Click" class="btn btn-success">
                <i class="fa fa-check"></i>
                <asp:Literal ID="ltrAdminSave" runat="server"></asp:Literal>
            </button>

            <button validationgroup="adminproductCategory" id="btn_Delete" runat="server" text="Xóa"
                cssclass="btn btn-info" onserverclick="btnDelete_Click" title="Xóa" visible="false">
                <i class="fa fa-trash-o  fa-2x"></i>
                <asp:Literal ID="ltrAdminDelete" runat="server"></asp:Literal>
            </button>

            <button id="btn_Cancel" runat="server" onserverclick="btnCancel_Click" type="button" name="back" class="btn btn-secondary-outline">
                <i class="fa fa-angle-left"></i>
                <asp:Literal ID="ltrAdminCancel" runat="server"></asp:Literal>
            </button>
        </div>
    </div>
</section>
<!-- /Event btn-->

<!-- BEGIN show_msg -->
<div class="message">
    <%=show_msg%>
</div>
<asp:ValidationSummary ID="sumv_SumaryValidate" ValidationGroup="adminproductCategory" DisplayMode="BulletList" ShowSummary="true" runat="server" EnableClientScript="true" ViewStateMode="Disabled" CssClass="col-md-5 ValidationSummary" />
<!-- END show_msg -->

<section class="content editCotent">
    <div class="row ">
        <div class="col-xs-12">
            <div class="box">
                <div class="form-horizontal">
                    <div class="panel-body">
                        <div class="section">

                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="ltrBaseImage" runat="server" Text="ltrBaseImage"></asp:Literal></label>
                                <div class="col-sm-10">
                                    <dgc:block_baseimage ID="block_baseimage" runat="server" />
                                </div>

                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="ltrAminPublish" runat="server" Text="ltrAminPublish"></asp:Literal></label>
                                <div class="col-sm-4">
                                    <input type="checkbox" name="chkPublished" id="chkPublished" runat="server" class="checkbox" />
                                </div>
                                <label class="col-sm-2 control-label">
                                    <label>
                                        <asp:Literal ID="ltrPermission" runat="server" Text="ltrPermission"></asp:Literal></label>
                                </label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="drpPermission" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="ltrUserName" runat="server" Text="ltrUserName"></asp:Literal></label>
                                <div class="col-sm-4">
                                    <input type="text" name="txtUsername" id="txtUsername" maxlength="50" runat="server"
                                        class="form-control" />
                                    <asp:RequiredFieldValidator ID="reqv_txtUsername" ControlToValidate="txtUsername"
                                        SetFocusOnError="true" Enabled="false" Display="Dynamic" runat="server" ValidationGroup="adminuser"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cusv_txtUsername" ControlToValidate="txtUsername" ValidationGroup="adminuser"
                                        ClientValidationFunction="CheckUserName" runat="server"></asp:CustomValidator>
                                    <i style="color: Red">
                                        <asp:Literal ID="ltrNoteUsername" runat="server"></asp:Literal></i>
                                </div>
                                <label class="col-sm-2 control-label">
                                    <label>
                                        <asp:Literal ID="ltrFullName" runat="server" Text="ltrFullName"></asp:Literal>
                                    </label>
                                </label>
                                <div class="col-sm-4">
                                    <input type="text" name="txtName" id="txtFullName" size="60" runat="server"
                                        class="form-control" />
                                    <asp:RequiredFieldValidator ID="reqvc_txtFullName" ControlToValidate="txtFullName" CssClass="validator" Enabled="false"
                                        Display="Dynamic" runat="server" ValidationGroup="adminuser" ErrorMessage="<%=msg_user_name%>"></asp:RequiredFieldValidator>


                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <label>
                                        <asp:Literal ID="ltrPassword" runat="server" Text="ltrPassword"></asp:Literal>
                                    </label>
                                </label>
                                <div class="col-sm-4">
                                    <input type="password" name="txtPassword" id="txtPassword" size="20" maxlength="25"
                                        runat="server" class="form-control" />
                                    <asp:RequiredFieldValidator ID="reqv_txtPassword" ControlToValidate="txtPassword"
                                        runat="server" ValidationGroup="adminuser" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cus_checkPassWord" ControlToValidate="txtPassword" ValidationGroup="adminuser"
                                        ClientValidationFunction="CheckPassWord" runat="server" Display="Dynamic"></asp:CustomValidator>
                                    <i style="color: Red">
                                        <asp:Literal ID="ltrNotePassword" runat="server"></asp:Literal></i>
                                </div>
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="ltrConfirmPassword" runat="server" Text="ltrConfirmPassword"></asp:Literal></label>
                                <div class="col-sm-4">
                                    <input type="password" name="txtConfirmpassword" id="txtConfirmpassword" size="20"
                                        maxlength="25" runat="server" class="form-control" />
                                    <asp:RequiredFieldValidator ID="reqvc_txtConfirmpassword" ControlToValidate="txtConfirmpassword"
                                        Display="Dynamic" runat="server" ValidationGroup="adminuser" ErrorMessage="<%=msg_user_confirmpassword%>"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="comv_Password" runat="server" ControlToValidate="txtConfirmpassword"
                                        Display="Dynamic" ControlToCompare="txtPassword" ValidationGroup="adminuser"
                                        ErrorMessage="<%=msg_user_not_same_password%>"></asp:CompareValidator>
                                </div>
                            </div>

                            <!--Điện thoại-->
                            <div class="row">
                                <label class="col-sm-2 control-label">
                                </label>
                                <div class="col-sm-10">
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label>
                                                <asp:Literal ID="ltrEmail" runat="server" Text="ltrEmail"></asp:Literal></label>
                                            <input type="text" name="txtEmail" id="txtEmail" size="30" runat="server" class="form-control edit-width" />
                                            <asp:RequiredFieldValidator ID="reqvc_txtEmail" ControlToValidate="txtEmail" Display="Dynamic"
                                                runat="server" ValidationGroup="adminuser" ErrorMessage="<%=msg_empty_email%>"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="regv_Email" ControlToValidate="txtEmail" runat="server"
                                                Display="Dynamic" ValidationExpression="" ValidationGroup="adminuser" ErrorMessage="<%=msg_invalid_email%>"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label>
                                                <asp:Literal ID="ltrPhone" runat="server" Text="ltrPhone"></asp:Literal></label>
                                            <input type="text" name="txtPhone" id="txtPhone" maxlength="15" runat="server" class="form-control edit-width" />
                                            <asp:RegularExpressionValidator ID="regv_txtPhone" ControlToValidate="txtPhone" runat="server"
                                                ValidationGroup="adminuser" Display="Dynamic"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label>
                                                <asp:Literal ID="ltrMobile" runat="server" Text="ltrMobile"></asp:Literal>
                                            </label>
                                            <input type="text" name="txtMobile" id="txtMobile" maxlength="15" runat="server" class="form-control edit-width" />
                                            <asp:RegularExpressionValidator ID="regv_txtMobile" ControlToValidate="txtMobile"
                                                runat="server" ValidationGroup="adminuser" CssClass="validator"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group hidden">
                                <label class="col-sm-2 control-label">
                                    <label>
                                        <asp:Literal ID="ltrCity" runat="server" Text="ltrCity"></asp:Literal>
                                    </label>
                                </label>
                                <div class="col-sm-4 ">
                                    <asp:DropDownList ID="drpCity" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                </div>
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="ltrPromotion" runat="server" Text="ltrPromotion"></asp:Literal>
                                </label>

                                <div class="col-sm-4 ">
                                    <asp:CheckBox ID="cbxNewsPromo" runat="server" CssClass="checkbox" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="ltrAddress" runat="server" Text="ltrAddress"></asp:Literal></label>
                                <div class="col-sm-10">
                                    <input type="text" name="txtAddress" id="txtAddress" class="form-control" runat="server" />
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<input type="hidden" name="task" value="" />
<input type="hidden" name="id" value="<%=id%>" />
