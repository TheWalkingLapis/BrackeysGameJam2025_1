extends Task

@onready var uranium = $Uranium

func start_task():
	if get_task_completed():
		return
	if !Global.inventory.has_item(Global.inventory.Items.URANIUM):
		return
	Global.inventory.drop()
	Global.uranium_delivered = true
	uranium.visible = true
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
	uranium.visible = Global.uranium_delivered
