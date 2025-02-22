extends Control
class_name RoomManager

signal task_started()
signal task_ended()
signal post_day()

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
var active_task = null
var required_tasks_pre_break = []
var required_tasks_all = []
var completed_tasks = []

var tasks_with_connected_signals = {}

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
	office.ordered.connect(storage._on_orders_update)

func setup_day(day):
	if day <= 3:
		change_room_to("Main_Hallway")
	else:
		change_room_to("Office")
	Global.talked_to_aliens_task_received = 0
	collect_tasks(day, false)

func _on_break_time_over():
	collect_tasks(Global.game_manager.current_day, true)

func collect_tasks(day, post_break):
	if !post_break:
		completed_tasks = []
	required_tasks_pre_break = []
	required_tasks_all = []
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
			if ((task as Task).after_mealtime == post_break) or (task as Task).whole_day:
				tasks[room_name].append(task)
				if not post_break:
					(task as Task).reset_task() # only reset at start of day to avoid reseting whole-day tasks after break
				task.visible = true
				if !tasks_with_connected_signals.has(task):
					tasks_with_connected_signals[task] = null # use as a set for connected signals to avoid errors
					(task as Task).started.connect(_on_task_started)
					(task as Task).completed.connect(_on_task_completed)
					(task as Task).quit.connect(_on_task_quit)
				if !(task as Task).optional and !(task as Task).uncompletable:
					required_tasks_all.append(task)
					if !(task as Task).after_mealtime and !(task as Task).whole_day:
						required_tasks_pre_break.append(task)
			else:
				task.visible = false
	current_tasks = tasks
	Global.ui_manager.setup_tasks(tasks)
	
func change_room_to(room_name: String):
	if current_room != "None":
		name_to_node_dict[current_room].visible = false
	if not room_name in name_to_node_dict:
		printerr("Room name doesn't exist: %s" % [room_name])
		return
	Global.text_manager.clear_text()
	current_room = room_name
	if room_name != "None":
		name_to_node_dict[current_room].visible = true

func _on_task_started(task):
	task_in_progress = true
	active_task = task
	task_started.emit()

func _on_task_quit():
	active_task = null
	task_ended.emit()

func _on_task_completed():
	completed_tasks.append(active_task)
	active_task = null
	task_in_progress = false
	task_ended.emit()
	Global.ui_manager.update_tasks()

func _on_time_evening():
	for room_name in name_to_node_dict:
		if room_name == "None": continue
		if name_to_node_dict[room_name].has_method("_on_time_evening"):
			name_to_node_dict[room_name]._on_time_evening()

func clear_active_tasks():
	if active_task != null:
		active_task.visible = false
		if active_task.has_method("reset_screen"):
			active_task.reset_screen()
		else:
			active_task.reset_task()
		active_task = null
		Global.game_manager.gameState = Global.game_manager.GameState.IDLE

func get_tasks_completed(post_break):
	if !post_break:
		for t in required_tasks_pre_break:
			if not t in completed_tasks:
				return false
		return true
	else:
		for t in required_tasks_all:
			if not t in completed_tasks:
				return false
		return true

func _process(delta):
	pass
