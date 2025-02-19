extends Task


func start_task():
	if get_task_completed():
		return
	if !Global.inventory.has_item(Global.inventory.Items.WATERING_CAN):
		return
	started.emit()
	set_task_completed()
