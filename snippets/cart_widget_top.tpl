<div sliding-cart-widget id="cartWidgetTop" class="shb-sliding-cart-widget shb-sliding-cart-widget-vertical">
    <a cart-widget-trigger id="closeTriggerTop" class="cart-widget-trigger"><i class="shb-icon shb-icon-close-thin"></i></a>
    <div class="container">
        <header class="shb-cart-widget-header">
            <h4>{trans}store_theme_translations.cart_widget_heading{/trans}</h4>
            <div class="shb-cart-free-shipping-info-wrapper is-hidden"></div>
        </header>
        <form minicart-summary id="minicartSummary" class="{if $cart->item_count == 0}is-hidden{/if}" action="{reverse_url name=shop_cart}" method="post">
            <div id="tableHead" class="is-hidden-mobile">
                <div class="columns">
                    <div class="column is-5 is-vertical-paddingless shb-cart-head-product"><span class="shb-text">{trans}store_theme_translations.cart_head_product{/trans}</span></div>
                    <div class="column is-7 is-paddingless">
                        <div class="columns is-marginless">
                            <div class="column is-4 is-vertical-paddingless shb-quantity align-center"><span class="shb-text">{trans}store_theme_translations.cart_head_quantity{/trans}</span></div>
                            <div class="column is-7 is-vertical-paddingless align-right"><span class="shb-text">{trans}store_theme_translations.cart_head_amount{/trans}</span></div>
                        </div>
                    </div>
                </div>
            </div>
            <ol cart-list class="shb-mini-products-list">
                <li cart-product class="shb-mini-products-item shb-cart-product shb-item-template" data-variant-id="" data-product-id="" data-qty="" data-price="">
                    <div class="columns">
                        <div class="column is-5 is-vertical-center shb-mini-products-info">
                            <div class="shb-product-image">
                                <a item-image href=""><img src="" alt="" /></a>
                            </div>
                            <div class="shb-product-info">
                                <a item-title class="shb-mini-product-title has-text-weight-semibold" href=""></a>
                                <ul item-properties class="column shb-product-variants shb-mini-products-item-properties">
                                </ul>
                            </div>
                        </div>
                        <div class="column is-7 is-paddingless is-vertical-center">
                            <div class="columns is-mobile is-marginless shb-mini-products-actions">
                                <div class="column is-4 is-vertical-center shb-product-qty shb-mini-products-item-quantity align-flex-center">
                                    <a decrease-quantity class="shb-decrease-button is-vertical-center align-flex-center">-</a>
                                    <input product-quantity class="shb-qty shb-input align-center" name="" id="" value="" data-price="" type="text">
                                    <a increase-quantity class="shb-increase-button is-vertical-center align-flex-center">+</a>
                                </div>
                                <div class="column is-mobile is-7 is-vertical-center shb-product-price shb-product-price-sum align-flex-center">
                                    <span product-price class="shb-mini-products-item-price has-text-weight-semibold"></span>
                                </div>
                                <div class="column is-1 is-vertical-center align-flex-right">
                                    <span delete-item
                                          class="shb-delete-item shb-mini-products-item-remove"><i class="shb-icon shb-icon-close"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                {if $cart->item_count > 0}
                    {foreach from=$cart->items item="item" key="i"}
                        {assign isFreeItem $item->isBogoItem()}
                        <li cart-product class="shb-mini-products-item shb-cart-product" id="cart-item-{$item->id}" data-variant-id="{$item->variant->id}" data-product-id="{$item->product->id}" data-qty="{$item->quantity}" data-price="{$item->price|money}">
                            <div class="columns">
                                <div class="column is-5 is-vertical-center shb-mini-products-info">
                                    <div class="shb-product-image">
                                        <a item-image href="{reverse_url name='shop_product' product_name=$item->product->url}">
                                            <img src="{$item->variant->main_image|product_img_url:th100}" alt="{$item->product->name}" />
                                        </a>
                                    </div>
                                    <div class="shb-product-info">
                                        <a item-title href="{reverse_url name='shop_product' product_name=$item->product->url}" class="shb-mini-product-title has-text-weight-semibold">{$item->product->name|truncate:25}</a>
                                        <ul item-properties class="column shb-product-variants shb-mini-products-item-properties">
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
                                </div>
                                <div class="column is-7 is-paddingless is-vertical-center">
                                    <div class="columns is-mobile is-marginless shb-mini-products-actions">
                                        <div class="column is-4 is-vertical-center shb-product-qty shb-mini-products-item-quantity align-flex-center">
                                            <a decrease-quantity class="shb-decrease-button is-vertical-center align-flex-center">-</a>
                                            <input product-quantity class="shb-qty align-center" name="updates[{$i}]" id="updates_{$i}" value="{$item->quantity}" data-price="{$item->price|money_without_currency}" type="text"{if $isFreeItem == '1'} readonly{/if}>
                                            {if $isFreeItem != '1'}
                                                <a increase-quantity class="shb-increase-button is-vertical-center align-flex-center">+</a>
                                            {/if}
                                        </div>
                                        <div class="column is-mobile is-7 is-vertical-center shb-product-price shb-product-price-sum align-flex-center">
                                            {if $item->price_original > $item->price}
                                                <span product-price-original
                                                      class="shb-item-price shb-item-price-old">{$item->price_original|money}</span>
                                            {/if}
                                            <span product-price class="shb-mini-products-item-price has-text-weight-semibold">{$item->price|money}</span>
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
                {/if}
            </ol>
            <div id="sumCartPrice" class="shb-cart-sum columns is-marginless">
                <div class="column is-offset-6 is-paddingless">
                    {if $settings->show_cart_default_delivery_cost}
                        <div class="columns is-mobile is-marginless shb-cart-total-price-without-delivery">
                            <div class="column is-8-tablet is-8-desktop is-vertical-paddingless align-right">
                                <p>{trans}store_theme_translations.order_summary_label{/trans}</p>
                            </div>
                            <div cart-sum-without-shipping class="column is-4 is-paddingless shb-cart-delivery-cost align-right">
                                <p>{$cart->total_price|money}</p>
                            </div>
                        </div>
                        <div cart-delivery-cost-wrapper class="columns is-mobile is-marginless shb-cart-delivery">
                            <div class="column is-8-tablet is-8-desktop is-vertical-paddingless align-right">
                                <p>{trans}store_theme_translations.cart_delivery_label{/trans}</p>
                            </div>
                            <div class="column is-4 cart-delivery-cost is-paddingless align-right">
                                {assign defaultDeliveryCost $settings->cart_default_delivery_cost|floatval*100}
                                <span>{$defaultDeliveryCost|money}</span>
                            </div>
                        </div>
                    {/if}
                    <div class="columns is-mobile is-marginless has-text-weight-semibold">
                        <div class="column is-8-tablet is-8-desktop is-vertical-paddingless align-right">
                            <p>{trans}store_theme_translations.order_grand_summary_label{/trans}</p>
                        </div>
                        <div  id="sumPrice" class="column is-4 is-paddingless align-right">
                            <span mini-products-list-total-price class="shb-mini-products-list-total-price" data-sum="{$cart->total_price|money_without_currency}">{$cart->total_price|money_without_currency}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div id="cartActions" class="columns is-mobile is-vertical-center">
                <div class="column">
                    <a cart-widget-trigger href="{reverse_url name='shop_category_list'}" class="shb-return">
                        {trans}store_theme_translations.continue_shopping_label{/trans}</a>
                </div>
                <div class="column align-right">
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

        <div empty-cart class="shb-mini-products-list-empty align-center{if $cart->item_count != 0} is-hidden{/if}">
            <i class="shb-icon shb-icon-cart-blankslate"></i>
            <p>{trans}store_theme_translations.empty_cart_text{/trans}</p>
            <a href="{reverse_url name='shop_category_list'}">{trans}store_theme_translations.prompt_text{/trans}</a>
        </div>
    </div>
</div>