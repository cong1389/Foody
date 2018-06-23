<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_like.ascx.cs" Inherits="Cb.Web.Controls.block_like" %>

<!--block_like-->

<ul class="social_icon heading_top text-left ">
    <li>
        <asp:Literal runat="server" ID="ltrFBLike"></asp:Literal>
    </li>
    <li>
        <asp:Literal runat="server" ID="ltrTwiter"></asp:Literal>
        <%--<a href="javascript:void(0)" class="twitter" onclick="st_buildingx_PopupCenterDual('http://twitter.com/share?url=http://shinetheme.com/demosd/buildingx/project/featured-works/&amp;title=Featured Works','twitter',600,600);"><i class="fa fa-twitter"></i><span></span></a>--%>

    </li>
    <li class="hidden">
        <asp:Literal runat="server" ID="ltrPinterest"></asp:Literal>
        <%--<a class="instagram" href="javascript:void((function()%7Bvar%20e=document.createElement('script');e.setAttribute('type','text/javascript');
            e.setAttribute('charset','UTF-8');e.setAttribute('src','http://assets.pinterest.com/js/pinmarklet.js?r='+Math.random()*99999999);document.body.appendChild(e)%7D)());" target="popup"><i class="fa fa-pinterest"></i><span></span></a>--%>

    </li>
    <li>
        <asp:Literal runat="server" ID="ltrGooglePlus"></asp:Literal>
    </li>

    <li>
        <a href="https://www.tripadvisor.co.uk/Attraction_Review-g293925-d8094955-Reviews-Vietnam_Food_Tours_Day_Tours-Ho_Chi_Minh_City.html">
            <img src="/images/tripadvisor.png"></a>
    </li>

</ul>



<!--/block_like-->
