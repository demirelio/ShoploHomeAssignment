<!-- ### HOME ### --><!-- banner_7_1566420411761 -->
<div id="{$settings->banner_7_1566420411761->name}" class="shb-banner-7 shb-section-slider shb-banner-without-top-margin" data-banner-handler="{$settings->banner_7_1566420411761->name}">
    <div class="container is-full">
        {if $settings->banner_7_1566420411761->slides|count > 0 && $settings->isBannerVisible({$settings->banner_7_1566420411761->name})}
            <div class="shb-slider-loader shb-dots-loader">
                <div class="shb-dot"></div>
                <div class="shb-dot"></div>
                <div class="shb-dot"></div>
            </div>
            <div class="shb-slider-wrapper" data-autoplay="{$settings->banner_7_1566420411761->settings->autoplay->value}" data-duration="{$settings->banner_7_1566420411761->settings->duration->value}" data-show-arrows="{$settings->banner_7_1566420411761->settings->show_arrows->value}" data-animation="{$settings->banner_7_1566420411761->settings->animation_effect->value}">
                <div class="shb-slider">
                    <div class="shb-slides">
                        {foreach from=$settings->banner_7_1566420411761->slides item="slide"}
                            {if $slide->settings->slide_visibility == "1"}
                            <div class="live-preview-slide-wrapper" data-slide-handler="{$slide->name}">
                                {if $slide->settings->link_url != 'none'}
                                <a href="{$slide->settings->link_url}">
                                    {/if}
                                    <figure>
                                        <img src="{$slide->img_url}" alt="{$slide->image_alt}" />
                                        <figcaption class="shb-alignment-{$slide->settings->alignment}">
                                          <h2 class="shb-slider-header" style="color: {$slide->settings->title_color}; --desktop-font-size: {$slide->settings->title_text_size}; --mobile-font-size: {$slide->settings->title_text_size_mobile}">{$slide->settings->title}</h2>
                                          <p class="shb-slider-description" style="color: {$slide->settings->description_color}; --desktop-font-size: {$slide->settings->description_text_size}; --mobile-font-size: {$slide->settings->description_text_size_mobile}">{$slide->settings->description}</p>
                                        </figcaption>
                                    </figure>
                                    {if $slide->settings->link_url != 'none'}
                                </a>
                                {/if}
                            </div>
                            {/if}
                        {/foreach}
                    </div>
                </div>
            </div>
        {else}
            <div class="shb-blankslate-banner">
                <figure{if !$settings->isBannerVisible({$settings->banner_7_1566420411761->name})} data-slide-handler="1"{/if}>
                    <a href="/admin/layout/theme/settings/{$shop->active_theme_id}" class="banner-add-button" data-img-info="{trans preview-trans=0}store_theme_translations.banner_blankslate_banner_fit_to_screen{/trans}">
                        <i class="shb-icon shb-icon-empty-img"></i>
                        <span>{trans preview-trans=0}store_theme_translations.banner_blankslate_add_label{/trans}</span>
                        <span class="shb-size-info">{trans preview-trans=0}store_theme_translations.banner_blankslate_banner_fit_to_screen{/trans}</span>
                    </a>
                </figure>
            </div>
        {/if}
    </div>
</div>
<!-- END banner_7_1566420411761 -->


<!-- productgrid_col4_13_1566420428183 -->
{snippet
  file="home_grid"
  grid_class="shb-grid-col-4"
  product_col_class="column is-12-mobile is-3-tablet"
  sidebar_col_class="column is-3-tablet"
  product_view=1
  set_image_ratio={$settings->product_image_ratio}
  settings_frontpage_collection=$settings->frontpage_collection
  settings_frontpage_collection_products_count=$settings->hp_frontpage_collection_products_count
  home_show_sidebar= $settings->home_show_sidebar
  home_show_sidebar_subcategories=$settings->home_show_sidebar_subcategories
  home_show_categories_nav=$settings->home_show_categories_nav
  home_show_collections_nav=$settings->home_show_collections_nav
  home_show_vendors_nav=$settings->home_show_vendors_nav
  product_list_show_add_to_cart = {$settings->product_list_show_add_to_cart}
  product_list_show_title = {$settings->product_list_show_title}
  product_list_title_limit = {$settings->product_list_title_limit}
  product_list_show_variants = {$settings->product_list_show_variants}
  product_list_show_variants_on_hover = {$settings->product_list_show_variants_on_hover}
}
<!-- END productgrid_col4_13_1566420428183 -->


<div class='section custom-video'>
		<iframe width="560" height="315" src="https://www.youtube.com/embed/OP80n76nz4Y?controls=0&loop=1&autoplay=1&mute=1&playlist=OP80n76nz4Y" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<!--to-do-4-->
<div class='section'>
	<div class='container'>
		<div class="columns is-multiline">
		  <div class="column is-one-third">
			<img src='https://via.placeholder.com/250'>
		  </div>
		  <div class="column is-one-third">
			<img src='https://via.placeholder.com/250'>
		  </div>
		  <div class="column is-one-third">
			<img src='https://via.placeholder.com/250'>
		  </div>
		  <div class="column is-one-third">
			<img src='https://via.placeholder.com/250'>
		  </div>
			<div class="column is-one-third">
			<img src='https://via.placeholder.com/250'>
		  </div>
			<div class="column is-one-third">
			<img src='https://via.placeholder.com/250'>
		  </div>
			<div class="column is-one-third">
			<img src='https://via.placeholder.com/250'>
		  </div>
			<div class="column is-one-third">
			<img src='https://via.placeholder.com/250'>
		  </div>
		</div>
	</div>
</div>
<!--to-do-6-->
<div id="overlay">
    <div id="popup">
         <h2>Hello World!!!</h2>
    </div>
</div>