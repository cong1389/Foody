<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_productcategory.ascx.cs"
    Inherits="Cb.Web.Admin.Pages.ProductCategory.admin_productcategory" %>

<!--admin_productcategory-->
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>

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
<section class="content-header">
    <div class="row">
        <div class="col-lg-4">
            <div style="display: table" class="form-group">
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
<%--<%=show_msg%>--%>
<!-- END show_msg -->
<section class="content">
    <div class="row ">
        <div class="col-xs-12  table-responsive">
            <table class="table table-bordered table-hover tbl-news">
                <tr class="txt-bold tbl-title ">
                    <th width="2%" class="hidden">#
                    </th>
                    <th width="3%">
                        <input class="chkAll" type="checkbox" name="checkedAll" onclick="checkAll(<%=records%>);" />
                    </th>
                    <th>
                        <asp:Literal ID="ltrProductCategory" runat="server" Text="ltrProductCategory"></asp:Literal>
                    </th>
                    <th width="12%">
                        <asp:Literal ID="ltrAdminHeaderImg" runat="server" Text="ltrBaseImage"></asp:Literal>
                    </th>
                    <th width="10%">
                        <asp:Literal ID="ltrAdminHeaderOrder" runat="server" Text="strOrdering"></asp:Literal>
                    </th>
                    <th width="13%">
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
                            <td class="hidden">
                                <input type="button" id="btId" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="ltrchk" runat="server"></asp:Literal>
                            </td>
                            <td>
                                <asp:HyperLink ID="hdflink" runat="server">
                                    <asp:Literal ID="ltrName" runat="server"></asp:Literal>
                                </asp:HyperLink>
                            </td>
                            <td>
                                <a runat="server" id="hypBaseImage">
                                    <img runat="server" id="baseImage" class="center-block baseImageGrid" />
                                </a>
                            </td>
                            <td>
                                <input id="txtOrder" disabled class="form-control text-center txtOrder" runat="server" />
                            </td>
                            <td id="trUpdateDate" runat="server">
                                <%# Eval("UpdateDate", "{0:d}")%>
                            </td>
                            <td align="center" id="tdbtn" runat="server">
                                <asp:ImageButton CssClass="toolbar" ID="btnPublish" runat="server" Width="15" Height="15"
                                    ValidationGroup="admincontent" AlternateText="Publish" title="Publish" ImageUrl="~/admdgc/images/write_f2.png" />
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