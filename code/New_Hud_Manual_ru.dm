//существующие оверлеи: flash, pain, blind, damageoverlay, blurry, druggy, nvg, thermal, meson, science
Используемые глобальные переменные:
GLOB..HUDdatums - тут хранятся датумы с подтипом /datum/hud, используется ассоциация name датума = сам датум

________________________________________________________________________________________________________________________
Датум /datum/hud
В данном датуме находится информация о ХУДе: имя, элементы и тд.


name - Имя датума
list/HUDneed - список необходимых элементов (например, хелсбар). С помощью данного списка заполняются HUDneed и HUDprocess у моба
list/slot_data - список элементов инвентаря. С помощью данного списка заполняются HUDinventory у моба
icon/icon -испольхуемый файл dmi
HUDfrippery - Список элементов украшения ХУДа. С помощью данного списка заполняются HUDfrippery у моба
HUDoverlays - Список "технических" элементов. С помощью данного списка заполняются HUDtech и дополняется HUDprocess у моба
ConteinerData - Информация для функции /obj/item/storage/proc/space_orient_objs и /obj/item/storage/proc/slot_orient_objs.
IconUnderlays - Список андерлеев для элемнтов ХУДа при "максимализированной" версии. Может быть пустым.
MinStyleFlag - Флаг, обозначающий имеет ли данный тип ХУДа "минимализированную" версию. Принимает значение 1 или 0

Пример элемента в списке HUDneed
"health"      = list("type" = /obj/screen/health, "loc" = "16,6", "minloc" = "15,7", "background" = "back1"),

Описание вводимых данных:
"health" - имя и ИД ХУДА
"type" - тип ХУДа, нужно чтобы система знала что именно создавать
"loc" - положение на экране в "максимализированной" версии
"minloc" положение на экране в "минимализированной" версии. Опционален. Используется если MinStyleFlag = 1
"background" - какой андерлей используется в "максимализированной" версии. Название берется из IconUnderlays. Опционален.

Пример элемента в списке HUDoverlays
"damageoverlay" = list("type" = /obj/screen/damageoverlay, "loc" = "1,1", "icon" =  'icons/mob/screen1_full.dmi'),

Описание вводимых данных:
"damageoverlay" - имя и ИД ХУДА
"type" - тип ХУДа, нужно чтобы система знала что именно создавать
"loc" - положение на экране
"icon" - используемый dmi файл, перезаписывает icon самого датума. Опционален.

Пример элемента в списке slot_data
"Uniform" =   list("loc" = "2,1","minloc" = "1,2", "state" = "center",  "hideflag" = TOGGLE_INVENTORY_FLAG, "background" = "back1"),

Описание вводимых данных:
"Uniform" - имя Слота
"loc" - положение на экране в "максимализированной" версии
"minloc" положение на экране в "минимализированной" версии. Опционально и если MinStyleFlag = 1
"hideflag" - используется для функций по скрыванию элементов ХУДа, такие как /obj/screen/toggle_invetory/proc/hideobjects(), /mob/verb/button_pressed_F12 (не работает). Опционален.
"background" - какой андерлей используется в "максимализированной" версии. Название берется из IconUnderlays. Опционален.

Пример элемента в списке HUDfrippery
list("loc" = "1,1", "icon_state" = "frame2-2",  "hideflag" = TOGGLE_INVENTORY_FLAG),

Описание вводимых данных:
"loc" - положение на экране в "максимализированной" версии
"icon_state" - какая иконка берется из dmi файла
"hideflag" - используется для функций по скрыванию элементов ХУДа, такие как /obj/screen/toggle_invetory/proc/hideobjects(), /mob/verb/button_pressed_F12 (не работает). Опционален.

________________________________________________________________________________________________________________________
Описание объектов для ХУДа

Общий тип:/obj/screen

Используемые уникальные переменные
	var/mob/living/parentmob - Моб, к которому привязан ХУД
	var/process_flag = 0 - флаг необходимости вызова подпрограммы process()

Используемые подпрограммы
/Click() - для элементов, которые работают при клике на них
/process() - для элементов, делающие что-то постоянно (в основном при вызове life у моба).

________________________________________________________________________________________________________________________
Датум /datum/species

Используемые уникальные переменные:
var/datum/hud_data/hud - сдесь находится ссылка на датум с подтипом /datum/hud_data
var/hud_type - находится тип датума /datum/hud_data для рассы

________________________________________________________________________________________________________________________
Датум /datum/hud_data

Используемые уникальные переменные:
	var/list/ProcessHUD - В данный список вносятся "имена" элементов худа, для инициализации.
	Пример: "health"

	var/list/gear - список для элементов ХУДа инвентаря, используется "имя" слота с ассоциацией
	Пример: "i_clothing" =   slot_w_uniform,
________________________________________________________________________________________________________________________
Используемые переменные на уровне моба
/mob/living
	var/list/HUDneed - Список элементов Худа для отображения на экране
	var/list/HUDinventory - Список элементов Худа, которые являются "инвентарем" моба, для отображения на экране
	var/list/HUDfrippery - Всякие украшения (например, рамка)
	var/list/HUDprocess - Список Элементов Худа, у которых нужно вызывать process()
	var/list/HUDtech - Список элементов Худа, которые являются "техническими" (например, слой для слепоты моба), для отображения на экране
	var/defaultHUD - Дефолтное имя ХУДа, которое использует моб

________________________________________________________________________________________________________________________
Используемые подпрограммы на уровне моба
/mob/proc/create_HUD() - Подпрограмма, для создания элементов ХУДа
/mob/living/proc/destroy_HUD() - Подпрограмма, для уничтожения элементов ХУДа
/mob/living/proc/show_HUD() - Подпрограмма, для отображения элементов ХУДа у клиента

/mob/living/proc/check_HUD() - Основная подпрограмма, в ней анализируется "правильность" ХУДа, и через неё идет создание\вывод элементов на экран
/mob/living/proc/check_HUDdatum() - Проверяет текущий датум у моба на правильность, возвращает 1, если все правильно, или 0, если иначе
/mob/living/proc/check_HUDinventory() - Проверяет переменную HUDinventory у моба на правильность, возвращает 1, если все правильно, или 0, если иначе.(не используется, но существует)
/mob/living/proc/check_HUDneed() - Проверяет переменную HUDneed у моба на правильность, возвращает 1, если все правильно, или 0, если иначе.(не используется, но существует)
/mob/living/proc/check_HUDfrippery() - Проверяет переменную HUDfrippery у моба на правильность, возвращает 1, если все правильно, или 0, если иначе.(не используется, но существует)
/mob/living/proc/check_HUDprocess() - Проверяет переменную HUDprocess у моба на правильность, возвращает 1, если все правильно, или 0, если иначе.(не используется, но существует)
/mob/living/proc/check_HUDtech() - Проверяет переменную HUDtech у моба на правильность, возвращает 1, если все правильно, или 0, если иначе.(не используется, но существует)

Следующие подпрограммы создают элементы в соотвествующих массивов
/mob/living/proc/create_HUDinventory() - в HUDinventory моба
/mob/living/proc/create_HUDneed() - в HUDneed моба
/mob/living/proc/create_HUDfrippery() - в HUDfrippery моба
/mob/living/proc/create_HUDprocess() - в HUDprocess моба
/mob/living/proc/create_HUDtech() - в HUDtech моба

________________________________________________________________________________________________________________________
Как это работает



________________________________________________________________________________________________________________________
ДОГОВОР О ЕДИНОМ СТИЛЕ

1) При переписывании кода под особенности подтипа моба, создавайте новый файл с названием "[type_name]_hud". Пример: human_hud.dm, robot_hud.dm.
2) При создании новой подпрограммы для работы с ситемой, пишите её "название" и приписывайте в конце _HUD. Пример: create_HUD(), show_HUD().
2.1) При работе с переменными, дописывайте название переменной. Пример: check_HUDfrippery()
3) При переписывания кода под особенности подтипа /obj/screen, создайте новый файл с названием "[HUDname]_screen_object",
если вы создаете элементы для "расы", то создайте файл с названием "[species_name]_[HUDname]_screen_object".
ПРИМЕЧАНИЕ: в файле "screen_object.dmi", находится "базовый" код.
4)Все подпрограммы, отвечающие за проверку чего либо (check_HUDdatum(), check_HUDinventory() и т.д) не должны иметь внутри себя код, не относящийся к проверке,
например, вывод предупреждения. Подпрограммы, отвечающие за проверку, должны выдавать результат проверки.