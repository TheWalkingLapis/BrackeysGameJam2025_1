extends Control
class_name TimeManager

signal break_time()
signal break_time_over()
signal day_done()
signal evening()

const ingame_hour_in_seconds: float = 15.0
const evening_hour: int = 17

var day_start_hour: int = 0
var day_end_hour: int = 0
var day_break_hour: int = 0
var post_break: bool = false
var day_break_duration: int = 0
var day_time = "day"

var current_ingame_time: float = 0.0
var current_ingame_hour: int = 0
var current_real_time: float = 0.0
var time_fac: float = 1.0

var day_active = false
var break_active = false

@export var ingame_day_times: Array[DayDurationTimes]

func _ready():
	pass

func start_day(day: int):
	day_start_hour = ingame_day_times[day].start_hour
	day_end_hour = ingame_day_times[day].end_hour
	day_break_hour = ingame_day_times[day].break_hour
	day_break_duration = ingame_day_times[day].break_duration
	current_ingame_time = day_start_hour
	current_ingame_hour = floor(current_ingame_time)
	current_real_time = 0.0
	time_fac = 1.0
	day_active = true
	break_active = false
	post_break = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !day_active or break_active: 
		return
	var prev_hour = floor(current_ingame_time)
	current_real_time += delta * time_fac
	current_ingame_time = day_start_hour + (current_real_time / ingame_hour_in_seconds)
	current_ingame_hour = floor(current_ingame_time)
	if !post_break and current_ingame_hour == day_break_hour:
		break_time.emit()
		break_active = true
	if current_ingame_hour == evening_hour and day_time != "evening":
		evening.emit()
		day_time = "evening"
	if current_ingame_hour == day_end_hour:
		current_ingame_time = day_end_hour
		current_real_time = (current_ingame_time - day_start_hour) * ingame_hour_in_seconds
		day_active = false
		day_done.emit()

func resume_after_break():
	current_ingame_time = day_break_hour + day_break_duration
	current_real_time = (current_ingame_time - day_start_hour) * ingame_hour_in_seconds
	break_active = false
	post_break = true
	break_time_over.emit()

func get_formated_ingame_time():
	var hours = current_ingame_hour
	var minutes = floor(60 * (current_ingame_time - current_ingame_hour))
	return "%02d:%02d" % [hours, minutes]

func get_working_hours():
	return [day_start_hour, day_end_hour]

func change_time_speed(new_fac: float):
	time_fac = new_fac
