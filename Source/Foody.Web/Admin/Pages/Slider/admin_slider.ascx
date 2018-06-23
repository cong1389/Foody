<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_slider.ascx.cs"
    Inherits="Cb.Web.Admin.Pages.Slider.admin_slider" %>
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>

<!--admin_slider-->
<script type="text/javascript">
    function submitButton(task) {
        var frm = document.getElementById('aspnetForm');
        //alert(task);
        if (task == 'new' || task == 'search' || task == 'edit' || task == 'delete' || task == 'publish' || task == 'unpublish' || checkSelectedItem('<%=msg_no_selected_item%>')) {
            switch (task) {
                case 'delete':
                    if (!confirm('<%=msg_confirm_delete_item%>')) {
                        break;
                    }
                default:
                    submitForm(frm, task);
            }
        }
    }   
</script>

<!-- Event btn-->
<section class="content-header ulBtn">
    <div class="row">
        <div class="col-lg-4">
            <div style="display: table" class="form-group">
                <asp:DropDownList ID="drpPosition" runat="server" class="form-control" Visible="false">
                </asp:DropDownList>
                <input type="text" id="search" name="search" class="form-control" runat="server"
                    onkeypress="return checkEnter(event);" placeholder="Tìm kiếm" />
                <div class="input-group-btn">
                    <button id="btnSearch" runat="server" class="btn btn-default " onserverclick="btnSearch_Click"
                        style="height: 34px !important">
                        <i class="fa fa-search fa-1x"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="col-lg-8 col-xs-12 btnGroup">

            <a href="javascript:submitButton('new');" class="btn green-haze btn-outline btn-circle btn-sm">
                <i class="fa fa-plus"></i>
                <span class="hidden-xs">
                    <asp:Literal ID="ltrAdminAddNew" runat="server" Text="Thêm mới"></asp:Literal>
                </span>
            </a>

            <div class="btn-group">
                <a class="btn green-haze btn-outline btn-circle btn-sm" href="javascript:;" data-toggle="dropdown" data-hover="dropdown" data-close-others="true" aria-expanded="true">Chọn thao tác
                    <i class="fa fa-angle-down"></i>
                </a>
                <ul class="dropdown-menu pull-right">
                    <li>
                        <a class="" href="javascript:submitButton('publish');">
                            <i class="fa fa-check-circle-o fa-fw"></i>
                            <asp:Literal ID="ltrAdminPublish" runat="server" Text="strAdminPublish"></asp:Literal>
                        </a>
                    </li>
                    <li>
                        <a class="" href="javascript:submitButton('unpublish');">
                            <i class="fa fa-times-circle-o fa-fw"></i>
                            <asp:Literal ID="ltrAminUnPublish" runat="server" Text="strAdminUnpublish"></asp:Literal>
                        </a>
                    </li>
                    <li></li>
                    <li class="divider"></li>
                    <li>
                        <a class=" hidden" href="javascript:submitButton('edit');">
                            <i class="fa fa-pencil fa-fw"></i>
                            <asp:Literal ID="ltrAdminEdit" runat="server" Text="Chỉnh sửa"></asp:Literal>
                        </a>
                    </li>
                    <li>
                        <a class="" href="javascript:submitButton('delete');">
                            <i class="fa fa-trash-o fa-fw"></i>
                            <asp:Literal ID="ltrAdminDelete" runat="server" Text="Xóa"></asp:Literal>
                        </a>
                    </li>
                </ul>
            </div>

            <button runat="server" id="btnSave" class="btn btn-block btn-social btn-twitter hidden"
                title="Lưu" onserverclick="btnSave_Click">
                <i class="fa fa-floppy-o fa-2x"></i>&nbsp Lưu
            </button>

        </div>
    </div>
</section>
<!-- /Event btn-->

<!-- BEGIN show_msg -->
<%=show_msg%>
<!-- END show_msg -->
<section class="content">
    <div class="row ">
        <div class="col-xs-12">

            <table class="table table-bordered table-hover tbl-news">
                <tr class="txt-bold tbl-title">
                    <th width="2%">#
                    </th>
                    <th width="3%">
                        <input class="txt" type="checkbox" name="checkedAll" onclick="checkAll(<%=records%>);" />
                    </th>
                      <th width="10%">
                        <asp:Literal ID="Literal2" runat="server" Text="Hình ảnh"></asp:Literal>
                    </th>
                    <th>
                        <asp:Literal ID="ltrAdminHeaderProductCategory" runat="server" Text="strName"></asp:Literal>
                    </th>
                    <th class="hidden">
                        <asp:Literal ID="Literal1" runat="server" Text="strPosition"></asp:Literal>
                    </th>
                    <th class="text-center" width="9%">
                        <asp:Literal ID="ltrAdminHeaderOrder" runat="server" Text="strOrdering"></asp:Literal>
                    </th>
                  
                    <th width="20%">
                        <asp:Literal ID="ltrAdminHeaderDate" runat="server" Text="strUpdateDate"></asp:Literal>
                    </th>
                    <th width="10%">
                        <asp:Literal ID="ltrAdminHeaderPublic" runat="server" Text="strAdminPublish"></asp:Literal>
                    </th>
                </tr>
                <!-- BEGIN list -->
                <asp:Repeater ID="rptResult" runat="server" OnItemDataBound="rptResult_ItemDataBound">
                    <ItemTemplate>
                        <tr id="trList" runat="server">
                            <td>
                                <input type="button" id="btId" style="display: none" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="ltrchk" runat="server"></asp:Literal>
                            </td>
                            <td>
                                <a runat="server" id="hypImg">
                                    <cc:DGCBannerControl ID="ucBanner" runat="server" Width="50" Height="50" CssClass="baseImageGrid" />
                                </a>

                            </td>
                            <td>
                                <asp:HyperLink ID="hdflink" runat="server">
                                    <asp:Literal ID="ltrName" runat="server"></asp:Literal>
                                </asp:HyperLink>
                            </td>
                            <td class="hidden">
                                <asp:Literal ID="ltrPosition" runat="server" />
                            </td>
                            <td class="text-center">
                                <asp:Literal ID="ltrSort" runat="server"></asp:Literal>
                            </td>
                            
                            <td id="trUpdateDate" runat="server">
                                <%# Eval("UpdateDate")%>
                            </td>
                            <td align="center" id="tdbtn" runat="server">
                                <asp:ImageButton CssClass="toolbar" ID="btnPublish" runat="server" Width="15" Height="15"
                                    ValidationGroup="admincontent" AlternateText="Publish" title="Publish" />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
            <!-- Begin paging -->
            <div class="text-right">
                <cc:Pager ID="pager" runat="server" EnableViewState="true" OnCommand="pager_Command"
                    CompactModePageCount="10" MaxSmartShortCutCount="0" RTL="False" />
            </div>
            <!-- End paging -->

        </div>
    </div>
</section>
<input type="hidden" name="boxchecked" value="0" />
<input type="hidden" name="task" value="" />