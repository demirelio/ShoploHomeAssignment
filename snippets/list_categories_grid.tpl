{assign var="products" value=$category->getProducts({$grid_columns})}

<div class="columns">
  {if !$products}
    <p class="align-center">{trans}store_theme_translations.no_products{/trans}</p>
  {else}
    {foreach from=$products item="p" name="list"}
      <div class="{$product_col_class}">
        {assign var=productUrl value={reverse_url name=shop_product_within_category category_name=$category->url product_name=$p->url}}
        {snippet file="product_view_1" }
      </div>
    {/foreach}
  {/if}
</div>