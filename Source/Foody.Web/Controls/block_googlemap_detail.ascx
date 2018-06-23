<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_googlemap_detail.ascx.cs"
    Inherits="Cb.Web.Controls.block_googlemap_detail" %>

<!--block_googlemap_detail-->
<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>

<script src="http://maps.google.com/maps/api/js?key=AIzaSyAUGMGs71xVeboJ_eYyxFEiulA1vBLfVcY&amp;sensor=false" type="text/javascript"></script>

<%--<script src="/Scripts/googleMapsAPI.js" type="text/javascript"></script>--%>


<div class="">
    <div id="">
        <cc1:GMap ID="GMap1" runat="server" Width="100%" Height="700px" class="gMap" enableHookMouseWheelToZoom="True" enableGoogleBar="True" />
    </div>
</div>


<script>

  
</script>
