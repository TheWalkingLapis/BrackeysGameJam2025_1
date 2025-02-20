extends Task

@onready var coffee= $Coffee

func start_task():
	if get_task_completed():
		return
	if !Global.inventory.has_item(Global.inventory.Items.COFFEE_CUP):
		return
	Global.inventory.drop()
	coffee.visible = true
	started.emit(self)
	set_task_completed()

func reset_task():
	coffee.visible = false
	super.reset_task()
