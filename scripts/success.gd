extends ColorRect

@onready var bg = $BG

@export var meltdown_tex: Texture2D

func win():
	Global.time_manager.day_active = false
	Global.text_manager.show_text_in_menu("Win")

func _on_continue_pressed():
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")
