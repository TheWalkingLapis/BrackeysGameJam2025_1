extends Room

func _on_pc_screen_pressed():
	Global.time_manager.change_time_speed(2.0)
