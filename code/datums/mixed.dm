/datum/data
	var/name = "data"
	var/size = 1.0

/datum/data/function
	name = "function"
	size = 2.0

/datum/data/function/data_control
	name = "data control"

/datum/data/function/id_changer
	name = "id changer"

/datum/data/record
	name = "record"
	size = 5.0
	var/list/fields = list(  )

/datum/data/record/Destroy()

	data_core.medical -= src

	data_core.security -= src

	data_core.general -= src

	data_core.locked -= src

	. = ..()

/datum/data/text
	name = "text"
	var/data = null

/datum/debug
	var/list/debuglist
