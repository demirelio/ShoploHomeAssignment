{assign var=langletters value=['ą', 'ć', 'ę', 'ł', 'ś', 'ó', 'ż', 'ź', 'ń', ' ']}
{assign var=letters value=['a', 'c', 'e', 'l', 's', 'o', 'z', 'z', 'n', '_']}
<nav id="mobileMenu" class="shb-mobile-menu shb-sliding-menu shb-sliding-menu-{$settings->choose_mobile_menu_theme} shb-sliding-menu-offcanvas shb-sliding-menu-hide">
    {if $settings->show_searchbox_in_mobile_menu}
    <div class="mobile-search-box">
        <form action="{reverse_url name='shop_search'}" method="get">
            <input type="search" placeholder="{trans preview-trans=0}store_theme_translations.search_placeholder{/trans}" name="q">
            <button type="submit"><i class="shb-icon shb-icon-search"></i></button>
        </form>
    </div>
    {/if}
    <div class="shb-sliding-menu-contents" shb-sliding-menu-contents>
        <div class="shb-sliding-menu-content shb-menu-content-show" shb-sliding-menu-content="0">
            <ul>
                {assign submenus []}
                {assign submenuIndex 0}
                {foreach from=$menulists->main_menu->links item="menu"}
                {assign menu_has_dropdown 0}
                {foreach from=$categories->all() item="cat"}
                {if $cat->url == $menu->url|replace:'/kategoria/':''}
                {if $cat->has_children}
                {assign "childs" $cat->childs}
                {assign  menu_has_dropdown 1}
                {/if}
                {/if}
                {/foreach}
                <li class="nav-item{if $template == 'category' && $category->title == $menu->title} active
                                {elseif $template == 'collection' && ($menu->url|strpos:$collection->url !== false)} active
                                {elseif $template == 'list_categories' && 'Kategorie' == $menu->title} active
                                {elseif isset($page) and $page->url == $menu->url} active
                                {elseif isset($product) and $product_url == $menu->url} active
                                {elseif $template == 'home'}{if $menu->url == '/'} active{/if}{/if}{if $menu_has_dropdown} has-dropdown{/if}">
                    <a href="{$menu->url}">
                        {$menu->title}
                        {if $menulists->{$menu->title|lower|replace:$langletters:$letters}->links|count > 0}
                        {$submenuIndex = $submenuIndex+1}
                        {append var='submenus' value=$menulists->{$menu->title|lower|replace:$langletters:$letters} index=$submenuIndex}
                        <span shb-sliding-menu-show-submenu="{$submenuIndex}" class="shb-menu-next"><i class="shb-icon shb-icon-next"></i></span>
                        {/if}
                    </a>
                </li>
                {/foreach}
            </ul>
        </div>
        {if $submenuIndex > 0}
        {foreach from=$submenus item="subnav" name="submenus"}

        <div class="shb-sliding-menu-content shb-menu-content-hide" shb-sliding-menu-content="{$smarty.foreach.submenus.index + 1}">
            <ul>
                <li><a shb-sliding-menu-show-submenu="0" class="align-center"><span class="shb-menu-prev"><i class="shb-icon shb-icon-previous"></i></span> {$subnav->title}</a></li>
                {foreach from=$subnav->links item="submenu"}
                <li><a href="{$submenu->url}">{$submenu->title}</a></li>
                {/foreach}
            </ul>
        </div>
        {/foreach}
        {/if}
    </div>
    <div class="shb-sliding-menu-bottom-content">
        {if $settings->show_social_icons && ($settings->show_facebook || $settings->show_twitter || $settings->show_pinterest || $settings->show_instagram || $settings->show_youtube)}
        <div class="shb-sliding-menu-social">
            <ul>
                {if $settings->show_facebook}
                <li>
                    <a href="{$settings->facebook_url}" target="_blank" class="shb-icon shb-icon-facebook"></a>
                </li>
                {/if}
                {if $settings->show_twitter}
                <li>
                    <a href="{$settings->twitter_url}" target="_blank" class="shb-icon shb-icon-twitter"></a>
                </li>
                {/if}
                {if $settings->show_pinterest}
                <li>
                    <a href="{$settings->pinterest_url}" target="_blank" class="shb-icon shb-icon-pinterest"></a>
                </li>
                {/if}
                {if $settings->show_instagram}
                <li>
                    <a href="{$settings->instagram_url}" target="_blank" class="shb-icon shb-icon-instagram-circle"></a>
                </li>
                {/if}
                {if $settings->show_youtube}
                    <li>
                        <a href="{$settings->youtube_url}" target="_blank" class="shb-icon shb-icon-youtube-circle"></a>
                    </li>
                {/if}
            </ul>
        </div>
        {/if}
        {if $settings->show_language_switcher}
        <div class="mobile-lang-switcher">
            <select class="select select-small" name="lang" tabindex="0" placeholder="{trans preview-trans=0}store_theme_translations.lang_placeholder{/trans}">
                <option value="0" selected="selected">{trans preview-trans=0}store_theme_translations.lang_placeholder{/trans}</option>
                <option value="{$settings->lang_switcher_1_url}">{$settings->lang_switcher_1_title}</option>
                <option value="{$settings->lang_switcher_2_url}">{$settings->lang_switcher_2_title}</option>
            </select>
        </div>
        {/if}
    </div>
</nav>
