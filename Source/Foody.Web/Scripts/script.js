//Replace ký tự đặc biệt
function RemoveUnicode(text) {
    var result;

    //Đổi chữ hoa thành chữ thường
    result = text.toLowerCase();

    // xóa dấu
    result = result.replace(/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/g, 'a');
    result = result.replace(/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/g, 'e');
    result = result.replace(/(ì|í|ị|ỉ|ĩ)/g, 'i');
    result = result.replace(/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/g, 'o');
    result = result.replace(/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/g, 'u');
    result = result.replace(/(ỳ|ý|ỵ|ỷ|ỹ)/g, 'y');
    result = result.replace(/(đ)/g, 'd');
    // Xóa ký tự đặc biệt
    result = result.replace(/([^0-9a-z-\s])/g, '');
    // Xóa khoảng trắng thay bằng ký tự -
    result = result.replace(/(\s+)/g, '-');
    // xóa phần dự - ở đầu
    result = result.replace(/^-+/g, '');
    // xóa phần dư - ở cuối
    result = result.replace(/-+$/g, '');

    return result;
}

jQuery(document).ready(function ($) {

    VisablePageInfo();

    //Fix top
    var header = jQuery("#header.horizontal-w");
    var navHomeY = header.offset().top;
    var isFixed = false;
    var scrolls_pure = parseInt("380");
    var $w = jQuery(window);
    $w.scroll(function (e) {
        var scrollTop = $w.scrollTop();
        var shouldBeFixed = scrollTop > scrolls_pure;
        if (shouldBeFixed && !isFixed) {
            header.addClass("sticky");
            isFixed = true;
        } else if (!shouldBeFixed && isFixed) {
            header.removeClass("sticky");
            isFixed = false;
        }
        e.preventDefault();
    });

    //Ẩn chát
    jQuery("#tidio-chat-button").addClass("hidden");

    var posTabProduct = $(".partners");
    posTabProduct.owlCarousel({
        items: 6,
        itemsDesktop: [1199, 6],
        itemsDesktopSmall: [991, 6],
        itemsTablet: [767, 3],
        itemsMobile: [480, 1],
        autoPlay: true,
        stopOnHover: false,
        addClassActive: true,

    });

    //Ẩn paging k cần thiết
    //jQuery(".info").addClass("hidden");
    //jQuery(".nextprev").addClass("hidden");
});

function GetLink3Param(pageName, langId, catId) {
    re = "/" + pageName + "/" + langId + "/" + catId;
    return re;
}

function checkEnter(e) { //e is event object passed from function invocation
    var characterCode //literal character code will be stored in this variable

    if (e && e.which) { //if which property of event object is supported (NN4)
        e = e;
        characterCode = e.which;  //character code is contained in NN4's which property
    }
    else {
        e = event;
        characterCode = e.keyCode;  //character code is contained in IE's keyCode property
    }
    if (characterCode == 13) { //if generated character code is equal to ascii 13 (if enter key)
        submitButtonSearchThemes('search'); //submit the form
        return false;
    }
    else {
        return true;
    }
}

var essapi_5;
jQuery(document).ready(function () {
    essapi_5 = jQuery("#esg-grid-5-1").tpessential({
        gridID: 5,
        layout: "masonry",
        forceFullWidth: "off",
        lazyLoad: "on",
        lazyLoadColor: "#FFFFFF",
        gridID: "5",
        loadMoreType: "scroll",
        loadMoreAmount: 3,
        loadMoreTxt: "Load More",
        loadMoreNr: "on",
        loadMoreEndTxt: "No More Items for the Selected Filter",
        loadMoreItems: [
            [5876, [-1, 29, 28]],
            [5877, [-1, 29, 30]],
            [5878, [-1, 30, 28]],
            [5879, [-1, 29, 30]],
            [5880, [-1, 29, 28]],
            [5881, [-1, 26, 28]],
            [5882, [-1, 29]],
            [5883, [-1, 26]],
            [5886, [-1, 28]]
        ],
        row: 9999,
        loadMoreAjaxToken: "e8873699c5",
        //loadMoreAjaxUrl: "http://webnus.biz/themes/easyweb/host/wp-admin/admin-ajax.php",
        loadMoreAjaxAction: "Essential_Grid_Front_request_ajax",
        ajaxContentTarget: "ess-grid-ajax-container-",
        ajaxScrollToOffset: "0",
        ajaxCloseButton: "off",
        ajaxContentSliding: "on",
        ajaxScrollToOnLoad: "on",
        ajaxNavButton: "off",
        ajaxCloseType: "type1",
        ajaxCloseInner: "false",
        ajaxCloseStyle: "light",
        ajaxClosePosition: "tr",
        row: 3,
        column: 55,
        space: 20,
        pageAnimation: "horizontal-slide",
        paginationScrollToTop: "off",
        spinner: "spinner0",
        forceFullWidth: "off",
        lightBoxMode: "single",
        animSpeed: 1000,
        delayBasic: 1,
        mainhoverdelay: 1,
        filterType: "single",
        showDropFilter: "hover",
        filterGroupClass: "esg-fgc-5",
        googleFonts: ['Open+Sans:300,400,600,700,800', 'Raleway:100,200,300,400,500,600,700,800,900', 'Droid+Serif:400,700'],
        responsiveEntries: [{
            width: 1400,
            amount: 3
        }, {
            width: 1170,
            amount: 3
        }, {
            width: 1024,
            amount: 2
        }, {
            width: 960,
            amount: 2
        }, {
            width: 778,
            amount: 1
        }, {
            width: 640,
            amount: 1
        }, {
            width: 480,
            amount: 1
        }],
        rowItemMultiplier: [
            [3, 3, 2, 2, 1, 1, 1],
            [5, 4, 2, 2, 1, 1, 1],
            [2, 2, 2, 2, 1, 1, 1],
            [4, 4, 2, 2, 1, 1, 1]
        ]
    });
    try {
        jQuery("#esg-grid-5-1 .esgbox").esgbox({
            padding: [0, 0, 0, 0],
            afterLoad: function () {
                if (this.element.hasClass("esgboxhtml5")) {
                    var mp = this.element.data("mp4"),
                        ogv = this.element.data("ogv"),
                        webm = this.element.data("webm");
                    this.content = '<div style="width:100%;height:100%;"><video autoplay="true" loop="" class="rowbgimage" poster="" width="100%" height="auto"><source src="' + mp + '" type="video/mp4"><source src="' + webm + '" type="video/webm"><source src="' + ogv + '" type="video/ogg"></video></div>';
                    var riint = setInterval(function () {
                        jQuery(window).trigger("resize");
                    }, 100);
                    setTimeout(function () {
                        clearInterval(riint);
                    }, 2500);
                };
            },
            beforeShow: function () {
                this.title = jQuery(this.element).attr('lgtitle');
                if (this.title) {
                    this.title = "";
                    this.title = '<div style="padding:0px 0px 0px 0px">' + this.title + '</div>';
                }
            },
            afterShow: function () { },
            openEffect: 'fade',
            closeEffect: 'fade',
            nextEffect: 'fade',
            prevEffect: 'fade',
            openSpeed: 'normal',
            closeSpeed: 'normal',
            nextSpeed: 'normal',
            prevSpeed: 'normal',
            helpers: {
                media: {},
                thumbs: {
                    width: 50,
                    height: 50
                },
                title: {
                    type: ""
                }
            }
        });
    } catch (e) { }



});

function VisablePageInfo() {
    jQuery(".info").addClass("hidden");

    jQuery(".nextprev").addClass("hidden");
}