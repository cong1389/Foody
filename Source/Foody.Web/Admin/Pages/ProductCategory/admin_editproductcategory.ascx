<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_editproductcategory.ascx.cs"
    Inherits="Cb.Web.Admin.Pages.ProductCategory.admin_editproductcategory" %>

<!--admin_editproductcategory-->
<%@ Register Assembly="Cb.WebControls" Namespace="Cb.WebControls" TagPrefix="uc" %>
<%@ Register TagPrefix="dgc" TagName="block_baseimage" Src="~/Admin/Controls/block_baseimage.ascx" %>

<script type="text/javascript">

    //function TreeNodeCheckChanged() {
    //    var o = window.event.srcElement;
    //    if (o.tagName == "INPUT" && o.type == "checkbox") {
    //        __doPostBack("", "");
    //    }
    //}

    jQuery(document).ready(function () {

        //Copy value từ tên sản phẩm bỏ vào group SEO
        CopyValue();

    });

    //Set text thông tin SEO từ tên bài viết
    function CopyValue() {

        //VN
        jQuery("#<%=txtName.ClientID%>").change(function () {
            var name = jQuery("#<%=txtName.ClientID%>").val();
            if (name != "") {
                jQuery("#<%=txtMetaTitle.ClientID%>").val(name);
                jQuery("#<%=txtMetaKeyword.ClientID%>").val(name);
                jQuery("#<%=txtMetaDescription.ClientID%>").val(name);
                jQuery("#<%=txtH1.ClientID%>").val(name);
                jQuery("#<%=txtH2.ClientID%>").val(name);
                jQuery("#<%=txtH3.ClientID%>").val(name);
            }
        });

        //Eng
        jQuery("#<%=txtNameEng.ClientID%>").change(function () {
            var nameEng = jQuery("#<%=txtNameEng.ClientID%>").val();
            if (nameEng != "") {
                jQuery("#<%=txtMetaTitleEng.ClientID%>").val(nameEng);
                jQuery("#<%=txtMetaKeywordEng.ClientID%>").val(nameEng);
                jQuery("#<%=txtMetaDescriptionEng.ClientID%>").val(nameEng);
                jQuery("#<%=txtH1Eng.ClientID%>").val(nameEng);
                jQuery("#<%=txtH2Eng.ClientID%>").val(nameEng);
                jQuery("#<%=txtH3Eng.ClientID%>").val(nameEng);
            }
        });

        //SizeImage
        var categoryName = $('#<%=drpCategory.ClientID %> option:selected').text();
        ResizeImageDefault(categoryName);
    };

    //Set img đại diện có resize hay không
    function ResizeImageDefault(path) {
        jQuery(".chkDefault").attr('checked', 'checked');
    }

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

</script>

<!-- Event btn-->
<section class="content-header ulBtn btnEdit">
    <div class="row ">
        <div class="col-xs-12">

            <button validationgroup="adminproductCategory" id="btn_Save" runat="server" onserverclick="btnSave_Click" class="btn btn-success">
                <i class="fa fa-check"></i>
                <asp:Literal ID="ltrAdminSave" runat="server"></asp:Literal>
            </button>

            <button validationgroup="adminproductCategory" id="btn_Delete" runat="server" onserverclick="btnDelete_Click" class="btn btn-success" visible="false">
                <i class="fa fa-check"></i>
                <asp:Literal ID="ltrAdminDelete" runat="server"></asp:Literal>
            </button>

            <button id="btn_Cancel" runat="server" onserverclick="btnCancel_Click" type="button" name="back" class="btn btn-secondary-outline">
                <i class="fa fa-angle-left"></i>
                <asp:Literal ID="ltrAdminCancel" runat="server"></asp:Literal>
            </button>

            <button id="btn_Apply" runat="server" type="button" name="btn_Apply" class="btn btn-secondary-outline" onserverclick="btnApply_Click" validationgroup="adminproductCategory">
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
            <div class="box ">
                <div class="form-horizontal">
                    <div class="panel-body">

                        <!--Validator-->
                        <div class="form-group">
                            <asp:ValidationSummary ID="sumv_SumaryValidate" ValidationGroup="adminproductCategory" DisplayMode="BulletList" ShowSummary="true" runat="server" EnableClientScript="true" ViewStateMode="Disabled" CssClass="col-md-5 ValidationSummary" />
                        </div>

                        <%-- Thông tin chung--%>
                        <div class="form-group">
                            <div class="col-sm-2 col-xs-3 control-label"></div>
                            <div class="col-sm-6 col-xs-3">
                                <div class="checkbox-list">
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="chkPublished" id="chkPublished" checked runat="server" />
                                        <asp:Literal ID="ltrAminPublish" runat="server" Text="Menu top"></asp:Literal>
                                    </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" runat="server" id="chkMenuFooter" value="option1">
                                        Menu Footer
                                    </label>

                                </div>
                            </div>

                            <label class="col-sm-2 control-label">
                                <asp:Literal ID="ltrSort" runat="server" Text="ltrSort"></asp:Literal>
                            </label>
                            <div class="col-sm-2">
                                <input id="txtOrder" runat="server" type="text" value="33" name="demo_vertical" class="touchpin" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">
                                <asp:Literal ID="ltrAminCategory" runat="server" Text="ltrAminCategory"></asp:Literal></label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="drpCategory" runat="server" CssClass="form-control select2">
                                </asp:DropDownList>
                                <asp:CustomValidator ID="csv_drpCategory" runat="server" ValidationGroup="adminproductCategory"
                                    Text="*" ControlToValidate="drpCategory" OnServerValidate="csv_drpCategory_ServerValidate"
                                    CssClass="validator"></asp:CustomValidator>
                            </div>
                            <label class="col-sm-2 control-label">
                            </label>
                            <div class="col-sm-4 hidden">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:TreeView ID="TreeView1" runat="server" ShowCheckBoxes="All" ShowExpandCollapse="true" EnableClientScript="true">
                                        </asp:TreeView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>

                        <div class="form-group" runat="server" id="trPage">
                            <label class="col-sm-2 control-label">
                                <abbr title="Đường dẫn chứa trang ascx. Ví dụ: Pages/CategoryManagement/Category.ascx">
                                    <asp:Literal ID="ltrPage" runat="server" Text="ltrPage"></asp:Literal></abbr>
                            </label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="drpPage" runat="server" CssClass="form-control select2">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="drpPage"
                                    Text="*" Enabled="false" runat="server" ValidationGroup="adminproductCategory"
                                    SetFocusOnError="true" CssClass="validator"></asp:RequiredFieldValidator>
                            </div>
                            <label class="col-sm-2 control-label">
                                <asp:Literal ID="ltrPageDetail" runat="server" Text="ltrPageDetail"></asp:Literal>
                            </label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="drpPageDetail" runat="server" CssClass="form-control ">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <%--/Thông tin chung--%>

                        <%-- Thông tin chi tiết--%>
                        <div class="tabbable tabbable-tabdrop">
                            <ul class="nav nav-tabs">
                                <li class="active">
                                    <a href="#tab_1" data-toggle="tab" aria-expanded="true">
                                        <asp:Literal ID="ltrAminLangVi" runat="server"></asp:Literal>
                                    </a>
                                </li>
                                <li class="">
                                    <a href="#tab_2" data-toggle="tab">
                                        <asp:Literal ID="ltrAminLangEn" runat="server"></asp:Literal>
                                    </a>
                                </li>
                                <li class="">
                                    <a href="#tab_3" data-toggle="tab">
                                        <asp:Literal ID="ltrCategoryImages" runat="server" Text="Hình đại diện"></asp:Literal>
                                    </a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab_1">
                                    <div class="panel-group accordion" id="adn">
                                        <!--Accordion thông tin chung-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#adn" href="#adnGeneral" class="accordion-toggle accordion-toggle-styled accordion-toggle accordion-toggle-styled collapsed accordion-toggle accordion-toggle-styled collapsed" aria-expanded="false">
                                                        <asp:Literal runat="server" ID="ltrGeneral" Text="ltrGeneral"></asp:Literal>
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="adnGeneral" class="panel-collapse collapse in">
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrAminName" runat="server" Text="ltrAminName"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="txtName" id="txtName" runat="server" class="form-control form-group" />
                                                            <asp:RequiredFieldValidator ID="reqv_txtNameVi" ControlToValidate="txtName" runat="server"
                                                                ValidationGroup="adminproductCategory" SetFocusOnError="true" Display="None"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrIntro" runat="server" Text="ltrIntro"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtIntro" TextMode="MultiLine" Rows="2" CssClass="form-control form-group" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrAdminIntro" runat="server" Text="ltrAdminIntro"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" Language="vi" ID="txtDetail" CssClass="form-control">
                                                            </uc:CKEditorControl>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <!--/Accordion thông tin chung-->
                                        <!--Accordion SEO-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#adn" href="#adnSEO" class="accordion-toggle accordion-toggle-styled accordion-toggle accordion-toggle-styled collapsed accordion-toggle accordion-toggle-styled collapsed" aria-expanded="false">
                                                        <asp:Literal runat="server" ID="ltrAdnMeta" Text="ltrAdnMeta"></asp:Literal>
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="adnSEO" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrMetaTitle" runat="server" Text="ltrMetaTitle"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtMetaTitle" TextMode="MultiLine" Rows="2" placeholder="Meta Title" CssClass="form-control form-group" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrMetaKeyWord" runat="server" Text="ltrMetaKeyWord"></asp:Literal>
                                                        </label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtMetaKeyword" TextMode="MultiLine" Rows="2" placeholder="Meta Keywords" CssClass="form-control form-group" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrMetaDescription" runat="server" Text="ltrMetaDescription"></asp:Literal>
                                                        </label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtMetaDescription" TextMode="MultiLine" Rows="2" placeholder="Meta Description" CssClass="form-control form-group" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrH1" runat="server" Text="ltrH1"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtH1" TextMode="MultiLine" Rows="2" placeholder="H1 Tag" CssClass="form-control form-group" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrH2" runat="server" Text="ltrH2"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtH2" TextMode="MultiLine" Rows="2" placeholder="H2 Tag" CssClass="form-control form-group" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrH3" runat="server" Text="ltrH3"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtH3" TextMode="MultiLine" Rows="2" placeholder="H3 Tag" CssClass="form-control form-group" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--/Accordion SEO-->
                                    </div>
                                </div>
                                <!-- /.tab-pane -->
                                <div class="tab-pane" id="tab_2">
                                    <div class="panel-group accordion" id="adnEng">
                                        <!--Accordion General Info-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#adnEng" href="#adnGeneralEng" class="accordion-toggle accordion-toggle-styled accordion-toggle accordion-toggle-styled collapsed accordion-toggle accordion-toggle-styled collapsed" aria-expanded="false">
                                                        <asp:Literal runat="server" ID="ltrGeneralEng" Text="ltrGeneralEng"></asp:Literal>
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="adnGeneralEng" class="panel-collapse collapse in">
                                                <div class="panel-body">

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrAminNameEng" runat="server" Text="ltrAminNameEng"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="txtNameEng" id="txtNameEng" size="60" runat="server"
                                                                class="form-control form-group" />

                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrIntroEng" runat="server" Text="ltrIntroEng"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtIntroEng" TextMode="MultiLine" Rows="2" CssClass="form-control form-group" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrDetailEng" runat="server" Text="ltrDetailEng"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" Language="vi" ID="txtDetailEng">
                                                            </uc:CKEditorControl>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <!--/Accordion General Info-->

                                        <!--Accordion SEO-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#adnEng" href="#adnSEOEng" class="accordion-toggle accordion-toggle-styled accordion-toggle accordion-toggle-styled collapsed accordion-toggle accordion-toggle-styled collapsed" aria-expanded="false">
                                                        <asp:Literal runat="server" ID="ltrSEOEng" Text="ltrSEOEng"></asp:Literal>
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="adnSEOEng" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrMetaTitleEng" runat="server" Text="ltrMetaTitleEng"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtMetaTitleEng" TextMode="MultiLine" Rows="2" placeholder="Meta Title" CssClass="form-group form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrMetaKeywordEng" runat="server" Text="ltrMetaKeywordEng"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtMetaKeywordEng" TextMode="MultiLine" Rows="2" placeholder="Meta Keywords" CssClass="form-group form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrMetaDescriptionEng" runat="server" Text="ltrMetaDescriptionEng"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtMetaDescriptionEng" TextMode="MultiLine" Rows="2" placeholder="Meta Description" CssClass="form-group form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrH1TagEng" runat="server" Text="ltrH1TagEng"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtH1Eng" TextMode="MultiLine" Rows="2" placeholder="H1 Tag" CssClass="form-group form-control" />


                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrH2TagEng" runat="server" Text="ltrH2TagEng"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtH2Eng" TextMode="MultiLine" Rows="2" placeholder="H2 Tag" CssClass="form-group form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrH3TagEng" runat="server" Text="ltrH3TagEng"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtH3Eng" TextMode="MultiLine" Rows="2" placeholder="H3 Tag" CssClass="form-group form-control" />
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <!--/Accordion SEO-->

                                    </div>
                                </div>
                                <!-- /.tab-pane -->
                                <div class="tab-pane" id="tab_3">
                                    <dgc:block_baseimage ID="block_baseimage" runat="server" />
                                </div>
                                <!-- /.tab-pane -->
                            </div>
                            <!-- /.tab-content -->
                        </div>
                        <%-- /Thông tin chi tiết--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<input type="hidden" name="task" value="" />
<input type="hidden" name="id" value="<%=productcategoryId%>" />