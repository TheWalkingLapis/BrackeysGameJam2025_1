extends Control
class_name RoomManager

signal task_started()
signal task_ended()

@onready var office: Room = $Office
@onready var kitchen: Room = $Kitchen
@onready var main_hallway: Room = $Main_Hallway
var current_room = "Office"

var name_to_node_dict: Dictionary
var current_tasks = {}
var task_in_progress = false
var num_tasks = 0
var num_completed_tasks = 0

func _ready():
	name_to_node_dict = {
		"Office": office,
		"Kitchen": kitchen,
		"Main_Hallway": main_hallway
	}
	for room_name in name_to_node_dict:
		name_to_node_dict[room_name].visible = (current_room == room_name)

func setup_day(day):
	num_completed_tasks = 0
	num_tasks = 0
	var tasks = {}
	for room_name in name_to_node_dict:
		var room_tasks = name_to_node_dict[room_name].get_tasks_for_day(day)
		tasks[room_name] = room_tasks
		for task in room_tasks:
			(task as Task).started.connect(_on_task_started)
			(task as Task).completed.connect(_on_task_completed)
			num_tasks += 1
	current_tasks = tasks
	Global.ui_manager.setup_tasks(tasks)

func change_room_to(room_name: String):
	name_to_node_dict[current_room].visible = false
	if not room_name in name_to_node_dict:
		printerr("Room name doesn't exist: %s" % [room_name])
		return
	current_room = room_name
	name_to_node_dict[current_room].visible = true

func _on_task_started():
	task_in_progress = true
	task_started.emit()

func _on_task_failed(): # TODO connect
	task_ended.emit()

func _on_task_completed():
	num_completed_tasks += 1
	task_in_progress = false
	task_ended.emit()
	Global.ui_manager.update_tasks()
	if num_completed_tasks == num_tasks:
		print("all done, TODO")

func _process(delta):
	pass
