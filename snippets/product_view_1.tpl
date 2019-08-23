{$prop = $p->getProperties()}
{if $p->main_image && $p->main_image->width > 0}
{$ratio = $p->main_image->height / $p->main_image->width * 100}
{else}
{$ratio = 100}
{/if}
{* get ratio for main image *}
{if $ratio > 100}
{$image_ratio = 'vertical'}
{else if $ratio < 100}
{$image_ratio = 'horizontal'}
{else}
{$image_ratio = 'square'}
{/if}

{if $settings->product_image_after_hover == 'next'}
{$photos = $p->getImages()}
{if $photos|@count > 1}
{foreach from=$photos item="photo" name="list"}
{if $photo->url|product_img_url:th640 != $p->main_image|product_img_url:th640}
{$indexHoverImg = $smarty.foreach.list.index}
{assign ratio2 0}
{if $photos[{$indexHoverImg}]->width > 0}
{$ratio2 = $photos[{$indexHoverImg}]->height / $photos[{$indexHoverImg}]->width * 100}
{else}
{$ratio2 = 100}
{/if}
{if $ratio2 > 100}
{$second_image_ratio = 'vertical'}
{else if $ratio2 < 100}
{$second_image_ratio = 'horizontal'}
{else}
{$second_image_ratio = 'square'}
{/if}
{break}
{else}
{continue}
{/if}
{/foreach}
{/if}
{/if}

{if $p->properties_colors['Kolor']}
{$colors = $p->properties_colors['Kolor']}
{$property_name = 'Kolor'}
{else if $p->properties_colors['Color']}
{$colors = $p->properties_colors['Color']}
{$property_name = 'Color'}
{else}
{$colors = []}
{/if}

<figure class="shb-product-list-item">
  {if $settings->product_image_after_hover == 'next'}
  {if $photos|@count > 1}
  <div class="shb-product-list-img-show-next">
    <section class="shb-product-list-placeholder shb-product-list-placeholder-top-left">
      <div product-id="{$p->id}" app-wishlist-product-list-item class="shb-hiden"></div>
      {if $p->on_sale || $p->getPromotion()->promotion_type === PromotionModel::PROMOTION_TYPE_BOGO}
        <div><span class="shb-product-list-label-sale">{trans}store_theme_translations.product_list_item_sale_label{/trans}</span></div>
      {/if}
      {if !$p->available}
        <div><span class="shb-product-list-label-sold">{trans}store_theme_translations.product_list_item_sold_label{/trans}</span></div>
      {/if}
      {foreach from=$p->tags item="tag"}
        {if $tag|lower|strstr:"onpromo_"}
          {assign promo $tag|replace:"onpromo_":""}
          <div><span class="shb-product-list-label-sale">{$promo}</span></div>
        {/if}
      {/foreach}
    </section>
    <section class="shb-product-list-placeholder shb-product-list-placeholder-top-right">
      <div product-id="{$p->id}" app-wishlist-product-list-item></div>
    </section>
    <section class="shb-product-list-placeholder shb-product-list-placeholder-bottom-left">
      <div product-id="{$p->id}" app-wishlist-product-list-item></div>
    </section>
    <section class="shb-product-list-placeholder shb-product-list-placeholder-bottom-right">
      <div product-id="{$p->id}" app-wishlist-product-list-item></div>
    </section>
    <div class="main-photo">
      <div class="responsively-lazy shb-product-list-image-set-{$set_image_ratio} shb-product-list-image-ratio-{$image_ratio} {if $settings->cropped_product_photos} crop-photo{/if}"{if $set_image_ratio == 'vertical' && !$settings->cropped_product_photos} style="padding-bottom: {$ratio}%"{/if}>
        <a href="{$productUrl}" title="{$p->title}">
          <img src="{$p->main_image|product_img_url:th480}"
               data-srcset="{$p->main_image|product_img_url:th480} 480w,{$p->main_image|product_img_url:th640} 640w, {$p->main_image|product_img_url:th1024} 1024w, {$p->main_image|product_img_url:th2048} 2048w"
               {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if}
          />
        </a>
      </div>
    </div>
    <div class="hovered-photo">
      <div class="responsively-lazy shb-product-list-image-set-{$set_image_ratio} shb-product-list-image-ratio-{$second_image_ratio}"{if $set_image_ratio == 'vertical' && !$settings->cropped_product_photos} style="padding-bottom: {$ratio}%"{/if}>
        <a href="{$productUrl}" title="{$p->title}">
          <img src="{$photos[{$indexHoverImg}]->url|product_img_url:th480}"
               data-srcset="{$photos[{$indexHoverImg}]->url|product_img_url:th480} 480w,{$photos[{$indexHoverImg}]->url|product_img_url:th640} 640w, {$photos[{$indexHoverImg}]->url|product_img_url:th1024} 1024w, {$photos[{$indexHoverImg}]->url|product_img_url:th2048} 2048w"
               {if $photos[{$indexHoverImg}]->alt}alt="{$photos[{$indexHoverImg}]->alt}"{else}alt="{$p->name|escape}"{/if}
          />
        </a>
      </div>
    </div>
    {if $colors && $product_list_show_variants && $product_list_show_variants_on_hover}
    <div class="{if $settings->product_name_align == 'left'}align-left{elseif $settings->product_name_align == 'right'}align-right{else}align-center{/if} shb-variants-list-hover-wrapper">
      <div class="shb-variants-list shb-variants-list-hover">
        <ul data-property-name="{$property_name}" class="shb-properties">
          {foreach from=$colors item="color" name="colors"}
          <li class="shb-property shb-property-xsmall shb-property-circle">
            <a href="{$productUrl}?property[{$property_name}]={$color|escape:'url'}">
              <span style="background: {$pallete[$color|lower]};"></span>
            </a>

          </li>
          {/foreach}
        </ul>
      </div>
    </div>
    {/if}
  </div>
  {else}
  <div class="responsively-lazy shb-product-list-image-set-{$set_image_ratio} shb-product-list-image-ratio-{$image_ratio} {if $settings->cropped_product_photos} crop-photo{/if}"{if $set_image_ratio == 'vertical' && !$settings->cropped_product_photos} style="padding-bottom: {$ratio}%"{/if}>
    <section class="shb-product-list-placeholder shb-product-list-placeholder-top-left">
      <div product-id="{$p->id}" app-wishlist-product-list-item class="shb-hiden"></div>
      {if $p->on_sale || $p->getPromotion()->promotion_type === PromotionModel::PROMOTION_TYPE_BOGO}
        <div><span class="shb-product-list-label-sale">{trans}store_theme_translations.product_list_item_sale_label{/trans}</span></div>
      {/if}
      {if !$p->available}
        <div><span class="shb-product-list-label-sold">{trans}store_theme_translations.product_list_item_sold_label{/trans}</span></div>
      {/if}
      {foreach from=$p->tags item="tag"}
        {if $tag|lower|strstr:"onpromo_"}
          {assign promo $tag|replace:"onpromo_":""}
          <div><span class="shb-product-list-label-sale">{$promo}</span></div>
        {/if}
      {/foreach}
    </section>
    <section class="shb-product-list-placeholder shb-product-list-placeholder-top-right">
      <div product-id="{$p->id}" app-wishlist-product-list-item></div>
    </section>
    <section class="shb-product-list-placeholder shb-product-list-placeholder-bottom-left">
      <div product-id="{$p->id}" app-wishlist-product-list-item></div>
    </section>
    <section class="shb-product-list-placeholder shb-product-list-placeholder-bottom-right">
      <div product-id="{$p->id}" app-wishlist-product-list-item></div>
    </section>
    <a href="{$productUrl}" title="{$p->title}">
      <img src="{$p->main_image|product_img_url:th480}"
           data-srcset="{$p->main_image|product_img_url:th480} 480w,{$p->main_image|product_img_url:th640} 640w, {$p->main_image|product_img_url:th1024} 1024w, {$p->main_image|product_img_url:th2048} 2048w"
           {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if}
      />
    </a>
  </div>
  {/if}
  {else}
  <div class="responsively-lazy shb-product-list-image-set-{$set_image_ratio} shb-product-list-image-ratio-{$image_ratio} {if $settings->product_image_after_hover == 'opacity'}shb-product-list-img-opacity{/if} {if $settings->cropped_product_photos} crop-photo{/if}"{if $set_image_ratio == 'vertical' && !$settings->cropped_product_photos} style="padding-bottom: {$ratio}%"{/if}>
    <section class="shb-product-list-placeholder-top-left" placeholder-product-list-product-top-left>
      <div product-id="{$p->id}" app-wishlist-product-list-item class="shb-hiden"></div>
      {if $p->on_sale || $p->getPromotion()->promotion_type === PromotionModel::PROMOTION_TYPE_BOGO}
      <div><span class="shb-product-list-label-sale">{trans}store_theme_translations.product_list_item_sale_label{/trans}</span></div>
      {/if}
      {if !$p->available}
      <div><span class="shb-product-list-label-sold">{trans}store_theme_translations.product_list_item_sold_label{/trans}</span></div>
      {/if}
      {foreach from=$p->tags item="tag"}
      {if $tag|lower|strstr:"onpromo_"}
      {assign promo $tag|replace:"onpromo_":""}
      <div><span class="shb-product-list-label-sale">{$promo}</span></div>
      {/if}
      {/foreach}
    </section>
    <section class="shb-product-list-placeholder-top-right" placeholder-product-list-product-top-right>
      <div product-id="{$p->id}" app-wishlist-product-list-item></div>
    </section>
    <section class="shb-product-list-placeholder-bottom-left" placeholder-product-list-product-bottom-left>
      <div product-id="{$p->id}" app-wishlist-product-list-item></div>
    </section>
    <section class="shb-product-list-placeholder-bottom-right" placeholder-product-list-product-bottom-right>
      <div product-id="{$p->id}" app-wishlist-product-list-item></div>
    </section>
    <a href="{$productUrl}" title="{$p->title}">
      <img src="{$p->main_image|product_img_url:th480}"
           data-srcset="{$p->main_image|product_img_url:th480} 480w,{$p->main_image|product_img_url:th640} 640w, {$p->main_image|product_img_url:th1024} 1024w, {$p->main_image|product_img_url:th2048} 2048w"
           {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if}
      />
    </a>
    {if $colors && $product_list_show_variants && $product_list_show_variants_on_hover}
    <div class="{if $settings->product_name_align == 'left'}align-left{elseif $settings->product_name_align == 'right'}align-right{else}align-center{/if} shb-variants-list-hover-wrapper">
      <div class="shb-variants-list shb-variants-list-hover">
        <ul data-property-name="{$property_name}" class="shb-properties">
          {foreach from=$colors item="color" name="colors"}
          <li class="shb-property shb-property-xsmall shb-property-circle">
            <a href="{$productUrl}?property[{$property_name}]={$color|escape:'url'}">
              <span style="background: {$pallete[$color|lower]};"></span>
            </a>

          </li>
          {/foreach}
        </ul>
      </div>
    </div>
    {/if}
  </div>
  {/if}
  {if $product_list_show_title || $product_list_show_add_to_cart || $product_list_show_variants}
  <figcaption
          class="{if $settings->product_name_align == 'left'}align-left{elseif $settings->product_name_align == 'right'}align-right{else}align-center{/if}{if !$product_list_show_title} shb-product-without-title{/if}">
    {if $product_list_show_title}
    <h3 class="shb-product-list-title{if $product_list_title_limit} shb-product-list-title-limit{/if}">
      <a href="{$productUrl}"
         class="{if $settings->cropped_product_photos} crop-photo{/if}{if $img_with_sidebar} img-with-sidebar{/if}"
         title="{$p->title}">
        {$p->name}
      </a>
    </h3>
    <p class="shb-product-list-price">{if $p->price_differ}{trans}store_theme_translations.price_differ{/trans}{/if} {if
      $p->on_sale}<span
              class="shb-product-list-old-price">{$p->price_regular|money}</span><span
              class="shb-product-list-new-price">{$p->price_min|money}</span>{else}<span>{$p->price_min|money}</span>{/if}
    </p>
    {/if}
    {if $colors && $product_list_show_variants && !$product_list_show_variants_on_hover}
    <div class="shb-variants-list">
      <ul data-property-name="{$property_name}" class="shb-properties">
        {foreach from=$colors item="color" name="colors"}
        <li class="shb-property shb-property-xsmall shb-property-circle">
          <a href="{$productUrl}?property[{$property_name}]={$color|escape:'url'}">
            <span style="background: {$pallete[$color|lower]};"></span>
          </a>

        </li>
        {/foreach}
      </ul>
    </div>
    {/if}
    {if $product_list_show_add_to_cart}
    <form action="{reverse_url name='shop_cart_add'}" method="post" class="clearfix">
      <input type="hidden" name="id" value="{$p->first_available_variant->id}"
             data-price="{$p->first_available_variant->price|money_without_currency}"
             data-property1="{$p->first_available_variant->property1}"
             data-property2="{$p->first_available_variant->property2}"
             data-property3="{$p->first_available_variant->property3}" data-product-id="{$p->id}"/>
      {if "productoptions"|in_array:$p->tags}
      <a href="{$productUrl}" title="{$p->title}" class="shb-product-list-add-to-cart shb-btn shb-btn-small shb-btn-light">
        {trans}store_theme_translations.show_product_button_label{/trans}
      </a>
      {else}
      <button type="submit" class="shb-product-list-add-to-cart shb-btn shb-btn-small shb-btn-light">
        {trans}store_theme_translations.add_to_cart_button_label{/trans}
      </button>
      {/if}
    </form>
    {/if}

    <section class="shb-product-list-placeholder-bottom" placeholder-product-list-product-bottom>
      <div app-reviews-product-list-rating product-id="{$p->id}"></div>
    </section>

  </figcaption>
  {/if}
</figure>
