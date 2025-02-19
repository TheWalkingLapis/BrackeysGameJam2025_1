extends Control
class_name RoomManager

signal task_started()
signal task_ended()

@onready var office: Room = $Office
@onready var kitchen: Room = $Kitchen
@onready var main_hallway: Room = $Main_Hallway
@onready var storage: Room = $Storage
@onready var boss: Room = $Boss
@onready var passage: Room = $Passage
@onready var control: Room = $Control
@onready var reactor: Room = $Reactor
@onready var plan: Room = $Plan
@onready var restaurant: Room = $Restaurant
var current_room = "None"

var name_to_node_dict: Dictionary
var current_tasks = {}
var task_in_progress = false
var num_tasks = 0
var num_completed_tasks = 0

var days_started_once = [false, false, false, false, false, false] #avoid signal reconnection on day restart

func _ready():
	name_to_node_dict = {
		"None": null,
		"Office": office,
		"Kitchen": kitchen,
		"Main_Hallway": main_hallway,
		"Storage": storage,
		"Boss": boss,
		"Passage": passage,
		"Control": control,
		"Reactor": reactor,
		"Plan": plan,
		"Restaurant": restaurant
	}
	for room_name in name_to_node_dict:
		if room_name == "None": continue
		name_to_node_dict[room_name].visible = (current_room == room_name)

func setup_day(day):
	collect_tasks(day, false)

func _on_break_time_over():
	collect_tasks(Global.game_manager.current_day, true)

func collect_tasks(day, post_break):
	num_completed_tasks = 0
	num_tasks = 0
	var tasks = {}
	for room_name in name_to_node_dict:
		if room_name == "None": continue
		for i in range(6):
			var day_string = "Tasks/Day%d" % [i+1]
			var day_node = name_to_node_dict[room_name].get_node_or_null(day_string)
			if day_node != null:
				day_node.visible = i == day
		if name_to_node_dict[room_name].has_method("setup_day"):
			name_to_node_dict[room_name].setup_day(day, post_break)
		var room_tasks = (name_to_node_dict[room_name] as Room).get_tasks_for_day(day)
		if len(room_tasks) == 0: continue
		tasks[room_name] = []
		for task in room_tasks:
			if (task as Task).after_mealtime == post_break:
				tasks[room_name].append(task)
				(task as Task).reset_task()
				task.visible = true
				if not days_started_once[day]:
					(task as Task).started.connect(_on_task_started)
					(task as Task).completed.connect(_on_task_completed)
				num_tasks += 1
			else:
				task.visible = false
		days_started_once[day] = true
	current_tasks = tasks
	change_room_to("Main_Hallway")
	Global.ui_manager.setup_tasks(tasks)
	
func change_room_to(room_name: String):
	if current_room != "None":
		name_to_node_dict[current_room].visible = false
	if not room_name in name_to_node_dict:
		printerr("Room name doesn't exist: %s" % [room_name])
		return
	current_room = room_name
	if room_name != "None":
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

func _on_time_evening():
	for room_name in name_to_node_dict:
		if room_name == "None": continue
		if name_to_node_dict[room_name].has_method("_on_time_evening"):
			name_to_node_dict[room_name]._on_time_evening()

func _process(delta):
	pass
