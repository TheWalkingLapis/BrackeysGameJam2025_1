extends Control
class_name Task

signal started()
signal completed()

@export var task_name: String = "Task"
@export var task_description: String = "Short txt of what to do"

@export var task_progression_goal: int = 1
var task_progression: int = 0

@export var task_duration_in_hours: float = -1.0
@export var task_allowed_from: float = -1.0
@export var task_allowed_to: float = -1.0

var is_completed: bool = false

func set_task_completed():
	is_completed = true
	completed.emit()

func get_task_completed():
	return is_completed

func get_task_allowed_at(time: float):
	return task_allowed_from <= time and task_allowed_to >= time

func get_task_strings():
	var start_time_formated = "%02d:%02d" % [int(task_allowed_from), int(60*fmod(task_allowed_from, 1.0))]
	var end_time_formated = "%02d:%02d" % [int(task_allowed_to), int(60*fmod(task_allowed_to, 1.0))]
	
	var header = "%d/%d: %s" % [task_progression, task_progression_goal, task_name]
	if task_allowed_from > 0:
		header += " (between %s - %s)" % [start_time_formated, end_time_formated]
	var subtext = ""
	if task_duration_in_hours > 0:
		if task_duration_in_hours < 1.0:
			subtext = "(%02d min) %s" % [int(60 * task_duration_in_hours), task_description]
		else:
			subtext = "(%02d:%02d h) %s" % [task_duration_in_hours, int(60 * task_duration_in_hours), task_description]
	else:
		subtext = task_description
	
	return [header, subtext]
