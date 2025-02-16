extends Control
class_name TimeManager

const ingame_hour_in_seconds: float = 15.0

var day_start_hour: int = 0
var day_end_hour: int = 0

var current_ingame_time: float = 0.0
var current_ingame_hour: int = 0
var current_real_time: float = 0.0
var time_fac: float = 1.0

@export var ingame_day_times: Array[DayDurationTimes]

func _ready():
	pass

func start_day(day: int):
	day_start_hour = ingame_day_times[day].start_hour
	day_end_hour = ingame_day_times[day].end_hour
	current_ingame_time = day_start_hour
	current_ingame_hour = floor(current_ingame_time)
	current_real_time = 0.0
	time_fac = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var prev_hour = floor(current_ingame_time)
	current_real_time += delta * time_fac
	current_ingame_time = day_start_hour + (current_real_time / ingame_hour_in_seconds)
	var new_ingame_hour = floor(current_ingame_time)
	if new_ingame_hour > current_ingame_hour:
		print("It is now " + str(new_ingame_hour) + ":00 (current factor = " + str(time_fac) + ")")
	current_ingame_hour = new_ingame_hour

func change_time_speed(new_fac: float):
	time_fac = new_fac
