extends Room

@export var reactor_closed_tex: Texture2D
@export var reactor_open_tex: Texture2D
@export var reactor_open_fueled_tex: Texture2D

@onready var bg = $TextureRect
@onready var fuel_rod = $Fuel_Rod_Button

var wire_task = null
var fuel_task = null

func _ready():
	Global.fuel_task_progress_changed.connect(_on_fuel_progress_changed)

func setup_day(day, post_break):
	_on_fuel_progress_changed()
	match day:
		0:
			wire_task = null
			fuel_task = null
		1:
			wire_task = null
			fuel_task = null
		2:
			wire_task = null
			fuel_task = null
		3:
			wire_task = null
			fuel_task = $Tasks/Day4/Task_refuel
		4:
			wire_task = $Tasks/Day5/Task_Fix_Wires
			fuel_task = $Tasks/Day5/Task_refuel
		5:
			wire_task = $Tasks/Day6/Task_Fix_Wires
			fuel_task = $Tasks/Day6/Task_refuel

func _on_leave_pressed():
	if !Global.game_manager.allow_interaction and (!Global.time_manager.break_active and Global.time_manager.day_active): return
	Global.room_manager.change_room_to("Passage")


func _on_wirebox_pressed():
	if !Global.game_manager.allow_interaction: return
	if wire_task != null:
		if (wire_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already fixed these wires")
		else:
			wire_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I think this one is not broken")

func _on_fuel_progress_changed():
	bg.texture = reactor_closed_tex if Global.fuel_task_progress == 0 else (reactor_open_tex if Global.fuel_task_progress == 1 else reactor_open_fueled_tex)
	fuel_rod.visible = Global.fuel_task_progress != 0


func _on_fuel_rod_button_pressed():
	if !Global.game_manager.allow_interaction: return
	if fuel_task != null:
		if Global.fuel_task_progress == 1:
			fuel_task.start_task()
		else:
			Global.text_manager.display_interaction_text("I need to lower them into the reactor from the control room")
