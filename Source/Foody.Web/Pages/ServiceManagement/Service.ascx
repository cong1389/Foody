<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Service.ascx.cs" Inherits="Cb.Web.Pages.ServiceManagement.Service" %>

<!--Service-->
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>
<%@ Register TagPrefix="dgc" TagName="block_choosetemplate" Src="~/Controls/block_choosetemplate.ascx" %>

<!--Category-->
<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<section class="container">
    <div class="row-wrapper-x">
        <section class="wpb_row   w-animate w-start_animation">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space3">
                    </div>
                </div>
            </div>
        </section>
    </div>

    <section class="wpb_row   w-animate w-start_animation">

        <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
            <ItemTemplate>
                <div class="wpb_column vc_column_container vc_col-sm-4">
                    <div class="vc_column-inner ">
                        <div class="wpb_wrapper">
                            <article class="icon-box18">
                                <a runat="server" id="hypTitle">
                                    <asp:Literal runat="server" ID="ltrImge"></asp:Literal></a>
                                <h4>
                                    <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></h4>
                                <p>
                                    <asp:Literal runat="server" ID="ltrBrief"></asp:Literal>
                                </p>
                                <a class="magicmore" runat="server" id="hypContinus">
                                    <asp:Literal runat="server" ID="ltrContinus"></asp:Literal></a>
                            </article>
                            <hr class="vertical-space1">
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>


        <section class="wpb_row   w-animate w-start_animation">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space1">
                    </div>
                </div>
            </div>
        </section>

    </section>

</section>

  <dgc:block_choosetemplate ID="block_choosetemplate" runat="server" />

<!--Padding-->
<cc:Pager ID="pager" runat="server" EnableViewState="true" OnCommand="pager_Command" CompactModePageCount="10" MaxSmartShortCutCount="0" RTL="False" PageSize="9" />
