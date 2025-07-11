// Parent Class
/datum/brewing_product/
    var/reagent_to_brew = "ethanol"         // The item that is brewed
    var/display_name = "unnamed"            // The name displayed in-game
    var/prerequisite = null                 // Another brewed item needed to make this (optional)
    var/list/needed_crops = list()          // Crops needed for the recipe
    var/list/needed_chems = list()          // Chems needed for the recipe
    var/price_tag_setter = 0                // The price of the item
    var/brew_timer = 1                      // The time it takes to brew the item
    var/brewed_amount = 1                   // Amount of the brewed item that is made
    var/bottled_brew_amount = 30            // How much of the item is in the bottle (unsure on this)
    var/other_name                          // In-game name of any alternate brew items (byproducts)
    var/alt_brew_item                       // Byproduct item
    var/alt_brew_item_amount                // Amount of the byproduct item produced
    var/info_helper                         // Extra information line
    var/holy = FALSE                        // Can be produced by people with a working implanted cruciform

// Beers
/datum/brewing_product/beer
    reagent_to_brew = "beer"
    display_name = "Beer"
    needed_crops = list("wheat" = 40, "poppy" = 5)
    needed_chems = list("water" = 60)
    price_tag_setter = 1750
    brew_timer = 2 MINUTES
    brewed_amount = 12
    info_helper = "Further brewing can be done with this item."

/datum/brewing_product/sleepy_beer          // #TODO-MIRAI - Change this to sleepybeer
    reagent_to_brew = "beer2"               // #TODO-MIRAI - Change this to sleepybeer
    display_name = "Sleepy Beer"
    prerequisite = "beer"
    needed_crops = list("wheat" = 10, "poppy" = 5)
    needed_chems = list("water" = 60, "chloralhydrate" = 5)
    price_tag_setter = 2250
    brew_timer = 2 MINUTES
    brewed_amount = 2

/datum/brewing_product/ale
    reagent_to_brew = "ale"
    display_name = "Ale"
    needed_crops = list("wheat" = 60, "towercap" = 5, "poppy" = 5)
    needed_chems = list("water" = 120, "honey" = 5)
    price_tag_setter = 2000
    brew_timer = 14 MINUTES
    brewed_amount = 12

// Liquors
/datum/brewing_product/melonliquor
    reagent_to_brew = "melonliquor"
    display_name = "Melon Liquor"
    needed_crops = list("watermelon" = 80, "towercap" = 15, "poppy" = 35)
    needed_chems = list("water" = 160)
    price_tag_setter = 2000
    brew_timer = 6 MINUTES
    brewed_amount = 2

/datum/brewing_product/bluecuracao
    reagent_to_brew = "bluecuracao"
    display_name = "Blue Curacao"
    needed_crops = list("orange" = 80, "towercap" = 15, "poppy" = 35)
    needed_chems = list("water" = 160)
    price_tag_setter = 2100
    brew_timer = 8 MINUTES
    brewed_amount = 2

// Wines
/datum/brewing_product/wine
    reagent_to_brew = "wine"
    display_name = "Wine"
    needed_crops = list("grapes" = 80, "towercap" = 5)
    needed_chems = list("water" = 160, "sugar"= 15)
    price_tag_setter = 3000
    brew_timer = 6 MINUTES
    brewed_amount = 2
    info_helper = "Further brewing can be done with this item."

/datum/brewing_product/vermouth
    reagent_to_brew = "vermouth"
    display_name = "Vermouth"
    prerequisite = "wine"
    needed_crops = list("grass" = 60, "towercap" = 15, "blueberries" = 30)
    needed_chems = list("water" = 160)
    price_tag_setter = 3500
    brew_timer = 8 MINUTES
    brewed_amount = 3

/datum/brewing_product/pwine                // #TODO-MIRAI - Change this to fungalwine
    reagent_to_brew = "pwine"               // #TODO-MIRAI - Change this to fungalwine
    display_name = "Fungal Wine (Poison)"
    prerequisite = "wine"
    needed_crops = list("grapes" = 10, "towercap" = 5, "plumphelmet" = 5)
    needed_chems = list("amatoxin" = 15)
    price_tag_setter = 4000
    brew_timer = 16 MINUTES
    brewed_amount = 1

/datum/brewing_product/redcandyliquor       // #TODO-MIRAI - Change this to redcandywine
    reagent_to_brew = "redcandyliquor"      // #TODO-MIRAI - Change this to redcandywine
    display_name = "Red Candy Wine"
    prerequisite = "wine"
    needed_crops = list("grapes" = 10, "sunflowers" = 5, "harebells" = 5)
    needed_chems = list("sugar" = 15)
    price_tag_setter = 4000
    brew_timer = 16 MINUTES
    brewed_amount = 1

// Rums
/datum/brewing_product/rum
    reagent_to_brew = "rum"
    display_name = "Rum"
    needed_crops = list("sugarcane" = 60, "towercap" = 5)
    needed_chems = list("water" = 120, "sodiumchloride" = 5)
    price_tag_setter = 2000
    brew_timer = 7 MINUTES
    brewed_amount = 4
    info_helper = "Further brewing can be done with this item."

/datum/brewing_product/deadrum
    reagent_to_brew = "deadrum"
    display_name = "Deadrum (Seawater Rum)"
    prerequisite = "rum"
    needed_crops = list("sugarcane" = 30, "towercap" = 15)
    needed_chems = list("water" = 60, "sodiumchloride" = 60)
    price_tag_setter = 5000
    brew_timer = 10 MINUTES
    brewed_amount = 2
    info_helper = "Further brewing can be done with this item."

/datum/brewing_product/nanatsunoumi
    reagent_to_brew = "nanatsunoumi"
    display_name = "Nanatsunoumi"
    prerequisite = "deadrum"
    needed_crops = list("rice" = 30, "towercap" = 15, "poppy" = 5)
    needed_chems = list("water" = 80)
    price_tag_setter = 8000
    brew_timer = 20 MINUTES
    brewed_amount = 3

/datum/brewing_product/kahlua
    reagent_to_brew = "kahlua"
    display_name = "Kahlua"
    prerequisite = "rum"
    needed_crops = list("gelthi" = 40, "cinnamon" = 5)
    needed_chems = list("water" = 30, "sugar" = 30)
    price_tag_setter = 3000
    brew_timer = 3 MINUTES
    brewed_amount = 3

// Schnapps
/datum/brewing_product/schnapps             // #TODO-MIRAI - Make a normal schnapps which this will use as a prerequisite
    reagent_to_brew = "schnapps"            // Then make this into cinnamonschnapps. Needs sprites too
    display_name = "Cinnamon Schnapps (Kros Style)"
    needed_crops = list("berries" = 40, "strawberries" = 40, "towercap" = 5, "cinnamon" = 5)
    needed_chems = list("water" = 160, "sugar"= 35)
    price_tag_setter = 1200
    brew_timer = 5 MINUTES
    brewed_amount = 4
    info_helper = "Further brewing can be done with this item."

/datum/brewing_product/goldschlager
    reagent_to_brew = "goldschlager"
    display_name = "Goldschlager"
    prerequisite = "schnapps"
    needed_crops = list("berries" = 40, "goldapple" = 5, "cinnamon" = 55)
    needed_chems = list("water" = 10)
    price_tag_setter = 6500
    brew_timer = 20 MINUTES
    brewed_amount = 4

// Vodka
/datum/brewing_product/vodka
    reagent_to_brew = "vodka"
    display_name = "Vodka"
    needed_crops = list("potato" = 30, "corn" = 15)
    needed_chems = list("water" = 80)
    price_tag_setter = 1000
    brew_timer = 1 MINUTES
    brewed_amount = 4
    info_helper = "Further brewing can be done with this item."

/datum/brewing_product/ethanol
    reagent_to_brew = "ethanol"
    display_name = "Ethanol"
    prerequisite = "vodka"
    needed_crops = list("corn" = 30)
    needed_chems = list("water" = 30)
    price_tag_setter = 1500
    brew_timer = 5 MINUTES
    brewed_amount = 3
    info_helper = "Further brewing can be done with this item."

/datum/brewing_product/absinthe
    reagent_to_brew = "absinthe"
    display_name = "Absinthe"
    prerequisite = "ethanol"
    needed_crops = list("towercap" = 120, "maidengrass" = 5, "moon tear" = 30)
    needed_chems = list("water" = 230)
    price_tag_setter = 12000
    brew_timer = 60 MINUTES
    brewed_amount = 1
    bottled_brew_amount = 50

/datum/brewing_product/Kvass                // #TODO-MIRAI - Make this and the reagent to brew lowercase (also in prerequisites)
    reagent_to_brew = "Kvass"
    display_name = "Kvass"
    prerequisite = "vodka"
    needed_crops = list("wheat" = 30)
    needed_chems = list("water" = 200)
    price_tag_setter = 1200
    brew_timer = 3 MINUTES
    brewed_amount = 3
    info_helper = "Further brewing can be done with this item."

/datum/brewing_product/glucose
    reagent_to_brew = "glucose"
    display_name = "Glucose"
    prerequisite = "Kvass"
    needed_crops = list("wheat" = 60, "corn" = 30)
    needed_chems = list("water" = 30, "sugar" = 30, "honey" = 5)
    price_tag_setter = 4750
    brew_timer = 12 MINUTES
    brewed_amount = 1
    bottled_brew_amount = 5
    info_helper = "Further brewing can be done with this item."

// Spirits
/datum/brewing_product/gin
    reagent_to_brew = "gin"
    display_name = "Gin"
    needed_crops = list("berries" = 40, "lemon" = 40, "towercap" = 5, "cinnamon" = 25)
    needed_chems = list("water" = 160, "sugar"= 15)
    price_tag_setter = 3200
    brew_timer = 9 MINUTES
    brewed_amount = 3

/datum/brewing_product/tequilla
    reagent_to_brew = "tequilla"
    display_name = "Tequilla"
    needed_crops = list("lime" = 40, "lemon" = 40, "towercap" = 5, "pineapple" = 10)
    needed_chems = list("water" = 50, "sodiumchloride"= 5)
    price_tag_setter = 2250
    brew_timer = 3 MINUTES
    brewed_amount = 2

/datum/brewing_product/patron
    reagent_to_brew = "patron"
    display_name = "Patron"
    needed_crops = list("wheat" = 80,  "mint" = 30)
    needed_chems = list("water" = 30)
    price_tag_setter = 2000
    brew_timer = 15 MINUTES
    brewed_amount = 1

/datum/brewing_product/whiskey
    reagent_to_brew = "whiskey"
    display_name = "Whiskey"
    needed_crops = list("wheat" = 40, "towercap" = 5)
    needed_chems = list("water" = 120)
    price_tag_setter = 2000
    brew_timer = 20 MINUTES
    brewed_amount = 10

/datum/brewing_product/fernet
    reagent_to_brew = "fernet"
    display_name = "Fernet"
    needed_crops = list("mint" = 20, "thaadra" = 20, "harebells" = 5)
    needed_chems = list("water" = 60)
    price_tag_setter = 1500
    brew_timer = 15 MINUTES
    brewed_amount = 1

// Food
/datum/brewing_product/vinegar
    reagent_to_brew = "vinegar"
    display_name = "Vinegar"
    prerequisite = "wine"
    needed_crops = list("apple" = 20, "pineapple" = 30)
    needed_chems = list("water" = 30)
    price_tag_setter = 2500
    brew_timer = 15 MINUTES
    brewed_amount = 3
    info_helper = "Further brewing can be done with this item."

/datum/brewing_product/soysauce
    reagent_to_brew = "soysauce"
    display_name = "Soy Sauce"
    prerequisite = "vinegar"
    needed_crops = list("wheat" = 20, "soybeans" = 30, "plumphelmet" = 2)
    needed_chems = list("water" = 30, "sodiumchloride" = 30)
    price_tag_setter = 2750
    brew_timer = 5 MINUTES
    brewed_amount = 3

/datum/brewing_product/enzyme
    reagent_to_brew = "enzyme"
    display_name = "Universal Enzyme"
    prerequisite = "vinegar"
    needed_crops = list("mint" = 20, "pineapple" = 30, "grass" = 120, "orange" = 30)
    needed_chems = list("water" = 30, "ethanol" = 60)
    price_tag_setter = 7500
    brew_timer = 15 MINUTES
    brewed_amount = 1

/datum/brewing_product/cream
    reagent_to_brew = "cream"
    display_name = "Cream"
    needed_crops = list("soybeans" = 40)
    needed_chems = list("milk" = 30, "vinegar" = 10)
    price_tag_setter = 800
    brew_timer = 3 MINUTES
    brewed_amount = 3
    info_helper = "Further brewing can be done with this item."

/datum/brewing_product/grenadine
    reagent_to_brew = "grenadine"
    display_name = "Grenadine"
    needed_crops = list("cherry" = 20, "strawberries" = 20)
    needed_chems = list("water" = 30, "sugar" = 20)
    price_tag_setter = 1300
    brew_timer = 5 MINUTES
    brewed_amount = 2

/datum/brewing_product/blackpepper
    reagent_to_brew = "blackpepper"
    display_name = "Black Pepper"
    needed_crops = list("chili" = 10, "ambrosia" = 15, "towercap" = 10)
    needed_chems = list("sodiumchloride" = 15, "cornoil" = 5)
    price_tag_setter = 1500
    brew_timer = 3 MINUTES
    brewed_amount = 1

/datum/brewing_product/salt
    reagent_to_brew = "sodiumchloride"      // #TODO-MIRAI - Rename this to salt and change the ingredients
    display_name = "Salt"
    needed_crops = list("orange" = 10, "pineapple" = 10, "lemon" = 10, "lime" = 10)
    needed_chems = list("water" = 20)
    price_tag_setter = 900
    brew_timer = 5 MINUTES
    brewed_amount = 1

/datum/brewing_product/cheese
    reagent_to_brew = "vinegar"
    display_name = "Cheese Wheels (Byproduct Vinegar)"
    prerequisite = "cream"
    needed_crops = list("soybeans" = 20)
    needed_chems = list("water" = 30, "milk" = 30, "vinegar" = 5)
    price_tag_setter = 1000
    brew_timer = 2 MINUTES
    brewed_amount = 1
    bottled_brew_amount = 5
    other_name = "Cheese Wheel"
    alt_brew_item = /obj/item/reagent_containers/snacks/cheesewheel
    alt_brew_item_amount = 3
    info_helper = "There is some vinegar left behind from this recipe."

/datum/brewing_product/dough
    reagent_to_brew = "ethanol"
    display_name = "Dough (Byproduct Ethanol)"
    needed_crops = list("wheat" = 30)
    needed_chems = list("sodiumchloride" = 5, "egg" = 5, "sugar" = 10, "water" = 30)
    price_tag_setter = 800
    brew_timer = 1 MINUTES
    brewed_amount = 1
    bottled_brew_amount = 5
    other_name = "Dough"
    alt_brew_item = /obj/item/reagent_containers/snacks/dough
    alt_brew_item_amount = 6
    info_helper = "There is some ethanol left behind from this recipe."

// Psionic
/datum/brewing_product/witch_brew           // #TODO-MIRAI - Change this and the reagent_to_brew to witchesbrew
    reagent_to_brew = "witch_brew"
    display_name = "Witches Brew"
    needed_crops = list("mint" = 5, "reishi" = 10, "harebells" = 5, "blueberries" = 25)
    needed_chems = list("sugarrush" = 60, "fringeweaver" = 60)
    price_tag_setter = 1000
    brew_timer = 5 MINUTES
    brewed_amount = 1                       // Every 5u is 1 psionic point, so this will give 6 points

// Church
/datum/brewing_product/holywater
    reagent_to_brew = "holywater"
    display_name = "Blessed Water"
    needed_crops = list("mint" = 20, "towercap" = 30, "harebells" = 25)
    needed_chems = list("carbon" = 120, "water" = 120)
    price_tag_setter = 1000
    brew_timer = 5 MINUTES
    brewed_amount = 12
    info_helper = "Further brewing can be done with this item."
    holy = TRUE

/datum/brewing_product/ntcahors             // #TODO-MIRAI - Change this and the reagent_to_brew to match the display name
    reagent_to_brew = "ntcahors"
    display_name = "Absolutism Cahors Wine"
    prerequisite = "holywater"
    needed_crops = list("green grape" = 30, "sugarcane" = 25, "harebells" = 5)
    needed_chems = list("carbon" = 120, "holywater" = 120)
    price_tag_setter = 16000
    brew_timer = 1 HOUR
    brewed_amount = 6
    holy = TRUE

// Easter Eggs
/datum/brewing_product/mythiccoderstears    // #TODO-MIRAI - See if I need to do anything with this
    reagent_to_brew = "ethanol"
    display_name = "mythic coder's tears"
    needed_crops = list()
    needed_chems = list()
    price_tag_setter = 0
    brew_timer = 2 MINUTES
    brewed_amount = 1
    bottled_brew_amount = 30

/datum/brewing_product/nothing
    reagent_to_brew = "nothing"
    display_name = "Nothing"
    prerequisite = "glucose"
    needed_crops = list("cinnamon" = 10)
    needed_chems = list("water" = 200)
    price_tag_setter = 404
    brew_timer = 30 MINUTES
    brewed_amount = 1
    bottled_brew_amount = 50
