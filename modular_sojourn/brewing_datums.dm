// Beers
/datum/brewing_product/beer
	reagent_to_brew = "beer"
	display_name = "Beer"

	brewed_amount = 12
	needed_crops = list("wheat" = 40, "poppy" = 5)
	needed_chems = list("water" = 60)

	brew_timer = 2 MINUTES
	price_tag_setter = 1750
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/sleepy_beer	// #TODO-MIRAI - Change this to sleepybeer
	reagent_to_brew = "beer2" 		// #TODO-MIRAI - Change this to sleepybeer
	display_name = "Sleepy Beer"
	prerequisite = "beer"

	brewed_amount = 2
	needed_crops = list("wheat" = 10, "poppy" = 5)
	needed_chems = list("water" = 60, "chloralhydrate" = 5)

	brew_timer = 2 MINUTES
	price_tag_setter = 2250

// Liquor
/datum/brewing_product/melonliquor
	reagent_to_brew = "melonliquor"
	display_name = "Melon Liquor"

	brewed_amount = 2
	needed_crops = list("watermelon" = 80, "towercap" = 15, "poppy" = 35)
	needed_chems = list("water" = 160)

	brew_timer = 6 MINUTES
	price_tag_setter = 2000

/datum/brewing_product/bluecuracao
	reagent_to_brew = "bluecuracao"
	display_name = "Blue Curacao"

	brewed_amount = 2
	needed_crops = list("orange" = 80, "towercap" = 15, "poppy" = 35)
	needed_chems = list("water" = 160)

	brew_timer = 8 MINUTES
	price_tag_setter = 2100

// Wine
/datum/brewing_product/wine
	reagent_to_brew = "wine"
	display_name = "Wine"

	brewed_amount = 2
	needed_crops = list("grapes" = 80, "towercap" = 5)
	needed_chems = list("water" = 160, "sugar"= 15)

	brew_timer = 6 MINUTES
	price_tag_setter = 3000
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/vermouth
	reagent_to_brew = "vermouth"
	display_name = "Vermouth"
	prerequisite = "wine"

	brewed_amount = 3
	needed_crops = list("grass" = 60, "towercap" = 15, "blueberries" = 30)
	needed_chems = list("water" = 160)

	brew_timer = 8 MINUTES
	price_tag_setter = 3500

/datum/brewing_product/pwine				// #TODO-MIRAI - Change this to fungalwine
	reagent_to_brew = "pwine"				// #TODO-MIRAI - Change this to fungalwine
	display_name = "Fungal Wine (poison)"
	prerequisite = "wine"

	brewed_amount = 1
	needed_crops = list("grapes" = 10, "towercap" = 5, "plumphelmet" = 5)
	needed_chems = list("amatoxin" = 15)

	brew_timer = 16 MINUTES
	price_tag_setter = 4000

/datum/brewing_product/redcandyliquor		// #TODO-MIRAI - Change this to redcandywine
	reagent_to_brew = "redcandyliquor"		// #TODO-MIRAI - Change this to redcandywine
	display_name = "Red Candy Wine"
	prerequisite = "wine"
	
	brewed_amount = 1
	needed_crops = list("grapes" = 10, "sunflowers" = 5, "harebells" = 5)
	needed_chems = list("sugar" = 15)

	brew_timer = 16 MINUTES
	price_tag_setter = 4000

// Rum
/datum/brewing_product/rum
	reagent_to_brew = "rum"
	display_name = "Rum"
	
	brewed_amount = 4
	needed_crops = list("sugarcane" = 60, "towercap" = 5)
	needed_chems = list("water" = 120, "sodiumchloride" = 5)

	brew_timer = 7 MINUTES
	price_tag_setter = 2000
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/deadrum
	reagent_to_brew = "deadrum"
	display_name = "Deadrum (Seawater Rum)"
	prerequisite = "rum"

	brewed_amount = 2
	needed_crops = list("sugarcane" = 30, "towercap" = 15)
	needed_chems = list("water" = 60, "sodiumchloride" = 60)

	brew_timer = 10 MINUTES
	price_tag_setter = 5000
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/nanatsunoumi
	reagent_to_brew = "nanatsunoumi"
	display_name = "Nanatsunoumi"
	prerequisite = "deadrum"

	brewed_amount = 3
	needed_crops = list("rice" = 30, "towercap" = 15, "poppy" = 5)
	needed_chems = list("water" = 80)

	brew_timer = 20 MINUTES
	price_tag_setter = 8000

/datum/brewing_product/kahlua
	reagent_to_brew = "kahlua"
	display_name = "Kahlua"
	prerequisite = "rum"

	brewed_amount = 3
	needed_crops = list("gelthi" = 40, "cinnamon" = 5)
	needed_chems = list("water" = 30, "sugar" = 30)

	brew_timer = 3 MINUTES
	price_tag_setter = 3000

// Unsorted
/datum/brewing_product/gin
	reagent_to_brew = "gin"
	display_name = "Gin"

	brewed_amount = 3
	needed_crops = list("berries" = 40, "lemon" = 40, "towercap" = 5, "cinnamon" = 25)
	needed_chems = list("water" = 160, "sugar"= 15)

	brew_timer = 9 MINUTES
	price_tag_setter = 3200

/datum/brewing_product/schnapps			// #TODO-MIRAI - Make a normal schnapps without cinnamon for this to use as a base
	reagent_to_brew = "schnapps"		// #TODO-MIRAI - Make a normal schnapps without cinnamon for this to use as a base
	display_name = "Cinnamon Schnapps (Kros Style)"

	brewed_amount = 4
	needed_crops = list("berries" = 40, "strawberries" = 40, "towercap" = 5, "cinnamon" = 5)
	needed_chems = list("water" = 160, "sugar"= 35)

	brew_timer = 5 MINUTES
	price_tag_setter = 1200
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/goldschlager
	reagent_to_brew = "goldschlager"
	display_name = "Goldschlager"
	prerequisite = "schnapps"			

	brewed_amount = 4
	needed_crops = list("berries" = 40, "goldapple" = 5, "cinnamon" = 55)
	needed_chems = list("water" = 10)

	brew_timer = 20 MINUTES
	price_tag_setter = 6500

/datum/brewing_product/tequilla
	reagent_to_brew = "tequilla"
	display_name = "Tequilla"

	brewed_amount = 2
	needed_crops = list("lime" = 40, "lemon" = 40, "towercap" = 5, "pineapple" = 10)
	needed_chems = list("water" = 50, "sodiumchloride"= 5)

	brew_timer = 3 MINUTES
	price_tag_setter = 2250

/datum/brewing_product/patron
	reagent_to_brew = "patron"
	display_name = "Patron"

	brewed_amount = 1
	needed_crops = list("wheat" = 80,  "mint" = 30)
	needed_chems = list("water" = 30)

	brew_timer = 15 MINUTES
	price_tag_setter = 2000

/datum/brewing_product/ale
	reagent_to_brew = "ale"
	display_name = "Ale"

	brewed_amount = 12
	needed_crops = list("wheat" = 60, "towercap" = 5, "poppy" = 5)
	needed_chems = list("water" = 120, "honey" = 5)

	brew_timer = 14 MINUTES
	price_tag_setter = 2000

/datum/brewing_product/vodka
	reagent_to_brew = "vodka"
	display_name = "Vodka"

	brewed_amount = 4
	needed_crops = list("potato" = 30, "corn" = 15)
	needed_chems = list("water" = 80)

	brew_timer = 1 MINUTES
	price_tag_setter = 1000
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/ethanol
	reagent_to_brew = "ethanol"
	display_name = "Ethanol"
	prerequisite = "vodka"

	brewed_amount = 3
	needed_crops = list("corn" = 30)
	needed_chems = list("water" = 30)

	brew_timer = 5 MINUTES
	price_tag_setter = 1500
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/absinthe
	reagent_to_brew = "absinthe"
	display_name = "Absinthe"
	prerequisite = "ethanol"

	brewed_amount = 1
	bottled_brew_amount = 50 // #TODO-MIRAI - I don't know, do something with it
	needed_crops = list("towercap" = 120, "maidengrass" = 5, "moon tear" = 30)
	needed_chems = list("water" = 230)

	brew_timer = 60 MINUTES
	price_tag_setter = 12000

/datum/brewing_product/Kvass
	reagent_to_brew = "Kvass"
	display_name = "Kvass"
	prerequisite = "vodka"

	brewed_amount = 3
	needed_crops = list("wheat" = 30)
	needed_chems = list("water" = 200)

	brew_timer = 3 MINUTES
	price_tag_setter = 1200
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/whiskey
	reagent_to_brew = "whiskey"
	display_name = "Whiskey"

	brewed_amount = 10
	needed_crops = list("wheat" = 40, "towercap" = 5)
	needed_chems = list("water" = 120)

	brew_timer = 20 MINUTES
	price_tag_setter = 2000

/datum/brewing_product/glucose
	reagent_to_brew = "glucose"
	display_name = "Glucose"
	prerequisite = "Kvass"

	brewed_amount = 1
	bottled_brew_amount = 5
	needed_crops = list("wheat" = 60, "corn" = 30)
	needed_chems = list("water" = 30, "sugar" = 30, "honey" = 5)
	
	brew_timer = 12 MINUTES
	price_tag_setter = 4750
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/nothing
	reagent_to_brew = "nothing"
	display_name = "Nothing"
	prerequisite = "glucose"

	brewed_amount = 1
	bottled_brew_amount = 50
	needed_crops = list("cinnamon" = 10)
	needed_chems = list("water" = 200)

	brew_timer = 30 MINUTES
	price_tag_setter = 404 //this is more or less a joke price, you make a lot more by mixing silencer

/datum/brewing_product/soysauce
	reagent_to_brew = "soysauce"
	display_name = "Soy Sauce"
	prerequisite = "vinegar"

	brewed_amount = 3
	needed_crops = list("wheat" = 20, "soybeans" = 30, "plumphelmet" = 2)
	needed_chems = list("water" = 30, "sodiumchloride" = 30)

	brew_timer = 5 MINUTES
	price_tag_setter = 2750

/datum/brewing_product/vinegar
	reagent_to_brew = "vinegar"
	display_name = "Vinegar"
	prerequisite = "wine"

	brewed_amount = 3
	needed_crops = list("apple" = 20, "pineapple" = 30)
	needed_chems = list("water" = 30)

	brew_timer = 15 MINUTES
	price_tag_setter = 2500
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/cream
	reagent_to_brew = "cream"
	display_name = "Cream"

	brewed_amount = 3
	needed_crops = list("soybeans" = 40)
	needed_chems = list("milk" = 30, "vinegar" = 10)

	brew_timer = 3 MINUTES
	price_tag_setter = 800
	info_helper = "Further brewing can be done when finished."

/datum/brewing_product/grenadine
	reagent_to_brew = "grenadine"
	display_name = "Grenadine"

	brewed_amount = 2
	needed_crops = list("cherry" = 20, "strawberries" = 20)
	needed_chems = list("water" = 30, "sugar" = 20)
	
	brew_timer = 5 MINUTES
	price_tag_setter = 1300

/datum/brewing_product/cheese // #TODO-MIRAI - See if there is a better way of doing this or remove it
	reagent_to_brew = "vinegar" //Gives back some vinegar
	display_name = "Cheese Wheels (Byproduct Vinegar)"
	prerequisite = "cream"

	brewed_amount = 1
	bottled_brew_amount = 5
	needed_crops = list("soybeans" = 20)
	needed_chems = list("water" = 30, "milk" = 30, "vinegar" = 5)

	brew_timer = 2 MINUTES
	price_tag_setter = 1000

	other_name = "Cheese Wheel"
	alt_brew_item = /obj/item/reagent_containers/snacks/cheesewheel
	alt_brew_item_amount = 3
	info_helper = "The bottles will produced Vinegar."

//Fast-ish for drying
/datum/brewing_product/blackpepper // #TODO-MIRAI - Look at this later, why is it called pepper three times?
	reagent_to_brew = "blackpepper"
	display_name = "Pepper Pepper Pepper"
	needed_crops = list("chili" = 10, "ambrosia" = 15, "towercap" = 10)
	needed_chems = list("sodiumchloride" = 15, "cornoil" = 5)
	brew_timer = 3 MINUTES
	brewed_amount = 1
	price_tag_setter = 1500

/datum/brewing_product/dough  // #TODO-MIRAI - See if there is a better way of doing this or remove it, this one doesn't make the most sense though
	reagent_to_brew = "ethanol"
	display_name = "Dough (Ethanol Byproduct)"
	needed_crops = list("wheat" = 30)
	needed_chems = list("sodiumchloride" = 5, "egg" = 5, "sugar" = 10, "water" = 30)
	brew_timer = 1 MINUTES
	brewed_amount = 1
	price_tag_setter = 800 //Its cheap and fast and just uncooked bread
	bottled_brew_amount = 5 //Just a little bit as a byproduct

	other_name = "Dough"
	alt_brew_item = /obj/item/reagent_containers/snacks/dough
	alt_brew_item_amount = 6 //Mass production
	info_helper = "The bottles produced are Ethanol."

/datum/brewing_product/salt // #TODO-MIRAI - What do I even do with this, what do I change it to? Change the reagent name too, for consistancy
	reagent_to_brew = "sodiumchloride"
	display_name = "Salt"

	brewed_amount = 1
	needed_crops = list("orange" = 10, "pineapple" = 10, "lemon" = 10, "lime" = 10)
	needed_chems = list("water" = 20)

	brew_timer = 5 MINUTES
	price_tag_setter = 900

//Asked Microsoft Copoilet for this one, idk looks fine to me - Trilby
/datum/brewing_product/enzyme // #TODO-MIRAI - What do I even do with this? Change some ingredients? Also change the name to enzyme or something
	reagent_to_brew = "enzyme"
	display_name = "Universal Enzyme"
	prerequisite = "vinegar"

	brewed_amount = 1
	needed_crops = list("mint" = 20, "pineapple" = 30, "grass" = 120, "orange" = 30)
	needed_chems = list("water" = 30, "ethanol" = 60)
	
	brew_timer = 15 MINUTES
	price_tag_setter = 7500

/datum/brewing_product/fernet
	reagent_to_brew = "fernet"
	display_name = "Fernet"

	brewed_amount = 1
	needed_crops = list("mint" = 20, "thaadra" = 20, "harebells" = 5)
	needed_chems = list("water" = 60)

	brew_timer = 15 MINUTES
	price_tag_setter = 1500

//Psionic based drink
/datum/brewing_product/witch_brew // #TODO-MIRAI - Do something with this too, make the name consistant, remove the underscore too
	reagent_to_brew = "witch_brew"
	display_name = "Witches Brew"
	//mint is wool of bat, reishi is toe of frog, herbell is Tongue of dog, lastly blueberries are meant to be eye of newt
	needed_crops = list("mint" = 5, "reishi" = 10, "harebells" = 5, "blueberries" = 25)
	needed_chems = list("sugarrush" = 60, "fringeweaver" = 60)
	brew_timer = 5 MINUTES
	brewed_amount = 1 //Every 5u is 1 psionic point so this gives you 6 points
	price_tag_setter = 1000 //Fast and easy also not useful for anyone without psionics


//Church exclusive brews
/datum/brewing_product/ntcahors // #TODO-MIRAI - Change the reagent and brewing product name
	reagent_to_brew = "ntcahors"
	display_name = "Absolutism Cahors Wine"
	prerequisite = "holywater"

	brewed_amount = 6
	needed_crops = list("green grape" = 30, "sugarcane" = 25, "harebells" = 5)
	needed_chems = list("carbon" = 120, "holywater" = 120)

	price_tag_setter = 16000
	brew_timer = 1 HOUR
	holy = TRUE

/datum/brewing_product/holywater
	reagent_to_brew = "holywater"
	display_name = "Blessed Water"

	brewed_amount = 12
	needed_crops = list("mint" = 20, "towercap" = 30, "harebells" = 25)
	needed_chems = list("carbon" = 120, "water" = 120)

	brew_timer = 5 MINUTES
	price_tag_setter = 1000
	holy = TRUE
	info_helper = "Further brewing can be done when finished."