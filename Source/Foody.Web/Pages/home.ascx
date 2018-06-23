<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="home.ascx.cs" Inherits="Cb.Web.Pages.home" %>

<!--home-->
<%@ Register TagPrefix="dgc" TagName="block_slide" Src="~/Controls/block_slide.ascx" %>

<%@ Register TagPrefix="dgc" TagName="block_featuredvideo" Src="~/Controls/block_featuredvideo.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_categoryhome" Src="~/Controls/block_categoryhome.ascx" %>

<!--Slide-->
<section class="wpb_row  w-animate full-row">
    <div class="wpb_column vc_column_container vc_col-sm-12">
        <div class="vc_column-inner vc_custom_1453020108738">
            <div class="wpb_wrapper">
                <div class="wpb_revslider_element wpb_content_element">

                    <dgc:block_slide ID="block_slide" runat="server" />

                </div>
            </div>
        </div>
    </div>
</section>

<section class="container">
    <div class="row-wrapper-x"></div>
</section>

<!--Dịch vụ-->
<section class="blox  dark      w-animate max-pat2 w-start_animation" style="padding-top: px; padding-bottom: px; background: url('/Images/slider1slide1.jpg') no-repeat; background-position: center center; background-size: cover; min-height: px;">
    <div class="max-overlay" style="background-color: rgba(10,10,10,0.2)"></div>
    <div class="wpb_row vc_row-fluid full-row">
        <div class="container">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner vc_custom_1455367855917">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space2">
                        <div class="max-title max-title5">
                            <h4>
                                <asp:Literal runat="server" ID="ltrServiceHeader"></asp:Literal></h4>
                        </div>
                        <div class="vc_row wpb_row vc_inner vc_row-fluid">
                            <div class="vc_col-sm-12">
                                <asp:Repeater runat="server" ID="rptServiceLeft" OnItemDataBound="rptServiceLeft_ItemDataBound">
                                    <ItemTemplate>

                                        <div class="wpb_column vc_column_container vc_col-sm-6">
                                            <div class="vc_column-inner ">
                                                <div class="wpb_wrapper">

                                                    <hr class="vertical-space1">
                                                    <a runat="server" id="hypTitle">
                                                        <article class="icon-box4">
                                                            <asp:Literal runat="server" ID="ltrImge"></asp:Literal>
                                                            <h4>
                                                                <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></h4>
                                                            <p>
                                                                <asp:Literal runat="server" ID="ltrBrief"></asp:Literal>
                                                            </p>
                                                        </article>
                                                    </a>
                                                    <hr class="vertical-space1">
                                                </div>
                                            </div>
                                        </div>

                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <div class="wpb_column vc_column_container vc_col-sm-3 hidden">
                                <div class="vc_column-inner ">
                                    <div class="wpb_wrapper">
                                        <hr class="vertical-space1">
                                        

                                        <hr class="vertical-space1">
                                    </div>
                                </div>
                            </div>
                            <hr class="vertical-space1">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="container">
    <div class="row-wrapper-x"></div>
</section>

<!--Count-->

<%--<asp:Literal runat="server" ID="ltrCount"></asp:Literal>--%>
<section class="container">
    <div class="row-wrapper-x"></div>
</section>

<!---Most popular daily tours-->
<dgc:block_categoryhome ID="block_mostPopularDailyTour" runat="server" />
<!---/Most popular daily tours-->

<!---block_otherTour-->
<dgc:block_categoryhome ID="block_otherTour" runat="server" />
<!---/block_otherTour-->

<dgc:block_featuredvideo ID="block_featuredvideo" runat="server" />

<!--Comment customer-->
<section class="commentcus blox topborder w-animate  w-start_animation divCommentCustomer">
    <div class="row-wrapper-x">
        <section class="wpb_row w-animate">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space2">
                        <div class="max-title max-title4">
                            <h2>
                                <asp:Literal runat="server" ID="ltrCommentCusHeader"></asp:Literal></h2>
                        </div>
                        <div class="testimonial-carousel">
                            <div class="testimonial-owl-carousel owl-carousel owl-theme" data-testimonial_count="3">

                                <asp:Repeater runat="server" ID="rptCommentCustomer" OnItemDataBound="rptCommentCustomer_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="tc-item">
                                            <a runat="server" id="hypImg" target="_blank">
                                                <img runat="server" id="img">
                                                <div class="tc-content">
                                                    <asp:Literal runat="server" ID="ltrDetail"></asp:Literal>
                                                </div>
                                                <div class="tc-name">
                                                    <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                                                </div>
                                                <div class="tc-job">
                                                    <asp:Literal runat="server" ID="ltrBrief"></asp:Literal>
                                                </div>
                                            </a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>

                            </div>
                            <div class="tc-navigation"><a class="btn prev"><i class="fa-angle-left"></i></a><a class="btn next"><i class="fa-angle-right"></i></a></div>
                        </div>
                        <hr class="vertical-space2">
                    </div>
                </div>
            </div>
        </section>
    </div>
</section>

<!--Đối tác-->
<section class="divPartner blox w-animate  w-start_animation" style="padding-top: px; padding-bottom: px; background-size: cover; min-height: px; background-color: #f9f9f9;">
    <div class="max-overlay" style="background-color: "></div>
    <div class="wpb_row vc_row-fluid full-row">
        <div class="container">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space2">
                        <div class="max-title max-title4">
                            <h2>
                                <asp:Literal runat="server" ID="ltrPartnerHeader"></asp:Literal></h2>
                        </div>

                        <div class="aligncenter">
                            <div class="col-md-12 our-clients-wrap crsl">
                                <ul id="our-clients" class="our-clients crsl owl-carousel owl-theme" style="opacity: 1; display: block;">

                                    <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
                                        <ItemTemplate>
                                            <li>
                                                <a target="_blank" runat="server" id="hypImg">
                                                    <img runat="server" id="img">
                                                </a>

                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                        <hr class="vertical-space2">
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="container">
    <div class="row-wrapper-x"></div>
</section>

<!--Last blog-->
<section class="hidden container w-animate w-start_animation">
    <div class="row-wrapper-x">
        <section class="wpb_row   w-animate w-start_animation">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner vc_custom_1454490389082">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space2">
                        <div class="max-title max-title3">
                            <h2>
                                <asp:Literal runat="server" ID="ltrLastNews"></asp:Literal></h2>
                        </div>
                        <hr class="vertical-space1">
                        <div class="container latestposts-eight">

                            <asp:Repeater runat="server" ID="rptLastBlog" OnItemDataBound="rptLastBlog_ItemDataBound">
                                <ItemTemplate>
                                    <div class="col-sm-4">
                                        <article class="latest-b8">
                                            <figure class="latest-b8-img boxFixImg_Blog_352_277">
                                                <a runat="server" id="hypImg">
                                                    <img runat="server" id="img" class="landscape thumbnail latestfromblog" width="720" height="388"></a>
                                            </figure>
                                            <div class="latest-b8-content">
                                                <span class="post-format-icon "></span>
                                                <h3 class="latest-b8-title"><a runat="server" id="hypTitle">
                                                    <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></a></h3>
                                                <p>
                                                    <asp:Literal runat="server" ID="ltrBrief"></asp:Literal>
                                                </p>
                                                <a class="readmore" runat="server" id="hypContinus">
                                                    <asp:Literal runat="server" ID="ltrContinus"></asp:Literal></a>
                                                <div class="latest-b8-meta">
                                                    <div class="autho">
                                                        <i class="sl-user"></i><span>by: <a href="#">
                                                            <asp:Literal runat="server" ID="ltrUpdateBy"></asp:Literal></a></span>
                                                    </div>
                                                    <div class="date">
                                                        <i class="sl-calendar"></i><span>
                                                            <asp:Literal runat="server" ID="ltrDate"></asp:Literal></span>
                                                    </div>

                                                </div>
                                            </div>
                                        </article>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <hr class="vertical-space2">
                    </div>
                </div>
            </div>
        </section>
    </div>
</section>
<!--/Last blog-->



<section class="wpb_row   w-animate full-row w-start_animation">
    <div class="wpb_column vc_column_container vc_col-sm-12">
        <div class="vc_column-inner ">
            <div class="wpb_wrapper">
                <div class="w-map">

                   <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.572411848409!2d106.69152031521666!3d10.767399992327693!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752f160135e981%3A0x423eb7168c362aff!2zNTggQsO5aSBWaeG7h24sIFBo4bqhbSBOZ8WpIEzDo28sIFF14bqtbiAxLCBI4buTIENow60gTWluaCwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1494946695139" width="100%" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
                    <%--<dgc:block_googlemap ID="block_googlemap" runat="server" />--%>
                </div>
            </div>
        </div>
    </div>
</section>


<script>
    //Search Themes
    function submitButtonSearchThemes(task) {
        var txtSearch = jQuery(".searchTemplate").val();
        var langId = '<%=LangId %>';
        if (txtSearch != "") {
            window.location = langId == "vn" ? GetLink3Param('tim-kiem', langId, RemoveUnicode(txtSearch)) : GetLink3Param('search', langId, RemoveUnicode(txtSearch));
        }
        return false;
    }
</script>
