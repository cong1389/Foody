<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_config.ascx.cs"
    Inherits="Cb.Web.Admin.Pages.Config.admin_config" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<script type="text/javascript">
    jQuery(function () {
        $("#tabs").tabs();
        jQuery("a.zoom-image").fancybox();
    });
</script>
<!-- Event btn-->
<section class="content-header ulBtn">
    <div class="row ">
        <div class="col-xs-12 text-right ">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <button validationgroup="adminconfig" id="btn_Save" runat="server" class="btn btn-success" onserverclick="btnSave_Click">
                        <i class="fa fa-check"></i>
                        <asp:Literal ID="ltrAdminSave" runat="server"></asp:Literal></button>


                    <%-- <button validationgroup="adminconfig" id="btn_Save" runat="server" text="Lưu" cssclass="btn btn-info"
                        onserverclick="btnSave_Click" title="Lưu">
                        <i class="fa fa-floppy-o fa-2x"></i>
                        <asp:Literal ID="ltrAdminSave" runat="server"></asp:Literal>
                    </button>--%>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</section>
<!--/ Event btn-->
<section class="content">
    <div class="row ">
        <div class="col-xs-12">
            <div class="box">
                <div class="main">
                    <!--Tab-->
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                            <li><a href="#tab_1" data-toggle="tab" runat="server" id="tabWebConfig">
                                <asp:Literal ID="ltrCo" runat="server" Text="Web.config"></asp:Literal></a></li>
                            <li class="active"><a href="#tab_2" data-toggle="tab" runat="server" id="hypImageSize">
                                <asp:Literal ID="ltrImageSize" runat="server" Text="Kích thước hình ảnh"></asp:Literal></a></li>
                            <li><a href="#tab_3" data-toggle="tab" runat="server" id="A1">
                                <asp:Literal ID="Literal1" runat="server" Text="Tài khoản email"></asp:Literal></a></li>
                            <li class="hidden"><a href="#tab_4" data-toggle="tab" runat="server">
                                <asp:Literal ID="Literal2" runat="server" Text="Phân trang"></asp:Literal></a></li>
                        </ul>
                        <div class="tab-content ">
                            <!-- /.tab-pane -->
                            <div class="tab-pane " id="tab_1">
                                <table class="adminform">
                                    <tr>
                                        <td class="width190">
                                            <strong>
                                                <asp:Literal ID="Literal9" runat="server" Text="Key"> </asp:Literal></strong>
                                        </td>
                                        <td>
                                            <input type="text" id="txtWebConfigKey" name="search" class="form-control inputSearch form-group"
                                                runat="server" placeholder="Nhập key" />
                                            <button id="btnGetWebConfig" runat="server" class="btn btn-default form-group " onserverclick="btnGetWebConfig_Click"
                                                style="height: 34px !important" title="Find">
                                                <i class="fa fa-search fa-1x"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>
                                                <asp:Literal ID="Literal10" runat="server" Text="Value"> </asp:Literal></strong>
                                        </td>
                                        <td>
                                            <input type="text" id="txtWebConfigValue" class="form-control inputSearch form-group"
                                                runat="server" placeholder="Value By Key" />

                                            <button validationgroup="btnSetWebConfig" id="Button1" runat="server" class="btn btn-success" onserverclick="btnSetWebConfig_Click">
                                                <i class="fa fa-check"></i>
                                                <asp:Literal ID="Literal21" runat="server">Lưu</asp:Literal></button>


                                            <%--   <button validationgroup="adminproductCategory" id="btnSetWebConfig" runat="server"
                                                text="Lưu" cssclass="btn btn-info" onserverclick="btnSetWebConfig_Click" title="Lưu">
                                                <i class="fa fa-floppy-o fa-2x"></i>
                                                <asp:Literal ID="Literal21" runat="server"></asp:Literal>
                                            </button>--%>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>
                                                <asp:Literal ID="Literal11" runat="server" Text="Web.config"></asp:Literal></strong>
                                        </td>
                                        <td>
                                            <textarea id="txtWebConfig" runat="server" class="form-control form-group" rows="50"
                                                cols="150"></textarea>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <!-- /.tab-pane -->
                            <div class="tab-pane active " id="tab_2">
                                <div class="panel-body">
                                    <div class="panel-group accordion" id="accordion">
                                        <!-- Category Image-->
                                        <div class="panel panel-default ">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false"
                                                        class="accordion-toggle accordion-toggle-styled collapsed">Danh mục </a>
                                                </h4>
                                            </div>
                                            <div id="collapseOne" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                                <div class="panel-body">
                                                    <div class="form-horizontal">
                                                        <div class="form-group hidden">
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Min width category</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMinWidthCategory" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Min height category</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMinHeightCategory" TextMode="Number" runat="server" min="10"
                                                                    max="2000" step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group ">
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Chiều rộng tối đa</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMaxWidthCategory" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Chiều cao tối đa</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMaxHeightCategory" TextMode="Number" runat="server" min="10"
                                                                    max="2000" step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group hidden">
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Chiều rộng tối đa</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtmaxWidthBoxCategory" TextMode="Number" runat="server" min="10"
                                                                    max="2000" step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Chiều cao tối đa</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMaxHeightBoxCategory" TextMode="Number" runat="server" min="10"
                                                                    max="2000" step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Item Image-->
                                        <div class="panel panel-default ">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="accordion-toggle accordion-toggle-styled collapsed"
                                                        aria-expanded="false">Bài viết </a>
                                                </h4>
                                            </div>
                                            <div id="collapseTwo" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                                <div class="panel-body">
                                                    <div class="form-horizontal ">
                                                        <div class="form-group hidden">
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Min width item</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMinWidthItem" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Min height item</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMinHeightItem" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group ">
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Chiều rộng tối đa</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMaxWidthItem" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Chiều cao tối đa</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMaxHeightItem" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group hidden">
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Chiều rộng tối đa</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtmaxWidthBoxItem" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Chiều cao tối đa</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMaxHeightBoxItem" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Slide Image-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" class="accordion-toggle accordion-toggle-styled collapsed"
                                                        aria-expanded="false">Slide </a>
                                                </h4>
                                            </div>
                                            <div id="collapseThree" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                                <div class="panel-body">
                                                    <div class="form-horizontal">
                                                        <div class="form-group hidden">
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Min width slide</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMinWidthSlider" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Min height slide</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMinHeightSlider" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group ">
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Chiều rộng tối đa</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMaxWidthSlider" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Chiều cao tối đa</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtMaxHeightSlider" TextMode="Number" runat="server" min="10" max="2000"
                                                                    step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group hidden">
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Max width box slide</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtmaxWidthBoxSlider" TextMode="Number" runat="server" min="10"
                                                                    max="2000" step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                            <label for="inputEmail3" class="col-sm-3 control-label">
                                                                Max height box slide</label>
                                                            <div class="col-sm-2">
                                                                <asp:TextBox ID="txtmaxHeightBoxSlider" TextMode="Number" runat="server" min="10"
                                                                    max="2000" step="1" Text="10" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.tab-pane -->
                            <div class="tab-pane" id="tab_3">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">
                                            Host</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="txtHost" placeholder="Host" runat="server">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">
                                            Tên đăng nhập</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="txtUser" placeholder="User" runat="server">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">
                                            Mật khẩu</label>
                                        <div class="col-sm-10">
                                            <input type="password" class="form-control" id="txtPass" placeholder="Pass" runat="server">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">
                                            Địa chỉ nhận email</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="txtEmail" placeholder="Email address"
                                                runat="server">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">
                                            SSL</label>
                                        <div class="col-sm-10">
                                            <input type="checkbox" name="chkSSL" id="chkSSL" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">
                                            Cổng</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="txtPort" placeholder="Port" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.tab-pane -->
                            <div class="tab-pane hidden" id="tab_4">
                                <div class="form-horizontal">
                                    <div class="row">
                                        <label class="col-sm-2 control-label">
                                            Hiển thị sản phẩm
                                        </label>
                                        <div class="col-sm-10">
                                            <div class="col-lg-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Literal ID="ltrPhone" runat="server" Text="Nhóm bài viết/Trang"></asp:Literal></label>
                                                    <input type="text" class="form-control edit-width" id="txtProductCategoryPz" runat="server">
                                                </div>
                                            </div>
                                            <div class="col-lg-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Literal ID="ltrFax" runat="server" Text="Bài viết/Trang"></asp:Literal></label>
                                                    <input type="text" class="form-control edit-width" id="txtProductPz" runat="server">
                                                </div>
                                            </div>
                                            <div class="col-lg-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Literal ID="ltrEmail" runat="server" Text="Slide/Trang"></asp:Literal>
                                                    </label>
                                                    <input type="text" class="form-control edit-width" id="txtSlidetPz" runat="server">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- /.tab-content -->
                    </div>
                    <!--End Tab-->
                </div>
            </div>
        </div>
    </div>
</section>
<input type="hidden" name="task" value="" />
