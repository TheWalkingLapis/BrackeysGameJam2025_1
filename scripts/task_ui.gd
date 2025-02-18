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
	var text = "Today's Working Hours: %02d:00 - %02d:00\n" % [working_hours[0], working_hours[1]]
	for room in current_tasks:
		var task_list = current_tasks[room]
		if len(task_list) == 0: continue
		text += "%s:\n" % [room]
		for task in task_list:
			var task_texts = (task as Task).get_task_strings()
			text += " - %s\n" % task_texts[0]
			text += "   %s\n" % task_texts[1]
	task_label.text = Utils.bbc_text(text, 25)
