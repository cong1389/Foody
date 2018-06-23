<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_seo.ascx.cs" Inherits="Cb.Web.Admin.Pages.Config.admin_seo" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!--admin_seo-->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <!--Tab-->
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tabRobots" data-toggle="tab" runat="server">
                            <asp:Literal ID="ltrCo" runat="server" Text="Robots"></asp:Literal></a></li>

                    </ul>
                    <div class="tab-content">
                        <!-- /.tab-pane -->
                        <div class="tab-pane active ulBtn" id="tabRobots">
                            <div class="box box-solid">
                                <div class="panel-heading">
                                    <div class="form-group col-sm-3 ">
                                        <asp:CheckBoxList ID="chkChoice" runat="server" RepeatDirection="Horizontal" ValidationGroup="checkselected"
                                            meta:resourcekey="chkChoiceResource1">
                                            <asp:ListItem>Google</asp:ListItem>
                                            <asp:ListItem>Yahoo</asp:ListItem>
                                            <asp:ListItem>Bing</asp:ListItem>
                                            <asp:ListItem>Msn</asp:ListItem>
                                        </asp:CheckBoxList>
                                    </div>
                                    <div class="form-group col-sm-3 ">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <button id="btnGenerateRobots" runat="server" text="Lưu" cssclass="btn btn-info"
                                                    onserverclick="btnGenerateRobots_Click" title="Lưu">
                                                    <i class="fa fa-floppy-o fa-2x iPadding5"></i>Generate Robots
                                                </button>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <asp:CheckBoxList runat="server" ID="chkPage">
                                    </asp:CheckBoxList>
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
</section>
<input type="hidden" name="task" value="" />
