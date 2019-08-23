{if $smarty.server.REQUEST_URI|strstr:'properties' || $smarty.server.REQUEST_URI|strstr:'vendor' || $activeTags[$name] || $smarty.server.REQUEST_URI|strstr:'price_from' || $smarty.server.REQUEST_URI|strstr:'sort'}
{assign clearFilters "?"|explode:$smarty.server.REQUEST_URI}
<div class="container shb-active-filters">
  <div class="columns">
    <div class="column is-vertical-paddingless">
      <ul class="shb-active-filters-labels shb-list-inline">
        {foreach from=$smarty.get item="prop" name="list" key="name"}
        {if $name == 'properties'}
        {foreach from=$prop item="properties" key="propName"}
        <li>
            <span class="shb-black-label shb-label-with-icon shb-active-filters-remove-filter" data-filter="properties[{$propName}]={$properties}">
                {$properties}
                <i class="shb-icon shb-icon-close"></i>
            </span>
        </li>
        {/foreach}
        {elseif $name == 'vendor'}
        {assign activeFilterVendors value=' '|explode:$smarty.get.vendor}
        {foreach from=$activeFilterVendors item="val"}
        <li>
            <span class="shb-black-label shb-label-with-icon shb-active-filters-remove-filter" data-filter="vendor={$val}">
                {$val}
                <i class="shb-icon shb-icon-close"></i>
            </span>
        </li>
        {/foreach}
        {elseif $name == 'tags'}
        {assign activeFilterTags value=' '|explode:$smarty.get.tags}
        {foreach from=$activeFilterTags item="val"}
        <li>
            <span class="shb-black-label shb-label-with-icon shb-active-filters-remove-filter" data-filter="tags={$val}">
                {$val}
                <i class="shb-icon shb-icon-close"></i>
            </span>
        </li>
        {/foreach}
        {elseif $name == 'price_from'}
        <li>
            <span class="shb-black-label shb-label-with-icon shb-active-filters-remove-filter" data-filter="price">
                Price: {$smarty.get.price_from} {$shop->currency|replace:'PLN':'zł'}  - {$smarty.get.price_to} {$shop->currency|replace:'PLN':'zł'}
                <i class="shb-icon shb-icon-close"></i>
            </span>
        </li>
        {elseif $name == 'sort'}
        <li>
          {if $smarty.get.sort == 'price'}
          <span class="shb-black-label shb-label-with-icon shb-active-filters-remove-filter" data-filter="sort=price{if $smarty.get.order == 'desc'}&order=desc{/if}">
                  {if $smarty.get.order == 'desc'}
                    {trans}store_theme_translations.from_most_expensive{/trans}
                  {else}
                    {trans}store_theme_translations.from_cheapest{/trans}
                  {/if}
                  <i class="shb-icon shb-icon-close"></i>
              </span>
          {elseif $smarty.get.sort == 'title'}
          <span class="shb-black-label shb-label-with-icon shb-active-filters-remove-filter" data-filter="sort=title{if $smarty.get.order == 'desc'}&order=desc{/if}">
                  {if $smarty.get.order == 'desc'}
                    {trans}store_theme_translations.filter_by_name_reverse{/trans}
                  {else}
                    {trans}store_theme_translations.filter_by_name{/trans}
                  {/if}
                  <i class="shb-icon shb-icon-close"></i>
              </span>
          {elseif $smarty.get.sort == 'created_at'}
          <span class="shb-black-label shb-label-with-icon shb-active-filters-remove-filter" data-filter="sort=created_at{if $smarty.get.order == 'desc'}&order=desc{/if}">
                  {if $smarty.get.order == 'desc'}
                    {trans}store_theme_translations.filter_oldest{/trans}
                  {else}
                    {trans}store_theme_translations.filter_newest{/trans}
                  {/if}
                  <i class="shb-icon shb-icon-close"></i>
              </span>
          {/if}
        </li>
        {/if}
        {/foreach}
        <li>
          <a href="{$ROOT}{$clearFilters[0]}"
             class="shb-clear-all-filters">{trans}store_theme_translations.clear_all_filters{/trans}</a>
        </li>
      </ul>
    </div>
  </div>
</div>
{/if}
