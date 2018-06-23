<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_categorypagetemplate.ascx.cs" Inherits="Cb.Web.Controls.block_categorypagetemplate" %>

<!--block_categorypagetemplate-->
<!-- CSS -->
<link href='/Plugin/categorypagetemplate/asset/bootstrap/3.3.6/css/bootstrap.min.css' rel='stylesheet' type='text/css' media='all' />
<link href='/Plugin/categorypagetemplate/asset/css/master.css' rel='stylesheet' type='text/css' media='all' />
<link href='/Plugin/categorypagetemplate/asset/css/css3-animate.css' rel='stylesheet' type='text/css' media='all' />
<!-- CSS END -->

<div class="container theme-detail">
    <div class="row-lg">
        <div class='col-sm-4'>
            <hr class="vertical-space5">
            <div class="product-detail-left">
                <h2 class="theme-heading">
                    <asp:Literal runat="server" ID="ltrTitle"></asp:Literal>
                </h2>

                <p class="price-detail hidden">
                    1,300,000₫	
                </p>

                <div class="demo">
                    <a class="hidden btn btn-success btn-lg btn-demo" name="add" runat="server" id="hypViewTemplate" target="_blank">
                        <asp:Literal runat="server" ID="ltrWebsite"></asp:Literal></a>
                </div>

                <div class="demo">
                    <a class="btn-lg button skyblue large  bordered-bot  btndemo" name="add" runat="server" id="hypRequest" target="_blank">
                        <asp:Literal runat="server" ID="ltrRegistration"></asp:Literal></a>
                </div>

                <div class="info-support">
                    <p style="font-weight: 300; line-height: 1.6;">
                        <asp:Literal runat="server" ID="ltrQuestion"></asp:Literal><br>
                        <span class="num-phone">
                            <asp:Literal runat="server" ID="ltrPhoneValue"></asp:Literal></span>
                    </p>

                </div>
            </div>

        </div>
        <div class='col-sm-8 theme-img'>
            <div class="col-sm-12" style="position: relative">
                <div class="theme-desktop">
                    <img runat="server" id="imgPC" />
                </div>

                <div class='thememobile-position'>
                    <div class="thememobile">
                        <div class="screen-mobile">
                            <img runat="server" id="imgMobile" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container product_related">
            <div class="row">
                <div class="col-xs-12">
                    <h3 class="collection-title">
                        <asp:Literal runat="server" ID="ltrThemeOther"></asp:Literal></h3>
                </div>
            </div>
        </div>

    </div>
</div>

<style>
    @media (min-width: 768px) {
        .cd-background-wrapper {
            height: 0 !impotant;
        }
    }

    img-link {
        max-width: 150px;
    }
</style>

<style>
    .cd-floating-background {
        padding: 20px 0px 13px;
    }

    .btndemo {
        padding: 12px 130px !important;
        width: 100%;
        text-align: center;
    }
</style>

<script>

    var $isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
    $(window).scroll(function () {
        if ($(this).scrollTop() > 1 && $isMobile == false) {
            $('.scrollToTop').fadeIn();
            $('.navbar').addClass("fixed");
        } else if ($isMobile == false) {
            $('.scrollToTop').fadeOut();
            $('.navbar').removeClass("fixed");
        }

        if ($(this).scrollTop() > 900) {
            $(".banner .container").hide();
        }
        else {
            $(".banner .container").show();
        }
    });


</script>


