<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_programtour.ascx.cs" Inherits="Cb.Web.Controls.block_programtour" %>

<!--block_programtour--->
<div class="timeline">

    <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
        <ItemTemplate>
            <!-- TIMELINE ITEM -->
            <div class="timeline-item">
                <div class="timeline-badge">
                    <div class="timeline-icon">
                        <asp:Literal runat="server" ID="ltrIcon"></asp:Literal>                    
                    </div>
                </div>
                <div class="timeline-body">
                    <div class="timeline-body-arrow"></div>
                    <div class="timeline-body-head">
                        <div class="timeline-body-head-caption">
                            <span class="timeline-body-alerttitle font-red-intense">
                                <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></span>

                        </div>

                    </div>
                    <div class="timeline-body-content">
                        <span class="font-grey-cascade">
                            <asp:Literal runat="server" ID="ltrDetail"></asp:Literal>
                        </span>
                    </div>
                </div>
            </div>
            <!-- END TIMELINE ITEM -->
        </ItemTemplate>
    </asp:Repeater>

</div>

<!--/block_programtour--->
