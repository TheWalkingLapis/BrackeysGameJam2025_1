extends Room


func _on_back_pressed():
	if !Global.game_manager.allow_interaction and !Global.time_manager.break_active: return
	Global.room_manager.change_room_to("Main_Hallway")
