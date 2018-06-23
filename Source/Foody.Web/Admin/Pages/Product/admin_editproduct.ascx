<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_editproduct.ascx.cs"
    Inherits="Cb.Web.Admin.Pages.Products.admin_editproduct" %>

<%@ Register Assembly="Cb.WebControls" Namespace="Cb.WebControls" TagPrefix="uc" %>
<%@ Register TagPrefix="dgc" TagName="block_baseimage" Src="~/Admin/Controls/block_baseimage.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_uploadimage" Src="~/Admin/Controls/block_uploadimage.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_uploadvideo" Src="~/Admin/Controls/block_uploadvideo.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_uploadfile" Src="~/Admin/Controls/block_uploadfile.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_mapsmulti" Src="~/Admin/Controls/block_mapsmulti.ascx" %>

<%@ Register TagPrefix="dgc" TagName="admin_programtour" Src="~/Admin/Pages/ProgramTour/admin_programtour.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_bookingprice" Src="~/Admin/Pages/BookingPrice/admin_bookingprice.ascx" %>

<script type="text/javascript">


    //function fileUpload_OnClientUploadComplete(sender, args) {
    //    var fileName = sender.newFileName;
    //    alert(fileName);
    //    //  jQuery("#txtNameFileUpload").val(fileName);//ss attr("src", "/Resource/UpLoad/Products" + "/" + fileName);
    //}


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
    };

    jQuery(document).ready(function () {

        var categoryID = $("#hddProductCategoryId").val();
        if (categoryID < 0) {
            $(".tabUploadFile, .tabUploadVideo").addClass("hidden");
        }
        else {
            $(".tabUploadFile, .tabUploadVideo").removeClass("hidden");
        }

        //
        chkIsHome();

        //Copy value từ tên sản phẩm bỏ vào group SEO
        CopyValue();

        jQuery("#<%=drpCategory.ClientID%>").change(function () {
            var id = $('#<%=drpCategory.ClientID %> option:selected').val();
            jQuery.ajax({
                type: "POST",
                url: "/WebServices/Service.asmx/GetCategoryPageDetail",
                data: "{'id': '" + id + "' }",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    jQuery("#<%=txtPage.ClientID %>").val(data.d);

                    ResizeImageDefault(data.d);
                },
                error: function (x) {
                    alert(x.responseText);
                }
            });
        });

        //SizeImage
        var categoryName = $('#<%=drpCategory.ClientID %> option:selected').text();
        ResizeImageDefault(categoryName);

    });

    //Set img đại diện có resize hay không
    function ResizeImageDefault(path) {
        if (path.indexOf("BlogDetail")
             || path.indexOf("Nhận xét của khách hàng") >= 0) {
            jQuery(".chkDefault").attr('checked', 'checked');
        }
        else {
            jQuery(".chkDefault").attr('checked', '');
        }
    }

    function checkForm() {
        return true;
    }

    function submitButton(pressbutton) {
        var f = document.adminForm;
        submitForm(f, pressbutton);
    }

    function chkIsHome() {


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

                        <!-- Validator-->
                        <div class="form-group">
                            <asp:ValidationSummary ID="sumv_SumaryValidate" ValidationGroup="adminproductCategory" DisplayMode="BulletList" ShowSummary="true" runat="server" EnableClientScript="true" ViewStateMode="Disabled" CssClass="col-md-5 ValidationSummary" />

                        </div>

                        <%-- Thông tin chung--%>
                        <div class="form-group">
                            <div class="col-sm-2 col-xs-3 control-label"></div>
                            <div class="checkbox-list">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="chkPublished" id="chkPublished" checked runat="server" />
                                    <asp:Literal ID="ltrAminPublish" runat="server" Text="ltrAminPublish"></asp:Literal>
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" runat="server" id="chkPublishedHot" value="option1">
                                    Sản phẩm hot
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" runat="server" id="chkPublishedFeature" value="option2">
                                    Hiển thị sản phẩm trang chủ
                                </label>
                                <label class="checkbox-inline hidden">
                                    <input type="checkbox" runat="server" id="chkProjectNew" value="option2">
                                    Dự án ngoài nước
                                </label>
                                <label class="checkbox-inline hidden">
                                    <input type="checkbox" runat="server" id="chkNewInHome">
                                    Hiển thị tin tức trang chủ
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">
                                <asp:Literal ID="ltrAminCategory" runat="server" Text="ltrAminCategory"></asp:Literal></label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="drpCategory" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="drpCategory"
                                    runat="server" ValidationGroup="adminproductCategory" SetFocusOnError="true" Display="None"></asp:RequiredFieldValidator>

                            </div>
                            <label class="col-sm-2 control-label divStatus">
                                <label>
                                    <asp:Literal ID="ltrStatus" runat="server" Text="Tour code"></asp:Literal>
                                </label>
                            </label>
                            <div class="col-sm-4 divStatus">
                                <input type="text" name="txtPrice" id="txtStatus" runat="server" class="form-control" />
                            </div>
                        </div>

                        <div class="form-group hidden">
                            <label class="col-sm-2 control-label">
                                <asp:Literal ID="Literal7" runat="server" Text="Từ ngày"></asp:Literal></label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtFromDate" runat="server" type="date" placeholder="Từ ngày" CssClass="form-control "></asp:TextBox>
                            </div>
                            <label class="col-sm-2 control-label">
                                <label>
                                    <asp:Literal ID="Literal3" runat="server" Text="Đến ngày"></asp:Literal></label>
                            </label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtToDate" runat="server" type="date" placeholder="Đến ngày" CssClass="form-control "></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group" runat="server" id="divPage">
                            <label class="col-sm-2 control-label">
                                <abbr title="Đường dẫn chứa trang ascx. Ví dụ: Pages/CategoryManagement/Category.ascx">
                                    <asp:Literal ID="ltrPageDetail" runat="server" Text="ltrPageDetail"></asp:Literal>
                                </abbr>
                            </label>
                            <div class="col-sm-10">
                                <asp:TextBox runat="server" ID="txtPage" CssClass="form-control disabled " />
                            </div>

                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">
                                <asp:Literal ID="Literal10" runat="server" Text="Nguyên giá"></asp:Literal></label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtWebsite" runat="server" type="numbers" placeholder="Nhập nguyên giá" CssClass="form-control "></asp:TextBox>
                            </div>
                            <label class="col-sm-2 control-label">
                                <label>
                                    <asp:Literal ID="Literal26" runat="server" Text="Giá khuyến mãi"></asp:Literal></label>
                            </label>
                            <div class="col-sm-4">
                                <span class="col-sm-12 noPM">
                                    <asp:TextBox ID="txtPost" runat="server" type="numbers" placeholder="Nhập giá khuyến mãi" CssClass="form-control "></asp:TextBox>
                                    <span class="col-sm-6 hidden">
                                        <asp:DropDownList ID="drpCost" runat="server" CssClass="form-control">
                                        </asp:DropDownList></span>
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-2 control-label">
                                <asp:Literal ID="Literal29" runat="server" Text="Length"></asp:Literal></label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="cboArea" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="1" Text="Half Day"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="By Hour"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="Full Day"></asp:ListItem>
                                </asp:DropDownList>
                                <%--<input type="text" name="txtPrice" id="txtArea" runat="server" class="form-control" />--%>
                                <asp:RegularExpressionValidator ID="reqE_Area" ControlToValidate="cboArea" runat="server" Text="*" class="validator"></asp:RegularExpressionValidator>
                            </div>
                            <label class="col-sm-2 control-label">
                                <label>
                                    <asp:Literal ID="ltrProvince" runat="server" Text="Tour Type"></asp:Literal></label>
                            </label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="drpProvince" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="1" Text="Day Trips"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="Shortly Cycling Tours"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="Package Cycling Tours"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label hidden">
                                <asp:Literal ID="Literal5" runat="server" Text="Start From"></asp:Literal></label>
                            <div class="col-sm-4 hidden">
                                <asp:DropDownList ID="drpDistrict" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                            </div>
                            <label class="col-sm-2 control-label">
                                <label>
                                    <asp:Literal ID="Literal4" runat="server" Text="Start From"></asp:Literal></label>
                            </label>
                            <div class="col-sm-10">
                                <input type="text" name="txtPrice" id="txtBedRoom" runat="server" class="form-control" />
                                <asp:RegularExpressionValidator ID="req_BedRoom" ControlToValidate="txtBedRoom" runat="server" class="validator" Text="*"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="form-group hidden">
                            <label class="col-sm-2 control-label">
                                <label>
                                    <asp:Literal ID="Literal9" runat="server" Text="Vĩ độ (*)"></asp:Literal></label>
                            </label>
                            <div class="col-sm-4">
                                <input type="text" name="txtMap" id="txtLatitude" runat="server" class="form-control" />
                                <asp:RegularExpressionValidator ID="req_Latitude" ControlToValidate="txtLatitude" class="validator"
                                    runat="server" Text="*"></asp:RegularExpressionValidator>
                            </div>

                            <label class="col-sm-2 control-label">
                                <asp:Literal ID="Literal23" runat="server" Text="Kinh độ (*)"></asp:Literal>
                            </label>
                            <div class="col-sm-4">
                                <input type="text" name="txtMap" id="txtLongitude" runat="server" class="form-control" />
                                <asp:RegularExpressionValidator ID="req_Longitude" ControlToValidate="txtLongitude" class="validator" runat="server" Text="*"></asp:RegularExpressionValidator>
                            </div>

                        </div>
                        <%-- /Thông tin chung--%>

                        <%-- Thông tin chi tiết--%>
                        <div class="tabbable tabbable-tabdrop">
                            <ul class="nav nav-tabs">
                                <li class="active">
                                    <a href="#tab_1" data-toggle="tab">
                                        <asp:Literal ID="ltrAminLangVi" runat="server" Text="strVietNam"></asp:Literal></a>
                                </li>
                                <li class="">
                                    <a href="#tab_2" data-toggle="tab">
                                        <asp:Literal ID="ltrAminLangEn" runat="server" Text="strEnglish_en"></asp:Literal></a>
                                </li>
                                <li>
                                    <a href="#tab_3" data-toggle="tab">
                                        <asp:Literal ID="ltrAvartarImages" runat="server" Text="Hình đại diện"></asp:Literal></a>
                                </li>
                                <li>
                                    <a href="#tab_4" data-toggle="tab">
                                        <asp:Literal ID="ltrUploadFile" runat="server" Text="Upload Picture"></asp:Literal></a>
                                </li>
                                <li class="tabUploadVideo">
                                    <a href="#tab_5" data-toggle="tab">
                                        <asp:Literal ID="ltrUploadVideo" runat="server" Text="Upload Video"></asp:Literal></a>
                                </li>
                                <li class="tabUploadFile">
                                    <a href="#tab_6" data-toggle="tab">
                                        <asp:Literal ID="Literal2" runat="server" Text="Upload File"></asp:Literal></a>
                                </li>
                                <li class="">
                                    <a href="#tab_7" data-toggle="tab">
                                        <asp:Literal ID="Literal6" runat="server" Text="Maps"></asp:Literal></a>
                                </li>
                                <li class="">
                                    <a href="#tab_8" data-toggle="tab">
                                        <asp:Literal ID="Literal8" runat="server" Text="Chương trình tour"></asp:Literal></a>
                                </li>
                                <li class="">
                                    <a href="#tab_9" data-toggle="tab">
                                        <asp:Literal ID="Literal1119" runat="server" Text="Booking price"></asp:Literal></a>
                                </li>
                            </ul>

                            <div class="tab-content">
                                <div class="tab-pane active" id="tab_1">
                                    <div class="panel-group accordion" id="adn">
                                        <!--Accordion thông tin chung-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#adn" href="#adnGeneral" class="accordion-toggle accordion-toggle-styled collapsed" aria-expanded="false">
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
                                                            <input type="text" name="txtName" id="txtName" runat="server"
                                                                class="form-control form-group" />
                                                            <asp:RequiredFieldValidator ID="reqv_txtNameVi" ControlToValidate="txtName"
                                                                runat="server" ValidationGroup="adminproductCategory" SetFocusOnError="true" Display="None"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrIntro" runat="server" Text="ltrIntro"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtIntro" TextMode="MultiLine" Rows="2" CssClass="form-control form-group" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group ">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrAdminIntro" runat="server" Text="Highlights"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" Language="vi" ID="txtDetailVi">
                                                            </uc:CKEditorControl>
                                                        </div>
                                                    </div>

                                                    <div class="form-group hidden ">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="Literal11" runat="server" Text="Highlights"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" Language="vi" ID="txtPositionVi">
                                                            </uc:CKEditorControl>
                                                            <%-- <asp:TextBox runat="server" ID="txtPositionVi" TextMode="MultiLine" Rows="2" CssClass="form-control form-group" />--%>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            Itinerary</label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" Language="vi" ID="txtUtilityVi">
                                                            </uc:CKEditorControl>
                                                            <%--<asp:TextBox runat="server" ID="txtUtilityVi" TextMode="MultiLine" CssClass="form-control form-group" />--%>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            Prices & Services</label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" Language="vi" ID="txtDesignVi">
                                                            </uc:CKEditorControl>
                                                            <%--<asp:TextBox runat="server" ID="txtDesignVi" CssClass="form-control form-group" />--%>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="Literal14" runat="server" Text="Products"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtPicturesVi" CssClass="form-control form-group" />

                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="Literal15" runat="server" Text="Product Application"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtPaymentVi" CssClass="form-control form-group" />

                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="Literal16" runat="server" Text="Architect"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox runat="server" ID="txtContactVi" CssClass="form-control form-group" />

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
                                                    <a data-toggle="collapse" data-parent="#adn" href="#adnSEO" class="accordion-toggle accordion-toggle-styled collapsed" aria-expanded="false">
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
                                                    <a data-toggle="collapse" data-parent="#adn" href="#adnGeneralEng" class="accordion-toggle accordion-toggle-styled collapsed" aria-expanded="false">
                                                        <asp:Literal runat="server" ID="Literal1" Text="ltrGeneral"></asp:Literal>
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="adnGeneralEng" class="panel-collapse collapse in">
                                                <div class="panel-body">

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="ltrAminNameEng" runat="server" Text="ltrAminNameEng"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="txtName_En" id="txtNameEng" size="60" runat="server" class="form-control form-group" />

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
                                                            <asp:Literal ID="ltrDetailEng" Text="ltrDetailEng" runat="server"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" ID="txtDetailEng">
                                                            </uc:CKEditorControl>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="Literal22" runat="server" Text="Address"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" Language="vi" ID="txtPositionEng">
                                                            </uc:CKEditorControl>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="Literal17" runat="server" Text="Glass Type"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" ID="txtUtilityEng">
                                                            </uc:CKEditorControl>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="Literal18" runat="server" Text="Glazing Contractor"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" ID="txtDesignEng">
                                                            </uc:CKEditorControl>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="Literal219" runat="server" Text="Products"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" ID="txtPicturesEng">
                                                            </uc:CKEditorControl>
                                                        </div>
                                                    </div>

                                                    <div class="form-group hidden">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="Literal20" runat="server" Text="Product Application"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" ID="txtPaymentEng">
                                                            </uc:CKEditorControl>
                                                        </div>
                                                    </div>

                                                    <div class="form-group hidden">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal ID="Literal21" runat="server" Text="Architect"></asp:Literal></label>
                                                        <div class="col-sm-10">
                                                            <uc:CKEditorControl runat="server" ID="txtContactEng">
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
                                                    <a data-toggle="collapse" data-parent="#adnEng" href="#adnSEOEng" class="accordion-toggle accordion-toggle-styled collapsed" aria-expanded="false">
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
                                <div class="tab-pane " id="tab_3">
                                    <dgc:block_baseimage ID="block_baseimage" runat="server" />
                                </div>
                                <!-- /.tab-pane -->
                                <div class="tab-pane" id="tab_4">
                                    <dgc:block_uploadimage Id="block_uploadimage" runat="server" />
                                </div>
                                <!-- /.tab-pane -->
                                <div class="tab-pane tabUploadVideo" id="tab_5">
                                    <dgc:block_uploadvideo Id="block_uploadvideo" runat="server" />
                                </div>
                                <!-- /.tab-pane -->
                                <div class="tab-pane" id="tab_6">
                                    <dgc:block_uploadfile ID="block_uploadfile" runat="server" />
                                </div>
                                <div class="tab-pane" id="tab_7">
                                    <dgc:block_mapsmulti Id="block_mapsmulti" runat="server" />
                                </div>
                                <div class="tab-pane" id="tab_8">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <i class="fa fa-hand-o-right fa-fw"></i><a runat="server" id="hypProgramTour" href="/adm/programtour" target="_blank">Quản lý chương trình tour</a>
                                            </h4>
                                        </div>
                                    </div>

                                    <%--<dgc:admin_programtour ID="admin_programtour" runat="server" />--%>
                                </div>

                                <div class="tab-pane" id="tab_9">
                                    <dgc:block_bookingprice ID="block_bookingprice" runat="server" />
                                </div>

                            </div>
                            <!-- /.tab-content -->
                        </div>

                        <%--/ Thông tin chi tiết--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<input type="hidden" name="task" value="" />
<input id="hddProductCategoryId" type="hidden" name="hddProductCategoryId" value="<%=productcategoryId%>" />


