extends ColorRect

@onready var bg = $BG

@export var meltdown_tex: Texture2D
@export var planet_explosion_tex: Texture2D

var fail_1 = "You didn't sign your HR paperwork! The employees of the power plant go on strike, leading to a meltdown!
Your slacking is responsible for the death of millions."
var fail_2 = "You didn't finish your tasks! They were essential to keep the power plant running, a meltdown happens!
Your slacking is responsible for the death of millions."
var fail_3 = "You didn't finish your tasks! They were essential to keep the power plant running, a meltdown happens!
Your slacking is responsible for the death of millions."
var fail_4 = "The reactor blew up, you should have kept an eye on your taskbar and the temperature and fuel!
You are responsible for the death of millions."
var fail_5 = "The reactor blew up, you should have kept an eye on your taskbar and the temperature and fuel!
You are responsible for the death of millions."
var fail_6 = "You couldn't give the aliens the fuel in time! The aliens destroyed earth with their laser beam and are now on their way home."

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
