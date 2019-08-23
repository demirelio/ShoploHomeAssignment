{if $collections->{$settings->frontpage_collection}}
  {assign frontpage_collection $collections->{$settings->frontpage_collection}}
{/if}

{if $frontpage_collection}
  {assign var="products" value=$frontpage_collection->getProducts($settings_frontpage_collection_products_count)}
{/if}

{if $color_pallete->values}
  {$pallete = []}
  {foreach from=$color_pallete->values item="color" key="i"}
    {append var='pallete' value=$color index=$i|lower}
  {/foreach}
{/if}

<div class="container {$grid_class}">
  <div class="columns">
    {if $home_show_sidebar}
      {snippet
        file="sidebar"
        home_show_sidebar_subcategories = $home_show_sidebar_subcategories
        home_show_categories_nav = $home_show_categories_nav
        home_show_collections_nav = $home_show_collections_nav
        home_show_vendors_nav = $home_show_vendors_nav
      }
    {/if}
    <div class="column {if $home_show_sidebar}is-9-desktop{/if} shb-product-list">
      {if !$products && $frontpage_collection}
        <p class="align-center">{trans}store_theme_translations.no_products{/trans}</p>
      {else}
        <div class="columns is-mobile">
          {foreach from=$products item="p" name="list"}
          {$productUrl = {reverse_url name=shop_product_within_collection collection_name=$frontpage_collection->url
          product_name=$p->url}}
          <div class="{$product_col_class}">
            {snippet file="product_view_1" img_with_sidebar=$home_show_sidebar}
          </div>
          {/foreach}
        </div>
      {/if}
    </div>
  </div>
</div>
