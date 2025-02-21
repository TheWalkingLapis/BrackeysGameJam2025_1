extends Room

@onready var pickup_bomb_kit = $pickup_bomb_kit
@onready var pickup_plutonium = $pickup_plutonium

var pickup_cereal_task = null
var pickup_coffee_task = null
var pickup_hazmat_task = null
var pickup_uranium_task = null
var pickup_bomb_kit_task = null
var pickup_plutonium_task = null
var wire_task = null

func setup_day(day, post_break):
	match day:
		0:
			wire_task = null
			pickup_cereal_task = null
			pickup_coffee_task = null
			pickup_hazmat_task = null
			pickup_uranium_task = null
			pickup_bomb_kit_task = null
			pickup_plutonium_task = null
			$pickup_cereal_bar.visible = true
			$pickup_coffee.visible = true
			$pickup_uranium.visible = true
			$pickup_hazmat.visible = true
			pickup_bomb_kit.visible = false
			pickup_plutonium.visible = false
		1:
			wire_task = null
			pickup_cereal_task = null
			pickup_coffee_task = null
			pickup_hazmat_task = null
			pickup_uranium_task = null
			pickup_bomb_kit_task = null
			pickup_plutonium_task = null
			$pickup_cereal_bar.visible = true
			$pickup_coffee.visible = true
			$pickup_uranium.visible = true
			$pickup_hazmat.visible = true
			pickup_bomb_kit.visible = false
			pickup_plutonium.visible = false
		2:
			wire_task = $Tasks/Day3/Task_Fix_Wires
			if pickup_cereal_task != null and (pickup_cereal_task as Task).get_task_completed():
				pickup_cereal_task = null
			else:
				pickup_cereal_task = $Tasks/Day3/Task_Pick_up_Cereal_Bar
			if pickup_coffee_task != null and (pickup_coffee_task as Task).get_task_completed():
				pickup_coffee_task = null
			else:
				pickup_coffee_task = $Tasks/Day3/Task_Pick_up_Coffee_Cup
			if pickup_hazmat_task != null and (pickup_hazmat_task as Task).get_task_completed():
				pickup_hazmat_task = null
			else:
				pickup_hazmat_task = $Tasks/Day3/Task_Pick_up_hazmat
			if pickup_uranium_task != null and (pickup_uranium_task as Task).get_task_completed():
				pickup_uranium_task = null
			else:
				pickup_uranium_task = $Tasks/Day3/Task_Pick_up_Uranium
			pickup_bomb_kit_task = null
			pickup_plutonium_task = null
			$pickup_cereal_bar.visible = true
			$pickup_coffee.visible = true
			$pickup_uranium.visible = true
			$pickup_hazmat.visible = true
			pickup_bomb_kit.visible = false
			pickup_plutonium.visible = false
		3:
			wire_task = null
			if pickup_cereal_task != null and (pickup_cereal_task as Task).get_task_completed():
				pickup_cereal_task = null
			else:
				pickup_cereal_task = $Tasks/Day4/Task_Pick_up_Cereal_Bar
			if pickup_coffee_task != null and (pickup_coffee_task as Task).get_task_completed():
				pickup_coffee_task = null
			else:
				pickup_coffee_task = $Tasks/Day4/Task_Pick_up_Coffee_Cup
			if pickup_hazmat_task != null and (pickup_hazmat_task as Task).get_task_completed():
				pickup_hazmat_task = null
			else:
				pickup_hazmat_task = $Tasks/Day4/Task_Pick_up_hazmat
			if pickup_uranium_task != null and (pickup_uranium_task as Task).get_task_completed():
				pickup_uranium_task = null
			else:
				pickup_uranium_task = $Tasks/Day4/Task_Pick_up_Uranium
			pickup_bomb_kit_task = null
			pickup_plutonium_task = null
			$pickup_cereal_bar.visible = true
			$pickup_coffee.visible = true
			$pickup_uranium.visible = true
			$pickup_hazmat.visible = true
			pickup_bomb_kit.visible = false
			pickup_plutonium.visible = false
		4:
			wire_task = $Tasks/Day5/Task_Fix_Wires
			if pickup_cereal_task != null and (pickup_cereal_task as Task).get_task_completed():
				pickup_cereal_task = null
			else:
				pickup_cereal_task = $Tasks/Day5/Task_Pick_up_Cereal_Bar
			if pickup_coffee_task != null and (pickup_coffee_task as Task).get_task_completed():
				pickup_coffee_task = null
			else:
				pickup_coffee_task = $Tasks/Day5/Task_Pick_up_Coffee_Cup
			if pickup_hazmat_task != null and (pickup_hazmat_task as Task).get_task_completed():
				pickup_hazmat_task = null
			else:
				pickup_hazmat_task = $Tasks/Day5/Task_Pick_up_hazmat
			if pickup_uranium_task != null and (pickup_uranium_task as Task).get_task_completed():
				pickup_uranium_task = null
			else:
				pickup_uranium_task = $Tasks/Day5/Task_Pick_up_Uranium
			if pickup_bomb_kit_task != null and (pickup_bomb_kit_task as Task).get_task_completed():
				pickup_bomb_kit_task = null
			else:
				pickup_bomb_kit_task = $Tasks/Day5/Task_Pick_up_bomb_kit
			pickup_plutonium_task = null
			$pickup_cereal_bar.visible = true
			$pickup_coffee.visible = true
			$pickup_uranium.visible = true
			$pickup_hazmat.visible = true
			pickup_bomb_kit.visible = true
			pickup_plutonium.visible = false
		5:
			wire_task = $Tasks/Day6/Task_Fix_Wires
			if pickup_cereal_task != null and (pickup_cereal_task as Task).get_task_completed():
				pickup_cereal_task = null
			else:
				pickup_cereal_task = $Tasks/Day6/Task_Pick_up_Cereal_Bar
			if pickup_coffee_task != null and (pickup_coffee_task as Task).get_task_completed():
				pickup_coffee_task = null
			else:
				pickup_coffee_task = $Tasks/Day6/Task_Pick_up_Coffee_Cup
			if pickup_hazmat_task != null and (pickup_hazmat_task as Task).get_task_completed():
				pickup_hazmat_task = null
			else:
				pickup_hazmat_task = $Tasks/Day6/Task_Pick_up_hazmat
			if pickup_uranium_task != null and (pickup_uranium_task as Task).get_task_completed():
				pickup_uranium_task = null
			else:
				pickup_uranium_task = $Tasks/Day6/Task_Pick_up_Uranium
			if pickup_bomb_kit_task != null and (pickup_bomb_kit_task as Task).get_task_completed():
				pickup_bomb_kit_task = null
			else:
				pickup_bomb_kit_task = $Tasks/Day6/Task_Pick_up_bomb_kit
			if pickup_plutonium_task != null and (pickup_plutonium_task as Task).get_task_completed():
				pickup_plutonium_task = null
			else:
				pickup_plutonium_task = $Tasks/Day6/Task_Pick_up_plutonium
			$pickup_cereal_bar.visible = true
			$pickup_coffee.visible = true
			$pickup_uranium.visible = true
			$pickup_hazmat.visible = true
			pickup_bomb_kit.visible = true
			pickup_plutonium.visible = true

func _on_leave_pressed():
	if !Global.game_manager.allow_interaction and (!Global.time_manager.break_active and Global.time_manager.day_active): return
	Global.room_manager.change_room_to("Main_Hallway")

func _on_pickup_cereal_bar_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_cereal_task != null and !(pickup_cereal_task as Task).get_task_completed():
			if not Global.cereal_bar_ordered:
				Global.text_manager.display_interaction_text("I need to order this first")
			elif Global.inventory.is_empty():
				pickup_cereal_task.start_task()
				pickup_cereal_task.visible = false
				$pickup_cereal_bar.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up")

func _on_pickup_coffee_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_coffee_task != null and !(pickup_coffee_task as Task).get_task_completed():
			if not Global.coffee_cup_ordered:
				Global.text_manager.display_interaction_text("I need to order this first")
			elif Global.inventory.is_empty():
				pickup_coffee_task.start_task()
				pickup_coffee_task.visible = false
				$pickup_coffee.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up")

func _on_pickup_uranium_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_uranium_task != null and !(pickup_uranium_task as Task).get_task_completed():
			if not Global.uranium_ordered:
				Global.text_manager.display_interaction_text("I need to order this first")
			elif Global.inventory.is_empty():
				pickup_uranium_task.start_task()
				pickup_uranium_task.visible = false
				$pickup_uranium.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up")

func _on_pickup_hazmat_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_hazmat_task != null and !(pickup_hazmat_task as Task).get_task_completed():
			if not Global.hazmat_suit_ordered:
				Global.text_manager.display_interaction_text("I need to order this first")
			elif Global.inventory.is_empty():
				pickup_hazmat_task.start_task()
				pickup_hazmat_task.visible = false
				$pickup_hazmat.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up")

func _on_pickup_bomb_kit_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_bomb_kit_task != null and !(pickup_bomb_kit_task as Task).get_task_completed():
			if not Global.bomb_ordered:
				Global.text_manager.display_interaction_text("I need to order this first")
			elif Global.inventory.is_empty():
				pickup_bomb_kit_task.start_task()
				pickup_bomb_kit_task.visible = false
				$pickup_bomb_kit.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up")

func _on_pickup_plutonium_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_plutonium != null and !(pickup_plutonium as Task).get_task_completed():
			if not Global.plutonium_ordered:
				Global.text_manager.display_interaction_text("I need to order this first")
			elif Global.inventory.is_empty():
				pickup_plutonium.start_task()
				pickup_plutonium.visible = false
				$pickup_plutonium.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up")


func _on_orders_update(): # called when leaving office 
	# this should be considered a war crime
	if pickup_cereal_task != null:
		pickup_cereal_task.get_child(0).visible = Global.cereal_bar_ordered
	if pickup_coffee_task != null:
		pickup_coffee_task.get_child(0).visible = Global.coffee_cup_ordered
	if pickup_hazmat_task != null:
		pickup_hazmat_task.get_child(0).visible = Global.hazmat_suit_ordered
	if pickup_uranium_task != null:
		pickup_uranium_task.get_child(0).visible = Global.uranium_ordered
	if pickup_bomb_kit_task != null:
		pickup_bomb_kit_task.get_child(0).visible = Global.bomb_ordered
	if pickup_plutonium_task != null:
		pickup_plutonium_task.get_child(0).visible = Global.plutonium_ordered


func _on_wirebox_pressed():
	if !Global.game_manager.allow_interaction: return
	if wire_task != null:
		if (wire_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already fixed these wires")
		else:
			wire_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I think this one is not broken")
