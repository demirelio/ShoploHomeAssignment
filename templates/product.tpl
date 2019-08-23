<!-- ### PRODUCT ### --><!-- product_1_1566420450655 -->

{assign var="additional_var" value="Drogi Marszałku, Wysoka Izbo. PKB rośnie. Różnorakie i realizacji obecnej sytuacji. Przez            ostatnie kilkanaście lat odkryliśmy że rozszerzenie naszej kompetencji w większym stopniu           tworzenie kierunków postępowego wychowania. Podobnie, wzmocnienie i unowocześniania        istniejących kryteriów spełnia istotną rolę w większym stopniu tworzenie nowych propozycji. iLoveKebab Gdy            za sobą proces wdrożenia i określenia istniejących kryteriów pomaga w restrukturyzacji           przedsiębiorstwa. W związku z szerokim aktywem zabezpiecza udział szerokiej grupie w           restrukturyzacji przedsiębiorstwa. Jak już mówiłem jasne jest to, iż wzmocnienie i rozwijanie            struktur przedstawia interpretującą próbę sprawdzenia modelu rozwoju."}

<div class="shb-product-1">
    <div class="container">
        <div class="columns">
            <div class="column is-half">
                {assign var="photos" value=$product->getImages()}
                {if $photos}
                <div class="shb-main-gallery" data-slider-id="shb-product-1" data-zoom-ratio="{$settings->zoom_ratio}" data-fade="{$settings->gallery_fade}" data-type="{$settings->gallery_type}" data-fullscreen="{$settings->enable_fullscreen}">
                    {foreach from=$photos item="photo" name="list"}
                    <figure class="shb-gallery-item" data-hash="{$smarty.foreach.list.index}">
                        <img src="{$photo->url|product_img_url:th640}" data-large="{$photo->url|product_img_url:th2048}" {if $photo->alt}alt="{$photo->alt}"{else}alt="{$product->title}"{/if} />
                    </figure>
                    {/foreach}
                </div>

                <div class="shb-thumbs-gallery">
                    {foreach from=$photos item="photo" name="list"}
                    <div class="shb-thumb-item" data-image="{$photo->url|product_img_url:th640}" data-index="{$smarty.foreach.list.index}">
                        <img src="{$photo->url|product_img_url:th100}" {if $photo->alt}alt="{$photo->alt}"{else}alt="{$product->title}"{/if} />
                    </div>
                    {/foreach}
                </div>
                {/if}
            </div>
            <div class="column is-half">
                <div class="shb-product-details">
                    {if $settings->show_breadcrumbs}
                        {snippet file="breadcrumbs"}
                    {/if}
                    <form action="{reverse_url name='shop_cart_add'}" method="post">
                        {assign var="variants" value=$product->getVariants()}
                        {assign var="properties" value=$product->getProperties()}
                        <div class="shb-product-header columns is-marginless">
                            <div class="column is-paddingless">
                                <div class="shb-product-top-info">
                                    {if $settings->show_vendor && $product->vendor->title}
                                        <a href="{reverse_url name=shop_vendor vendor_name=$product->vendor->url}" title="{$product->vendor->title}"><h2 class="shb-product-vendor is-uppercase has-text-weight-semibold">{$product->vendor->title}</h2></a>
                                    {/if}
                                    <section placeholder-above-product-title>
                                        <div app-wishlist-add-to-wishlist product-id="{$product->id}"></div>
                                    </section>
                                </div>
                                <h1 class="has-text-weight-semibold">{$product->title}</h1>
                                <section placeholder-under-product-title>
                                    <div app-reviews-product-rating product-id="{$product->id}"></div>
                                </section>
                            </div>
                        </div>

                        <h4 class="shb-product-price" product-price>
                            {if $product->on_sale}
                            <span class="shb-old-price" product-price-old><span>{$product->price_regular|money}</span></span>
                            {/if}
                            <span class="shb-new-price {if $product->on_sale}red{/if}" product-price-new>
                                <span>{$product->price_min|money}</span>
                            </span>
                        </h4>

                        {snippet file="variants"}
						<div class="custom-container">
							<label>Type to increase product price: </label>
							<input type='text' value='' id='custom-input' size="15">
						</div>

                        <div class="shb-product-actions">
                            <input type="hidden" name="id" value="{$variants[0]->id}" data-quantity="{$variant->quantity}" data-property1="{$variants[0]->property1}" data-property2="{$variants[0]->property2}" data-property3="{$variants[0]->property3}" data-product-id="{$product->id}" />
                            <input type="hidden" name="return_to" value="" />
                            <input type="number" name="quantity" value="1" min="1" aria-label="Quantity" class="shb-product-quantity shb-input-large">
                            <div class="shb-add-to-cart-section">
                                <button name="addToCard" add-to-cart-button class="shb-btn shb-btn-dark shb-btn-large shb-btn-with-icon shb-add-to-cart-button" type="submit" {if !$variants[0]->available}disabled="disabled"{/if}>
                                    <span class="shb-add-to-cart-button-text">
                                        {if $variants[0]->available}
                                            {trans}store_theme_translations.add_to_cart_button_label{/trans}
                                        {else}
                                            {trans}store_theme_translations.variant_sold_out{/trans}
                                        {/if}
                                    </span>
                                    <i class="shb-icon shb-icon-arrow-right" {if !$variants[0]->available}style="display: none;"{/if}></i>
                                </button>
                                <section placeholder-under-add-to-card-button>
                                    <div app-instock-reminder-button></div>
                                </section>
                            </div>

                            {if $settings->show_shipping_info}
                            <div class="shb-product-shipping-info" data-shipping-default="{$settings->shipping_info}">
                                <i class="shb-icon shb-icon-parcel"></i>
                                {foreach from=$product->variants item="variant"}
                                {if $variant->availability_description != '' && $variant->availability_description != ' '}
                                {assign shipping $variant->availability_description}
                                {/if}
                                {/foreach}
                                {if $shipping}
                                {trans}store_theme_translations.shipping_info_label{/trans}: <span>{$shipping}</span>
                                {else}
                                {trans}store_theme_translations.shipping_info_label{/trans}: <span>{$settings->shipping_info}</span>
                                {/if}
                            </div>
                            {/if}
                        </div>
                    </form>
                    <div class="shb-tabs-widget" shb-tabs>
                        <div class="tabs shb-tabs-header">
                            <ul role="tablist">
                                {if $settings->product_page_show_tab_1}
                                {assign tabName_1 value={t key="store_theme_translations.product_page_tab_1_title"}}
                                <li role="tab" class="is-active">
                                    <a shb-tabs-tab role="tab" href="#{$tabName_1|handle}" class="has-text-weight-semibold is-uppercase">
                                        {t key="store_theme_translations.product_page_tab_1_title"}
                                    </a>
                                </li>
                                {/if}
                                {if $settings->product_page_show_tab_2}
                                {assign tabName_2 value={t key="store_theme_translations.product_page_tab_2_title"}}
                                <li role="tab">
                                    <a shb-tabs-tab role="tab" href="#{$tabName_2|handle}" class="has-text-weight-semibold is-uppercase">
                                        {trans}store_theme_translations.product_page_tab_2_title{/trans}
                                    </a>
                                </li>
                                {/if}
                                {if $settings->product_page_show_tab_3}
                                {assign tabName_3 value={t key="store_theme_translations.product_page_tab_3_title"}}
                                <li role="tab">
                                    <a shb-tabs-tab role="tab" href="#{$tabName_3|handle}" class="has-text-weight-semibold is-uppercase">
                                        {trans}store_theme_translations.product_page_tab_3_title{/trans}
                                    </a>
                                </li>
                                {/if}
                            </ul>
                        </div>
                        <section class="shb-tab-content-wrapper">
                            {if $settings->product_page_show_tab_1}
                            <div shb-tabs-content class="shb-tab-content wysiwyg-content is-active" id="{$tabName_1|handle}">
                                {$product->description}
                            </div>
                            {/if}
                            {if $settings->product_page_show_tab_2}
                            <div shb-tabs-content class="shb-tab-content wysiwyg-content" role="tabpanel" id="{$tabName_2|handle}" style="display: none">
                                {$shop->pages[$settings->product_page_tab_2_page]->content}
                            </div>
                            {/if}
                            {if $settings->product_page_show_tab_3}
                            <div shb-tabs-content class="shb-tab-content wysiwyg-content" role="tabpanel" id="{$tabName_3|handle}" style="display: none">
                                {$shop->pages[$settings->product_page_tab_3_page]->content}
                            </div>
                            {/if}
                        </section>
                    </div>
                    <section placeholder-under-product-details class="has-text-centered"></section>

                    <div class="columns is-marginless">
                        <div class="column is-paddingless is-two-thirds">
                            {if $settings->show_product_socials}
                            <ul class="shb-product-social">
                                {if $settings->product_show_facebook_share}
                                <li>
                                    <a href="https://www.facebook.com/sharer/sharer.php?u={reverse_url name=shop_product product_name=$product->url}&p[images][0]={$product->main_image|product_img_url:th1024}" aria-label="Facebook" target="_blank" rel="noopener nofolow">
                                        <i class="shb-icon shb-icon-facebook"></i>
                                    </a>
                                </li>
                                {/if}
                                {if $settings->product_show_twitter_share}
                                <li>
                                    <a href="http://twitter.com/share?url={reverse_url name=shop_product  product_name=$product->url}" aria-label="Twitter" target="_blank" rel="noopener nofolow">
                                        <i class="shb-icon shb-icon-twitter"></i>
                                    </a>
                                </li>
                                {/if}
                                {if $settings->product_show_pinterest_share}
                                <li>
                                    <a href="http://pinterest.com/pin/create/button/?url={reverse_url name=shop_product product_name=$product->url}" aria-label="Pinterest" target="_blank" rel="noopener nofolow">
                                        <i class="shb-icon shb-icon-pinterest"></i>
                                    </a>
                                </li>
                                {/if}
                            </ul>
                            {/if}
                            <section placeholder-under-product-details-left></section>
                        </div>
                        <div class="column is-paddingless has-text-right-tablet">
                            <section placeholder-under-product-details-right></section>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="columns">
            <div class="column is-vertical-paddingless">
                <section placeholder-under-product-section>
                    <div app-reviews-product-reviews product-id="{$product->id}"></div>
                </section>
            </div>
        </div>
    </div>
</div>
<div class='section'>
	<div class='container'>
		<div id="todo10container">
			<h2>Original text:</h2>
			<p id='todo-base'>{$additional_var}</p>
			<h2>Underscores:</h2>
			<p id='todoUnderscore'></p>
			<h2>No Polish Letters</h2>
			<p id='todoPolishChar'></p>
		</div>		
	</div>
</div>


<!-- END product_1_1566420450655 -->




{snippet file="rich_snippet"}
{snippet file="product_matrix"}
{snippet file="photo_swipe"}
{if $product->getPromotion()->promotion_type == 3}
<script>
    var isProgressiv = 1;
</script>
{/if}