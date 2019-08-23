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

<div class="shb-product-list shb-product-list-3 shb-category">
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
                    <div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 col-sm-12 col-xs-12">
                        {if $vendor->description}
                        {$vendor->description}
                        {/if}
                    </div>
                    {/if}
                    {elseif $page_type == 'collection'}
                    {if $settings->collection_show_description}
                    <div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 col-sm-12 col-xs-12">
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

        <div class="container shb-filters is-hidden-mobile">
            <div class="columns">
                {if $settings->category_3_show_categories_nav}
                <div class="column is-3-tablet">
                    <div class="shb-categories-select">
                        <select name="categories" class="select select-small transparent-label select-url" id="">
                            {foreach from=$categories->all item="cat"}
                            <option value="{reverse_url name=shop_category category_name=$cat->url}" {if $category->title == $cat->title}selected="selected"{/if}>{$cat->title}</option>
                            {if $cat->childs}
                            {foreach from=$cat->childs item="child"}
                            <optgroup>
                                <option value="{reverse_url name=shop_category category_name=$child->url}">{$child->title}</option>
                                {if $child->childs}
                                {foreach from=$child->childs item="childOfChilds"}
                                <optgroup>
                                    <option value="{reverse_url name=shop_category category_name=$childOfChilds->url}">{$childOfChilds->title}</option>
                                </optgroup>
                                {/foreach}
                                {/if}
                            </optgroup>
                            {/foreach}
                            {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>
                {/if}
                {if $template == 'category' && $settings->category_3_show_filters_properties}
                    {if $template == 'category' && $settings->category_3_show_filters_properties}
                    {foreach from=$page_set->properties key=name item=props name="filter_props"}
                    {if $smarty.foreach.filter_props.index < 15}
                    {assign var="foo" value=sort($props)}
                    <div class="column is-3-tablet">
                        <div class="shb-filters-filter-section shb-filters-filter-property"  data-filter-type="filter-property">
                            <select name="{$name|replace:' ':''}" data-name="{$name|escape:'url'}" class="select select-small transparent-label">
                                {foreach from=$props item=p name=list}
                                {if $smarty.foreach.list.first}
                                <option value="0">{$name}</option>
                                {/if}
                                {if $p == ""}{continue}{/if}
                                <option value="{$p}" data-val="{$p|lower|replace:' ':'_'}">{$p}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    {/if}
                    {/foreach}
                    {/if}
                {/if}
                {if $settings->category_3_show_filters_sort}
                <div class="column is-3-tablet">
                    <section class="shb-filters-filter-section shb-filters-filter-sort"  data-filter-type="filter-sort">
                        <select class="select select-small transparent-label" name="sort">
                            <option value="0">{trans}store_theme_translations.sort{/trans}</option>
                            <option value="sort=price">{trans}store_theme_translations.from_cheapest{/trans}</option>
                            <option value="sort=price&order=desc">{trans}store_theme_translations.from_most_expensive{/trans}</option>
                            <option value="sort=title">{trans}store_theme_translations.filter_by_name{/trans}</option>
                            <option value="sort=title&order=desc">{trans}store_theme_translations.filter_by_name_reverse{/trans}</option>
                        </select>
                    </section>
                </div>
                {/if}
            </div>
        </div>
        <div class="is-hidden-mobile">
            {snippet file="active_filters"}
        </div>

        <div class="shb-mobile-filters-wrapper is-hidden-tablet">
            <a href="#filtersMobile" id="filtersMobileToggle" class="shb-btn shb-btn-light shb-btn-large shb-btn-with-icon shb-btn-full-width">
                {trans}store_theme_translations.filter{/trans}
            </a>
            {snippet file="active_filters"}
        </div>

        <div class="container {$grid_class}">
            <div class="columns">
                {paginate set=$page_set per_page=$settings->category_3_list_products_count}
                <div class="column product-list">
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
                </div>
            </div>
            {if $pager->is_pagination_need}
                {snippet file="pagination"}
            {/if}
            {/paginate}
        </div>
    </div>
</div>
