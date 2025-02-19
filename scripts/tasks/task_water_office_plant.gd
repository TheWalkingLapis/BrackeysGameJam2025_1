extends Task


func start_task():
	if get_task_completed():
		return
	if !Global.inventory.has_item(Global.inventory.Items.WATERING_CAN):
		return
	started.emit()
	Global.watering_task_allow_discard_watering_can = true
	set_task_completed()
