<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_contentstatic.ascx.cs"
    Inherits="Cb.Web.Admin.Pages.ContentStatic.admin_contentstatic" %>

<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>

<script language="javascript" type="text/javascript">
    function submitButton(task) {
        var frm = document.getElementById('aspnetForm');
        //alert(task);
        if (task == 'new' || task == 'search' || task == 'edit' || task == 'delete' || task == 'publish' || task == 'unpublish' || ('<%=msg_no_selected_item%>')) {
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
        <%-- <div class="col-lg-4">
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

        </div>--%>
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

<%--<table width="100%" class="menubar" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td class="menudottedline" width="40%">
            <div class="pathway">
            </div>
        </td>
        <td class="menudottedline" align="right">
            <table cellpadding="0" cellspacing="0" border="0" id="toolbar">
                <tr valign="middle" align="center">
                    <td>
                        <a class="toolbar" href="javascript:submitButton('publish');">
                            <img src="<%=template_path%>/Images/publish_f2.png" alt="Publish" name="publish"
                                title="Publish" align="middle" border="0" /><br />
                            <asp:Literal ID="ltrAdminPublish" runat="server" Text="strAdminPublish"></asp:Literal></a>
                    </td>
                    <td>&nbsp;
                    </td>
                    <td>
                        <a class="toolbar" href="javascript:submitButton('unpublish');">
                            <img src="<%=template_path%>/images/unpublish_f2.png" alt="Unpublish" name="unpublish"
                                title="unpublish" align="middle" border="0" /><br />
                            <asp:Literal ID="ltrAminUnpublish" runat="server" Text="str_admin_unpublish"></asp:Literal></a>
                    </td>
                    <td>&nbsp;
                    </td>
                    <td>
                        <a class="toolbar" href="javascript:submitButton('new');">
                            <img src="<%=template_path%>/images/new_f2.png" alt="New" name="new" title="New"
                                align="middle" border="0" /><br />
                            <asp:Literal ID="ltrAdminAddNew" runat="server" Text="strAdminAddNew"></asp:Literal></a>
                    </td>
                    <td>&nbsp;
                    </td>
                    <td>
                        <a class="toolbar">
                            <asp:ImageButton CssClass="toolbar" ID="btn_Save" runat="server" AlternateText="Save"
                                name="Save" title="Save" ImageUrl="/admin/images/save_f2.png" OnClick="btn_Save_Click" />
                            <br />
                            <asp:Literal ID="ltrAdminSave" runat="server" Text="strSave"></asp:Literal>
                        </a>
                        
                    </td>
                    <td>&nbsp;
                    </td>
                    <td>
                        <a class="toolbar" href="javascript:submitButton('edit');">
                            <img src="<%=template_path%>/images/edit_f2.png" alt="Edit" name="edit" title="Edit"
                                align="middle" border="0" /><br />
                            <asp:Literal ID="ltrAdminEdit" runat="server" Text="strEdit"></asp:Literal></a>
                    </td>
                    <td>&nbsp;
                    </td>
                    <td>
                        <a class="toolbar" href="javascript:submitButton('delete');">
                            <img src="<%=template_path%>/images/delete_f2.png" alt="Delete" name="delete" title="Delete"
                                align="middle" border="0" /><br />
                            <asp:Literal ID="ltrAdminDelete" runat="server" Text="strDelete"></asp:Literal></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>--%>
<br />
<!-- BEGIN show_msg -->
<%--<%=show_msg%>--%>
<!-- END show_msg -->

<section class="content">
    <div class="row ">
        <div class="col-xs-12  table-responsive">
            <table class="table table-bordered table-hover tbl-news">
                <tr class="txt-bold tbl-title ">
                    <th width="2%" class="hidden">#
                    </th>
                    <th width="3%" class="title">
                        <input class="txt" type="checkbox" name="checkedAll" onclick="checkAll(<%=records%>);" />
                    </th>
                    <th class="title">
                        <asp:Literal ID="ltrAdminHeaderProductCategory" runat="server" Text="strName"></asp:Literal>
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
                                <a runat="server" id="hypImage">
                                    <img runat="server" id="Image" class="center-block baseImageGrid" />
                                </a>
                            </td>
                            <td>
                                <input id="txtOrder" disabled class="form-control text-center txtOrder" runat="server" />
                            </td>
                            <td id="trUpdateDate" runat="server">
                                <%# Eval("UpdateDate")%>
                            </td>
                            <td align="center" id="tdbtn" runat="server">
                                <asp:ImageButton CssClass="toolbar" ID="btnPublish" runat="server" Width="12" Height="12"
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

<%--
<div align="center" class="centermain">
    <div class="main">
        <table class="adminheading">
            <tr>
                <th class="config">
                    <asp:Literal ID="ltrAdminHeaderName" runat="server" Text="strHeaderFooter"></asp:Literal>
                </th>
            </tr>
        </table>


        <table>
            <tr>
                <th colspan="2">
                    <!-- BEGIN paging -->
                    <div style="padding: 3px;" align="center">
                        <cc:Pager ID="pager" runat="server" EnableViewState="true" OnCommand="pager_Command"
                            CompactModePageCount="10" MaxSmartShortCutCount="0" RTL="False" />
                    </div>
                    <!-- END paging -->
                </th>
            </tr>
        </table>
    </div>
</div>--%>


<input type="hidden" name="boxchecked" value="0" />
<input type="hidden" name="task" value="" />