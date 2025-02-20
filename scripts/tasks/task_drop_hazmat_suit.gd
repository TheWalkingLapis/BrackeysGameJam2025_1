extends Task

@onready var hazmat_suit = $Hazmat_suit

func start_task():
	if get_task_completed():
		return
	if !Global.inventory.has_item(Global.inventory.Items.HAZMAT_SUIT):
		return
	Global.inventory.drop()
	hazmat_suit.visible = true
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
	hazmat_suit.visible = false
