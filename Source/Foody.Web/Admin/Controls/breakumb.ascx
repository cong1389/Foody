<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="breakumb.ascx.cs" Inherits="Cb.Web.Admin.Controls.breakumb" %>
<!--breakumb<>-->

<section class="content-header">
    <div class="title-content clear-l ">
        <h3 class="tilte txt-up txt-bold col-sm-3">
          <i class="fa fa-home"></i>  <asp:Literal runat="server" ID="ltrHeader" Text="Trang chủ"></asp:Literal>
        </h3>
        <div class="name-select text-right">
            <h2 class="config-name txt-up txt-bold">
                <ol class="breadcrumb">
                    <li><a runat="server" id="hypHome"><i class="fa fa-dashboard"></i>Trang chủ</a></li>
                    <li><a runat="server" id="hypCategory">
                        <i class="fa fa-angle-double-right"></i>
                        <asp:Literal runat="server" ID="ltrCategory"></asp:Literal>
                    </a></li>
                    <li><i class="fa fa-angle-double-right"></i>
                        <asp:Literal runat="server" ID="ltrProduct"></asp:Literal></li>
                </ol>
            </h2>

        </div>
    </div>
</section>
