extends Control
class_name Room

func get_tasks_for_day(day):
	var return_tasks = []
	var day_string = "Tasks/Day%d" % [day+1]
	var day_node = get_node_or_null(day_string)
	if day_node != null:
		for n in day_node.get_children():
			if n is Task:
				return_tasks.append(n)
	return return_tasks
