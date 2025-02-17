extends Room

func _on_hr_pressed():
	print(Global.game_manager.allow_interaction)
	if !Global.game_manager.allow_interaction: return
	Global.room_manager.change_room_to("Office")
