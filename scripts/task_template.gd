extends Control
class_name Task

signal started()
signal completed()

enum TaskTag {NONE}

@export var task_name: String = "Task"
@export var task_description: String = "Short txt of what to do"
@export var tag: TaskTag = TaskTag.NONE

@export var optional: bool = false
@export var uncompletable: bool = false
@export var after_mealtime: bool = false
@export var whole_day: bool = false


var is_completed: bool = false

func set_task_completed():
	if !uncompletable:
		is_completed = true
	completed.emit()

func get_task_completed():
	return is_completed
	
func reset_task():
	is_completed = false

func get_task_strings():
	var header = task_name
	var subtext = task_description
	
	return [header, subtext]
