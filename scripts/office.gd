extends Room

func _on_pc_screen_pressed():
	if !Global.game_manager.allow_interaction: return
	Global.text_manager.display_interaction_text("What a nice screen UwU")
	Global.time_manager.change_time_speed(2.0)
