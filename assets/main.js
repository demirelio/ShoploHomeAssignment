var m,
  MAIN = {
    settings: {
      windowHandler: $(window),
      select: $(".select"),
      navToggle: $("#navToggle"),
      stickyBar: $(".sticky-bar"),
      filtersContainer: $(".shb-filters"),
      mobileFiltersContainer: $("#filtersMobile"),
      langSwitcher: $(".shb-lang-widget select"),
      mobileNav: $("#mobileMenu"),
      mobileLangSwitcher: $(".mobile-lang-switcher select"),
      newsletterForm: $(".shb-newsletter-form"),
      infoBar: $("body").find(".shb-info-bar"),
      searchForm: $("body").find(".shb-search-top-widget"),
      body: $("body"),
      tabs: $("[shb-tabs]")
    },

    init: function() {
      m = this.settings;
      this.windowLoadHandler();
      this.bindUIActions();
    },

    windowLoadHandler: function() {
      if ($("#cartSummary").length) {
        Shop.cartHandler = $("#cartSummary").cartOptions({
          showFreeShippingInfo: cart_free_delivery_show,
          showDefaultDeliveryCost: cart_delivery_cost_show,
          products: "[cart-product]:not(.shb-item-template)"
        });
      } else {
        if ($("#minicartSummary").length) {
          Shop.cartHandler = $("#minicartSummary").cartOptions({
            isDynamic: useDynamicCart,
            dynamicCartType: dynamicCartType,
            showFreeShippingInfo: cart_free_delivery_show,
            showDefaultDeliveryCost: cart_delivery_cost_show,
            products: "[cart-product]:not(.shb-item-template)",
            quantityInput: "[product-quantity]",
            priceText: "[product-price]",
            cartPrice: "[sum-price] span",
            productAddDone: function() {
              if (
                typeof UpSellAppProduct !== "undefined" &&
                typeof upSellData !== "undefined"
              ) {
                if (upSellData.ajaxCart == true) {
                  UpSellAppProduct.checkForCampaign();
                }
              }
            }
          });
        }
      }

      if (m.mobileNav.length) {
        MAIN.mobileMenuInit();
      }

      if (m.select.length) {
        MAIN.selectricInit(m.select);
      }

      if (m.filtersContainer.length) {
        if (m.windowHandler.width() < 767) {
          m.filtersContainer = m.mobileFiltersContainer;
        }
        var filterProperties = false,
          filterVendor = false,
          filterTags = false,
          filterPrice = false,
          filterSort = false,
          filterPropertiesWrapper = m.filtersContainer.find(
            ".shb-filters-filter-property"
          ),
          filterVendorWrapper = m.filtersContainer.find(
            ".shb-filters-filter-vendor"
          ),
          filterTagsWrapper = m.filtersContainer.find(
            ".shb-filters-filter-tags"
          ),
          filterSortWrapper = m.filtersContainer.find(
            ".shb-filters-filter-sort"
          ),
          filterPriceWrapper = m.filtersContainer.find(
            ".shb-filters-filter-price"
          ),
          filterPropertiesHandler,
          filterVendorHandler,
          filterTagsHandler,
          filterSortHandler,
          filterPriceHandler;

        if (filterPropertiesWrapper.length) {
          filterProperties = true;
          if (filterPropertiesWrapper.find("select").length) {
            filterPropertiesHandler = "select";
          } else {
            filterPropertiesHandler = "shb-checkbox";
          }
        }
        if (filterVendorWrapper.length) {
          filterVendor = true;
          if (filterVendorWrapper.find("select").length) {
            filterVendorHandler = "select";
          } else {
            filterVendorHandler = "shb-checkbox";
          }
        }
        if (filterTagsWrapper.length) {
          filterTags = true;
          if (filterTagsWrapper.find("select").length) {
            filterTagsHandler = "select";
          } else {
            filterTagsHandler = "shb-checkbox";
          }
        }
        if (filterSortWrapper.length) {
          filterSort = true;
          if (filterSortWrapper.find("select").length) {
            filterSortHandler = "select";
          } else {
            filterSortHandler = "shb-checkbox";
          }
        }
        if (filterPriceWrapper.length) {
          filterPrice = true;
          if (filterPriceWrapper.find("select").length) {
            filterPriceHandler = "select";
          } else if (filterPriceWrapper.find("shb-checkbox").length) {
            filterPriceHandler = "shb-checkbox";
          } else {
            filterPriceHandler = "slider-range";
          }
        }

        m.filtersContainer.productFilters({
          filterProperties: filterProperties,
          filterVendor: filterVendor,
          filterPrice: filterPrice,
          filterSort: filterSort,
          filterTags: filterTags,
          filterPropertiesHandler: filterPropertiesHandler,
          filterVendorHandler: filterVendorHandler,
          filterTagsHandler: filterTagsHandler,
          filterSortHandler: filterSortHandler,
          filterPriceHandler: filterPriceHandler
        });
      }

      if (m.infoBar.length) {
        if (document.cookie.indexOf("isInfoBarClosed") < 0) {
          m.infoBar.addClass("active");

          if (m.infoBar.attr("data-autoclose") === "1") {
            setTimeout(function() {
              MAIN.hideInfoBar();
            }, parseInt(m.infoBar.attr("data-autoclose-time")) * 1000);
          }
        }
      }

      if (m.searchForm.length > 0) {
        MAIN.getRecentSearch();
        if ($.fn.autocompleter) {
          MAIN.autocompleterInit(m.searchForm);
        }
      }

      if (m.tabs) {
        MAIN.tabs();
      }

      if (window.location.hash) {
        var tab = $('[shb-tabs-tab][href="' + window.location.hash + '"]');
        if (tab.length) {
          tab.trigger("click");
        }
      }
      if (m.windowHandler.width() < 767) {
        if ($("#filtersMobile").length) {
          $("#filtersMobile").shbSlidingMenu({
            position: "bottom"
          });
        }

        if ($("#navListMobile").length) {
          $("#navListMobile").shbSlidingMenu({
            position: "bottom"
          });
        }
      }

      return false;
    },

    bindUIActions: function() {
      if (!m.mobileNav.length) {
        MAIN.navToggleInit();
      }

      m.langSwitcher.change(function() {
        MAIN.changeLang(this);
      });

      m.mobileLangSwitcher.on("change", function() {
        window.location = m.body
          .find(".mobile-lang-switcher select")
          .find("option:selected")
          .val();
      });

      if (m.stickyBar.length) {
        m.windowHandler.scroll(function() {
          MAIN.stickMenu();
        });
      }

      if (m.newsletterForm.length) {
        this.checkNewsletterClause();
      }

      if (m.infoBar.length) {
        m.infoBar.find(".shb-info-bar-close").on("click", function() {
          MAIN.hideInfoBar();
        });
      }

      m.body.on("click", ".shb-recent-searches li", function() {
        MAIN.chooseRecentSearch(
          $(this)
            .parents(".shb-search-wrapper")
            .find("form"),
          $(this).text()
        );
      });

      m.body.on("submit", ".shb-search-top-widget form", function(e) {
        if (!$(this).hasClass("ready-to-submit")) {
          e.preventDefault();
          $(this).addClass("ready-to-submit");
          MAIN.addToRecentSearch(
            $(this),
            $(this)
              .find('input[type="search"]')
              .val()
          );
        }
      });

      m.body.on("click", "[search-widget-trigger]", function(e) {
        e.preventDefault();
        m.searchForm.toggleClass("active");
      });

      $(document).click(function(e) {
        if (
          !$(e.target).is(".shb-search-top-widget") &&
          !$(e.target)
            .parents()
            .is(".shb-search-top-widget") &&
          !$(e.target).parent(".shb-search-widget-trigger").length
        ) {
          $(".shb-search-top-widget").removeClass("active");
        }
      });
    },

    hideInfoBar: function() {
      m.infoBar.removeClass("active");
      var date = new Date(),
        expires = "";

      date.setTime(date.getTime() + 7 * 24 * 60 * 60 * 1000);
      expires = "; expires=" + date.toGMTString();
      document.cookie = "isInfoBarClosed=1;" + expires + "; path=/";
    },

    selectricInit: function(select) {
      select.selectric({
        disableOnMobile: true,
        nativeOnMobile: true
      });
    },

    autocompleterInit: function(autocompleterHandler) {
      var searchWithAutocompleter = autocompleterHandler.find(
        "[search-with-autocompleter]"
      );

      autocompleterHandler.autocompleter({
        productsCount: parseInt(
          searchWithAutocompleter.attr("data-products-count")
        ),
        showVendorWithProduct: parseInt(
          searchWithAutocompleter.attr("data-products-show-vendors")
        ),
        productsShowImage: parseInt(
          searchWithAutocompleter.attr("data-products-show-images")
        ),
        productsShowPrice: parseInt(
          searchWithAutocompleter.attr("data-products-show-price")
        ),
        showCategories: parseInt(
          searchWithAutocompleter.attr("data-show-categories")
        ),
        categoriesCount: parseInt(
          searchWithAutocompleter.attr("data-categories-count")
        ),
        categoriesShowImages: parseInt(
          searchWithAutocompleter.attr("data-categories-show-images")
        ),
        showCollections: parseInt(
          searchWithAutocompleter.attr("data-show-collections")
        ),
        collectionsCount: parseInt(
          searchWithAutocompleter.attr("data-collections-count")
        ),
        collectionsShowImages: parseInt(
          searchWithAutocompleter.attr("data-collections-show-images")
        ),
        showVendors: parseInt(
          searchWithAutocompleter.attr("data-show-vendors")
        ),
        vendorsCount: parseInt(
          searchWithAutocompleter.attr("data-vendors-count")
        ),
        vendorsShowImages: parseInt(
          searchWithAutocompleter.attr("data-vendors-show-images")
        )
      });
    },

    navToggleInit: function() {
      m.navToggle.on("click", function(e) {
        e.preventDefault();
        m.mobileNav.toggle();
      });
    },

    mobileMenuInit: function() {
      m.mobileNav.shbSlidingMenu();
    },

    getRecentSearch: function() {
      var recentSearches = localStorage.getItem("recentSearches"),
        $recentSearchesWrapper = m.body.find(".shb-recent-searches");

      if (recentSearches) {
        $recentSearchesWrapper.removeClass("is-hidden");
        recentSearches = recentSearches.split("#SR#");
        recentSearches = recentSearches.reverse();
        for (var i = 0; i < recentSearches.length; i++) {
          $recentSearchesWrapper
            .find("ul")
            .append("<li>" + recentSearches[i] + "</li>");
        }
      }
    },

    addToRecentSearch: function($form, query) {
      var recentSearches = localStorage.getItem("recentSearches"),
        max = 5;
      if ($.trim(query) !== "") {
        if (recentSearches) {
          recentSearches = recentSearches.split("#SR#");
          if (recentSearches.indexOf(query) > -1) {
            recentSearches.splice(recentSearches.indexOf(query), 1);
          }
          if (recentSearches.length + 1 > max) {
            recentSearches.splice(0, 1);
          }
          recentSearches.push(query);
          recentSearches = recentSearches.join("#SR#");
          localStorage.setItem("recentSearches", recentSearches);
        } else {
          recentSearches = query;
          localStorage.setItem("recentSearches", recentSearches);
        }
      }
      $form.submit();
    },

    chooseRecentSearch: function($form, query) {
      $form.find('input[type="search"]').val(query);
      $form.submit();
    },

    changeLang: function(lang) {
      window.location = lang.value;
    },

    stickMenu: function() {
      var afterStickHeight = $(".unsticky-after-this").outerHeight() || 0,
        afterContainerHeight = $(".sticky-after-this").outerHeight(),
        fromTop = m.windowHandler.scrollTop();
      if (fromTop >= afterContainerHeight + afterStickHeight) {
        m.stickyBar.addClass("is-sticky");
        $("body").css("padding-top", afterContainerHeight);
      } else if (fromTop <= afterStickHeight) {
        m.stickyBar.removeClass("is-sticky");
        $("body").css("padding-top", 0);
      }
    },

    checkNewsletterClause: function() {
      m.newsletterForm.find('[type="submit"]').on("click", function(e) {
        var checkboxWrapper = $(this)
          .parents("form")
          .find(".shb-checkbox")
          .parent();
        if (
          checkboxWrapper.find("input").length > 0 &&
          !checkboxWrapper.find("input").is(":checked")
        ) {
          if (checkboxWrapper.find(".shb-error-alert").length <= 0) {
            var errorAlert = checkboxWrapper
              .find("input")
              .attr("data-required-text");
            checkboxWrapper.prepend(
              '<p class="shb-error-alert">' + errorAlert + "</p>"
            );
          }
          return false;
        }
      });
      m.newsletterForm.find(".shb-checkbox input").on("change", function() {
        var checkboxWrapper = $(this)
          .parents("form")
          .find(".shb-checkbox")
          .parent();
        if ($(this).is(":checked")) {
          checkboxWrapper.find("p.shb-error-alert").remove();
        }
      });
    },

    tabs: function() {
      $("[shb-tabs]").on("click", "[shb-tabs-tab]", function() {
        var tabId = $(this).attr("href"),
          tabs = $(this).closest("[shb-tabs]");

        tabs.find("li").removeClass("is-active");
        $(this)
          .parent("li")
          .addClass("is-active");

        tabs
          .find("[shb-tabs-content]:visible")
          .fadeOut("fast", "linear", function() {
            tabs.find(tabId).fadeIn("fast", "linear");
          });
      });
    }
  };

var ShbNotification = {
  settings: {
    shopMessageWrapper: $("#shbNotification"),
    shopMessage: $("#shopMessage")
  },
  init: function() {
    n = this.settings;

    n.shopMessage.bind("DOMNodeInserted", function() {
      ShbNotification.showShopMessage();
    });

    if (n.shopMessage.find("p").length) {
      ShbNotification.showShopMessage();
    }
  },
  showShopMessage: function(text, type) {
    if ($.trim(n.shopMessage.text()) == "" && text && type) {
      n.shopMessage.prepend('<p class="' + type + '">' + text + "</p>");
      n.shopMessageWrapper.addClass(type);
    }
    setTimeout(function() {
      n.shopMessageWrapper.removeAttr("class");
      n.shopMessage.html("");
    }, 3500);
  }
};

Shop.shbNotification = ShbNotification;

var ShbCategoryDropdown = {
  settings: {
    categoryTitleWrapper: $(".shb-categories-list-inline .categories>li")
  },
  init: function() {
    c = this.settings;
    ShbCategoryDropdown.createDropdownButton();
  },
  createDropdownButton: function() {
    c.categoryTitleWrapper.each(function() {
      var $this = $(this);
      if ($this.children("ul.submenu").length) {
        $this.addClass("shb-category-has-children");
      }
    });
  }
};

$(function() {
  MAIN.init();
  ShbNotification.init();
  if ($(".shb-categories-list-inline").length) {
    ShbCategoryDropdown.init();
  }
});

/*to-do-6*/
$(window).on("load", function() {
  if (localStorage.isOpen != "true") {
    setTimeout(() => {
      $("#overlay")
        .fadeIn(300)
        .delay(5000)
        .fadeOut(300);
    }, 5000);
    localStorage.setItem("isOpen", "true");
  } else {
    console.log("Hope you enjoyed what you have seen so far :)");
  }
});

/*to-do-7*/
/*This is the one I spent most of my time to figure out but I think my javascrip object knowledge is not enough to figure this out
First thing is I couldn't find the original function which fires the slider. I checked all the files 3 time but couldn't find it. Then I tried to do something by myself.
My idea was hiding the description, listening the change on the dom when the slide moves and then show the description 1s later. I tried change(). But it only works on input elements.
Then i tried bind('DOMSubtreeModified') but this fires when there is change in the subtree. It seems slider doesn't change the subtree. I feel really frustrated because I failed with the 7
I hope they won't affect your decision. I hope you still consider my application.
*/

/*to-do-8*/
var oldValue = $(".shb-new-price span").text();
oldValue = parseFloat(oldValue);

function customInputs(oldValue) {
  $("#custom-input")
    .keyup(function() {
      var customValue = $(this).val().length * 5;
      var newValue = customValue + oldValue;
      $(".shb-new-price span").text(newValue.toFixed(2) + " zł");
    })
    .keyup();
}
customInputs(oldValue);

/*to-do-9*/
$(".custom-toggle").click(function(e) {
  e.preventDefault();

  var $this = $(this);

  if ($this.next().hasClass("show")) {
    $this.next().removeClass("show");
    $this.next().slideUp(300);
  } else {
    $this
      .parent()
      .parent()
      .find("li .inner")
      .removeClass("show");
    $this
      .parent()
      .parent()
      .find("li .inner")
      .slideUp(300);
    $this.next().toggleClass("show");
    $this.next().slideToggle(300);
  }
});

/*to-do-10*/
var $content = $("#todo-base").text();
var $underscoreContent = $content.replace(/ /g, "_");
$("#todoUnderscore").text($underscoreContent);
$("#todoPolishChar").text(removeDiacritics($content));

function removeDiacritics(str) {
  var diacriticsMap = {
    A: /[\u0041\u24B6\uFF21\u00C0\u00C1\u00C2\u1EA6\u1EA4\u1EAA\u1EA8\u00C3\u0100\u0102\u1EB0\u1EAE\u1EB4\u1EB2\u0226\u01E0\u00C4\u01DE\u1EA2\u00C5\u01FA\u01CD\u0200\u0202\u1EA0\u1EAC\u1EB6\u1E00\u0104\u023A\u2C6F]/g,
    AA: /[\uA732]/g,
    AE: /[\u00C6\u01FC\u01E2]/g,
    AO: /[\uA734]/g,
    AU: /[\uA736]/g,
    AV: /[\uA738\uA73A]/g,
    AY: /[\uA73C]/g,
    B: /[\u0042\u24B7\uFF22\u1E02\u1E04\u1E06\u0243\u0182\u0181]/g,
    C: /[\u0043\u24B8\uFF23\u0106\u0108\u010A\u010C\u00C7\u1E08\u0187\u023B\uA73E]/g,
    D: /[\u0044\u24B9\uFF24\u1E0A\u010E\u1E0C\u1E10\u1E12\u1E0E\u0110\u018B\u018A\u0189\uA779]/g,
    DZ: /[\u01F1\u01C4]/g,
    Dz: /[\u01F2\u01C5]/g,
    E: /[\u0045\u24BA\uFF25\u00C8\u00C9\u00CA\u1EC0\u1EBE\u1EC4\u1EC2\u1EBC\u0112\u1E14\u1E16\u0114\u0116\u00CB\u1EBA\u011A\u0204\u0206\u1EB8\u1EC6\u0228\u1E1C\u0118\u1E18\u1E1A\u0190\u018E]/g,
    F: /[\u0046\u24BB\uFF26\u1E1E\u0191\uA77B]/g,
    G: /[\u0047\u24BC\uFF27\u01F4\u011C\u1E20\u011E\u0120\u01E6\u0122\u01E4\u0193\uA7A0\uA77D\uA77E]/g,
    H: /[\u0048\u24BD\uFF28\u0124\u1E22\u1E26\u021E\u1E24\u1E28\u1E2A\u0126\u2C67\u2C75\uA78D]/g,
    I: /[\u0049\u24BE\uFF29\u00CC\u00CD\u00CE\u0128\u012A\u012C\u0130\u00CF\u1E2E\u1EC8\u01CF\u0208\u020A\u1ECA\u012E\u1E2C\u0197]/g,
    J: /[\u004A\u24BF\uFF2A\u0134\u0248]/g,
    K: /[\u004B\u24C0\uFF2B\u1E30\u01E8\u1E32\u0136\u1E34\u0198\u2C69\uA740\uA742\uA744\uA7A2]/g,
    L: /[\u004C\u24C1\uFF2C\u013F\u0139\u013D\u1E36\u1E38\u013B\u1E3C\u1E3A\u0141\u023D\u2C62\u2C60\uA748\uA746\uA780]/g,
    LJ: /[\u01C7]/g,
    Lj: /[\u01C8]/g,
    M: /[\u004D\u24C2\uFF2D\u1E3E\u1E40\u1E42\u2C6E\u019C]/g,
    N: /[\u004E\u24C3\uFF2E\u01F8\u0143\u00D1\u1E44\u0147\u1E46\u0145\u1E4A\u1E48\u0220\u019D\uA790\uA7A4]/g,
    NJ: /[\u01CA]/g,
    Nj: /[\u01CB]/g,
    O: /[\u004F\u24C4\uFF2F\u00D2\u00D3\u00D4\u1ED2\u1ED0\u1ED6\u1ED4\u00D5\u1E4C\u022C\u1E4E\u014C\u1E50\u1E52\u014E\u022E\u0230\u00D6\u022A\u1ECE\u0150\u01D1\u020C\u020E\u01A0\u1EDC\u1EDA\u1EE0\u1EDE\u1EE2\u1ECC\u1ED8\u01EA\u01EC\u00D8\u01FE\u0186\u019F\uA74A\uA74C]/g,
    OI: /[\u01A2]/g,
    OO: /[\uA74E]/g,
    OU: /[\u0222]/g,
    P: /[\u0050\u24C5\uFF30\u1E54\u1E56\u01A4\u2C63\uA750\uA752\uA754]/g,
    Q: /[\u0051\u24C6\uFF31\uA756\uA758\u024A]/g,
    R: /[\u0052\u24C7\uFF32\u0154\u1E58\u0158\u0210\u0212\u1E5A\u1E5C\u0156\u1E5E\u024C\u2C64\uA75A\uA7A6\uA782]/g,
    S: /[\u0053\u24C8\uFF33\u1E9E\u015A\u1E64\u015C\u1E60\u0160\u1E66\u1E62\u1E68\u0218\u015E\u2C7E\uA7A8\uA784]/g,
    T: /[\u0054\u24C9\uFF34\u1E6A\u0164\u1E6C\u021A\u0162\u1E70\u1E6E\u0166\u01AC\u01AE\u023E\uA786]/g,
    TZ: /[\uA728]/g,
    U: /[\u0055\u24CA\uFF35\u00D9\u00DA\u00DB\u0168\u1E78\u016A\u1E7A\u016C\u00DC\u01DB\u01D7\u01D5\u01D9\u1EE6\u016E\u0170\u01D3\u0214\u0216\u01AF\u1EEA\u1EE8\u1EEE\u1EEC\u1EF0\u1EE4\u1E72\u0172\u1E76\u1E74\u0244]/g,
    V: /[\u0056\u24CB\uFF36\u1E7C\u1E7E\u01B2\uA75E\u0245]/g,
    VY: /[\uA760]/g,
    W: /[\u0057\u24CC\uFF37\u1E80\u1E82\u0174\u1E86\u1E84\u1E88\u2C72]/g,
    X: /[\u0058\u24CD\uFF38\u1E8A\u1E8C]/g,
    Y: /[\u0059\u24CE\uFF39\u1EF2\u00DD\u0176\u1EF8\u0232\u1E8E\u0178\u1EF6\u1EF4\u01B3\u024E\u1EFE]/g,
    Z: /[\u005A\u24CF\uFF3A\u0179\u1E90\u017B\u017D\u1E92\u1E94\u01B5\u0224\u2C7F\u2C6B\uA762]/g,
    a: /[\u0061\u24D0\uFF41\u1E9A\u00E0\u00E1\u00E2\u1EA7\u1EA5\u1EAB\u1EA9\u00E3\u0101\u0103\u1EB1\u1EAF\u1EB5\u1EB3\u0227\u01E1\u00E4\u01DF\u1EA3\u00E5\u01FB\u01CE\u0201\u0203\u1EA1\u1EAD\u1EB7\u1E01\u0105\u2C65\u0250]/g,
    aa: /[\uA733]/g,
    ae: /[\u00E6\u01FD\u01E3]/g,
    ao: /[\uA735]/g,
    au: /[\uA737]/g,
    av: /[\uA739\uA73B]/g,
    ay: /[\uA73D]/g,
    b: /[\u0062\u24D1\uFF42\u1E03\u1E05\u1E07\u0180\u0183\u0253]/g,
    c: /[\u0063\u24D2\uFF43\u0107\u0109\u010B\u010D\u00E7\u1E09\u0188\u023C\uA73F\u2184]/g,
    d: /[\u0064\u24D3\uFF44\u1E0B\u010F\u1E0D\u1E11\u1E13\u1E0F\u0111\u018C\u0256\u0257\uA77A]/g,
    dz: /[\u01F3\u01C6]/g,
    e: /[\u0065\u24D4\uFF45\u00E8\u00E9\u00EA\u1EC1\u1EBF\u1EC5\u1EC3\u1EBD\u0113\u1E15\u1E17\u0115\u0117\u00EB\u1EBB\u011B\u0205\u0207\u1EB9\u1EC7\u0229\u1E1D\u0119\u1E19\u1E1B\u0247\u025B\u01DD]/g,
    f: /[\u0066\u24D5\uFF46\u1E1F\u0192\uA77C]/g,
    g: /[\u0067\u24D6\uFF47\u01F5\u011D\u1E21\u011F\u0121\u01E7\u0123\u01E5\u0260\uA7A1\u1D79\uA77F]/g,
    h: /[\u0068\u24D7\uFF48\u0125\u1E23\u1E27\u021F\u1E25\u1E29\u1E2B\u1E96\u0127\u2C68\u2C76\u0265]/g,
    hv: /[\u0195]/g,
    i: /[\u0069\u24D8\uFF49\u00EC\u00ED\u00EE\u0129\u012B\u012D\u00EF\u1E2F\u1EC9\u01D0\u0209\u020B\u1ECB\u012F\u1E2D\u0268\u0131]/g,
    j: /[\u006A\u24D9\uFF4A\u0135\u01F0\u0249]/g,
    k: /[\u006B\u24DA\uFF4B\u1E31\u01E9\u1E33\u0137\u1E35\u0199\u2C6A\uA741\uA743\uA745\uA7A3]/g,
    l: /[\u006C\u24DB\uFF4C\u0140\u013A\u013E\u1E37\u1E39\u013C\u1E3D\u1E3B\u017F\u0142\u019A\u026B\u2C61\uA749\uA781\uA747]/g,
    lj: /[\u01C9]/g,
    m: /[\u006D\u24DC\uFF4D\u1E3F\u1E41\u1E43\u0271\u026F]/g,
    n: /[\u006E\u24DD\uFF4E\u01F9\u0144\u00F1\u1E45\u0148\u1E47\u0146\u1E4B\u1E49\u019E\u0272\u0149\uA791\uA7A5]/g,
    nj: /[\u01CC]/g,
    o: /[\u006F\u24DE\uFF4F\u00F2\u00F3\u00F4\u1ED3\u1ED1\u1ED7\u1ED5\u00F5\u1E4D\u022D\u1E4F\u014D\u1E51\u1E53\u014F\u022F\u0231\u00F6\u022B\u1ECF\u0151\u01D2\u020D\u020F\u01A1\u1EDD\u1EDB\u1EE1\u1EDF\u1EE3\u1ECD\u1ED9\u01EB\u01ED\u00F8\u01FF\u0254\uA74B\uA74D\u0275]/g,
    oi: /[\u01A3]/g,
    ou: /[\u0223]/g,
    oo: /[\uA74F]/g,
    p: /[\u0070\u24DF\uFF50\u1E55\u1E57\u01A5\u1D7D\uA751\uA753\uA755]/g,
    q: /[\u0071\u24E0\uFF51\u024B\uA757\uA759]/g,
    r: /[\u0072\u24E1\uFF52\u0155\u1E59\u0159\u0211\u0213\u1E5B\u1E5D\u0157\u1E5F\u024D\u027D\uA75B\uA7A7\uA783]/g,
    s: /[\u0073\u24E2\uFF53\u015B\u1E65\u015D\u1E61\u0161\u1E67\u1E63\u1E69\u0219\u015F\u023F\uA7A9\uA785\u1E9B]/g,
    ss: /[\u00DF]/g,
    t: /[\u0074\u24E3\uFF54\u1E6B\u1E97\u0165\u1E6D\u021B\u0163\u1E71\u1E6F\u0167\u01AD\u0288\u2C66\uA787]/g,
    tz: /[\uA729]/g,
    u: /[\u0075\u24E4\uFF55\u00F9\u00FA\u00FB\u0169\u1E79\u016B\u1E7B\u016D\u00FC\u01DC\u01D8\u01D6\u01DA\u1EE7\u016F\u0171\u01D4\u0215\u0217\u01B0\u1EEB\u1EE9\u1EEF\u1EED\u1EF1\u1EE5\u1E73\u0173\u1E77\u1E75\u0289]/g,
    v: /[\u0076\u24E5\uFF56\u1E7D\u1E7F\u028B\uA75F\u028C]/g,
    vy: /[\uA761]/g,
    w: /[\u0077\u24E6\uFF57\u1E81\u1E83\u0175\u1E87\u1E85\u1E98\u1E89\u2C73]/g,
    x: /[\u0078\u24E7\uFF58\u1E8B\u1E8D]/g,
    y: /[\u0079\u24E8\uFF59\u1EF3\u00FD\u0177\u1EF9\u0233\u1E8F\u00FF\u1EF7\u1E99\u1EF5\u01B4\u024F\u1EFF]/g,
    z: /[\u007A\u24E9\uFF5A\u017A\u1E91\u017C\u017E\u1E93\u1E95\u01B6\u0225\u0240\u2C6C\uA763]/g
  };
  for (var x in diacriticsMap) {
    str = str.replace(diacriticsMap[x], x);
  }
  return str;
}
