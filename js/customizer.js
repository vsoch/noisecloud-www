/**
 * Theme Customizer enhancements for a better user experience.
 *
 * Contains handlers to make Theme Customizer preview reload changes asynchronously.
 */

( function( $ ) {
	// Site title and description.
	wp.customize( 'blogname', function( value ) {
		value.bind( function( to ) {
			$( '.site-title a' ).text( to );
		} );
	} );
	wp.customize( 'blogdescription', function( value ) {
		value.bind( function( to ) {
			$( '.site-description' ).text( to );
		} );
	} );
	// Header text color.
	wp.customize( 'header_textcolor', function( value ) {
		value.bind( function( to ) {
			if ( 'blank' === to ) {
				$( '.site-title, .site-description' ).css( {
					'clip': 'rect(1px, 1px, 1px, 1px)',
					'position': 'absolute'
				} );
			} else {
				$( '.site-title, .site-description' ).css( {
					'clip': 'auto',
					'color': to,
					'position': 'relative'
				} );
			}
		} );
	} );
	
	// Display/hide post titles
	wp.customize( 'spun_titles', function( value ) {
		value.bind( function( to ) {
			if ( false === to ) {
				$( '.hentry .thumbnail-title' ).css( {
					'display': 'none',
				} );
				$( '.hentry.no-thumbnail .thumbnail-title' ).css( {
					'display': 'block',
				} );
			} else {
				$( '.hentry .thumbnail-title' ).css( {
					'display': 'block',
				} );
			}
		} );
	} );
	
	// Color circles
	wp.customize( 'spun_grayscale', function( value ) {
		value.bind( function( to ) {
			if ( false === to ) {
				$( '.blog .hentry a .attachment-home-post,'+
					'.archive .hentry a .attachment-home-post,'+
					'.search .hentry a .attachment-home-post' ).css( {
					'filter': 'grayscale(100%)',
					'-webkit-filter': 'grayscale(100%)',
					'-webkit-filter': 'grayscale(1)',
					'-moz-filter': 'grayscale(100%)',
					'-o-filter': 'grayscale(100%)',
					'-ms-filter': 'grayscale(100%)',
					'filter': 'gray',
					'filter': 'filter: url("data:image/svg+xml;utf8,<svg xmlns=\'http://www.w3.org/2000/svg\'><filter id=\'grayscale\'><feColorMatrix type=\'matrix\' values=\'0.3333 0.3333 0.3333 0 0 0.3333 0.3333 0.3333 0 0 0.3333 0.3333 0.3333 0 0 0 0 0 1 0\'/></filter></svg>#grayscale")'
				} );
			} else {
				$( '.blog .hentry a .attachment-home-post,'+
				'.archive .hentry a .attachment-home-post,'+
				'.search .hentry a .attachment-home-post' ).css( {
					'filter': 'grayscale(0)',
					'-webkit-filter': 'grayscale(0)',
					'-moz-filter': 'grayscale(0)',
					'-o-filter': 'grayscale(0)',
					'-ms-filter': 'grayscale(0)',
				} );
			}
		} );
	} );
	// Opacity
	wp.customize( 'spun_opacity', function( value ) {
		value.bind( function( to ) {
			if ( false === to ) {
				$( '.site-content #nav-below .nav-previous a,'+
					'.site-content #nav-below .nav-next a,'+
					'.site-content #image-navigation .nav-previous a,'+
					'.site-content #image-navigation .nav-next a,'+
					'.comment-navigation .nav-next,'+
					'.comment-navigation .nav-previous,'+
					'#infinite-handle span,'+
					'.sidebar-link,'+
					'a.comment-reply-link,'+
					'a#cancel-comment-reply-link,'+
					'.comments-link a,'+
					'.hentry.no-thumbnail,'+
					'button,'+
					'html input[type="button"],'+
					'input[type="reset"],'+
					'input[type="submit"],'+
					'.site-footer' ).css( {
						'opacity': '.2',
				} );
				$( '.site-header,'+
					'.entry-meta-wrapper,'+
					'.comment-meta,'+
					'.page-links span.active-link,'+
					'.page-links a span.active-link' ).css( {
						'opacity': '.3',
				} );
			} else {
				$( '.site-header,'+
					'.site-footer,'+
					'.entry-meta-wrapper,'+
					'.comment-meta,'+
					'.hentry.no-thumbnail,'+
					'.site-content #nav-below .nav-previous a,'+
					'.site-content #nav-below .nav-next a,'+
					'.site-content #image-navigation .nav-previous a,'+
					'.site-content #image-navigation .nav-next a,'+
					'.comment-navigation .nav-next,'+
					'.comment-navigation .nav-previous,'+
					'#infinite-handle span,'+
					'.sidebar-link,'+
					'a.comment-reply-link,'+
					'a#cancel-comment-reply-link,'+
					'.comments-link a,'+
					'button,'+
					'html input[type="button"],'+
					'input[type="reset"],'+
					'input[type="submit"],'+
					'.page-links span.active-link,'+
					'.page-links a span.active-link' ).css( {
							'opacity': '1',
				} );
			}
		} );
	} );
} )( jQuery );