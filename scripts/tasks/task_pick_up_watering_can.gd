extends Task

@onready var watering_can = $Watering_Can

func start_task():
	if get_task_completed():
		return
	var success = Global.inventory.pick_up(Global.inventory.Items.WATERING_CAN)
	if !success:
		return
	watering_can.visible = false
	started.emit(self)
	Global.watering_task_allow_discard_watering_can = 0
	set_task_completed()

func reset_task():
	super.reset_task()
	watering_can.visible = true
