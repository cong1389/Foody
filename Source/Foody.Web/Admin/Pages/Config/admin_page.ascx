<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_page.ascx.cs"
    Inherits="Cb.Web.Admin.Pages.Config.admin_page" %>

<!--admin_page-->
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Cb.WebControls" Namespace="Cb.WebControls" TagPrefix="uc" %>

<script type="text/javascript">
    $(function () {
        $("#tabs").tabs();
        jQuery("a.zoom-image").fancybox();
    });
</script>

<!-- Event btn-->
<section class="content-header ulBtn">
    <div class="row ">
        <div class="col-lg-12 col-xs-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="pull-right">
                        <button validationgroup="adminconfig" id="btn_Save" runat="server" class="btn btn-success" onserverclick="btnSave_Click">
                            <i class="fa fa-check"></i>
                            <asp:Literal ID="ltrAdminSave" runat="server"></asp:Literal></button>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</section>
<!-- /Event btn-->

<section class="content">
    <div class="row ">
        <div class="col-xs-12">
            <div class="box">
                <div class="form-horizontal">
                    <div class="panel-body">
                        <div class="section">
                            <!--Tab-->
                            <div class="nav-tabs-custom">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#tab_1" data-toggle="tab">
                                        <asp:Literal ID="ltrSite" runat="server" Text="Thông tin cửa hàng"></asp:Literal></a></li>
                                    <li>
                                        <a href="#tab_2" data-toggle="tab">
                                            <asp:Literal ID="ltrMetaTag" runat="server" Text="SEO Page"></asp:Literal>
                                        </a>
                                    </li>

                                    <li><a href="#tab_3" data-toggle="tab">Tiếng Việt</a></li>
                                    <li><a href="#tab_4" data-toggle="tab">Tiếng Anh</a></li>

                                </ul>
                                <div class="tab-content">
                                    <!-- tab 1 -->
                                    <div class="tab-pane active" id="tab_1">

                                        <!--Website-->
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                <asp:Literal ID="ltrSiteName" runat="server" Text="strSiteName"></asp:Literal></label>
                                            <div class="col-sm-10">
                                                <input type="text" id="txt_config_sitename" runat="server" class="form-control" size="30" />
                                            </div>

                                        </div>

                                        <!--Tên công ty-->
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                <asp:Literal ID="ltrCompanyName" runat="server" Text="Tên công ty tiếng việt"></asp:Literal>
                                            </label>
                                            <div class="col-sm-10">
                                                <input type="text" id="txtCompanyName" runat="server" class="form-control" size="30" />
                                            </div>
                                        </div>

                                        <!--Tên công ty-->
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                <asp:Literal ID="Literal2" runat="server" Text="Tên công ty tiếng anh"></asp:Literal>
                                            </label>
                                            <div class="col-sm-10">
                                                <input type="text" id="txtCompanyNameEng" runat="server" class="form-control" size="30" />
                                            </div>
                                        </div>

                                        <!--Phone-->
                                        <div class="row">
                                            <label class="col-sm-2 control-label">
                                            </label>
                                            <div class="col-sm-10">
                                                <div class="col-lg-4">
                                                    <div class="form-group">
                                                        <label>
                                                            <asp:Literal ID="ltrPhone" runat="server" Text="ltrPhone"></asp:Literal></label>
                                                        <input type="text" class="form-control edit-width" id="txt_config_phone" runat="server">
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="form-group">
                                                        <label>
                                                            <asp:Literal ID="ltrFax" runat="server" Text="ltrFax"></asp:Literal></label>
                                                        <input type="text" class="form-control edit-width" id="txtFax" runat="server">
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="form-group">
                                                        <label>
                                                            <asp:Literal ID="ltrEmail" runat="server" Text="ltrEmail"></asp:Literal>
                                                        </label>
                                                        <input type="text" class="form-control edit-width" id="txt_config_email" runat="server">
                                                        <asp:RegularExpressionValidator ID="regv_Email" ControlToValidate="txt_config_email"
                                                            runat="server" Text="*" ValidationExpression="" ValidationGroup="adminconfig" CssClass="validator" Enabled="false"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!--Địa chỉ 1-->
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                <asp:Literal ID="ltrAddress" runat="server" Text="Địa chỉ tiếng việt"></asp:Literal>
                                            </label>
                                            <div class="col-sm-10">
                                                <input type="text" id="txtAddress" runat="server" class="form-control"
                                                    size="30" />
                                            </div>

                                        </div>

                                        <!--Địa chỉ 2-->
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                <asp:Literal ID="ltrAddress2" runat="server" Text="Địa chỉ tiếng anh"></asp:Literal>
                                            </label>
                                            <div class="col-sm-10">
                                                <input type="text" id="txtAddress1" runat="server" class="form-control" size="30" />
                                            </div>
                                        </div>

                                        <!--Tài khoản yahoo, skype-->
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label hidden">
                                                <asp:Literal ID="ltrYahooAcc" runat="server" Text="ltrYahooAcc"></asp:Literal></label>
                                            <div class="col-sm-4 hidden">
                                                <input type="text" id="txtYahoo" runat="server" class="form-control"
                                                    size="30" />
                                            </div>
                                            <label class="col-sm-2 control-label">
                                                <label>
                                                    <asp:Literal ID="ltrSkypeAcc" runat="server" Text="Thời gian làm việc"></asp:Literal>
                                                </label>
                                            </label>
                                            <div class="col-sm-10">
                                                <input type="text" id="txtSkype" runat="server" class="form-control"
                                                    size="30" />
                                            </div>
                                        </div>

                                        <!--Vĩ độ, kinh độ-->
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                <label>
                                                    <asp:Literal ID="ltrLatitude" runat="server" Text="ltrLatitude"></asp:Literal>
                                                </label>
                                            </label>
                                            <div class="col-sm-4">
                                                <input type="text" id="txtLatitude" runat="server" class="form-control" size="60" />
                                            </div>
                                            <label class="col-sm-2 control-label">
                                                <asp:Literal ID="Literal1" runat="server" Text="ltrLongitude"></asp:Literal>
                                            </label>
                                            <div class="col-sm-4">
                                                <input type="text" id="txtLongitude" runat="server" class="form-control" size="60" />
                                            </div>
                                        </div>

                                        <!--Logo header, footer-->
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                <label>
                                                    <asp:Literal ID="Literal7" runat="server" Text="Logo Header"></asp:Literal>
                                                </label>
                                            </label>
                                            <div class="col-sm-4">
                                                <asp:FileUpload ID="fuImageHeader" runat="server" EnableViewState="true" />
                                                <asp:Button ID="btnUploadImageHeader" runat="server" Text="strUpload" OnClick="btnUploadImageHeader_Click" />
                                                <asp:LinkButton ID="lbnViewHeader" runat="server" Text="strView" Visible="false"
                                                    CssClass="zoom-image"><i class="fa fa-picture-o fa-2x"></i></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:LinkButton ID="lbnDeleteHeader" runat="server" Text="strDelete" Visible="false"
                                                OnClick="lbnDeleteImageHeader_Click"><i class="fa fa-trash-o fa-2x"></i></asp:LinkButton>
                                            </div>

                                            <label class="col-sm-2 control-label">
                                                <asp:Literal ID="Literal4" runat="server" Text="Logo Footer"></asp:Literal></label>
                                            <div class="col-sm-4">
                                                <asp:FileUpload ID="fuImageFooter" runat="server" EnableViewState="true" CssClass="col-xs-8" />
                                                <asp:Button ID="btnUploadImageFooter" runat="server" Text="strUpload" OnClick="btnUploadImageFooter_Click" />
                                                <asp:LinkButton ID="lbnViewFooter" runat="server" Text="strView" Visible="false"
                                                    CssClass="zoom-image"><i class="fa fa-picture-o fa-2x"></i></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:LinkButton ID="lbnDeleteFooter" runat="server" Text="strDelete" Visible="false"
                                                OnClick="lbnDeleteImageFooter_Click"><i class="fa fa-trash-o fa-2x"></i></asp:LinkButton>
                                            </div>
                                        </div>

                                        <!--Sơ đồ đường đi-->
                                        <div class="form-group hidden">
                                            <label class="col-sm-2 control-label">
                                                <label>
                                                    <asp:Literal ID="Literal5" runat="server" Text="Sơ đồ đường đi"></asp:Literal>
                                                </label>
                                            </label>
                                            <div class="col-sm-4">
                                                <asp:FileUpload ID="fuLocation" runat="server" EnableViewState="true" CssClass="btn btn-info btn-xs" />
                                                <asp:Button ID="btnUploadLocation" runat="server" Text="strUpload" OnClick="btnUploadLocation_Click"
                                                    CssClass="btn btn-info btn-xs" />
                                                <asp:LinkButton ID="lbnViewLocation" runat="server" Text="strView" Visible="false"
                                                    CssClass="zoom-image"><i class="fa fa-picture-o fa-2x"></i></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:LinkButton ID="lbnDeleteLocation" runat="server" Text="strDelete" Visible="false"
                                                OnClick="lbnDeleteLocation_Click"><i class="fa fa-trash-o fa-2x"></i></asp:LinkButton>
                                            </div>
                                        </div>

                                        <!--Liên hệ-->
                                        <div class="form-group ">
                                            <label class="col-sm-2 control-label">
                                                <asp:Literal ID="Literal3" runat="server" Text="Liên hệ"></asp:Literal></label>
                                            <div class="col-sm-10">
                                                <uc:CKEditorControl runat="server" Language="vi" ID="editContact">
                                                </uc:CKEditorControl>
                                            </div>

                                        </div>

                                        <!--Footer-->
                                        <div class="form-group ">
                                            <label class="col-sm-2 control-label">
                                                <asp:Literal ID="Literal9" runat="server" Text="Footer"></asp:Literal>s</label>
                                            <div class="col-sm-10">
                                                <uc:CKEditorControl runat="server" Language="vi" ID="editFooter">
                                                </uc:CKEditorControl>
                                            </div>
                                        </div>

                                    </div>

                                    <!-- tab 2 -->
                                    <div class="tab-pane" id="tab_2">
                                        <div class="panel-group accordion">
                                            <!--SEO Website-->
                                            <div class="panel panel-default ">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#pnlSEO" aria-expanded="false"
                                                            class="accordion-toggle accordion-toggle-styled collapsed">SEO WebSite</a>
                                                    </h4>
                                                </div>
                                                <div id="pnlSEO" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                                    <div class="panel-body">
                                                        <div class="form-horizontal">

                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">
                                                                    <asp:Literal ID="Literal8" runat="server" Text="Tiêu đề trang"> </asp:Literal></label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtTitle" runat="server" class="form-control" rows="2" cols="60"></textarea>
                                                                </div>
                                                                <label class="col-sm-2 control-label">
                                                                    <asp:Literal ID="Literal15" runat="server" Text="H1"></asp:Literal></label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtH1" runat="server" class="form-control" rows="2" cols="60"></textarea>
                                                                </div>

                                                            </div>

                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">
                                                                    <asp:Literal ID="ltrMetaKey" runat="server" Text="Meta Keyword"></asp:Literal></label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtMetaKeyword" runat="server" class="form-control" rows="2"
                                                                        cols="60"></textarea>
                                                                </div>
                                                                <label class="col-sm-2 control-label">
                                                                    <label>
                                                                        <asp:Literal ID="Literal16" runat="server" Text="H2"></asp:Literal>
                                                                    </label>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtH2" runat="server" class="form-control" rows="2" cols="60"></textarea>
                                                                </div>

                                                            </div>

                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">
                                                                    <asp:Literal ID="ltrMetaDesc" runat="server" Text="Meta Description"> </asp:Literal>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtMetaDescription" runat="server" class="form-control"
                                                                        rows="2" cols="60"></textarea>
                                                                </div>
                                                                <label class="col-sm-2 control-label">
                                                                    <asp:Literal ID="Literal17" runat="server" Text="H3"></asp:Literal></label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtH3" runat="server" class="form-control" rows="2" cols="60"></textarea>
                                                                </div>

                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!--Social network-->
                                            <div class="panel panel-default ">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#pnlSocialNetWork" aria-expanded="false"
                                                            class="accordion-toggle accordion-toggle-styled collapsed">Mạng xã hội</a>
                                                    </h4>
                                                </div>
                                                <div id="pnlSocialNetWork" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                                    <div class="panel-body">
                                                        <div class="form-horizontal">

                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">
                                                                    <asp:Literal ID="Literal13" runat="server" Text="FanPage Google+"></asp:Literal>

                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtGooglePlus" runat="server" class="form-control" rows="2"
                                                                        cols="60"></textarea>
                                                                </div>
                                                                <label class="col-sm-2 control-label">
                                                                    <asp:Literal ID="Literal19" runat="server" Text="Like Facebook"></asp:Literal>
                                                                    </br>
                                                                <a href="https://developers.facebook.com/docs/plugins/like-button" target="_blank">
                                                                    <small><ins>Lấy mã</small></sins>
                                                                </a>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtLikePage" runat="server" class="form-control" rows="2"
                                                                        cols="60"></textarea>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">
                                                                    <asp:Literal ID="Literal12" runat="server" Text="FanPage Facebook"></asp:Literal>
                                                                    </br>
                                                                <a href="https://developers.facebook.com/docs/plugins/page-plugin" target="_blank">
                                                                    <small><ins>Lấy mã</small></sins>
                                                                </a>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtFacebook" runat="server" class="form-control" rows="2"
                                                                        cols="60"></textarea>
                                                                </div>
                                                                <label class="col-sm-2 control-label">
                                                                    <asp:Literal ID="Literal18" runat="server" Text="Google Analytic"></asp:Literal>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtAnalytic" runat="server" class="form-control" rows="2"
                                                                        cols="60"></textarea>
                                                                </div>


                                                            </div>

                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">
                                                                    <label>
                                                                        <asp:Literal ID="Literal14" runat="server" Text="LinkedIn"></asp:Literal>
                                                                    </label>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtLinkedIn" runat="server" class="form-control" rows="2"
                                                                        cols="60"></textarea>
                                                                </div>
                                                                <label class="col-sm-2 control-label">
                                                                    <label>
                                                                        <asp:Literal ID="Literal20" runat="server" Text="pinterest"></asp:Literal>
                                                                    </label>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtPinterest" runat="server" class="form-control" rows="2" cols="60"></textarea>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">
                                                                    <label>
                                                                        <asp:Literal ID="Literal6" runat="server" Text="Twitter"></asp:Literal>
                                                                    </label>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtTwitter" runat="server" class="form-control" rows="2"
                                                                        cols="60"></textarea>
                                                                </div>
                                                                <label class="col-sm-2 control-label">
                                                                    <label>
                                                                        <asp:Literal ID="Literal10" runat="server" Text="VChat"></asp:Literal>
                                                                    </label>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtVChat" runat="server" class="form-control" rows="2" cols="60"></textarea>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">
                                                                    <label>
                                                                        <asp:Literal ID="Literal22" runat="server" Text="Reddit"></asp:Literal>
                                                                    </label>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtreddit" runat="server" class="form-control" rows="2"
                                                                        cols="60"></textarea>
                                                                </div>
                                                                <label class="col-sm-2 control-label">
                                                                    <label>
                                                                        <asp:Literal ID="Literal23" runat="server" Text="FanPage Facebook footer"></asp:Literal>
                                                                    </label>
                                                                </label>
                                                                <div class="col-sm-4">
                                                                    <textarea id="txtFBFooter" runat="server" class="form-control" rows="2" cols="60"></textarea>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                    <!-- tab 3 -->
                                    <div class="tab-pane" id="tab_3">
                                        <div class="panel-group accordion">

                                            <asp:Repeater ID="rptGenControlVn" runat="server" OnItemDataBound="rptGenControl_ItemDataBound">
                                                <ItemTemplate>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal runat="server" ID="ltrName"></asp:Literal>
                                                        </label>
                                                        <div class="col-sm-10">
                                                            <input id="txtContent" runat="server" class="form-control" />
                                                        </div>
                                                    </div>

                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </div>
                                    </div>
                                    <!-- /tab 3 -->

                                    <!-- tab 4 -->
                                    <div class="tab-pane" id="tab_4">
                                        <div class="panel-group accordion">

                                            <asp:Repeater ID="rptGenControlEng" runat="server" OnItemDataBound="rptGenControl_ItemDataBound">
                                                <ItemTemplate>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">
                                                            <asp:Literal runat="server" ID="ltrName"></asp:Literal>
                                                        </label>
                                                        <div class="col-sm-10">
                                                            <input id="txtContent" runat="server" class="form-control" />
                                                        </div>
                                                    </div>

                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </div>
                                    </div>
                                    <!-- /tab 4 -->

                                </div>
                            </div>
                            <!-- /.tab-content -->
                        </div>
                        <!--End Tab-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<input type="hidden" name="task" value="" />
