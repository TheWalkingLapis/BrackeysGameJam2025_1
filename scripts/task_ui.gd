extends Control

@onready var task_label = $TaskBG/TaskBox

var current_tasks = {}

func set_tasks(tasks):
	current_tasks = tasks
	update_task_text()

func update_task_display():
	update_task_text()

func update_task_text():
	var working_hours = Global.time_manager.get_working_hours()
	var text = ""
	var working_hour_text = "Today's Working Hours: %02d:00 - %02d:00\n" % [working_hours[0], working_hours[1]]
	var break_time_text = "Break Time at %02d:00\n" % Global.time_manager.day_break_hour
	text += Utils.bbc_text(working_hour_text, 22)
	if !Global.time_manager.post_break:
		text += Utils.bbc_text(break_time_text, 22)
	for room in current_tasks:
		var task_list = current_tasks[room]
		if len(task_list) == 0: continue
		text += "%s:\n" % [room]
		for task in task_list:
			var task_texts = (task as Task).get_task_strings()
			var task_text = " - %s\n" % Utils.bbc_text(task_texts[0], 25)
			task_text += "   %s\n" % Utils.bbc_text(task_texts[1], 18)
			text += Utils.bbc_strikethrough(task_text) if (task as Task).get_task_completed() else task_text
	task_label.text = text
