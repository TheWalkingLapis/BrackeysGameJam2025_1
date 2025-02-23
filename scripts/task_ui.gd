extends Control

@onready var task_label = $TaskBG/TaskBox
@onready var clock_label = $ClockBG/RichTextLabel
@onready var alarm = $Alarm
@onready var eye_hide = $HideBG/Hide

@export var eye_open: Texture2D
@export var eye_closed: Texture2D

var current_tasks = {}
var hide = false

var optional_string = "Optional"
var watering_string = "Watering"
var resupply_string = "Resupply"
var wire_string = "Wires"
var sign_string = "Signing"
var save_the_world_string = "Save the World"
var reactor_string = "Reactor Control"
var task_string = "Tasks" # default


var order_dict = {
	save_the_world_string: 2,
	reactor_string: 3,
	wire_string: 5,
	watering_string: 10,
	resupply_string: 15,
	sign_string: 18,
	optional_string: 99,
	task_string: 100
}

func order_func_categories(a, b):
	var val_a = 0
	var val_b = 0
	if order_dict.has(a):
		val_a = order_dict[a]
	if order_dict.has(b):
		val_b = order_dict[b]
	return val_a < val_b

func set_tasks(tasks):
	hide_taskbar(false)
	$TaskBG.visible = true
	$HideBG.visible = true
	alarm.visible = false
	current_tasks = {task_string: []}
	for room in tasks:
		var task_list = tasks[room]
		if len(task_list) == 0: continue
		for t in task_list:
			var task := t as Task
			if task.optional:
				if !current_tasks.has(optional_string):
					current_tasks[optional_string] = []
				current_tasks[optional_string].append(task)
			elif task.tag == Task.TaskTag.SIGN:
				if !current_tasks.has(sign_string):
					current_tasks[sign_string] = []
				current_tasks[sign_string].append(task)
			elif task.tag == Task.TaskTag.WATERING:
				if !current_tasks.has(watering_string):
					current_tasks[watering_string] = []
				current_tasks[watering_string].append(task)
			elif task.tag == Task.TaskTag.RESUPPLY:
				if !current_tasks.has(resupply_string):
					current_tasks[resupply_string] = []
				current_tasks[resupply_string].append(task)
			elif task.tag == Task.TaskTag.WIRES:
				if !current_tasks.has(wire_string):
					current_tasks[wire_string] = []
				current_tasks[wire_string].append(task)
			elif task.tag == Task.TaskTag.SAVE_THE_WORLD:
				if !current_tasks.has(save_the_world_string):
					current_tasks[save_the_world_string] = []
				current_tasks[save_the_world_string].append(task)
			elif task.tag == Task.TaskTag.FUEL or task.tag == Task.TaskTag.TEMEPERATURE:
				if !current_tasks.has(reactor_string):
					current_tasks[reactor_string] = []
				current_tasks[reactor_string].append(task)
			else:
				current_tasks[task_string].append(task)
	if current_tasks.has(watering_string):
		current_tasks[watering_string].sort_custom(Task._task_compare_func)
	if current_tasks.has(resupply_string):
		current_tasks[resupply_string].sort_custom(Task._task_compare_func)
	if current_tasks.has(reactor_string):
		current_tasks[reactor_string].sort_custom(Task._task_compare_func)
	if current_tasks.has(save_the_world_string):
		current_tasks[save_the_world_string].sort_custom(Task._task_compare_func)
	update_task_text()

func update_task_display():
	if !Global.time_manager.day_active:
		_on_day_done()
	if Global.time_manager.break_active or !Global.time_manager.day_active: return
	update_task_text()

func ui_final_task():
	$TaskBG.visible = false
	$HideBG.visible = false

func update_task_text():
	if Global.game_manager.current_day == 5:
		if Global.talked_to_aliens_task_received == 0:
			task_label.text = Utils.bbc_text("Go to the kitchen", 30)
			return
	var working_hours = Global.time_manager.get_working_hours()
	var text = ""
	var working_hour_text = "   Today's Working Hours: %02d:00 - %02d:00\n" % [working_hours[0], working_hours[1]]
	var break_time_text = "   Break Time at %02d:00" % Global.time_manager.day_break_hour
	if false:
		break_time_text += " for %dh" % Global.time_manager.day_break_duration
	break_time_text += "\n"
	text += Utils.bbc_text(working_hour_text, 22)
	if !Global.time_manager.post_break and Global.time_manager.day_break_hour >= 0:
		text += Utils.bbc_text(break_time_text, 22)
	
	var completed = Utils.bbc_underline(Utils.bbc_text("Completed:\n", 30))
	var completed_flag = false
	var categories = current_tasks.keys()
	categories.sort_custom(order_func_categories)
	for category in categories:
		var task_list = current_tasks[category]
		
		if len(task_list) == 0: continue
		var skip_category_text = true # skip empty categories
		for t in task_list:
			if !(t as Task).get_task_completed(): 
				skip_category_text = false
				break
		if !skip_category_text:
			text += " " + Utils.bbc_underline(Utils.bbc_text("%s:\n" % category, 30))
			
		for t in task_list:
			var task := t as Task
			if category == reactor_string:
				if task.tag == Task.TaskTag.TEMEPERATURE:
					text += Utils.bbc_text("  > Temperature: %dC" % [Global.room_manager.control.temperature * Global.temperatur_scale], 25)
					if Global.room_manager.control.temperature_critical:
						text += Utils.bbc_text(" - CRITICAL", 25)
					text += "\n"
				if task.tag == Task.TaskTag.FUEL and task.order == 1:
					text += Utils.bbc_text("  > Fuel: %d%%" % [Global.room_manager.control.fuel], 25)
					if Global.room_manager.control.fuel_critical:
						text += Utils.bbc_text(" - CRITICAL", 25)
					text += "\n"
			var task_texts = task.get_task_strings()
			#var task_text = "  - %s\n" % Utils.bbc_text(task_texts[0], 25)
			var task_text = "  -  %s\n" % Utils.bbc_text(task_texts[1], 18)
			if task.get_task_completed():
				completed_flag = true
				#completed += Utils.bbc_strikethrough(task_text)
				completed += task_text
			else:
				text += task_text
	if false:
		text += completed
	task_label.text = text

func _on_break_time():
	var text = ""
	var day = Global.game_manager.current_day
	if day < 3:
		text += Utils.bbc_text("Leave the power plant for your break", 30)
	elif day == 3:
		text += Utils.bbc_text("Get a snack from the kitchen, there is no time to leave the site", 30)
	task_label.text = text

func _on_day_done():
	var text = ""
	var day = Global.game_manager.current_day
	if day <= 2:
		text += Utils.bbc_text("Go home to sleep", 30)
	else:
		text += Utils.bbc_text("Sleep on the couch in your office", 30)
	task_label.text = text

func _on_hide_pressed():
	hide_taskbar(hide)

func hide_taskbar(set_visiblity = true):
	$TaskBG.visible = !set_visiblity
	hide = !set_visiblity
	eye_hide.texture_normal = eye_closed if hide else eye_open
	eye_hide.texture_hover = eye_closed if !hide else eye_open

func show_alarm():
	alarm.visible = true

func hide_alarm():
	alarm.visible = false
	
func _process(delta):
	clock_label.text = "[center]%s[/center]" % [Global.time_manager.get_formated_ingame_time()]
	if Global.game_manager.current_day == 3 or Global.game_manager.current_day == 4:
		update_task_display()
	if not get_tree().paused and Input.is_action_just_pressed("hide_taskbar"):
		hide_taskbar(hide)


func _on_pause_pressed():
	Global.game_manager.pause_game()
