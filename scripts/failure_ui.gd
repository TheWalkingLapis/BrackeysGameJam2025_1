extends ColorRect

@onready var bg = $BG

@export var meltdown_tex: Texture2D
@export var planet_explosion_tex: Texture2D

var fail_1 = "Fail Day 1"
var fail_2 = "Fail Day 2"
var fail_3 = "Fail Day 3"
var fail_4 = "Fail Day 4"
var fail_5 = "Fail Day 5"
var fail_6 = "Fail Day 6"

func set_screen():
	Global.time_manager.day_active = false
	match Global.game_manager.current_day:
		0:
			Global.text_manager.show_text_in_menu(fail_1)
			bg.texture = meltdown_tex
		1:
			Global.text_manager.show_text_in_menu(fail_2)
			bg.texture = meltdown_tex
		2:
			Global.text_manager.show_text_in_menu(fail_3)
			bg.texture = meltdown_tex
		3:
			Global.text_manager.show_text_in_menu(fail_4)
			bg.texture = meltdown_tex
		4:
			Global.text_manager.show_text_in_menu(fail_5)
			bg.texture = meltdown_tex
		5:
			Global.text_manager.show_text_in_menu(fail_6)
			bg.texture = planet_explosion_tex

func _on_continue_pressed():
	Global.game_manager.pre_start_day(Global.game_manager.current_day)
