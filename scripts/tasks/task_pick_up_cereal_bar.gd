extends Task

@onready var cereal_bar = $Cereal_Bar

func start_task():
	if get_task_completed():
		return
	var success = Global.inventory.pick_up(Global.inventory.Items.CEREAL_BAR)
	if !success:
		return
	cereal_bar.visible = false
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
	print(cereal_bar.visible)
	cereal_bar.visible = Global.cereal_bar_ordered and !Global.cereal_bar_delivered and !Global.inventory.has_item(Inventory.Items.CEREAL_BAR)
	print(Global.cereal_bar_ordered)
	print(Global.cereal_bar_delivered)
	print(Global.inventory.has_item(Inventory.Items.CEREAL_BAR))
	print(cereal_bar.visible)
