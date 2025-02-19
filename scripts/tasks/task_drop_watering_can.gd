extends Task

@onready var watering_can = $Watering_Can

func start_task():
	if get_task_completed():
		return
	var success = Global.inventory.has_item(Global.inventory.Items.WATERING_CAN)
	if !success:
		return
	watering_can.visible = true
	started.emit()
	set_task_completed()

func reset_task():
	super.reset_task()
	watering_can.visible = false
