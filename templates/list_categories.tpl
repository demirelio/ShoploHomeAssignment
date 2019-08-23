{assign category_list $categories->all()}

{if $color_pallete->values}
  {assign var='pallete' value=[]}
  {foreach from=$color_pallete->values item="color" key="i"}
    {append var='pallete' value=$color index=$i|lower}
  {/foreach}
{/if}

{if $category_list}
  {foreach from=$category_list item="category"}
    {if $category->top_category && $category->products_count != 0}
    <div class="shb-product-list shb-category product-list">
      <div class="container">
        <header class="shb-list-page-header">
          <div class="columns">
            <div class="column is-12 align-center is-vertical-paddingless">
              <h1><a href="{reverse_url name='shop_category' category_name=$category->url}">{$category->title}</a></h1>
            </div>
          </div>
        </header>
        {if $settings->show_breadcrumbs}
          {snippet file="breadcrumbs" center="true"}
        {/if}
        <!-- ### LIST_CATEGORIES ### --><!-- productgrid_col4_4_1543499187181 -->
{snippet
  file="list_categories_grid"
  grid_class="grid-col4-4"
  set_image_ratio={$settings->product_image_ratio}
  product_col_class="column is-12-mobile is-4-tablet is-3-desktop"
  grid_columns=4
  product_list_show_add_to_cart = {$settings->product_list_show_add_to_cart}
  product_list_show_title = {$settings->product_list_show_title}
  product_list_title_limit = {$settings->product_list_title_limit}
  product_list_show_variants = {$settings->product_list_show_variants}
  product_list_show_variants_on_hover = {$settings->product_list_show_variants_on_hover}
}
<!-- END productgrid_col4_4_1543499187181 -->



      </div>
    </div>
    {/if}
  {/foreach}
{else}
  <div class="container">
    <div class="columns">
      <div class="column">
        <h4>{trans}store_theme_translations.msg_no_categories{/trans}</h4>
      </div>
    </div>
  </div>
{/if}
