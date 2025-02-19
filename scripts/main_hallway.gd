extends Room

func _on_hr_pressed():
	if !Global.game_manager.allow_interaction: return
	Global.room_manager.change_room_to("Office")

func _on_boss_pressed():
	if !Global.game_manager.allow_interaction: return
	Global.room_manager.change_room_to("Boss")

func _on_kitchen_pressed():
	if !Global.game_manager.allow_interaction: return
	Global.room_manager.change_room_to("Kitchen")

func _on_storage_pressed():
	if !Global.game_manager.allow_interaction: return
	Global.room_manager.change_room_to("Storage")

func _on_passage_pressed():
	if !Global.game_manager.allow_interaction: return
	Global.room_manager.change_room_to("Passage")

func _on_plan_pressed():
	Global.time_manager.resume_after_break()
	#if !Global.game_manager.allow_interaction: return
	#Global.room_manager.change_room_to("Plan")
