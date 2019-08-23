<div class="column is-paddingless is-12-mobile shb-pagination align-{$settings->pagination_align}{if $settings->pagination_show_pages} shb-pagination-show-pages{/if}{if $settings->pagination_show_label} shb-pagination-with-labels{/if}">
    {if $settings->pagination_show_label}
        {$pager|default_pagination:"<i class='shb-icon shb-icon-previous'></i><span>{trans}store_theme_translations.previous{/trans}</span>":"<span>{trans}store_theme_translations.next{/trans}</span><i class='shb-icon shb-icon-next'></i>"}
    {else}
        {$pager|default_pagination:"<i class='shb-icon shb-icon-previous shb-pagination-without-label'></i>":"<i class='shb-icon shb-icon-next shb-pagination-without-label'></i>"}
    {/if}
</div>
