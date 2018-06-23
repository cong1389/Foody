(function( $ ) {

	// global caches
	var div_wrap = $('#wrap');

	// Header Section
	$('#headers').on('change', function () {   
	    var url = $(this).val(); // get selected value
			if (url) { // require a URL
				window.location = url; // redirect
		  	}
		return false;
	});

  	if ( window.location.href.substr(window.location.href.lastIndexOf('http://localhost:52882/') + 1) == '?menu_type=10' ) {
  		$('body').addClass('transparent-header-w');
  	}

	// Colorskin Section
	  $('.colorskin').each(function() {
	    // some cache
	    var $this = $(this);
	    var style_color = $this.data('colorskin');
	    $this.on('click', function(event) {
	      event.preventDefault();
	      if ( typeof pass_flag_c !== 'undefined' ) {
	        div_wrap.removeClass( 'colorskin-' + pass_flag_c );
	      }
	      div_wrap.addClass( 'colorskin-' + style_color );
	      window.pass_flag_c = style_color;

	      if ( typeof colorskin_8 == 'undefined' ) {
	        div_wrap.removeClass( 'colorskin-8' );
	      }
	      window.colorskin_8 = true;
	    });
	  });

	// Layout Section
	(function(){
		$('.btn-layout').each(function() {
			// some cache
			var $this = $(this);
			var layout_data = $this.data('layout');
			$this.on('click', function(event) {
				event.preventDefault();
				if ( layout_data == 'wide' ) {
					div_wrap.removeClass( 'boxed-wrap' );
				} else if ( layout_data == 'boxed' ) {
					div_wrap.addClass( 'boxed-wrap' );
				}
			});
		});
	})();

jQuery('.pattern-selector').click(function(){
	
	
	jQuery('body').css('background', 'url('+jQuery(this).attr('title') +') repeat');
	
});


jQuery('.bg-changer').click(function(){
	
	div_wrap.addClass( 'boxed-wrap' );
	
	jQuery('body').css('background', 'url('+jQuery(this).attr('title') +') no-repeat');
	jQuery('body').css('background-size', 'cover');
	jQuery('body').css('background-attachment', 'fixed');
	
	
	jQuery('body').css('-webkit-background-size', 'cover');
	jQuery('body').css('-moz-background-size', 'cover');
	jQuery('body').css('-o-background-size', 'cover');
	jQuery('body').css('background-position', 'center');
	
	
	
});



jQuery('#style-selector').css('right', '-240px');
jQuery('#ss-on').css('right', '0');

jQuery('#ss-on').toggle(function() {
	jQuery('#style-selector').css('right', '0');
	jQuery('#ss-on').css('right', '240px');
}, function() {
	jQuery('#style-selector').css('right', '-240px');
jQuery('#ss-on').css('right', '0');
});

})( jQuery );