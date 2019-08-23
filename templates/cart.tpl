<!-- ### CART ### --><!-- cart_1_1566420455711 -->
<div class="container">
    <div class="shb-cart-1">
        <header class="shb-cart-header columns">
            <h1 class="column">{trans}store_theme_translations.cart_header{/trans}</h1>
            <div class="column is-vertical-center align-flex-right">
                <div class="shb-cart-free-shipping-info-wrapper is-hidden"></div>
            </div>
        </header>

        {if $cart->item_count > 0}
            <form cart-summary id="cartSummary" action="{reverse_url name=shop_cart}" method="post">
                <div class="is-hidden-mobile shb-table-head">
                    <div class="columns">
                        <div class="column is-5 is-vertical-paddingless shb-cart-head-product"><span
                                    class="shb-text">{trans}store_theme_translations.cart_head_product{/trans}</span></div>
                        <div class="column is-7 is-paddingless">
                            <div class="columns is-marginless">
                                <div class="column is-4 align-center is-vertical-paddingless shb-quantity"><span
                                            class="shb-text">{trans}store_theme_translations.cart_head_quantity{/trans}</span>
                                </div>
                                <div class="column is-7 is-paddingless align-right"><span
                                            class="shb-text">{trans}store_theme_translations.cart_head_amount{/trans}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <ol cart-list class="shb-cart-list">
                    <li cart-product class="shb-cart-item shb-item-template" data-variant-id=""
                        data-product-id="">
                        <div class="columns">
                            <div class="column is-5 is-vertical-center shb-item-info">
                                <a item-image href=""
                                   class="shb-item-image align-flex-center is-vertical-center">
                                    <img src="" alt=""/>
                                </a>
                                <div class="shb-item-info">
                                    <a item-title href=""
                                       class="shb-item-title has-text-weight-semibold"></a>
                                    <ul item-properties class="column shb-product-variants shb-item-properties">

                                    </ul>
                                </div>
                            </div>
                            <div class="column is-7 is-paddingless is-vertical-center">
                                <div class="columns is-mobile is-marginless shb-item-actions">
                                    <div class="column is-4 align-flex-center is-vertical-center shb-product-qty shb-item-quantity-wrapper">
                                        <a decrease-quantity
                                           class="shb-decrease-button is-vertical-center align-flex-center">-</a>
                                        <input product-quantity class="shb-qty shb-input align-center"
                                               value=""
                                               data-price="" type="text">
                                        <a increase-quantity
                                           class="shb-increase-button is-vertical-center align-flex-center">+</a>
                                    </div>
                                    <div class="column is-mobile is-7 shb-product-price">
                                            <span product-price
                                                  class="shb-item-price has-text-weight-semibold"></span>
                                    </div>
                                    <div class="column is-1 is-vertical-center align-flex-right">
                                            <span delete-item
                                                  class="shb-delete-item"><i class="shb-icon shb-icon-close"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    {foreach from=$cart->items item="item" key="i"}
                        {assign isFreeItem $item->isBogoItem()}
                        <li cart-product class="shb-cart-item" data-variant-id="{$item->variant->id}"
                            data-product-id="{$item->product->id}">
                            <div class="columns">
                                <div class="column is-5 is-vertical-center shb-item-info">
                                    <a item-image
                                       href="{reverse_url name='shop_product' product_name=$item->product->url}"
                                       class="shb-item-image align-flex-center is-vertical-center">
                                        <img src="{$item->variant->main_image|product_img_url:th100}"
                                             alt="{$item->product->name}"/>
                                    </a>
                                    <div class="shb-item-info">
                                        <a item-title
                                           href="{reverse_url name='shop_product' product_name=$item->product->url}"
                                           class="shb-item-title has-text-weight-semibold">{$item->product->name|truncate:25}</a>
                                        <ul item-properties class="column shb-product-variants shb-item-properties">
                                            {foreach from=$item->variant->properties key="name" item="value" name="variantList"}
                                                <li>{$name}: {$value}</li>
                                            {/foreach}
                                            {if $settings->show_cart_products_properties}
                                                {foreach from=$item->properties key="name" item="value" name="variantList"}
                                                    {if $value->title !== PromotionModel::BOGO_LINE_ITEM_PROPERTY}
                                                        <li>{$value->title}:
                                                            {if $value->value|strstr:"/storeuploads"}
                                                                <a href="{$value->value}"
                                                                   target="_blank">{trans}store_theme_translations.uploaded_file{/trans}</a>
                                                            {else}
                                                                {$value->value}
                                                            {/if}</li>
                                                    {/if}
                                                {/foreach}
                                            {/if}
                                        </ul>
                                    </div>
                                </div>
                                <div class="column is-7 is-paddingless is-vertical-center">
                                    <div class="columns is-mobile is-marginless shb-item-actions">
                                        <div class="column is-4 align-flex-center is-vertical-center shb-product-qty shb-item-quantity-wrapper">
                                            <a decrease-quantity
                                               class="shb-decrease-button is-vertical-center align-flex-center">-</a>
                                            <input product-quantity class="shb-qty shb-input align-center"
                                                   name="updates[{$i}]" id="updates_{$i}" value="{$item->quantity}"
                                                   data-price="{$item->price|money_without_currency}" type="text"
                                                    {if $isFreeItem == '1'} readonly{/if}>
                                            {if $isFreeItem != '1'}
                                                <a increase-quantity
                                                   class="shb-increase-button is-vertical-center align-flex-center">+</a>
                                            {/if}
                                        </div>
                                        <div class="column is-mobile is-7 is-paddingless shb-product-price">
                                            {if $item->price_original > $item->price}
                                                <span product-price-original
                                                      class="shb-item-price shb-item-price-old">{$item->price_original|money}</span>
                                            {/if}
                                            <span product-price
                                                  class="shb-item-price has-text-weight-semibold">{$item->price|money}</span>
                                        </div>
                                        <div class="column is-1 is-vertical-center align-flex-right">
                                            <span delete-item
                                                  class="shb-delete-item"><i class="shb-icon shb-icon-close"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    {/foreach}
                </ol>
                <div id="sumCartPrice" class="shb-cart-sum columns is-marginless">
                    <div class="column is-paddingless align-right"></div>
                    <div class="column is-paddingless">
                        {if $settings->show_cart_default_delivery_cost}
                            <div class="columns is-mobile is-marginless shb-cart-total-price-without-delivery">
                                <div class="column is-8-tablet is-8-desktop is-vertical-paddingless align-right">
                                    <p>{trans}store_theme_translations.order_summary_label{/trans}</p>
                                </div>
                                <div cart-sum-without-shipping class="column is-4 is-vertical-paddingless shb-cart-delivery-cost align-right">
                                    <p>{$cart->total_price|money}</p>
                                </div>
                            </div>
                            <div cart-delivery-cost-wrapper class="columns is-mobile shb-cart-delivery-price">
                                <div class="column is-8-tablet is-8-desktop is-vertical-paddingless align-right">
                                    <p>{trans}store_theme_translations.cart_delivery_label{/trans}</p>
                                </div>
                                <div class="column is-4 is-vertical-paddingless shb-cart-delivery-cost align-right">
                                    {assign defaultDeliveryCost $settings->cart_default_delivery_cost|floatval*100}
                                    <span>{$defaultDeliveryCost|money}</span>
                                </div>
                            </div>
                        {/if}
                        <div class="columns is-mobile is-marginless has-text-weight-semibold shb-cart-total-price">
                            <div class="column is-8-tablet is-8-desktop is-vertical-paddingless align-right">
                                <p>{trans}store_theme_translations.order_grand_summary_label{/trans}</p>
                            </div>
                            <div sum-price id="sumPrice" class="column is-4 is-vertical-paddingless align-right" data-sum="{$cart->total_price|money_without_currency}">
                                <span total-price class="shb-total-price">{$cart->total_price|money}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="cartActions" class="columns is-mobile align-center-mobile">
                    <div class="column is-vertical-center">
                        <a href="{reverse_url name='shop_category_list'}" class="shb-return">
                            {trans}store_theme_translations.continue_shopping_label{/trans}</a>
                    </div>
                    <div class="column is-vertical-center align-flex-right">
                        <button id="toCheckout" class="shb-btn shb-btn-dark shb-btn-large shb-btn-with-icon" type="submit" name="order" value="Order">
                            {trans}store_theme_translations.puchase_button_label{/trans}
                            <i class="shb-icon shb-icon-arrow-right"></i>
                        </button>
                    </div>
                </div>
                <div class="columns shb-additional-info">
                    <div class="column is-offset-6 align-right is-vertical-paddingless">
                        {if $settings->show_cart_default_delivery_info}
                            <p>{trans}store_theme_translations.cart_delivery_info{/trans}</p>
                        {/if}
                        <p>{trans}store_theme_translations.cart_next_step_info{/trans}</p>
                    </div>
                </div>

            </form>
        {/if}
        <div empty-cart class="shb-empty-cart align-center {if $cart->item_count != 0}is-hidden{/if}">
            <i class="shb-icon shb-icon-cart-blankslate"></i>
            <p class="shb-msg align-center">{trans}store_theme_translations.empty_cart_text{/trans}</p>
            <a href="{reverse_url name='shop_category_list'}"
               class="shb-btn shb-btn-dark shb-btn-large shb-btn-with-icon">
                {trans}store_theme_translations.prompt_text{/trans}
                <i class="shb-icon shb-icon-arrow-right"></i>
            </a>
        </div>
    </div>
</div>
<!-- END cart_1_1566420455711 -->


