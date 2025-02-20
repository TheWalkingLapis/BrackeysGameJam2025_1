extends Task

@onready var watering_can = $Watering_Can

func start_task():
	if get_task_completed():
		return
	if !Global.inventory.has_item(Global.inventory.Items.WATERING_CAN):
		return
	Global.inventory.drop()
	watering_can.visible = true
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
	watering_can.visible = false
