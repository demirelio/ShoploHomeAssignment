{if $color_pallete->values}
{assign var='pallete' value=[]}
{foreach from=$color_pallete->values item="color" key="i"}
{append var='pallete' value=$color index=$i|lower}
{/foreach}
{/if}

{if isset($category)}
{assign min_price $category->price_min|money_without_currency}
{assign max_price $category->price_max|money_without_currency}
{assign activeProperties value=$category->active_properties}
{assign properties value=$category->properties}
{assign allTags value=$category->all_tags}
{assign activeTags value=$category->active_tags}
{elseif isset($collection)}
{assign min_price $collection->price_min|money_without_currency}
{assign max_price $collection->price_max|money_without_currency}
{assign activeProperties value=$collection->active_properties}
{assign properties value=$collection->properties}
{assign allTags value=$collection->all_tags}
{assign activeTags value=$collection->active_tags}
{elseif isset($vendor)}
{assign min_price $vendor->price_min|money_without_currency}
{assign max_price $vendor->price_max|money_without_currency}
{assign activeProperties value=$vendor->active_properties}
{assign properties value=$vendor->properties}
{assign allTags value=$vendor->all_tags}
{assign activeTags value=$vendor->active_tags}
{/if}

{assign clearFilters "?"|explode:$smarty.server.REQUEST_URI}

{assign showSidebarSubCategories value="{$template}_1_show_sidebar_subcategories"}
{assign showCollectionsNav value="{$template}_1_show_collections_nav"}
{assign showVendorsNav value="{$template}_1_show_vendors_nav"}
{assign showSidebarFilters value="{$template}_1_show_sidebar_filters"}
{assign showSidebarFiltersProperties value="{$template}_1_show_sidebar_filters_properties"}
{assign showSidebarFiltersVendor value="{$template}_1_show_sidebar_filters_vendor"}
{assign showSidebarFiltersTags value="{$template}_1_show_sidebar_filters_tags"}
{assign showSidebarFiltersSort value="{$template}_1_show_sidebar_filters_sort"}
{assign showSidebarFiltersPrice value="{$template}_1_show_sidebar_filters_price"}
{assign showSidebarOnLoad value="{$template}_1_show_sidebar_on_load"}
{if $smarty.server.REQUEST_URI|strstr:'properties' || $smarty.server.REQUEST_URI|strstr:'sort' || $settings->{$showSidebarOnLoad} == '1'}
{assign filters_active 1}
{else}
{assign filters_active 0}
{/if}


{if $template == 'category' || $template == 'collection' || $template == 'vendor'}
<div class="shb-sidebar column is-3-tablet is-hidden-touch">
    <div class="shb-sidebar-list-section {if $settings->{$showSidebarSubCategories}}show-subcategories{/if}">
        <h4>{trans}store_theme_translations.categories{/trans}</h4>
        {$categories->createListView($category->url, 'shb-sidebar-list shb-sidebar-list-categories custom-flex', 'active')}

        {if $settings->{$showCollectionsNav}}
        <h4>{trans}store_theme_translations.collections{/trans}</h4>
        <ul class="shb-sidebar-list">
            {foreach from=$collections->all item="collection"}
            <li>
                <a href="{reverse_url name='shop_collection' collection_name=$collection->url}">{$collection->title}</a>
            </li>
            {/foreach}
        </ul>
        {/if}

        {if $settings->{$showVendorsNav}}
        <h4>{trans}store_theme_translations.vendor{/trans}</h4>
        <ul class="shb-sidebar-list">
            {foreach from=$shop->vendors item="vendor" name="foo"}
            <li>
                <a href="{reverse_url name=shop_vendor vendor_name=$vendor->url}">{$vendor->title}</a>
            </li>
            {/foreach}
        </ul>
        {/if}
    </div>
    {if $settings->{$showSidebarFilters}}
    <div class="shb-filters shb-sidebar-filters">
        <header class="shb-sidebar-filters-header shb-sidebar-filters-header-main">
            <a href="#filtersContent" data-filters-container="shb-filters-sidebar-content"
               class="shb-toggle-filters {if $filters_active == 0} collapsed{/if}">{trans}store_theme_translations.filter{/trans}
            </a>
            <span class="shb-filters-clear-all">
         <a href="{$ROOT}{$clearFilters[0]}">{trans}store_theme_translations.clear_all_filters{/trans}</a>
         </span>
        </header>
        <div class="shb-filters-sidebar-content{if $filters_active == 0} shb-collapse{/if}" {if $filters_active == 0} style="display: none"{/if}">
        {if $settings->{$showSidebarFiltersProperties}}
        {foreach from=$properties key=name item=props}
        {assign var="foo" value=sort($props)}
        {if $name|escape:'url'|lower == 'kolor' || $name|escape:'url'|lower == 'color' || $name|escape:'url'|lower
        == 'colour'}
        {$color_mode = true}
        {else}
        {$color_mode = false}
        {/if}
        {if $settings->filters_handle != 'select'}
        <div data-filter-type="filter-property"
             class="shb-filters-filter-section shb-filters-filter-property {if $color_mode}color-mode{/if}">
            <header class="shb-sidebar-filters-header">
                <h4>{$name}</h4>
                {if $activeProperties[$name]}
                <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                {/if}
            </header>
            <div class="{if $color_mode}shb-checkbox-color-group{/if}">
                {foreach from=$props item=p}
                {if $p == ""}{continue}{/if}
                <div class="{if $color_mode}shb-checkbox-color{else}shb-checkbox{/if}">
                    <input id="{$p|replace:' ':''}" type="checkbox"
                           name="{$name|replace:' ':''}" value="{$p}"
                           data-name="{$name|escape:'url'}"
                           data-val="{$p|lower|replace:' ':'_'}">
                    <label for="{$p|replace:' ':''}">
                        {if $color_mode}
                        <span title="{$p}">
                            <span style="background: {$pallete[$p|lower]};"></span>
                        </span>
                        {else}
                        <span>{$p}</span>
                        {/if}
                    </label>
                </div>
                {/foreach}
            </div>
        </div>
        {else}
        <div class="shb-filters-filter-section shb-filters-filter-property"
             data-filter-type="filter-property">
            <header class="shb-sidebar-filters-header">
                <h4>{$name}</h4>
                {if $activeProperties[$name]}
                <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                {/if}
            </header>
            <div class="content">
                <select name="{$name|replace:' ':''}" id="" data-name="{$name|escape:'url'}"
                        class="select">
                    {foreach from=$props item=p name=list}
                    {if $smarty.foreach.list.first}
                    <option value="0">{trans}store_theme_translations.filter{/trans}</option>
                    {/if}
                    {if $p == ""}{continue}{/if}
                    <option value="{$p}"
                            data-val="{$p|lower|replace:' ':'_'}">{$p}
                    </option>
                    {/foreach}
                </select>
            </div>
        </div>
        {/if}
        {/foreach}
        {/if}
        <!-- vendor filter -->
        {if $shop->vendors|count != 0 && $settings->{$showSidebarFiltersVendor} && $template != 'vendor'}
        <div class="shb-filters-filter-section shb-filters-filter-vendor" data-filter-type="filter-vendor">
            <header class="shb-sidebar-filters-header">
                <h4>{trans}store_theme_translations.vendor{/trans}</h4>
                {if $smarty.server.REQUEST_URI|strstr:'vendor'}
                <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                {/if}
            </header>
            {if $settings->filters_handle != 'select'}
            {foreach from=$shop->vendors item="vendor"}
            {if $vendor->title}
            <div class="shb-checkbox">
                <input id="{$vendor->title|replace:' ':''}" type="checkbox" name="vendor"
                       value="{$vendor->url}">
                <label for="{$vendor->title|replace:' ':''}">{$vendor->title}</label>
            </div>
            {/if}
            {/foreach}
            {else}
            <select name="vendor" id="" class="select">
                {foreach from=$shop->vendors item="vendor" name="list"}
                {if $smarty.foreach.list.first}
                <option value="0">{trans}store_theme_translations.vendor{/trans}</option>
                {/if}
                {if $vendor->title}
                <option value="{$vendor->url}">{$vendor->title}</option>
                {/if}
                {/foreach}
            </select>
            {/if}
        </div>
        {/if}
        <!-- end vendor filter -->
        <!-- Tags filter -->
        {if $allTags|count != 0 && $settings->{$showSidebarFiltersTags}}
        <div class="shb-filters-filter-section shb-filters-filter-tags" data-filter-type="filter-tags">
            <header class="shb-sidebar-filters-header">
                <h4>{trans}store_theme_translations.tags{/trans}</h4>
                {if $activeTags[$name]}
                <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                {/if}
            </header>
            {foreach from=$allTags item=tag}
            <div class="shb-checkbox">
                <input id="{$tag|handle}" type="checkbox" name="{$tag|handle}" value="{$tag|handle}"
                       data-name="" {if $tag|in_array:$activeTags} checked="checked"{/if}>
                <label for="{$tag|handle}">{$tag}</label>
            </div>
            {/foreach}
        </div>
        {/if}
        <!-- end tags filter -->
        <!-- sort filter -->
        {if $settings->{$showSidebarFiltersSort}}
        <section class="shb-filters-filter-section shb-filters-filter-sort" data-filter-type="filter-sort">
            <header class="shb-sidebar-filters-header">
                <h4>{trans}store_theme_translations.sort{/trans}</h4>
                {if $smarty.server.REQUEST_URI|strstr:'sort'}
                <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                {/if}
            </header>
            <div class="shb-checkbox">
                <input id="sort=price" type="checkbox" name="sort=price" value="sort=price"
                       data-name="sort=price">
                <label for="sort=price">{trans}store_theme_translations.from_cheapest{/trans}</label>
            </div>
            <div class="shb-checkbox">
                <input id="sort=price&order=desc" type="checkbox" name="sort=price&order=desc"
                       value="sort=price&order=desc" data-name="sort=price&order=desc">
                <label for="sort=price&order=desc">{trans}store_theme_translations.from_most_expensive{/trans}</label>
            </div>
            <div class="shb-checkbox">
                <input id="sort=title" type="checkbox" name="sort=title" value="sort=title"
                       data-name="sort=title">
                <label for="sort=title">{trans}store_theme_translations.filter_by_name{/trans}</label>
            </div>
            <div class="shb-checkbox">
                <input id="sort=title&order=desc" type="checkbox" name="sort=title&order=desc"
                       value="sort=title&order=desc" data-name="sort=title&order=desc">
                <label for="sort=title&order=desc">{trans}store_theme_translations.filter_by_name_reverse{/trans}</label>
            </div>
            <div class="shb-checkbox">
                <input id="sort=created_at" type="checkbox" name="sort=created_at"
                       value="sort=created_at" data-name="sort=created_at">
                <label for="sort=created_at">{trans}store_theme_translations.filter_newest{/trans}</label>
            </div>
            <div class="shb-checkbox">
                <input id="sort=created_at&order=desc" type="checkbox" name="sort=created_at&order=desc"
                       value="sort=created_at&order=desc" data-name="sort=created_at&order=desc">
                <label for="sort=created_at&order=desc">{trans}store_theme_translations.filter_oldest{/trans}</label>
            </div>
        </section>
        {/if}
        <!-- end sort filter -->
        <!-- price filter -->
        {if $settings->{$showSidebarFiltersPrice} && $min_price !== $max_price}
        <div class="shb-filters-filter-section shb-filters-filter-price">
            <header class="shb-sidebar-filters-header">
                <h4>{trans}store_theme_translations.price{/trans}</h4>
                {if $smarty.server.REQUEST_URI|strstr:'price_from'}
                <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                {/if}
            </header>
            <div class="shb-filters-price-range" data-price-min="{$min_price}" data-price-max="{$max_price}"
                 data-currency="{$shop->currency|replace:'PLN':'zł'}">
                <input type="hidden" class="shb-price-range-input"/>
            </div>
        </div>
        {/if}
        <!-- end price filter -->
    </div>
</div>
{/if}
</div>
{elseif $template == 'home'}
<div class="shb-sidebar column is-3-tablet is-hidden-touch">
    <div class="shb-sidebar-list-section {if $home_show_sidebar_subcategories}show-subcategories{/if}">
        {if home_show_categories_nav}
        <h4>{trans}store_theme_translations.categories{/trans}</h4>
        {$categories->createListView($categories->url, 'shb-sidebar-list shb-sidebar-list-categories', 'active')}
        {/if}
        {if $home_show_collections_nav}
        <h4>{trans}store_theme_translations.collections{/trans}</h4>
        <ul class="shb-sidebar-list">
            {foreach from=$collections->all item="collection"}
            <li>
                <a href="{reverse_url name='shop_collection' collection_name=$collection->url}">{$collection->title}</a>
            </li>
            {/foreach}
        </ul>
        {/if}
        {if $home_show_vendors_nav}
        <h4>{trans}store_theme_translations.vendor{/trans}</h4>
        <ul class="shb-sidebar-list">
            {foreach from=$shop->vendors item="vendor" name="foo"}
            <li>
                <a href="{reverse_url name=shop_vendor vendor_name=$vendor->url}">{$vendor->title}</a>
            </li>
            {/foreach}
        </ul>
        {/if}
    </div>
</div>
{/if}
