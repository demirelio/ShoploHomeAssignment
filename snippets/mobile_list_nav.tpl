{if $template != 'home'}
{assign showSidebarSubCategories value="{$template}_1_show_sidebar_subcategories"}
{assign showCollectionsNav value="{$template}_1_show_collections_nav"}
{assign showVendorsNav value="{$template}_1_show_vendors_nav"}
{else}
{assign showSidebarSubCategories value="{$template}_show_sidebar_subcategories"}
{assign showCollectionsNav value="{$template}_show_collections_nav"}
{assign showVendorsNav value="{$template}_show_vendors_nav"}
{/if}

<div id="navListMobile" class="shb-sliding-menu shb-sliding-menu-hide shb-sliding-menu-bottom shb-sliding-menu-light shb-sliding-navigation">
  <div class="shb-sliding-menu-header">
    <h5>{trans}store_theme_translations.navigation{/trans}</h5>
    <a shb-sliding-menu-close-button><i class="shb-icon shb-icon-close-thin"></i></a>
  </div>
  <div class="shb-sliding-menu-contents" shb-sliding-menu-contents>
    <div class="shb-sliding-menu-content shb-menu-content-show" shb-sliding-menu-content="0">
      <ul>
        <li>
          <a shb-sliding-menu-show-submenu="categories-list">{trans}store_theme_translations.categories{/trans} <span class="shb-menu-next"><i class="shb-icon shb-icon-next"></i></span></a>
        </li>
        {if $settings->{$showCollectionsNav}}
        <li>
          <a shb-sliding-menu-show-submenu="collections-list" class="shb-menu-next">{trans}store_theme_translations.collections{/trans} <span class="shb-menu-next"><i class="shb-icon shb-icon-next"></i></span></a>
        </li>
        {/if}
        {if $settings->{$showVendorsNav}}
        <li>
          <a shb-sliding-menu-show-submenu="vendors-list" class="shb-menu-next">{trans}store_theme_translations.vendor{/trans} <span class="shb-menu-next"><i class="shb-icon shb-icon-next"></i></span></a>
        </li>
        {/if}
      </ul>
    </div>

    <div class="shb-sliding-menu-content shb-menu-content-hide" shb-sliding-menu-content="categories-list">
      <ul>
        <li><a shb-sliding-menu-show-submenu="0" class="align-center"><span class="shb-menu-prev"><i class="shb-icon shb-icon-previous"></i></span> {trans}store_theme_translations.categories{/trans}</a></li>
      </ul>
      {$categories->createListView($category->url, 'shb-sidebar-list shb-sidebar-list-categories', 'active')}
    </div>

    {if $settings->{$showCollectionsNav}}
    <div class="shb-sliding-menu-content shb-menu-content-hide" shb-sliding-menu-content="collections-list">
      <ul>
        <li><a shb-sliding-menu-show-submenu="0" class="align-center"><span class="shb-menu-prev"><i class="shb-icon shb-icon-previous"></i></span> {trans}store_theme_translations.collections{/trans}</a></li>
        {foreach from=$collections->all item="collection"}
        <li>
          <a href="{reverse_url name='shop_collection' collection_name=$collection->url}">{$collection->title}</a>
        </li>
        {/foreach}
      </ul>
    </div>
    {/if}
    {if $settings->{$showVendorsNav}}
    <div class="shb-sliding-menu-content shb-menu-content-hide" shb-sliding-menu-content="vendors-list">
      <ul>
        <li><a shb-sliding-menu-show-submenu="0" class="align-center"><span class="shb-menu-prev"><i class="shb-icon shb-icon-previous"></i></span> {trans}store_theme_translations.vendor{/trans}</a></li>
        {foreach from=$shop->vendors item="vendor" name="foo"}
        {if $vendor->title}
        <li>
          <a href="{reverse_url name=shop_vendor vendor_name=$vendor->url}">{$vendor->title}</a>
        </li>
        {/if}
        {/foreach}
      </ul>
    </div>
    {/if}
  </div>
</div>