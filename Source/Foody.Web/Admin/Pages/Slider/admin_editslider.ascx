<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_editslider.ascx.cs"
    Inherits="Cb.Web.Admin.Pages.Slider.admin_editslider" %>

<!--admin_editslider-->
<%@ Register Assembly="Cb.WebControls" Namespace="Cb.WebControls" TagPrefix="uc" %>
<%@ Register TagPrefix="dgc" TagName="block_baseimage" Src="~/Admin/Controls/block_baseimage.ascx" %>

<script type="text/javascript">

    function checkForm() {
        return true;
    }

    function submitButton(pressbutton) {
        var f = document.adminForm;
        submitForm(f, pressbutton);
    }

    function CheckProvider(src, args) {
        if (args.Value == '0')
            args.IsValid = false;
    }

    $(function () {
        $("a.zoom-image").fancybox();
    });

</script>

<!-- Event btn-->
<section class="content-header ulBtn btnEdit">
    <div class="row ">
        <div class="col-xs-12">
            <button validationgroup="adminproductCategory" id="btn_Save" runat="server" onserverclick="btnSave_Click" class="btn btn-success">
                <i class="fa fa-check"></i>
                <asp:Literal ID="ltrAdminSave" runat="server"></asp:Literal>
            </button>

            <button id="btn_Delete" runat="server" onserverclick="btnDelete_Click" class="btn btn-success" visible="false">
                <i class="fa fa-check"></i>
                <asp:Literal ID="ltrAdminDelete" runat="server"></asp:Literal>
            </button>

            <button id="btn_Cancel" runat="server" onserverclick="btnCancel_Click" type="button" name="back" class="btn btn-secondary-outline">
                <i class="fa fa-angle-left"></i>
                <asp:Literal ID="ltrAdminCancel" runat="server"></asp:Literal>
            </button>

            <button validationgroup="adminproductCategory" id="btn_Apply" runat="server" type="button" name="btn_Apply" class="btn btn-secondary-outline" onserverclick="btnApply_Click">
                <i class="fa fa-angle-right"></i>
                <asp:Literal ID="ltrAdminApply" runat="server" Text="ltrAdminApply"></asp:Literal>
            </button>
        </div>
    </div>
</section>
<!-- /Event btn-->

<section class="content editCotent">
    <div class="row ">
        <div class="col-xs-12">
            <div class="box">
                <div class="form-horizontal">
                    <div class="panel-body">

                        <!--Validator-->
                        <div class="form-group">
                            <asp:ValidationSummary ID="sumv_SumaryValidate" ValidationGroup="adminproductCategory" DisplayMode="BulletList" ShowSummary="true" runat="server" EnableClientScript="true" ViewStateMode="Disabled" CssClass="col-md-5 ValidationSummary" />
                        </div>

                        <div class="section">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="ltrAminPublish" runat="server" Text="ltrAminPublish"></asp:Literal></label>
                                <div class="col-sm-3 checkbox">
                                    <input type="checkbox" name="chkPublished" id="chkPublished" checked runat="server" class="noPM" />
                                </div>
                                <label class="col-sm-3 control-label">
                                    <label>
                                        <asp:Literal ID="ltrAminCategory" runat="server" Text="strPosition"></asp:Literal>
                                    </label>
                                </label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="drpCategory" runat="server" CssClass="form-control">
                                    </asp:DropDownList>

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="Literal3" runat="server" Text="strImage"></asp:Literal></label>
                                <div class="col-sm-10">
                                    <dgc:block_baseimage ID="block_baseimage" runat="server" />
                                </div>
                            </div>



                            <div class="form-group ">
                                <label class="col-sm-2 control-label">
                                </label>
                                <div class="col-sm-3 checkbox ">
                                    <div class="checkbox-list">
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="chkOutPage" id="chkOutPage" runat="server" />
                                            (link đến 1 liên kết website khác)
                                        </label>
                                    </div>


                                </div>
                                <label class="col-sm-1 control-label ">
                                    <label>
                                        <asp:Literal ID="Literal4" runat="server" Text="Link"></asp:Literal>
                                    </label>
                                </label>
                                <div class="col-sm-6">
                                    <asp:TextBox runat="server" ID="txtLink" CssClass="form-control" />
                                    (Nếu liên kết trong trang thì dang /abc/index.html. Nếu liên kết ngoài thì dạng
                                http://abc.com/index.html)
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="Literal10" runat="server" Text="Canh chỉnh nội dung"></asp:Literal></label>
                                <div class="col-sm-3">
                                    <asp:DropDownList ID="drpAlign" runat="server" CssClass="form-control form-group">
                                        <asp:ListItem Value="1" Text="Canh giữa"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Canh trái"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="Canh phải"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="form-group  ">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="ltrAminName" runat="server" Text="strName"></asp:Literal>
                                </label>
                                <div class="col-sm-10">
                                    <uc:CKEditorControl runat="server" Language="vi" ID="txtName"> </uc:CKEditorControl>
                                    <asp:RequiredFieldValidator ID="reqv_txtNameVi" ControlToValidate="txtName" Text="*" CssClass="validator" Enabled="false"
                                        runat="server" ValidationGroup="adminproductCategory" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="Literal5" runat="server" Text="Mô tả ngắn"></asp:Literal></label>
                                <div class="col-sm-10">
                                    <uc:CKEditorControl runat="server" Language="vi" ID="txtDetail">
                                    </uc:CKEditorControl>
                                </div>
                            </div>

                            <div class="form-group hidden">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="Literal2" runat="server" Text="Button 1"></asp:Literal></label>
                                <div class="col-sm-10">
                                    <uc:CKEditorControl runat="server" Language="vi" ID="txtButton1">
                                    </uc:CKEditorControl>
                                </div>
                            </div>
                            <div class="form-group hidden">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="Literal8" runat="server" Text="Data X"></asp:Literal></label>
                                <div class="col-sm-10">
                                    <asp:TextBox runat="server" ID="txtDataX" CssClass="form-control" TextMode="MultiLine" />
                                </div>
                            </div>
                            <div class="form-group hidden">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="Literal9" runat="server" Text="Data Y"></asp:Literal></label>
                                <div class="col-sm-10">
                                    <asp:TextBox runat="server" ID="txtDataY" CssClass="form-control" TextMode="MultiLine" />

                                </div>
                            </div>

                            <div class="form-group hidden">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="Literal6" runat="server" Text="Button 2"></asp:Literal></label>
                                <div class="col-sm-10">
                                    <uc:CKEditorControl runat="server" Language="vi" ID="txtButton2">
                                    </uc:CKEditorControl>
                                </div>
                            </div>
                            <div class="form-group hidden">
                                <label class="col-sm-2 control-label">
                                    <asp:Literal ID="Literal7" runat="server" Text="Button 3"></asp:Literal></label>
                                <div class="col-sm-10">
                                    <uc:CKEditorControl runat="server" Language="vi" ID="txtButton3">
                                    </uc:CKEditorControl>
                                </div>
                            </div>
                            
                            <div class="form-group hidden">
                                <label class="col-sm-2 control-label">
                                    <label>
                                        <asp:Literal ID="Literal1" runat="server" Text="strPage"></asp:Literal>
                                    </label>
                                </label>
                                <div class="col-sm-4">
                                    <asp:CheckBoxList runat="server" ID="chkPage">
                                    </asp:CheckBoxList>
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
<input type="hidden" name="id" value="<%=productcategoryId%>" />