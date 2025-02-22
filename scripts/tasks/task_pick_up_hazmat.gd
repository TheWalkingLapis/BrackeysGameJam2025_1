extends Task

@onready var hazmat_suit = $Hazmat

func start_task():
	if get_task_completed():
		return
	var success = Global.inventory.pick_up(Global.inventory.Items.HAZMAT_SUIT)
	if !success:
		return
	hazmat_suit.visible = false
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
	hazmat_suit.visible = !Global.hazmat_suit_delivered and Global.hazmat_suit_ordered
