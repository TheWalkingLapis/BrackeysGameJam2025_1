extends Task

@onready var uranium = $Uranium

func start_task():
	if get_task_completed():
		return
	var success = Global.inventory.pick_up(Global.inventory.Items.URANIUM)
	if !success:
		return
	uranium.visible = false
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
	uranium.visible = !Global.uranium_delivered and Global.uranium_ordered
