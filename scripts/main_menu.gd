extends Control

@onready var start_button = $ColorRect2/Button

func _on_button_pressed():
	Global.game_manager.current_day = 0
	Global.game_manager.pre_start_day(0)
