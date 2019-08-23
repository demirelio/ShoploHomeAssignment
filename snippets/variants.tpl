{assign variants $product->getVariants()}
{assign properties $product->getProperties()}
{assign pallete $color_pallete->values}

{if $product->getVariantsCount() > 0}
<div class="shb-variants">
    {foreach from=$product->getProperties() key="property_name" item="properties" name="loopOuter"}
    {assign settingName value="property_{$property_name|handle}"}
    {assign propertySetting value=$settings->product_properties->{$settingName}}
    {assign propertyClasses value="_"|explode:$propertySetting}
    <div class="shb-variant-option">
        <label for="property{$smarty.foreach.loopOuter.iteration}" class="shb-option-label">{$property_name}</label>
        {if $propertySetting == 'select_small' || $propertySetting == 'select'}
        <select name="{$property_name}" data-property-name="{$property_name}" product-properties class="shb-properties select{if $propertySetting == 'select_small'} shb-select-small{/if}" id="property{$smarty.foreach.loopOuter.iteration}">
            {foreach from=$properties item="value" name="loopInner"}
            <option class="shb-property" value="{$value}" data-property-value="{$value}" id="opt{$smarty.foreach.loopOuter.iteration}{$smarty.foreach.loopInner.iteration}">{$value}</option>
            {/foreach}
        </select>
        {else}
        <ul data-property-name="{$property_name}" class="shb-properties" product-properties>
            {foreach from=$properties item="value" name="loopInner"}
            <li class="shb-property shb-property-{$propertyClasses[0]} shb-property-{$propertyClasses[1]} shb-property-{$propertyClasses[2]} {if $active_value == $value} active{/if} {if ($value|count_characters > 4 || ($propertySetting|strstr:'photo' && !$product->properties_images[$property_name][$value])) && !$pallete[$value]} shb-long-value{/if}{if $propertySetting|strstr:'photo' || $pallete[$value]} has-image{/if}"
                id="opt{$smarty.foreach.loopOuter.iteration}{$smarty.foreach.loopInner.iteration}"
                data-property-name="{$property_name}"
                data-property-value="{$value}">
                {if $propertySetting|strstr:'photo' && $product->properties_images[$property_name][$value]}
                <span><img src="{$product->properties_images[$property_name][$value]}" alt="{$value}"/></span>
                {else}
                {if $pallete[$value]}
                <span style="background: {$pallete[$value]};"></span>
                {else}
                <span>{$value}</span>
                {/if}
                {/if}
            </li>
            {/foreach}
        </ul>
        {/if}
    </div>
    {/foreach}
</div>
{/if}
