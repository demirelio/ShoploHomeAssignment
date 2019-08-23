<div class="container">
	<div class="shb-page-content">
		<div class="column is-paddingless is-10-desktop is-offset-1-desktop">
			<header class="shb-page-title">
				<h1 class="has-text-weight-bold">{$page->title}</h1>
			</header>
			<div class="wysiwyg-content shb-page-wysiwyg-content">
				{if $page->title == 'FAQ'}
				<div class='section'>
					<div class='container'>
						<ul class="faq-accordion">
						  <li>
							<a class="custom-toggle" href="javascript:void(0);">FAQ 1</a>
							<ul class="inner">
							  <p>
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas
								tempus placerat fringilla. Duis a elit et dolor laoreet volutpat.
								Aliquam ultrices mauris id mattis imperdiet. Aenean
							</ul>
						  </li>

						  <li>
							<a class="custom-toggle" href="javascript:void(0);">FAQ 2</a>
							<ul class="inner">
							  <p>
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas
								tempus placerat fringilla. Duis a elit et dolor laoreet volutpat.
								Aliquam ultrices mauris id mattis imperdiet. Aenean
							  </p>
							</ul>
						  </li>

						  <li>
							<a class="custom-toggle" href="javascript:void(0);">FAQ 3</a>
							<ul class="inner">
							  <p>
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas
								tempus placerat fringilla. Duis a elit et dolor laoreet volutpat.
								Aliquam ultrices mauris id mattis imperdiet. Aenean
							  </p>
							</ul>
						  </li>
						</ul>
					</div>
				</div>
				{/if}
				{$page_content}
			</div>
		</div>
	</div>
</div>
