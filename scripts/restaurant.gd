extends Room


func _on_take_break_pressed():
	if Global.time_manager.break_active:
		Global.room_manager.change_room_to("Main_Hallway")
		Global.audio_manager.stop_loop_sfx()
		Global.time_manager.resume_after_break()
		Global.ui_manager.taskUI.visible = true
