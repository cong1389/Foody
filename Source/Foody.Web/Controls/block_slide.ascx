<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_slide.ascx.cs" Inherits="Cb.Web.Controls.block_slide" %>

<!---block_slide-->
<link rel='stylesheet' href='/Admin/Components/revslider/settings.css' type='text/css' media='all' />
<script type='text/javascript' src='/Admin/Components/revslider/jquery.themepunch.tools.min.js'></script>
<script type='text/javascript' src='/Admin/Components/revslider/jquery.themepunch.revolution.min.js'></script>
<link rel='stylesheet' href='/Admin/Components/revslider/fonts/pe-icon-7-stroke/css/pe-icon-7-stroke.css' type='text/css' media='all' />
<script type="text/javascript">
    function revslider_showDoubleJqueryError(sliderID) {
        var errorMessage = "Revolution Slider Error: You have some jquery.js library include that comes after the revolution files js include.";
        errorMessage += "<br> This includes make eliminates the revolution slider libraries, and make it not work.";
        errorMessage += "<br><br> To fix it you can:<br>&nbsp;&nbsp;&nbsp; 1. In the Slider Settings -> Troubleshooting set option:  <strong><b>Put JS Includes To Body</b></strong> option to true.";
        errorMessage += "<br>&nbsp;&nbsp;&nbsp; 2. Find the double jquery.js include and remove it.";
        errorMessage = "<span style='font-size:16px;color:#BC0C06;'>" + errorMessage + "</span>";
        jQuery(sliderID).show().html(errorMessage);
    }
</script>

<div id="rev_slider_1_1_wrapper" class="rev_slider_wrapper fullwidthbanner-container" style="margin: 0px auto; background-color: transparent; padding: 0px; margin-top: 0px; margin-bottom: 0px;">
    <!-- START REVOLUTION SLIDER 5.2.6 fullwidth mode -->
    <div id="rev_slider_1_1" class="rev_slider fullwidthabanner" style="display: none;" data-version="5.2.6">
        <ul>
            <!-- SLIDE  -->
            <asp:Repeater runat="server" ID="rptResult" OnItemDataBound="rptResult_ItemDataBound">
                <ItemTemplate>

                    <asp:Literal runat="server" ID="ltrLayer1"></asp:Literal>

                    <asp:Literal runat="server" ID="ltrLayer2"></asp:Literal>

                    <asp:Literal runat="server" ID="ltrLayer3"></asp:Literal>
                    <asp:Literal runat="server" ID="ltrLayer4"></asp:Literal>

                </ItemTemplate>
            </asp:Repeater>
            <!-- SLIDE  -->

        </ul>

        <script>
            var htmlDiv = document.getElementById("rs-plugin-settings-inline-css"); var htmlDivCss = "";
            if (htmlDiv) {
                htmlDiv.innerHTML = htmlDiv.innerHTML + htmlDivCss;
            } else {
                var htmlDiv = document.createElement("div");
                htmlDiv.innerHTML = "<style>" + htmlDivCss + "</style>";
                document.getElementsByTagName("head")[0].appendChild(htmlDiv.childNodes[0]);
            }
        </script>
        <div class="tp-bannertimer tp-bottom" style="visibility: hidden !important;"></div>
    </div>

    <script>
        var htmlDiv = document.getElementById("rs-plugin-settings-inline-css"); var htmlDivCss = ".tp-caption.Gym-SmallText,.Gym-SmallText{color:rgba(255,255,255,1.00);font-size:17px;line-height:22px;font-weight:300;font-style:normal;font-family:Raleway;padding:0px 0px 0px 0px;text-decoration:none;background-color:transparent;border-color:transparent;border-style:none;border-width:0px;border-radius:0px 0px 0px 0px;text-shadow:none}.tp-caption.NotGeneric-Title,.NotGeneric-Title{color:rgba(255,255,255,1.00);font-size:70px;line-height:70px;font-weight:800;font-style:normal;font-family:Raleway;padding:10px 0px 10px 0;text-decoration:none;background-color:transparent;border-color:transparent;border-style:none;border-width:0px;border-radius:0 0 0 0px}.tp-caption.NotGeneric-SubTitle,.NotGeneric-SubTitle{color:rgba(255,255,255,1.00);font-size:13px;line-height:20px;font-weight:500;font-style:normal;font-family:Raleway;padding:0 0 0 0px;text-decoration:none;background-color:transparent;border-color:transparent;border-style:none;border-width:0px;border-radius:0 0 0 0px;text-align:left;letter-spacing:1px;text-align:left}.tp-caption.NotGeneric-CallToAction,.NotGeneric-CallToAction{color:rgba(255,255,255,1.00);font-size:14px;line-height:14px;font-weight:500;font-style:normal;font-family:Raleway;padding:10px 30px 10px 30px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgba(255,255,255,0.50);border-style:solid;border-width:1px;border-radius:0px 0px 0px 0px;text-align:left;letter-spacing:3px;text-align:left}.tp-caption.NotGeneric-CallToAction:hover,.NotGeneric-CallToAction:hover{color:rgba(255,255,255,1.00);text-decoration:none;background-color:transparent;border-color:rgba(255,255,255,1.00);border-style:solid;border-width:1px;border-radius:0px 0px 0px 0px;cursor:pointer}.tp-caption.NotGeneric-Icon,.NotGeneric-Icon{color:rgba(255,255,255,1.00);font-size:30px;line-height:30px;font-weight:400;font-style:normal;font-family:Raleway;padding:0px 0px 0px 0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgba(255,255,255,0);border-style:solid;border-width:0px;border-radius:0px 0px 0px 0px;text-align:left;letter-spacing:3px;text-align:left}";
        if (htmlDiv) {
            htmlDiv.innerHTML = htmlDiv.innerHTML + htmlDivCss;
        } else {
            var htmlDiv = document.createElement("div");
            htmlDiv.innerHTML = "<style>" + htmlDivCss + "</style>";
            document.getElementsByTagName("head")[0].appendChild(htmlDiv.childNodes[0]);
        }
    </script>
    <script type="text/javascript">
        /******************************************
-	PREPARE PLACEHOLDER FOR SLIDER	-
******************************************/

        var setREVStartSize = function () {
            try {
                var e = new Object, i = jQuery(window).width(), t = 9999, r = 0, n = 0, l = 0, f = 0, s = 0, h = 0;
                e.c = jQuery('#rev_slider_1_1');
                e.responsiveLevels = [1240, 1024, 778, 480];
                e.gridwidth = [1240, 1024, 778, 480];
                e.gridheight = [500, 400, 500, 400];

                e.sliderLayout = "fullwidth";
                if (e.responsiveLevels && (jQuery.each(e.responsiveLevels, function (e, f) { f > i && (t = r = f, l = e), i > f && f > r && (r = f, n = e) }), t > r && (l = n)), f = e.gridheight[l] || e.gridheight[0] || e.gridheight, s = e.gridwidth[l] || e.gridwidth[0] || e.gridwidth, h = i / s, h = h > 1 ? 1 : h, f = Math.round(h * f), "fullscreen" == e.sliderLayout) { var u = (e.c.width(), jQuery(window).height()); if (void 0 != e.fullScreenOffsetContainer) { var c = e.fullScreenOffsetContainer.split(","); if (c) jQuery.each(c, function (e, i) { u = jQuery(i).length > 0 ? u - jQuery(i).outerHeight(!0) : u }), e.fullScreenOffset.split("%").length > 1 && void 0 != e.fullScreenOffset && e.fullScreenOffset.length > 0 ? u -= jQuery(window).height() * parseInt(e.fullScreenOffset, 0) / 100 : void 0 != e.fullScreenOffset && e.fullScreenOffset.length > 0 && (u -= parseInt(e.fullScreenOffset, 0)) } f = u } else void 0 != e.minHeight && f < e.minHeight && (f = e.minHeight); e.c.closest(".rev_slider_wrapper").css({ height: f })

            } catch (d) { console.log("Failure at Presize of Slider:" + d) }
        };

        setREVStartSize();

        var tpj = jQuery;

        var revapi12;
        tpj(document).ready(function () {
            if (tpj("#rev_slider_1_1").revolution == undefined) {
                revslider_showDoubleJqueryError("#rev_slider_1_1");
            } else {
                revapi12 = tpj("#rev_slider_1_1").show().revolution({
                    sliderType: "standard",
                    jsFileLocation: "/assets/wp-content/plugins/revslider/public/assets/js/",
                    sliderLayout: "fullwidth",
                    dottedOverlay: "none",
                    delay: 9000,
                    navigation: {
                        keyboardNavigation: "off",
                        keyboard_direction: "horizontal",
                        mouseScrollNavigation: "off",
                        mouseScrollReverse: "default",
                        onHoverStop: "off",
                        touch: {
                            touchenabled: "on",
                            swipe_threshold: 75,
                            swipe_min_touches: 50,
                            swipe_direction: "vertical",
                            drag_block_vertical: false
                        }
                        ,
                        arrows: {
                            style: "",
                            enable: true,
                            hide_onmobile: false,
                            hide_onleave: false,
                            tmp: '',
                            left: {
                                h_align: "left",
                                v_align: "center",
                                h_offset: 0,
                                v_offset: 0
                            },
                            right: {
                                h_align: "right",
                                v_align: "center",
                                h_offset: 0,
                                v_offset: 0
                            }
                        }
                    },
                    responsiveLevels: [1240, 1024, 778, 480],
                    visibilityLevels: [1240, 1024, 778, 480],
                    gridwidth: [1240, 1024, 778, 480],
                    gridheight: [500, 400, 500, 400],
                    lazyType: "none",
                    parallax: {
                        type: "mouse",
                        origo: "slidercenter",
                        speed: 2000,
                        levels: [2, 3, 4, 5, 6, 7, 12, 16, 10, 50, 47, 48, 49, 50, 51, 55],
                        type: "mouse",
                    },
                    shadow: 0,
                    spinner: "spinner2",
                    stopLoop: "off",
                    stopAfterLoops: -1,
                    stopAtSlide: -1,
                    shuffle: "off",
                    autoHeight: "off",
                    disableProgressBar: "on",
                    hideThumbsOnMobile: "off",
                    hideSliderAtLimit: 0,
                    hideCaptionAtLimit: 0,
                    hideAllCaptionAtLilmit: 0,
                    startWithSlide: 0,
                    debugMode: false,
                    fallbacks: {
                        simplifyAll: "off",
                        nextSlideOnWindowFocus: "off",
                        disableFocusListener: false,
                    }
                });
            }
        });	/*ready*/
    </script>
    <script>
        var htmlDivCss = ' #rev_slider_1_1_wrapper .tp-loader.spinner2{ background-color: #FFFFFF !important; } ';
        var htmlDiv = document.getElementById('rs-plugin-settings-inline-css');
        if (htmlDiv) {
            htmlDiv.innerHTML = htmlDiv.innerHTML + htmlDivCss;
        }
        else {
            var htmlDiv = document.createElement('div');
            htmlDiv.innerHTML = '<style>' + htmlDivCss + '</style>';
            document.getElementsByTagName('head')[0].appendChild(htmlDiv.childNodes[0]);
        }
    </script>
    <%-- <script>
        var htmlDivCss = unescape(".custom.tparrows%20%7B%0A%09cursor%3Apointer%3B%0A%09background%3A%23000%3B%0A%09background%3Argba%280%2C0%2C0%2C0.5%29%3B%0A%09width%3A40px%3B%0A%09height%3A40px%3B%0A%09position%3Aabsolute%3B%0A%09display%3Ablock%3B%0A%09z-index%3A100%3B%0A%7D%0A.custom.tparrows%3Ahover%20%7B%0A%09background%3A%23000%3B%0A%7D%0A.custom.tparrows%3Abefore%20%7B%0A%09font-family%3A%20%22revicons%22%3B%0A%09font-size%3A15px%3B%0A%09color%3A%23fff%3B%0A%09display%3Ablock%3B%0A%09line-height%3A%2040px%3B%0A%09text-align%3A%20center%3B%0A%7D%0A.custom.tparrows.tp-leftarrow%3Abefore%20%7B%0A%09content%3A%20%22%5Ce824%22%3B%0A%7D%0A.custom.tparrows.tp-rightarrow%3Abefore%20%7B%0A%09content%3A%20%22%5Ce825%22%3B%0A%7D%0A%0A%0A");
        var htmlDiv = document.getElementById('rs-plugin-settings-inline-css');
        if (htmlDiv) {
            htmlDiv.innerHTML = htmlDiv.innerHTML + htmlDivCss;
        }
        else {
            var htmlDiv = document.createElement('div');
            htmlDiv.innerHTML = '<style>' + htmlDivCss + '</style>';
            document.getElementsByTagName('head')[0].appendChild(htmlDiv.childNodes[0]);
        }
    </script>--%>
</div>

<!---/block_slide-->
