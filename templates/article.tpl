<div class="container">
	<div class="shb-article-content">
		<div class="column is-paddingless is-8-tablet is-offset-2-tablet is-6-desktop is-offset-3-desktop">
			<header class="shb-article-title">
				<h1>{$article->title}</h1>
				<span class="shb-article-additional-info">{$article->user_first_name}, {$article->published_at|nicedate}</span>
			</header>
			{if $article->image}
				<div class="shb-article-image">
					<img src="{$article->image|article_img_url}" alt="{$article->title} " />
				</div>
			{/if}
			<div class="shb-article-wysiwyg-content wysiwyg-content">
				{$article->content}
			</div>
			{if $article->tags|@count != 0}
				<div class="shb-article-tags">
					<ul class="shb-list-inline">
						{foreach from=$article->tags item=tag}
							<li>{$tag|link_to_tag:$tag}</li>
						{/foreach}
					</ul>
				</div>
			{/if}
			<div class="shb-article-comments">
				{$article->getBlog()->comment_script}
			</div>
		</div>
	</div>
</div>
