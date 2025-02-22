extends Task


func start_task():
	if get_task_completed():
		return
	if !Global.inventory.has_item(Global.inventory.Items.WATERING_CAN):
		return
	started.emit(self)
	Global.audio_manager.play_sfx(AudioManager.SFX.TASK_WATER)
	Global.watering_task_allow_discard_watering_can += 1
	set_task_completed()
