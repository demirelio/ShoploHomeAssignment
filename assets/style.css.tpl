/* Fonts settings */
html, body {
     font-size: {$settings->font_size_default};
     background-color: {$settings->page_background_color};
}
body {
    font-family: {$settings->font_default};
}

h1,h2,h3,h4,h5,h6{
  font-family: {$settings->font_headers};
}

a:not(.btn) {color: {$settings->content_link_color}; }
a:hover:not(.btn) {color: {$settings->content_link_hover_color}; }

body.bg-img{
  background-image: url('{{{$settings->bg_image_url}|asset_url}}');
  background-repeat: {$settings->bg_image_repeat};
  background-position: {$settings->bg_image_alignment};
}

/* Navbar colors */
{* .nav-bar-background-color,
.nav-bar-background-color,
#mainNav ul.submenu,
header.sticky-bar.is-sticky,
.header-6 .sticky-bar.is-sticky .nav-inline,
.header-2 .sticky-bar.is-sticky {
    background: {$settings->navbar_background_color};
} *}
#mainNav ul li a{color: {$settings->navbar_color};}
.nav-bar-top-border, .nav-bar-bottom-border {
    border-top: 1px solid {$settings->navbar_border_color};
    border-bottom: 1px solid {$settings->navbar_border_color};}

.header-4 #mobileNav a .cart-widget-total-count{
  background-color: {$settings->cart_icon_background_color};
}

.overlay:before{
  background-color: {$settings->navbar_background_color};
  opacity: 0.9;
}
.overlay ul li a, .overlay #closeOverlay{
  color: {$settings->navbar_color};
}

/*Footer colors*/
footer[class^="footer-"] a, footer[class^="footer-"]{color: {$settings->footer_color};}
.background-footer {background: {$settings->footer_background_color};}

/* Logo */
#logo img.logo_img {width: {$settings->logo_img_size};}

/* Text header colors */
.text-header h3, .text-header h2 {color: {$settings->text_header_color};}

/* Newsletter color */
.newsletter-text h5, .newsletter-text h6{ color: {$settings->newsletter_text_color}; }
.newsletter-background {background-color: {$settings->newsletter_background_color}; }

/* Product grids */
.img-opacity:hover{opacity: 0.5;}

/* Color settings */
.btn,
.product-info .product-actions .add-to-cart,
.product-7 .product-info .right-actions .add-to-cart
{background: {$settings->dark_button_background}; color: {$settings->dark_button_text_color};}

/* Product page colors */
{* .product-6 .gallery-wrapper, .product-7 .gallery-wrapper { background: {$settings->gallery_background_color};} *}

/* Banners colors */
.section-slider .slick-slider:not(.slick-vertical) .slick-prev:before, .section-slider .slick-slider:not(.slick-vertical) .slick-next:before {
    color: {$settings->banner_arrows_color};
}
.product-7 .gallery-wrapper .main-gallery-wrapper .main-gallery{
  background-color: {$settings->banner_background_color};
}

.slick-dots li button:hover, .section-slider .slick-dots li button:focus {border-color: {$settings->banner_dots_color};}
.slick-dots li.slick-active button {border-color: {$settings->banner_dots_color};}
.slick-dots li button:before {background: {$settings->banner_dots_color};}

.banner-19, .banner-20 {background: {$settings->banner_background_color};}

.blankslate-banner figure:before,
.banner-22 .blankslate-banner figure .banner-image:before,
.banner-23 .blankslate-banner figure .banner-image:before,
.banner-24 .blankslate-banner figure .banner-image:before,
.banner-25 .blankslate-banner figure .banner-image:before,
.banner-26 .blankslate-banner figure .banner-image:before {
background: url({{'blankslate-banner-elements.svg'|asset_url}}) center center no-repeat;
background-size: contain;
}

.pswp__button,
.pswp__button--arrow--left:before,
.pswp__button--arrow--right:before {
background: url({{'default-skin.png'|asset_url}}) 0 0 no-repeat;
background-size: 264px 88px;
width: 44px;
height: 44px; }

.pswp__bg {
background: {$settings->lightbox_background};
}
/*additional css*/
#add-secondnav-third{
	color:tomato !important;
}	
/*additional css*/