<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Faq.ascx.cs" Inherits="Cb.Web.Pages.FAQManagement.Faq" %>

<!--Service-->
<%@ Register Namespace="Cb.WebControls" Assembly="Cb.WebControls" TagPrefix="cc" %>

<!--Category-->
<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<section class="container">   

    <section class="wpb_row  ">
        <div class="wpb_column vc_column_container vc_col-sm-12">
            <div class="vc_column-inner ">
                <div class="wpb_wrapper">
                    <hr class="vertical-space2">
                    <div class="subtitle-element subtitle-element3">
                        <h4>FAQ</h4>
                    </div>
                    <hr class="vertical-space1">
                    <div class="vc_tta-container" data-vc-action="collapse">
                        <div class="vc_general vc_tta vc_tta-accordion vc_tta-color-white vc_tta-style-classic vc_tta-shape-square vc_tta-spacing-30 vc_tta-gap-5 vc_tta-controls-align-left vc_tta-o-no-fill">
                            <div class="vc_tta-panels-container">
                                <div class="vc_tta-panels">

                                    <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="vc_tta-panel"  id="<%# Eval("Id") %>"" data-vc-content=".vc_tta-panel-body">
                                                <div class="vc_tta-panel-heading">
                                                    <h4 class="vc_tta-panel-title vc_tta-controls-icon-position-right">
                                                        <a  href="#<%# Eval("Id") %>"" data-vc-accordion=""
                                                            data-vc-container=".vc_tta-container">
                                                            <i class="vc_tta-icon fa fa-briefcase"></i>
                                                            <span class="vc_tta-title-text">
                                                                <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                                                            </span>
                                                            <i class="vc_tta-controls-icon vc_tta-controls-icon-plus"></i></a></h4>
                                                </div>
                                                <div class="vc_tta-panel-body" style="">
                                                    <article class="icon-box">
                                                        <i class="fa-briefcase" style="color: #81d742;"></i>
                                                        <h4></h4>
                                                        <p>
                                                             <asp:Literal runat="server" ID="ltrDetail"></asp:Literal></p>
                                                    </article>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>

</section>


<!--Padding-->
<cc:Pager ID="pager" runat="server" EnableViewState="true" OnCommand="pager_Command" CompactModePageCount="10" MaxSmartShortCutCount="0" RTL="False" PageSize="9" />
