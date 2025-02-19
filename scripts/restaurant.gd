extends Room


func _on_take_break_pressed():
	if Global.time_manager.break_active:
		Global.room_manager.change_room_to("Main_Hallway")
		Global.time_manager.resume_after_break()
