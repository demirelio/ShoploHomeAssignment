<div class="container">
    <div class="shb-blog-content">
        <div class="column is-paddingless is-10-tablet is-offset-1-tablet is-8-desktop is-offset-2-desktop">
            <header class="shb-blog-title">
                <h1 class="has-text-weight-bold">{$blog->title}</h1>
            </header>
            {paginate set=$blog per_page={$settings->bloglist_posts_count}}
            {assign var="articles" value=$items}
            {if !$articles}
                <p>
                    {trans}store_theme_translations.blog_no_articles_in_blog{/trans}
                </p>
            {else}
                {foreach from=$articles item="article" name="articles_list"}
                    {if $smarty.foreach.articles_list.index % 2 == 0}<div class="columns">{/if}
                    <div class="column is-6 shb-article">
                        <div class="shb-article-image">
                            {if $article->image}
                                <a href="{reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}">
                                    <img src="{$article->image|article_img_url}" alt="{$article->title} " />
                                </a>
                            {else}
                                <a href="{reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}" class="shb-blankslate-article-image is-vertical-center align-flex-center">
                                    <i class="shb-icon shb-icon-empty-img"></i>
                                </a>
                            {/if}
                        </div>
                        <div class="shb-article-text">
                            <h3><a href="{reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}">{$article->title}</a></h3>
                            <span class="shb-additional-info">{$article->user_first_name}, {$article->published_at|nicedate}</span>
                            <p>{$article->excerpt|strip_tags|truncate:150}</p>
                            <a href="{reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}" class="shb-article-read-more">
                                {trans}store_theme_translations.blog_read_more{/trans}
                            </a>
                        </div>
                    </div>
                {if $smarty.foreach.articles_list.index % 2 != 0}</div><div class="shb-articles-hr"></div>{elseif $smarty.foreach.articles_list.last}</div>{/if}
                {/foreach}

                {if $pager->is_pagination_need}
                <div class="columns">
                    {snippet file="pagination"}
                </div>
                {/if}
            {/if}
            {/paginate}
        </div>
    </div>
</div>
