{assign var=langletters value=['ą', 'ć', 'ę', 'ł', 'ś', 'ó', 'ż', 'ź', 'ń', ' ']}
{assign var=letters value=['a', 'c', 'e', 'l', 's', 'o', 'z', 'z', 'n', '_']}
<div id="mobileNav" class="is-hidden-tablet columns is-marginless is-mobile">
  <div class="column align-flex-center is-vertical-center">
    <a href="#mobileMenu" id="navToggle" aria-label="Menu"><i class="shb-icon shb-icon-hamburger"></i></a>
  </div>
  {if $shop->customer_accounts_enabled}
    <div class="column align-flex-center is-vertical-center">
      <a href="{reverse_url name=shop_client_login}" aria-label="Account"><i class="shb-icon shb-icon-account"></i></a>
    </div>
  {/if}
  <div class="column align-flex-center is-vertical-center shb-cart-widget shb-cart-widget-mobile">
    <a {if $settings->show_sliding_cart_widget && $template != 'cart'}cart-widget-trigger{/if} href="{reverse_url name='shop_cart'}" class="shb-cart-icon-wrapper">
      <span cart-widget-total-count class="shb-cart-widget-total-count">{$cart->item_count}</span>
      <i class="shb-icon shb-icon-cart-with-items"></i>
    </a>
  </div>
</div>
<nav id="mainNav" class="is-hidden-mobile">
  <ul class="shb-list-inline">
    {foreach from=$menulists->main_menu->links item="menu"}
      <li class="shb-nav-item{if ($template == 'category') && $menu->url|strpos:$category->url !== false} active
      {elseif $template == 'collection' && ($menu->url|strpos:$collection->url !== false)} active
      {elseif $template == 'list_categories' && ($menu->url|strpos:'/all' != false || $menu->url|strpos:'/wszystkie' != false)} active
      {elseif isset($page) and $page->url == $menu->url} active
      {elseif isset($product) and $product_url == $menu->url} active
      {elseif $template == 'home'}{if $menu->url == '/'} active{/if}{/if}">
        <a href="{$menu->url}">{$menu->title}</a>
        {if $menulists->{$menu->title|lower|replace:$langletters:$letters}->links|count > 0}
          <ul class="shb-submenu shb-list-block">
            {foreach $menulists->{$menu->title|lower|replace:$langletters:$letters}->links item="submenu"}
              <li><a href="{$submenu->url}">{$submenu->title}</a></li>
            {/foreach}
          </ul>
        {/if}
      </li>
    {/foreach}
  </ul>
</nav>
