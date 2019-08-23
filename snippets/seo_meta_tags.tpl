{assign metaTitle ''}
{assign metaDescription ''}
{assign metaKeywords ''}
{assign translationMetaTemplates ['cart', 'search', 'list_categories', '404']}
{if $template == 'cart'}
    {assign metaTitle "{trans preview-trans=0}store_theme_translations.seo_meta_title_cart{/trans}"|replace:'%shop_name%':$shop->name}
    {assign metaDescription "{trans preview-trans=0}store_theme_translations.seo_meta_description_cart{/trans}"|replace:'%shop_name%':$shop->name}
    {assign metaKeywords "{trans preview-trans=0}store_theme_translations.seo_meta_keywords_cart{/trans}"|replace:'%shop_name%':$shop->name}
{elseif $template == 'search'}
    {assign metaTitle "{trans preview-trans=0}store_theme_translations.seo_meta_title_search_results{/trans}"|replace:'%query%':$query|replace:'%shop_name%':$shop->name}
    {assign metaDescription "{trans preview-trans=0}store_theme_translations.seo_meta_description_search_results{/trans}"|replace:'%shop_name%':$shop->name}
    {assign metaKeywords "{trans preview-trans=0}store_theme_translations.seo_meta_keywords_search_results{/trans}"|replace:'%shop_name%':$shop->name}
{elseif $template == 'list_categories'}
    {assign metaTitle "{trans preview-trans=0}store_theme_translations.seo_meta_title_list_categories{/trans}"|replace:'%shop_name%':$shop->name}
    {assign metaDescription "{trans preview-trans=0}store_theme_translations.seo_meta_description_list_categories{/trans}"|replace:'%shop_name%':$shop->name}
    {assign metaKeywords "{trans preview-trans=0}store_theme_translations.seo_meta_keywords_list_categories{/trans}"|replace:'%shop_name%':$shop->name}
{elseif $template == '404'}
    {assign metaTitle "{trans preview-trans=0}store_theme_translations.seo_meta_title_404{/trans}"|replace:'%shop_name%':$shop->name}
    {assign metaDescription "{trans preview-trans=0}store_theme_translations.seo_meta_description_404{/trans}"|replace:'%shop_name%':$shop->name}
    {assign metaKeywords "{trans preview-trans=0}store_theme_translations.seo_meta_keywords_404{/trans}"|replace:'%shop_name%':$shop->name}
{/if}

{if $template|in_array:$translationMetaTemplates}
    <title>{$metaTitle}</title>
    <meta name="description" content="{$metaDescription}" />
    <meta name="keywords" content="{$metaKeywords}" />
{else}
    <title>{if isset($meta) && $meta->title}{$meta->title}{else}{$shop->name}{/if}</title>
    {if isset($meta)}<meta name="description" content="{$meta->description}" />{/if}
    {if isset($meta)}<meta name="keywords" content="{$meta->keywords}" />{/if}
{/if}

