{if $color_pallete->values}
{assign var='pallete' value=[]}
{foreach from=$color_pallete->values item="color" key="i"}
{append var='pallete' value=$color index=$i|lower}
{/foreach}
{/if}

{if $smarty.server.REQUEST_URI|strstr:'properties' || $smarty.server.REQUEST_URI|strstr:'sort' || $settings->category_1_show_sidebar_on_load}
{assign filters_active 1}
{else}
{assign filters_active 0}
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

{if $template != 'home'}
{assign showSidebarSubCategories value="{$template}_1_show_sidebar_subcategories"}
{assign showCollectionsNav value="{$template}_1_show_collections_nav"}
{assign showVendorsNav value="{$template}_1_show_vendors_nav"}
{assign showSidebarFilters value="{$template}_1_show_sidebar_filters"}
{assign showSidebarFiltersProperties value="{$template}_1_show_sidebar_filters_properties"}
{assign showSidebarFiltersVendor value="{$template}_1_show_sidebar_filters_vendor"}
{assign showSidebarFiltersTags value="{$template}_1_show_sidebar_filters_tags"}
{assign showSidebarFiltersSort value="{$template}_1_show_sidebar_filters_sort"}
{assign showSidebarFiltersPrice value="{$template}_1_show_sidebar_filters_price"}
{else}
{assign showSidebarSubCategories value="{$template}_show_sidebar_subcategories"}
{assign showCollectionsNav value="{$template}_show_collections_nav"}
{assign showVendorsNav value="{$template}_show_vendors_nav"}
{/if}

<div id="filtersMobile" class="shb-sliding-menu shb-sliding-menu-hide shb-sliding-menu-bottom shb-sliding-menu-light shb-sliding-navigation">
    <div class="shb-sliding-menu-header">
        <h5>{trans}store_theme_translations.filter{/trans}</h5>
        <a shb-sliding-menu-close-button><i class="shb-icon shb-icon-close-thin"></i></a>
    </div>
    <div class="shb-sliding-menu-contents" shb-sliding-menu-contents>
        <div class="shb-sliding-menu-content shb-menu-content-show" shb-sliding-menu-content="0">
            <ul>
                {if $settings->{$showSidebarFiltersProperties}}
                {foreach from=$properties key=name item=props}
                {if $settings->filters_handle != 'select'}
                <li>
                    <a shb-sliding-menu-show-submenu="filter-property-{$name|escape:'url'}" class="shb-menu-next">{$name} <span class="shb-menu-next"><i class="shb-icon shb-icon-next"></i></span></a>
                </li>
                {else}
                <li>
                    <div class="shb-filters-filter-section shb-filters-filter-property" data-filter-type="filter-property">
                        <header class="shb-sidebar-filters-header">
                            <h4>{$name}</h4>
                            {if $activeProperties[$name]}
                            <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                            {/if}
                        </header>
                        <div class="content">
                            <select name="{$name|replace:' ':''}" id="" data-name="{$name|escape:'url'}" multiple class="select">
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
                </li>
                {/if}
                {/foreach}
                {/if}
                {if $settings->{$showSidebarFiltersPrice} && $min_price !== $max_price}
                <li>
                    <div class="shb-filters-filter-section shb-filters-filter-price">
                        <header class="shb-sidebar-filters-header">
                            <h4>{trans}store_theme_translations.price{/trans}</h4>
                        </header>
                        <div class="shb-filters-price-range" data-price-min="{$min_price}" data-price-max="{$max_price}"
                             data-currency="{$shop->currency|replace:'PLN':'zł'}">
                            <input type="hidden" class="shb-price-range-input"/>
                        </div>
                    </div>
                </li>
                {/if}
                {if $shop->vendors|count != 0 && $settings->{$showSidebarFiltersVendor} && $template != 'vendor'}
                {if $settings->filters_handle != 'select'}
                <li>
                    <a shb-sliding-menu-show-submenu="filter-vendor" class="shb-menu-next">{trans}store_theme_translations.vendor{/trans} <span class="shb-menu-next"><i class="shb-icon shb-icon-next"></i></span></a>
                </li>
                {else}
                <li>
                    <div class="shb-filters-filter-section shb-filters-filter-vendor" data-filter-type="filter-vendor">
                        <header class="shb-sidebar-filters-header">
                            <h4>{trans}store_theme_translations.vendor{/trans}</h4>
                            {if $smarty.server.REQUEST_URI|strstr:'vendor'}
                            <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                            {/if}
                        </header>
                        <select name="vendor" class="select" multiple>
                            {foreach from=$shop->vendors item="vendor" name="list"}
                            {if $smarty.foreach.list.first}
                            <option value="0">{trans}store_theme_translations.vendor{/trans}</option>
                            {/if}
                            {if $vendor->title}
                            <option value="{$vendor->url}">{$vendor->title}</option>
                            {/if}
                            {/foreach}
                        </select>
                    </div>
                </li>
                {/if}
                {/if}
                {if $allTags|count != 0 && $settings->{$showSidebarFiltersTags}}
                <li>
                    <a shb-sliding-menu-show-submenu="filter-tags" class="shb-menu-next">{trans}store_theme_translations.tags{/trans} <span class="shb-menu-next"><i class="shb-icon shb-icon-next"></i></span></a>
                </li>
                {/if}
                {if $settings->{$showSidebarFiltersSort}}
                <li>
                    <a shb-sliding-menu-show-submenu="filter-sort" class="shb-menu-next">{trans}store_theme_translations.sort{/trans} <span class="shb-menu-next"><i class="shb-icon shb-icon-next"></i></span></a>
                </li>
                {/if}

            </ul>
        </div>

        {if $shop->vendors|count != 0 && $settings->{$showSidebarFiltersVendor} && $settings->filters_handle != 'select'}
        <div class="shb-sliding-menu-content shb-menu-content-hide" shb-sliding-menu-content="filter-vendor">
            <ul>
                <li>
                    <a shb-sliding-menu-show-submenu="0" class="align-center"><span class="shb-menu-prev"><i class="shb-icon shb-icon-previous"></i></span> {trans}store_theme_translations.back{/trans}</a>
                </li>
            </ul>
            <div class="shb-filters-filter-section shb-filters-filter-vendor" data-filter-type="filter-vendor">
                <header class="shb-sidebar-filters-header">
                    <h4>{trans}store_theme_translations.vendor{/trans}</h4>
                    {if $smarty.server.REQUEST_URI|strstr:'vendor'}
                    <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                    {/if}
                </header>
                <ul>
                    {foreach from=$shop->vendors item="vendor"}
                    {if $vendor->title}
                    <li>
                        <div class="shb-checkbox shb-checkbox-mobile">
                            <input id="mobileFilters_{$vendor->title|replace:' ':''}" type="checkbox" name="vendor"
                                   value="{$vendor->url}">
                            <label for="mobileFilters_{$vendor->title|replace:' ':''}">{$vendor->title}</label>
                        </div>
                    </li>
                    {/if}
                    {/foreach}
                </ul>
            </div>
        </div>
        {/if}


        {if $allTags|count != 0 && $settings->{$showSidebarFiltersTags}}
        <div class="shb-sliding-menu-content shb-menu-content-hide" shb-sliding-menu-content="filter-tags">
            <ul>
                <li>
                    <a shb-sliding-menu-show-submenu="0" class="align-center"><span class="shb-menu-prev"><i class="shb-icon shb-icon-previous"></i></span> {trans}store_theme_translations.back{/trans}</a>
                </li>
            </ul>
            <div class="shb-filters-filter-section shb-filters-filter-tags" data-filter-type="filter-tags">

                <header class="shb-sidebar-filters-header">
                    <h4>{trans}store_theme_translations.tags{/trans}</h4>
                    {if $activeTags[$name]}
                    <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                    {/if}
                </header>
                {foreach from=$allTags item=tag}
                <div class="shb-checkbox shb-checkbox-mobile">
                    <input id="mobileFilters_{$tag|handle}" type="checkbox" name="{$tag|handle}" value="{$tag|handle}"
                           data-name="" {if $tag|in_array:$activeTags} checked="checked"{/if}>
                    <label for="mobileFilters_{$tag|handle}">{$tag}</label>
                </div>
                {/foreach}
            </div>
        </div>
        {/if}

        {if $settings->{$showSidebarFiltersProperties}}
        {foreach from=$properties key=name item=props}
        {assign var="foo" value=sort($props)}
        {if $name|escape:'url'|lower == 'kolor' || $name|escape:'url'|lower == 'color' || $name|escape:'url'|lower == 'colour'}
        {$color_mode = true}
        {else}
        {$color_mode = false}
        {/if}
        <div class="shb-sliding-menu-content shb-menu-content-hide" shb-sliding-menu-content="filter-property-{$name|escape:'url'}">
            <ul>
                <li>
                    <a shb-sliding-menu-show-submenu="0" class="align-center"><span class="shb-menu-prev"><i class="shb-icon shb-icon-previous"></i></span> {trans}store_theme_translations.back{/trans}</a>
                </li>
            </ul>
            <div data-filter-type="filter-property" class="shb-filters-filter-section shb-filters-filter-property {if $color_mode}color-mode{/if}">
                <header class="shb-sidebar-filters-header">
                    <h4>{$name}</h4>
                    {if $activeProperties[$name]}
                    <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                    {/if}
                </header>
                <div class="{if $color_mode}shb-checkbox-color-group{/if}">
                    {foreach from=$props item=p}
                    {if $p == ""}{continue}{/if}
                    <div class="{if $color_mode}shb-checkbox-color{else}shb-checkbox shb-checkbox-mobile{/if}">
                        <input id="mobileFilters_{$p|replace:' ':''}" type="checkbox"
                               name="{$name|replace:' ':''}" value="{$p}"
                               data-name="{$name|escape:'url'}"
                               data-val="{$p|lower|replace:' ':'_'}">
                        <label for="mobileFilters_{$p|replace:' ':''}">
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
        </div>
        {/foreach}
        {/if}

        {if $settings->{$showSidebarFiltersSort}}
        <div class="shb-sliding-menu-content shb-menu-content-hide" shb-sliding-menu-content="filter-sort">
            <ul>
                <li>
                    <a shb-sliding-menu-show-submenu="0" class="align-center"><span class="shb-menu-prev"><i class="shb-icon shb-icon-previous"></i></span> {trans}store_theme_translations.back{/trans}</a>
                </li>
            </ul>
            <div class="shb-filters-filter-section shb-filters-filter-sort" data-filter-type="filter-sort">
                <header class="shb-sidebar-filters-header">
                    <h4>{trans}store_theme_translations.sort{/trans}</h4>
                    {if $smarty.server.REQUEST_URI|strstr:'sort'}
                    <span class="shb-filters-clear">{trans}store_theme_translations.clear_filter{/trans}</span>
                    {/if}
                </header>
                <div class="shb-checkbox shb-checkbox-mobile">
                    <input id="sort=price" type="checkbox" name="sort=price" value="sort=price"
                           data-name="sort=price">
                    <label for="sort=price">{trans}store_theme_translations.from_cheapest{/trans}</label>
                </div>
                <div class="shb-checkbox shb-checkbox-mobile">
                    <input id="sort=price&order=desc" type="checkbox" name="sort=price&order=desc"
                           value="sort=price&order=desc" data-name="sort=price&order=desc">
                    <label for="sort=price&order=desc">{trans}store_theme_translations.from_most_expensive{/trans}</label>
                </div>
                <div class="shb-checkbox shb-checkbox-mobile">
                    <input id="sort=title" type="checkbox" name="sort=title" value="sort=title"
                           data-name="sort=title">
                    <label for="sort=title">{trans}store_theme_translations.filter_by_name{/trans}</label>
                </div>
                <div class="shb-checkbox shb-checkbox-mobile">
                    <input id="sort=title&order=desc" type="checkbox" name="sort=title&order=desc"
                           value="sort=title&order=desc" data-name="sort=title&order=desc">
                    <label for="sort=title&order=desc">{trans}store_theme_translations.filter_by_name_reverse{/trans}</label>
                </div>
                <div class="shb-checkbox shb-checkbox-mobile">
                    <input id="sort=created_at" type="checkbox" name="sort=created_at"
                           value="sort=created_at" data-name="sort=created_at">
                    <label for="sort=created_at">{trans}store_theme_translations.filter_newest{/trans}</label>
                </div>
                <div class="shb-checkbox shb-checkbox-mobile">
                    <input id="sort=created_at&order=desc" type="checkbox" name="sort=created_at&order=desc"
                           value="sort=created_at&order=desc" data-name="sort=created_at&order=desc">
                    <label for="sort=created_at&order=desc">{trans}store_theme_translations.filter_oldest{/trans}</label>
                </div>
            </div>
        </div>
        {/if}

    </div>
    <div class="shb-sliding-menu-bottom-content">
        {if $template != 'home'}
        <button type="button" class="shb-btn shb-btn-dark shb-btn-large shb-btn-with-icon shb-filters-submit">
            <span class="shb-add-to-cart-button-text">{trans}store_theme_translations.save{/trans}</span>
        </button>
        {/if}
        {if $activeProperties[$name] || $smarty.server.REQUEST_URI|strstr:'vendor' || $activeTags[$name] || $smarty.server.REQUEST_URI|strstr:'price_from'}
        <button type="button" data-href="{$ROOT}{$clearFilters[0]}" class="shb-btn shb-btn-light shb-btn-large shb-btn-with-icon" shb-sliding-menu-close-button>
            <span class="shb-add-to-cart-button-text">{trans}store_theme_translations.clear_all_filters{/trans}</span>
        </button>
        {/if}
    </div>
</div>