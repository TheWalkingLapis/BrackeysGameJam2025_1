extends Task

@onready var plutonium = $plutonium

func start_task():
	if get_task_completed():
		return
	var success = Global.inventory.pick_up(Global.inventory.Items.PLUTONIUM)
	if !success:
		return
	plutonium.visible = false
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
	plutonium.visible = !Global.plutonium_delivered and Global.plutonium_ordered
