jQuery(document).ready(function () {


    //Ẩn scroll boy
    jQuery("body").addClass("devivePreview_body");
    jQuery("#wrap").css("position", "static !important");

    jQuery("#mobilePreview").click(function (e) {
        e.preventDefault();

        jQuery("body").css("overflow-x", "none").removeClass("devivePreview_body");
        jQuery("body").addClass("bodyMobile");

        jQuery("#mobilePreview span").addClass("active");
        jQuery("#desktopPreview span").removeClass("active");

        jQuery("#previewFrameContainer").addClass("vc_col-md-6 vc_col-sm-offset-4 demo-mobile").removeClass("devivePreview_container");;
        jQuery(".previewFrame").removeClass("devivePreview_frame");
    });

    jQuery("#desktopPreview").click(function (e) {
        e.preventDefault();

        jQuery("body").addClass("devivePreview_body");

        jQuery("#desktopPreview span").addClass("active");
        jQuery("#mobilePreview span").removeClass("active");

        jQuery(".previewFrame").addClass("devivePreview_frame");
        jQuery("#previewFrameContainer").removeClass("vc_col-md-6 vc_col-sm-offset-4 demo-mobile ").addClass("devivePreview_container");
    });

    //Ẩn footer
    jQuery(".block-full-1500").addClass("hidden");

});

jQuery(function () {

    //
    var iFrames = jQuery('.previewFrame');

    function iResize() {
        var height = iFrames.contentWindow.document.body.offsetHeight + 'px';
        iFrames.attr("height", height);
        //for (var i = 0, j = iFrames.length; i < j; i++) {
        //    iFrames[i].style.height = iFrames[i].contentWindow.document.body.offsetHeight + 'px';
        //}
    }

    if (jQuery.browser.safari || jQuery.browser.opera) {
        iResize()
        //iFrames.load(function () {
        //    setTimeout(iResize, 0);
        //});

        //for (var i = 0, j = iFrames.length; i < j; i++) {
        //    var iSource = iFrames[i].src;
        //    //iFrames[i].src = '';
        //    //iFrames[i].src = iSource;
        //}

    } else {
        iFrames.load(function () {
            var height = this.contentWindow.document.body.offsetHeight + 'px';
            iFrames.attr("height", height);
            //jQuery(".devivePreview").css("height", height);
            jQuery(".devivePreview_container").css("height", height);

        });
    }

});