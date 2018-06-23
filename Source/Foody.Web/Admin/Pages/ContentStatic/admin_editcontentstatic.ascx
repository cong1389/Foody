<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_editcontentstatic.ascx.cs"
    Inherits="Cb.Web.Admin.Pages.ContentStatic.admin_editcontentstatic" %>

<!--Nội dung tĩnh-->
<%@ Register Assembly="Cb.WebControls" Namespace="Cb.WebControls" TagPrefix="uc" %>
<%@ Register TagPrefix="dgc" TagName="block_baseimage" Src="~/Admin/Controls/block_baseimage.ascx" %>

<script type="text/javascript">

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
        ResizeImageDefault();
    };

    //Set img đại diện có resize hay không
    function ResizeImageDefault() {
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

    //$(function () {
    //    $("#tabs").tabs();
    //    $("a.zoom-image").fancybox();
    //});

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

            <button validationgroup="adminproductCategory" id="btn_Cancel" runat="server" onserverclick="btnCancel_Click" type="button" name="back" class="btn btn-secondary-outline">
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
            <div class="box ">
                <div class="form-horizontal">
                    <div class="panel-body">

                        <!--Validator-->
                        <div class="form-group">
                            <asp:ValidationSummary ID="sumv_SumaryValidate" ValidationGroup="adminproductCategory" DisplayMode="BulletList" ShowSummary="true" runat="server" EnableClientScript="true" ViewStateMode="Disabled" CssClass="col-md-5 ValidationSummary" />
                        </div>

                        <%-- Thông tin chung--%>
                        <div class="form-group">
                            <label class="col-sm-2 col-xs-3 control-label">
                                <asp:Literal ID="ltrAminPublish" runat="server" Text="ltrAminPublish"></asp:Literal></label>
                            <div class="col-sm-4 col-xs-8 checkbox">

                                <div class="checkbox-list" data-error-container="#form_2_services_error">
                                    <label>
                                        <input type="checkbox" name="chkPublished" id="chkPublished" checked runat="server" class="noPM" />
                                    </label>
                                </div>
                                <div id="form_2_services_error"></div>

                            </div>
                            <label class="col-sm-2 control-label">
                                <asp:Literal ID="ltrSort" runat="server" Text="ltrSort"></asp:Literal>
                            </label>
                            <div class="col-sm-4">
                                <input id="txtOrder" runat="server" type="text" value="33" name="demo_vertical" class="touchpin">
                            </div>
                        </div>

                        <div class="form-group hidden">
                            <label class="col-sm-2 col-xs-3 control-label">
                                <asp:Literal ID="Literal3" runat="server" Text="strImage"></asp:Literal></label>
                            <div class="col-sm-4 col-xs-8 checkbox">

                                <asp:FileUpload ID="fuImage" runat="server" EnableViewState="true" />
                                <asp:Button ID="btnUploadImage" runat="server" Text="strUpload" OnClick="btnUploadImage_Click" />
                                <asp:LinkButton ID="lbnView" runat="server" Text="strView" Visible="false" CssClass="zoom-image">
                                </asp:LinkButton>

                                <asp:LinkButton ID="lbnDelete" runat="server" Text="strDelete" Visible="false" OnClick="lbnDelete_Click"></asp:LinkButton>

                            </div>
                            <label class="col-sm-2 control-label">
                                <asp:Literal ID="Literal6" runat="server" Text="strPhone"></asp:Literal>
                            </label>
                            <div class="col-sm-4">
                                <input id="txtPhone" runat="server" type="text" value="33" name="txtPhone" class="touchpin" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtPhone" runat="server">
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <%-- Thông tin chi tiết--%>
                        <div class="tabbable tabbable-tabdrop">
                            <ul class="nav nav-tabs">
                                <li class="active">
                                    <a href="#tab_1" data-toggle="tab" aria-expanded="true">
                                        <asp:Literal ID="ltrAminLangVi" runat="server" Text="strVietName"></asp:Literal>
                                    </a>
                                </li>
                                <li class="">
                                    <a href="#tab_2" data-toggle="tab">
                                        <asp:Literal ID="ltrAminLangEn" runat="server" Text="strEnglish_en"></asp:Literal>
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
                                                            <uc:CKEditorControl runat="server" ID="txtIntro" CssClass="form-control">
                                                            </uc:CKEditorControl>

                                                            <%--<asp:TextBox runat="server" ID="txtIntro" TextMode="MultiLine" Rows="2" CssClass="form-control form-group" />--%>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrAdminIntro" runat="server" Text="ltrAdminIntro"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" Language="vi" ID="editBriefVi" CssClass="form-control">
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
                                                        <asp:Literal ID="ltrGeneralEng" runat="server" Text="ltrGeneralEng"></asp:Literal>
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
                                                            <uc:CKEditorControl runat="server" Language="vi" ID="txtIntroEn">
                                                            </uc:CKEditorControl>
                                                            <%--<asp:TextBox runat="server" ID="txtIntroEn" TextMode="MultiLine" Rows="2" CssClass="form-control form-group" />--%>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrDetailEng" Text="ltrDetailEng" runat="server"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" Language="vi" ID="editBriefEn">
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