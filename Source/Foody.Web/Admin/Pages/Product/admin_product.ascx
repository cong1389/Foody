<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_product.ascx.cs"
    Inherits="Cb.Web.Admin.Pages.Products.admin_product" %>
<!--admin_product-->
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<script type="text/javascript">    

    function submitButton(task) {
        var frm = document.getElementById('aspnetForm');        
        if (task == 'new' || task == 'search' ||task == 'txtCode' || task == 'edit' || task == 'delete' || task == 'publish' || task == 'unpublish'             
            || task == 'producthome'    || task == 'produthot'  || task == 'produtpromotion' 
            //  || checkSelectedItem('<%=msg_no_selected_item%>')
            ) {
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

    function search_keypress(e) {
        var key;

        if (window.event)
            key = window.event.keyCode;     //IE
        else
            key = e.which;     //firefox
        //alert(key);
        if (key == 13) {
            document.getElementById('<%=btnSearch.ClientID%>').click();
        }
        else
            return true;
    }    
</script>

<!-- Event btn-->
<section class="content-header">
    <div class="row1">
        <div class="col-lg-8 col-xs-12 btnGroup">
            <a href="javascript:submitButton('new');" class="btn green-haze btn-outline btn-circle btn-sm">
                <i class="fa fa-plus"></i>
                <span class="hidden-xs">
                    <asp:Literal ID="ltrAdminAddNew" runat="server" Text="Thêm mới"></asp:Literal>
                </span>
            </a>
            <!--Thao tác-->
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
            <!--Thao tác-->

            <!--Lọc sản phẩm-->
            <div class="btn-group">
                <a class="btn green-haze btn-outline btn-circle btn-sm" href="javascript:;" data-toggle="dropdown" data-hover="dropdown" data-close-others="true" aria-expanded="true">Lọc sản phẩm
                    <i class="fa fa-angle-down"></i>
                </a>
                <ul class="dropdown-menu pull-right">
                    <li>
                        <a class="" href="javascript:submitButton('producthome');">
                            <i class="fa fa-check-circle-o fa-fw"></i>
                            <asp:Literal ID="Literal4" runat="server" Text="Hiển thị sản phẩm trang chủ"></asp:Literal>
                        </a>
                    </li>
                    <li>
                        <a class="" href="javascript:submitButton('produthot');">
                            <i class="fa fa-times-circle-o fa-fw"></i>
                            <asp:Literal ID="Literal5" runat="server" Text="Sản phẩm hot"></asp:Literal>
                        </a>
                    </li>
                    <li>
                        <a class="" href="javascript:submitButton('produtpromotion');">
                            <i class="fa fa-pencil fa-fw"></i>
                            <asp:Literal ID="Literal6" runat="server" Text="Sản phẩm khuyến mãi"></asp:Literal>
                        </a>
                    </li>
                </ul>
            </div>
            <!--Thao tác-->

            <button runat="server" id="btnSave" class="btn btn-block btn-social btn-twitter hidden"
                title="Lưu" onserverclick="btnSave_Click">
                <i class="fa fa-floppy-o fa-2x"></i>&nbsp Lưu
            </button>

        </div>
    </div>
</section>

<!-- /Event btn-->

<!-- BEGIN show_msg -->
<%--<%=show_msg%>--%>
<!-- END show_msg -->
<section class="content">
    <div class="row1 ">
        <div class="col-xs-12">

            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="form-horizontal1">

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>
                                    Hãng sản xuất</label>
                                <asp:DropDownList ID="drpBrand" runat="server" CssClass="form-control drp"
                                    OnSelectedIndexChanged="drpBrand_onchange"
                                    AutoPostBack="True">
                                </asp:DropDownList>

                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>
                                    <asp:Literal ID="strHeaderProduct" runat="server" Text="strHeaderProduct"></asp:Literal></label>

                                <asp:DropDownList ID="drpCategory" runat="server" CssClass="form-control drp" OnSelectedIndexChanged="drpCategory_onchange"
                                    AutoPostBack="True">
                                </asp:DropDownList>

                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Tên sản phẩm </label>
                                <div class="input-group">
                                    <input type="text" id="search" name="search" class="form-control" runat="server"
                                        onkeypress="return search_keypress(event);" placeholder="Nhập tên sản phẩm" />
                                    <div class="input-group-btn">
                                        <button id="btnSearch" runat="server" class="btn btn-default " onserverclick="btnSearch_Click"
                                            style="height: 34px !important">
                                            <i class="fa fa-search fa-1x"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Mã code </label>
                                <div class="input-group">
                                    <input type="text" id="txtCode" name="txtCode" class="form-control" runat="server"
                                        onkeypress="return search_keypress(event);" placeholder="Nhập mã code" />
                                    <div class="input-group-btn">
                                        <button id="btnSearchCode" runat="server" class="btn btn-default " onserverclick="btnSearchCode_Click"
                                            style="height: 34px !important">
                                            <i class="fa fa-search fa-1x"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="clearfix"></div>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover tbl-news">
                            <tr class="txt-bold tbl-title ">
                                <th width="2%" class="hidden">#</th>

                                <th width="3%">
                                    <input class="txt" type="checkbox" name="checkedAll" onclick="checkAll(<%=records%>);" />
                                </th>
                                <th width="12%">
                                    <asp:Literal ID="ltrAdminHeaderImg" runat="server" Text="Hình đại diện"></asp:Literal>
                                </th>
                                <th>
                                    <asp:Literal ID="ltrAdminHeaderProductCategory" runat="server" Text="Tên sản phẩm"></asp:Literal>
                                </th>
                                <th>
                                    <asp:Literal ID="Literal1" runat="server" Text="Code"></asp:Literal>
                                </th>
                                <th width="8%">
                                    <asp:Literal ID="Literal2" runat="server" Text="Model"></asp:Literal>
                                </th>
                                <th width="8%">
                                    <asp:Literal ID="Literal3" runat="server" Text="Hãng sản xuất"></asp:Literal>
                                </th>
                                <th width="8%">
                                    <asp:Literal ID="ltrListServices" runat="server" Text="Danh mục sản phẩm"></asp:Literal>
                                </th>

                                <th width="8%" class="hidden">
                                    <asp:Literal ID="ltrAdminHeaderOrder" runat="server" Text="Sắp xếp"></asp:Literal>
                                </th>
                                <th width="13%" class="hidden">
                                    <asp:Literal ID="ltrAdminHeaderDate" runat="server" Text="Ngày cập nhật"></asp:Literal>
                                </th>
                                <th width="8%">
                                    <asp:Literal ID="ltrAdminHeaderPublic" runat="server" Text="Hiển thị"></asp:Literal>
                                </th>
                            </tr>
                            <!-- BEGIN list -->
                            <asp:Repeater ID="rptResult" runat="server" OnItemDataBound="rptResult_ItemDataBound">
                                <ItemTemplate>
                                    <tr id="trList" runat="server">
                                        <td class="hidden">
                                            <input type="button" id="btId" style="display: none" runat="server" />
                                        </td>

                                        <td>
                                            <asp:Literal ID="ltrchk" runat="server"></asp:Literal>
                                        </td>
                                        <td>
                                            <a runat="server" id="hypBaseImage">
                                                <img runat="server" id="baseImage" class="center-block baseImageGrid" />
                                            </a>
                                        </td>
                                        <td>
                                            <asp:HyperLink ID="hdflink" runat="server">
                                                <asp:Literal ID="ltrName" runat="server"></asp:Literal>
                                            </asp:HyperLink>
                                        </td>
                                        <td>
                                            <asp:Literal ID="ltrCode" runat="server"></asp:Literal>
                                        </td>
                                        <td>
                                            <asp:Literal ID="ltrModel" runat="server"></asp:Literal>
                                        </td>
                                        <td>
                                            <asp:Literal ID="ltrBrand" runat="server"></asp:Literal>
                                        </td>
                                        <td>
                                            <asp:Literal ID="ltrNewsCategory" runat="server"></asp:Literal>
                                        </td>

                                        <td class="hidden">
                                            <asp:Literal ID="ltrSort" runat="server"></asp:Literal>
                                        </td>
                                        <td id="trUpdateDate" runat="server" class="hidden">
                                            <%# Eval("UpdateDate","{0:d}")%>
                                        </td>
                                        <td align="center" id="tdbtn" runat="server">
                                            <asp:ImageButton CssClass="toolbar" ID="btnPublish" runat="server" Width="15" Height="15"
                                                ValidationGroup="admincontent" AlternateText="Publish" title="Publish" ImageUrl="~/admdgc/images/write_f2.png" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                    <!-- Begin paging -->
                    <div class="text-right">
                        <cc:Pager ID="pager" runat="server" EnableViewState="true" OnCommand="pager_Command"
                            CompactModePageCount="10" MaxSmartShortCutCount="0" RTL="False" />
                    </div>
                    <!-- End paging -->
                </ContentTemplate>
            </asp:UpdatePanel>


        </div>
    </div>
</section>

<input type="hidden" name="boxchecked" value="0" />
<input type="hidden" name="task" value="" />

<cc1:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender1" TargetControlID="UpdatePanel1"
    runat="server">
    <Animations>
                    <OnUpdating>
                       <Parallel duration="0">
                            <ScriptAction Script="OnUpdating();" />
                            <EnableAction AnimationTarget="drpCategory_onchange" Enabled="false" />       
                                     
                        </Parallel>
                    </OnUpdating>    
                    <OnUpdated>
                        <Parallel duration="0">
                            <ScriptAction Script="OnUpdated();" />
                            <EnableAction AnimationTarget="drpCategory_onchange" Enabled="true" />                    
                        </Parallel>
                    </OnUpdated>     
    </Animations>
</cc1:UpdatePanelAnimationExtender>
