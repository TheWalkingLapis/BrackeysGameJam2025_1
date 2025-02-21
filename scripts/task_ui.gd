extends Control

@onready var task_label = $TaskBG/TaskBox

var current_tasks = {}
var hide = false

var optional_string = "Optional"
var watering_string = "Watering"
var resupply_string = "Resupply"
var wire_string = "Wires"
var save_the_world_string = "Save the World"
var task_string = "Tasks" # default


var order_dict = {
	save_the_world_string: 2,
	wire_string: 5,
	watering_string: 10,
	resupply_string: 15,
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
			else:
				current_tasks[task_string].append(task)
	if current_tasks.has(watering_string):
		current_tasks[watering_string].sort_custom(Task._task_compare_func)
	if current_tasks.has(resupply_string):
		current_tasks[resupply_string].sort_custom(Task._task_compare_func)
	if current_tasks.has(save_the_world_string):
		current_tasks[save_the_world_string].sort_custom(Task._task_compare_func)
	update_task_text()

func update_task_display():
	if Global.time_manager.break_active: return
	update_task_text()

func update_task_text():
	var working_hours = Global.time_manager.get_working_hours()
	var text = ""
	var working_hour_text = "Today's Working Hours: %02d:00 - %02d:00\n" % [working_hours[0], working_hours[1]]
	var break_time_text = "Break Time at %02d:00" % Global.time_manager.day_break_hour
	if Global.time_manager.day_break_duration >= 1:
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
			text += Utils.bbc_underline(Utils.bbc_text("%s:\n" % category, 30))
		
		
		for t in task_list:
			var task := t as Task
			var task_texts = task.get_task_strings()
			var task_text = "  - %s\n" % Utils.bbc_text(task_texts[0], 25)
			task_text += "     %s\n" % Utils.bbc_text(task_texts[1], 18)
			if task.get_task_completed():
				completed_flag = true
				completed += Utils.bbc_strikethrough(task_text)
			else:
				text += task_text
	if completed_flag:
		text += completed
	task_label.text = text

func _on_break_time():
	var text = ""
	var day = Global.game_manager.current_day
	if day <= 3:
		text += Utils.bbc_text("Leave the power plant for your break", 30)
	elif day == 4:
		text += Utils.bbc_text("Get a snack from the kitchen, no time to leave the site", 30)
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
	$TaskBG.visible = hide
	hide = !hide
