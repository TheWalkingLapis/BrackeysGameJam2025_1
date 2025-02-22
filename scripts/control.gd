extends Room

signal meltdown()
signal start_alarm()
signal stop_alarm()

var temperature = 0
var fuel = 100
var temperature_decay = 2.5
var temperature_decrease_rate = 5
var fuel_decay = 1

var temperature_critical = false
var fuel_critical = false

var wire_task = null
var open_fuel_task = null
var close_fuel_task = null
var temperature_task = null

func _ready():
	$Tasks/Day4/Task_close_fuel.refueled.connect(_on_refuel)
	$Tasks/Day5/Task_close_fuel.refueled.connect(_on_refuel)
	
	$Tasks/Day4/Task_Temperature.decrease_temperature.connect(_on_decrease_temperature)
	$Tasks/Day5/Task_Temperature.decrease_temperature.connect(_on_decrease_temperature)

func setup_day(day, post_break):
	if !post_break:
		temperature = 0
		fuel = 100
		Global.fuel_task_progress = 0
	match day:
		0:
			wire_task = null
			open_fuel_task = null
			close_fuel_task = null
			temperature_task = null
		1:
			wire_task = null
			open_fuel_task = null
			close_fuel_task = null
			temperature_task = null
		2:
			wire_task = null
			open_fuel_task = null
			close_fuel_task = null
			temperature_task = null
		3:
			wire_task = $Tasks/Day4/Task_Fix_Wires
			open_fuel_task = $Tasks/Day4/Task_open_fuel
			close_fuel_task = $Tasks/Day4/Task_close_fuel
			temperature_task = $Tasks/Day4/Task_Temperature
		4:
			wire_task = $Tasks/Day5/Task_Fix_Wires
			open_fuel_task = $Tasks/Day5/Task_open_fuel
			close_fuel_task = $Tasks/Day5/Task_close_fuel
			temperature_task = $Tasks/Day5/Task_Temperature
		5:
			wire_task = null
			open_fuel_task = null
			close_fuel_task = null
			temperature_task = null

func _on_leave_pressed():
	if !Global.game_manager.allow_interaction and (!Global.time_manager.break_active and Global.time_manager.day_active): return
	Global.room_manager.change_room_to("Passage")

func _on_wirebox_pressed():
	if !Global.game_manager.allow_interaction: return
	if wire_task != null:
		if (wire_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already fixed these wires.")
		else:
			wire_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I think this one is not broken.")

func _process(delta):
	if Global.time_manager.break_active or !Global.time_manager.day_active: return
	if Global.game_manager.current_day < 3 or Global.game_manager.current_day == 5: return
	temperature += temperature_decay * Global.time_manager.time_fac * delta
	fuel -= fuel_decay * Global.time_manager.time_fac * delta
	
	if fuel < 0 or temperature > 100:
		meltdown.emit()
	
	fuel = clamp(fuel, 0, 100)
	temperature = clamp(temperature, 0, 100)
	
	var new_temperature_critical = temperature > 80
	var new_fuel_critical = fuel < 15
	var critical = temperature_critical or fuel_critical
	var new_critical = new_temperature_critical or new_fuel_critical
	if new_critical != critical:
		if new_critical: 
			start_alarm.emit()
		else: 
			stop_alarm.emit()
	temperature_critical = new_temperature_critical
	fuel_critical = new_fuel_critical
	
	$Temperator_display/RichTextLabel.text = "[center]%dC[/center]" % [temperature * Global.temperatur_scale]

func _on_refuel():
	fuel = 100

func _on_decrease_temperature():
	temperature -= temperature_decrease_rate
	temperature = max(0, temperature)

func _on_fuel_display_pressed():
	if Global.game_manager.allow_interaction:
		if open_fuel_task != null and close_fuel_task != null:
			if Global.fuel_task_progress == 0:
				open_fuel_task.start_task()
			elif Global.fuel_task_progress == 2:
				close_fuel_task.start_task()
			else:
				Global.text_manager.display_interaction_text("I need to check the fuel rods before lowering them back into the reactor. Big D said simply touching them is sufficient.")
		else:
			Global.text_manager.display_interaction_text("I should leave this alone.")

func _on_temperator_display_pressed():
	if Global.game_manager.allow_interaction:
		if temperature_task != null:
			temperature_task.start_task()
		else:
			Global.text_manager.display_interaction_text("I should leave this alone.")
