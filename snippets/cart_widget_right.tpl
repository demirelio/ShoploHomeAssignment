<div id="cartWidgetRight" class="shb-sliding-cart-widget" sliding-cart-widget>
    <a cart-widget-trigger id="closeTriggerTop" class="shb-cart-widget-trigger"><i class="shb-icon shb-icon-close-thin"></i></a>
    <div class="shb-cart-widget-header">
        <h4>{trans}store_theme_translations.cart_widget_heading{/trans}</h4>
    </div>
    <form minicart-summary id="minicartSummary" action="{reverse_url name=shop_cart}" class="{if $cart->item_count == 0} is-hidden{/if}" method="post">
        <ol cart-list class="shb-mini-products-list">
            <li cart-product class="shb-mini-products-item shb-item-template shb-cart-product" data-variant-id="" data-product-id="" data-qty="" data-price="">
                <div class="shb-mini-products-item-top-left">
                    <a item-image href="" title="" class="shb-product-image">
                        <img src="" alt="">
                    </a>
                </div>
                <div class="shb-mini-products-item-top-right">
                    <div class="shb-mini-products-top-line">
                        <div class="shb-mini-products-info">
                            <a item-title href="" class="shb-mini-product-title"></a>
                            <ul item-properties class="shb-mini-products-item-properties">
                            </ul>
                        </div>
                        <span delete-item class="shb-mini-products-item-remove"><a href="#" class="shb-delete-item-button"><i class="shb-icon shb-icon-close"></i></a></span>
                    </div>
                    <div class="shb-mini-products-bottom-line columns is-vertical-center is-marginless is-mobile">
                        <span class="shb-mini-products-item-quantity column is-4 is-paddingless"><input product-quantity type="number" min="0" value="1" data-price=""></span>
                        <span class="shb-mini-products-item-price column is-8 align-right is-paddingless has-text-weight-semibold">
                            <span product-price data-price=""></span>
                        </span>
                    </div>
                </div>
            </li>
            {foreach from=$cart->items item="item" key="i"}
                <li cart-product class="shb-mini-products-item cart-product" id="cart-item-{$item->id}" data-variant-id="{$item->variant->id}" data-product-id="{$item->product->id}" data-qty="{$item->quantity}" data-price="{$item->price|money}">
                    <div class="shb-mini-products-item-top-left">
                        <a href="{reverse_url name='shop_product' product_name=$item->product->url}" title="{$item->title}" class="shb-product-image">
                            <img src="{$item->variant->main_image|product_img_url:th100}" alt="{$item->title}">
                        </a>
                    </div>
                    <div class="shb-mini-products-item-top-right">
                        <div class="shb-mini-products-top-line">
                            <div class="shb-mini-products-info">
                                <a item-title href="{reverse_url name='shop_product' product_name=$item->product->url}" class="shb-mini-product-title">{$item->product->name}</a>
                                <ul item-properties class="shb-mini-products-item-properties">
                                    {foreach from=$item->variant->properties key="name" item="value" name="variantList"}
                                        <li>{$name}: {$value}</li>
                                    {/foreach}
                                    {if $settings->show_cart_products_properties}
                                        {foreach from=$item->properties key="name" item="value" name="variantList"}
                                            {if $value->title !== PromotionModel::BOGO_LINE_ITEM_PROPERTY}
                                                <li>{$value->title}:
                                                    {if $value->value|strstr:"/storeuploads"}
                                                        <a href="{$value->value}" target="_blank">{trans}store_theme_translations.uploaded_file{/trans}</a>
                                                    {else}
                                                        {$value->value}
                                                    {/if}</li>
                                            {/if}
                                        {/foreach}
                                    {/if}
                                </ul>
                            </div>
                            <span delete-item class="shb-mini-products-item-remove"><a href="#" class="shb-delete-item-button"><i class="shb-icon shb-icon-close"></i></a></span>
                        </div>
                        <div class="shb-mini-products-bottom-line columns is-vertical-center is-marginless is-mobile">
                            <span class="shb-mini-products-item-quantity column is-4 is-paddingless"><input product-quantity name="updates[{$i}]" id="updates_{$i}" value="{$item->quantity}" data-price="{$item->price|money_without_currency}" data-value="{$item->quantity}" data-max="{$item->variant->quantity}" data-available="{$item->variant->available}" min="1" type="number"  data-price="{$item->price|money_without_currency}"></span>
                            <span class="shb-mini-products-item-price column is-8 align-right is-paddingless has-text-weight-semibold">
                                    {if $item->price_original > $item->price}
                                        <span product-price-original
                                              class="shb-item-price shb-item-price-old">{$item->price_original|money}</span>
                                    {/if}
                                    <span product-price
                                          data-price="{$item->price|money_without_currency}">{$item->price|money}</span>
                            </span>
                        </div>
                    </div>
                </li>
            {/foreach}
        </ol>

        <div class="shb-mini-cart-summary">
            {if $settings->show_cart_default_delivery_cost}
                <div class="columns is-mobile shb-cart-total-price-without-delivery">
                    <div class="column is-8 is-vertical-paddingless align-right">
                        <p>{trans}store_theme_translations.order_summary_label{/trans}</p>
                    </div>
                    <div cart-sum-without-shipping class="column is-4 is-vertical-paddingless align-right">
                        <p>{$cart->total_price|money}</p>
                    </div>
                </div>
                <div cart-delivery-cost-wrapper class="columns is-mobile shb-cart-delivery-price">
                    <div class="column is-8 is-vertical-paddingless align-right">
                        <p>{trans}store_theme_translations.cart_delivery_label{/trans}</p>
                    </div>
                    <div class="column is-4 is-vertical-paddingless is-vertical-center shb-cart-delivery-cost align-flex-right">
                        {assign defaultDeliveryCost $settings->cart_default_delivery_cost|floatval*100}
                        <span>{$defaultDeliveryCost|money}</span>
                    </div>
                </div>
            {/if}
            <div class="columns is-mobile has-text-weight-semibold shb-cart-total-price">
                <div class="column is-8 is-vertical-paddingless align-right">
                    <p>{trans}store_theme_translations.order_grand_summary_label{/trans}</p>
                </div>
                <div sum-price id="sumPrice" class="column is-4 is-vertical-paddingless is-vertical-center align-flex-right">
                    <span mini-products-list-total-price class="mini-products-list-total-price" data-sum="{$cart->total_price|money_without_currency}">{$cart->total_price|money}</span>
                </div>
            </div>
        </div>
        <div class="shb-cart-widget-actions">
            <div class="columns is-marginless is-mobile">
                <div class="column is-vertical-center is-paddingless">
                    <a cart-widget-trigger href="{reverse_url name='shop_category_list'}" class="shb-return">
                        {trans}store_theme_translations.continue_shopping_label{/trans}</a>
                </div>
                <div class="column is-paddingless">
                    <button class="shb-btn shb-btn-dark shb-btn-large shb-btn-with-icon" type="submit" name="order">
                        {trans}store_theme_translations.puchase_button_label{/trans} <i class="shb-icon shb-icon-arrow-right"></i>
                    </button>
                </div>
            </div>
        </div>
        {if $settings->show_cart_default_delivery_info}
        <div class="columns shb-additional-info">
            <div class="column align-right is-vertical-paddingless">
                <p>{trans}store_theme_translations.cart_delivery_info{/trans}</p>
            </div>
        </div>
        {/if}

    </form>

    <div empty-cart class="shb-mini-products-list-empty align-center{if $cart->item_count != 0} is-hidden{/if}">
        <i class="shb-icon shb-icon-cart-blankslate"></i>
        <p>{trans}store_theme_translations.empty_cart_text{/trans}</p>
        <a href="{reverse_url name='shop_category_list'}">{trans}store_theme_translations.prompt_text{/trans}</a>
    </div>
</div>
