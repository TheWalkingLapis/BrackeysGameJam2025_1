extends Control

@onready var label = $ColorRect/RichTextLabel

var current_tasks = {}

func set_tasks(tasks):
	current_tasks = tasks
	update_task_text()
	
func update_task_text():
	var text = ""
	for room in current_tasks:
		var task_list = current_tasks[room]
		if len(task_list) == 0: continue
		text += "%s:\n" % [room]
		for task in task_list:
			var task_texts = (task as Task).get_task_strings()
			text += " - %s\n" % task_texts[0]
			text += "   %s\n" % task_texts[1]
	label.text = Utils.bbc_text(text, 40)
