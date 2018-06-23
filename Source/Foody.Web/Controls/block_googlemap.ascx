<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_googlemap.ascx.cs"
    Inherits="Cb.Web.Controls.block_googlemap" %>

<!--block_googlemap-->
<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>

<script src="http://maps.google.com/maps/api/js?key=AIzaSyAUGMGs71xVeboJ_eYyxFEiulA1vBLfVcY&amp;sensor=false"
    type="text/javascript"></script>

<div class="img-responsive" id="maps">
    <div id="map-canvas">

        <cc1:GMap ID="GMap1" runat="server" Width="100%" Height="300px" enableHookMouseWheelToZoom="True"
            enableGoogleBar="True" />
    </div>
</div>
