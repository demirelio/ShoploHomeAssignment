{if $color_pallete->values}
{assign var='pallete' value=[]}
{foreach from=$color_pallete->values item="color" key="i"}
{append var='pallete' value=$color index=$i|lower}
{/foreach}
{/if}

{if $smarty.server.REQUEST_URI|strstr:'properties' || $smarty.server.REQUEST_URI|strstr:'sort' || $settings->show_sidebar_on_load}
{assign filters_active 1}
{else}
{assign filters_active 0}
{/if}
{if isset($page_set) && $page_type != 'search'}
{assign min_price $page_set->price_min|money_without_currency}
{assign max_price $page_set->price_max|money_without_currency}
{/if}

<div class="shb-product-list shb-category">
    <div class="container">
        <header class="shb-list-page-header">
            <div class="columns">
                <div class="column is-12 align-center is-vertical-paddingless">
                    <h1 {if !$settings->show_breadcrumbs}class="without-breadcrumbs"{/if} href="#navListMobile" id="navListMobileToggle">
                        <span>
                        {$showTitle = "{$page_type}_show_title"}
                        {if $settings->{$showTitle}}
                            {if $page_type == 'search'}
                            {trans}store_theme_translations.search_title{/trans}
                            {else}
                            {$page_set->title}
                            {/if}
                        {/if}
                        </span>
                    </h1>
                    {if $page_type == 'category'}
                    {if $settings->category_show_description}
                    <div class="shb-list-page-header-description column is-12-mobile is-8-tablet is-offset-2-tablet is-6-desktop is-offset-3-desktop  is-vertical-paddingless">
                        {if $category->description}
                        {$category->description}
                        {/if}
                    </div>
                    {/if}
                    {elseif $page_type == 'vendor'}
                    {if $settings->vendor_show_description}
                    <div class="shb-list-page-header-description column is-12-mobile is-8-tablet is-offset-2-tablet is-6-desktop is-offset-3-desktop  is-vertical-paddingless">
                        {if $vendor->description}
                        {$vendor->description}
                        {/if}
                    </div>
                    {/if}
                    {elseif $page_type == 'collection'}
                    {if $settings->collection_show_description}
                    <div class="shb-list-page-header-description column is-12-mobile is-8-tablet is-offset-2-tablet is-6-desktop is-offset-3-desktop  is-vertical-paddingless">
                        {if $collection->description}
                        {$collection->description}
                        {/if}
                    </div>
                    {/if}
                    {/if}
                </div>
            </div>
        </header>
        {if $settings->show_breadcrumbs}
            {snippet file="breadcrumbs" center="true"}
        {/if}

        <div class="shb-mobile-filters-wrapper is-hidden-tablet">
            <a href="#filtersMobile" id="filtersMobileToggle" class="shb-btn shb-btn-light shb-btn-large shb-btn-with-icon shb-btn-full-width">
                {trans}store_theme_translations.filter{/trans}
            </a>
            {snippet file="active_filters"}
        </div>

        <div class="container {$grid_class}">
            <div class="columns">
                {if $page_type == 'search'}
                {assign paginateItems ''}
                {else}
                {assign paginateItems $page_set->getProducts()}
                {/if}

                {paginate set=$page_set per_page=$settings->category_1_list_products_count}

                {if $settings->category_1_show_sidebar && $page_type != 'search'}
                {snippet file="sidebar"}
                {/if}
                <div class="column {if category_1_show_sidebar}is-9-tablet{/if} product-list">
                    {assign var="products" value=$items}
                    {if !$products}
                    <p class="align-center">{trans}store_theme_translations.no_products{/trans}</p>
                    {else}
                    <div class="columns is-mobile">
                        {foreach from=$products item="p" name="list"}
                        {$productUrlName = "shop_product_within_$page_type"}
                        {if $page_type == 'search'}
                        {$productUrl = {reverse_url name=shop_product product_name=$p->url}}
                        {elseif $page_type == 'category'}
                        {$productUrl = {reverse_url name=$productUrlName category_name=$page_set->url product_name=$p->url}}
                        {elseif $page_type == 'vendor'}
                        {$productUrl = {reverse_url name=$productUrlName vendor_name=$page_set->url product_name=$p->url}}
                        {elseif $page_type == 'collection'}
                        {$productUrl = {reverse_url name=$productUrlName collection_name=$page_set->url product_name=$p->url}}
                        {/if}
                        <div class="{$product_col_class}">
                            {snippet file="product_view_1" img_with_sidebar=$home_show_sidebar}
                        </div>
                        {/foreach}
                    </div>
                    {/if}
                    {if $pager->is_pagination_need}
                        {snippet file="pagination"}
                    {/if}
                </div>
                {/paginate}
            </div>
        </div>
    </div>
</div>
