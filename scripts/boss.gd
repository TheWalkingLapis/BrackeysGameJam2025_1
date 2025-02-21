extends Room

@onready var code = $Code

var maze_task = null

func setup_day(day, post_break):
	$Code.visible = false
	match day:
		0:
			maze_task = null
		1:
			maze_task = null
		2:
			maze_task = null
		3:
			maze_task = null
		4:
			maze_task = null
		5:
			maze_task = $Tasks/Day6/Task_maze
			if !post_break:
				# second digit never 0 to avoid 0000
				Global.plutonium_code = [randi_range(0, 9), randi_range(1, 9), randi_range(0, 9),randi_range(0, 9)]
	$Code/CodeTxt.text = "[u][center]Plutonium code:[/center][/u]\n[center]%d%d%d%d[/center]" % [Global.plutonium_code[0], Global.plutonium_code[1], Global.plutonium_code[2], Global.plutonium_code[3]]

func _on_vault_pressed():
	if !Global.game_manager.allow_interaction: return
	if maze_task != null:
		if !(maze_task as Task).get_task_completed():
			maze_task.start_task()
		else:
			$Code.visible = true
	else:
		Global.text_manager.display_interaction_text("I should leave it alone")


func _on_leave_pressed():
	if !Global.game_manager.allow_interaction and (!Global.time_manager.break_active and Global.time_manager.day_active): return
	$Code.visible = false
	Global.room_manager.change_room_to("Main_Hallway")
