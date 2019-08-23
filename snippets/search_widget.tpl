<div class="shb-search-top-widget" data-modal-id="search-modal">
	<span search-widget-trigger class="shb-search-widget-close-trigger"><i class="shb-icon shb-icon-close-thin"></i></span>
	<div class="container">
		<div class="columns align-flex-center">
			<div class="column is-10-tablet is-7-desktop">
				<header>
					<h2>{trans}store_theme_translations.search_widget_header{/trans}</h2>
				</header>
				<div search-with-autocompleter class="shb-search-wrapper"
					 data-products-count="{$settings->autocompleter_products_count}" data-products-show-images="{$settings->autocompleter_products_show_images}" data-products-show-vendors="{$settings->autocompleter_products_show_vendors}" data-products-show-price="{$settings->autocompleter_products_show_prices}"
					 data-show-categories="{$settings->autocompleter_show_categories}" data-categories-count="{$settings->autocompleter_categories_count}" data-categories-show-images="{$settings->autocompleter_categories_show_images}"
					 data-show-collections="{$settings->autocompleter_show_collections}" data-collections-count="{$settings->autocompleter_collections_count}" data-collections-show-images="{$settings->autocompleter_collections_show_images}"
					 data-show-vendors="{$settings->autocompleter_show_vendors}" data-vendors-count="{$settings->autocompleter_vendors_count}" data-vendors-show-images="{$settings->autocompleter_vendors_show_images}">
					<form action="{reverse_url name='shop_search'}" method="get" class="shb-form-inline shb-search-form">
						<div class="shb-input-group shb-input-group-with-icon">
							<i class="shb-icon shb-icon-search"></i>
							<input type="search" class="shb-input" placeholder="{trans preview-trans=0}store_theme_translations.search_placeholder{/trans}" aria-label="Search" name="q" {if isset($query)}value="{$query}"{/if} />
						</div>
						<button type="submit" class="shb-btn shb-btn-large shb-btn-dark">{trans}store_theme_translations.search{/trans}</button>
					</form>
					{if $settings->show_search_autocompleter && $shop->hasAccessToLivesearch()}
						<div search-results class="shb-autocompleter-search-results">
							<div class="products">
								<h4 class="shb-autocompleter-title">
									{trans}store_theme_translations.search_products{/trans}
								</h4>
								<div class="shb-autocompleter-items-list">
									<a autocompleter-item href="#" class="columns is-marginless shb-autocompleter-item shb-item-template">
										<div class="column is-paddingless is-8 is-vertical-center">
											<figure class="shb-image is-vertical-center">
												<img src="" alt="">
											</figure>
											<div class="shb-info">
												<h4 class="has-text-weight-semibold shb-name"></h4>
												<span class="shb-vendor"></span>
											</div>
										</div>
										<div class="column is-paddingless is-4 align-flex-right is-vertical-center">
											<p class="has-text-weight-semibold shb-price"></p>
										</div>
									</a>
								</div>
							</div>
							<div class="categories">
								<h4 class="shb-autocompleter-title">
									{trans}store_theme_translations.search_categories{/trans}
								</h4>
								<div class="shb-autocompleter-items-list">
									<a autocompleter-item href="#" class="columns is-marginless shb-autocompleter-item shb-item-template">
										<div class="column is-paddingless is-8 is-vertical-center">
											<figure class="shb-image is-vertical-center">
												<img src="" alt="">
											</figure>
											<div class="shb-info">
												<h4 class="has-text-weight-semibold shb-name"></h4>
											</div>
										</div>
										<div class="column is-paddingless is-4 align-flex-right is-vertical-center">
											<p class="has-text-weight-semibold shb-price"></p>
										</div>
									</a>
								</div>
							</div>
							<div class="collections">
								<h4 class="shb-autocompleter-title">
									{trans}store_theme_translations.search_collections{/trans}
								</h4>
								<div class="shb-autocompleter-items-list">
									<a autocompleter-item href="#" class="columns is-marginless shb-autocompleter-item shb-item-template">
										<div class="column is-paddingless is-8 is-vertical-center">
											<figure class="shb-image is-vertical-center">
												<img src="" alt="">
											</figure>
											<div class="shb-info">
												<h4 class="has-text-weight-semibold shb-name"></h4>
											</div>
										</div>
										<div class="column is-paddingless is-4 align-flex-right is-vertical-center">
											<p class="has-text-weight-semibold shb-price"></p>
										</div>
									</a>
								</div>
							</div>
							<div class="vendors">
								<h4 class="shb-autocompleter-title">
									{trans}store_theme_translations.search_vendors{/trans}
								</h4>
								<div class="shb-autocompleter-items-list">
									<a autocompleter-item href="#" class="columns is-marginless shb-autocompleter-item shb-item-template">
										<div class="column is-paddingless is-8 is-vertical-center">
											<figure class="shb-image is-vertical-center">
												<img src="" alt="">
											</figure>
											<div class="shb-info">
												<h4 class="has-text-weight-semibold shb-name"></h4>
											</div>
										</div>
										<div class="column is-paddingless is-4 align-flex-right is-vertical-center">
											<p class="has-text-weight-semibold shb-price"></p>
										</div>
									</a>
								</div>
							</div>
							<div class="shb-no-results align-center">
								<p>{trans}store_theme_translations.search_no_prods{/trans}</p>
							</div>
						</div>
					{/if}
					<div class="shb-recent-searches is-hidden">
						<h4>{trans}store_theme_translations.recent_searches{/trans}</h4>
						<ul class="shb-list-inline"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>