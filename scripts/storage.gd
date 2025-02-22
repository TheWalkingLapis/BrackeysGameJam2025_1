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
var build_bomb_task = null

func setup_day(day, post_break):
	if post_break: return
	match day:
		0:
			wire_task = null
			pickup_cereal_task = null
			pickup_coffee_task = null
			pickup_hazmat_task = null
			pickup_uranium_task = null
			pickup_bomb_kit_task = null
			pickup_plutonium_task = null
			build_bomb_task = null
		1:
			wire_task = null
			pickup_cereal_task = null
			pickup_coffee_task = null
			pickup_hazmat_task = null
			pickup_uranium_task = null
			pickup_bomb_kit_task = null
			pickup_plutonium_task = null
			build_bomb_task = null
		2:
			wire_task = $Tasks/Day3/Task_Fix_Wires
			pickup_cereal_task = $Tasks/Day3/Task_Pick_up_Cereal_Bar
			pickup_coffee_task = $Tasks/Day3/Task_Pick_up_Coffee_Cup
			pickup_hazmat_task = $Tasks/Day3/Task_Pick_up_hazmat
			pickup_uranium_task = $Tasks/Day3/Task_Pick_up_Uranium
			pickup_bomb_kit_task = null
			pickup_plutonium_task = null
			build_bomb_task = null
		3:
			wire_task = null
			pickup_cereal_task = $Tasks/Day4/Task_Pick_up_Cereal_Bar
			pickup_coffee_task = $Tasks/Day4/Task_Pick_up_Coffee_Cup
			pickup_hazmat_task = $Tasks/Day4/Task_Pick_up_hazmat
			pickup_uranium_task = $Tasks/Day4/Task_Pick_up_Uranium
			pickup_bomb_kit_task = null
			pickup_plutonium_task = null
			build_bomb_task = null
		4:
			wire_task = $Tasks/Day5/Task_Fix_Wires
			pickup_cereal_task = $Tasks/Day5/Task_Pick_up_Cereal_Bar
			pickup_coffee_task = $Tasks/Day5/Task_Pick_up_Coffee_Cup
			pickup_hazmat_task = $Tasks/Day5/Task_Pick_up_hazmat
			pickup_uranium_task = $Tasks/Day5/Task_Pick_up_Uranium
			pickup_bomb_kit_task = $Tasks/Day5/Task_Pick_up_bomb_kit
			pickup_plutonium_task = null
			build_bomb_task = $Tasks/Day5/Task_craft_atom_bomb
		5:
			wire_task = null
			pickup_cereal_task = null
			pickup_coffee_task = null
			pickup_hazmat_task = null
			pickup_uranium_task = null
			pickup_bomb_kit_task = null
			pickup_plutonium_task = $Tasks/Day6/Task_Pick_up_plutonium
			build_bomb_task = null
	
	$pickup_cereal_bar.visible = pickup_cereal_task != null
	$pickup_coffee.visible = pickup_coffee_task != null
	$pickup_uranium.visible = pickup_uranium_task != null
	$pickup_hazmat.visible = pickup_hazmat_task != null
	pickup_bomb_kit.visible = pickup_bomb_kit_task != null
	pickup_plutonium.visible = pickup_plutonium_task != null

func _on_leave_pressed():
	if !Global.game_manager.allow_interaction and (!Global.time_manager.break_active and Global.time_manager.day_active): return
	Global.room_manager.change_room_to("Main_Hallway")

func _on_pickup_cereal_bar_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_cereal_task != null and !(pickup_cereal_task as Task).get_task_completed():
			if not Global.cereal_bar_ordered:
				Global.text_manager.display_interaction_text("I need to order this first.")
			elif Global.inventory.is_empty():
				pickup_cereal_task.start_task()
				$pickup_cereal_bar.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up.")

func _on_pickup_coffee_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_coffee_task != null and !(pickup_coffee_task as Task).get_task_completed():
			if not Global.coffee_cup_ordered:
				Global.text_manager.display_interaction_text("I need to order this first.")
			elif Global.inventory.is_empty():
				pickup_coffee_task.start_task()
				$pickup_coffee.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up.")

func _on_pickup_uranium_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_uranium_task != null and !(pickup_uranium_task as Task).get_task_completed():
			if not Global.uranium_ordered:
				Global.text_manager.display_interaction_text("I need to order this first.")
			elif Global.inventory.is_empty():
				pickup_uranium_task.start_task()
				$pickup_uranium.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up.")

func _on_pickup_hazmat_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_hazmat_task != null and !(pickup_hazmat_task as Task).get_task_completed():
			if not Global.hazmat_suit_ordered:
				Global.text_manager.display_interaction_text("I need to order this first.")
			elif Global.inventory.is_empty():
				pickup_hazmat_task.start_task()
				$pickup_hazmat.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up.")

func _on_pickup_bomb_kit_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_bomb_kit_task != null and !(pickup_bomb_kit_task as Task).get_task_completed():
			if not Global.bomb_ordered:
				Global.text_manager.display_interaction_text("I need to order this first.")
			elif Global.inventory.is_empty():
				pickup_bomb_kit_task.start_task()
				$pickup_bomb_kit.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up.")

func _on_pickup_plutonium_pressed():
	if Global.game_manager.allow_interaction:
		if pickup_plutonium_task != null:
			if !(pickup_plutonium_task as Task).get_task_completed():
				if not Global.plutonium_ordered:
					Global.text_manager.display_interaction_text("I need to order this first.")
				elif Global.inventory.is_empty():
					pickup_plutonium_task.start_task()
					$pickup_plutonium.visible = false
				else:
					Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up.")


func _on_orders_update(): # called when leaving office 
	# this should be considered a war crime
	if pickup_cereal_task != null:
		pickup_cereal_task.get_child(0).visible = Global.cereal_bar_ordered and !Global.cereal_bar_delivered and !Global.inventory.has_item(Inventory.Items.CEREAL_BAR)
	if pickup_coffee_task != null:
		pickup_coffee_task.get_child(0).visible = Global.coffee_cup_ordered and !Global.coffee_cup_delivered and !Global.inventory.has_item(Inventory.Items.COFFEE_CUP)
	if pickup_hazmat_task != null:
		pickup_hazmat_task.get_child(0).visible = Global.hazmat_suit_ordered and !Global.hazmat_suit_delivered and !Global.inventory.has_item(Inventory.Items.HAZMAT_SUIT)
	if pickup_uranium_task != null:
		pickup_uranium_task.get_child(0).visible = Global.uranium_ordered and !Global.uranium_delivered and !Global.inventory.has_item(Inventory.Items.URANIUM)
	if pickup_bomb_kit_task != null:
		pickup_bomb_kit_task.get_child(0).visible = Global.bomb_ordered and !Global.bomb_delivered and !Global.inventory.has_item(Inventory.Items.BOMB_KIT)
	if pickup_plutonium_task != null:
		pickup_plutonium_task.get_child(0).visible = Global.plutonium_ordered and !Global.plutonium_delivered and !Global.inventory.has_item(Inventory.Items.PLUTONIUM)


func _on_wirebox_pressed():
	if !Global.game_manager.allow_interaction: return
	if wire_task != null:
		if (wire_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already fixed these wires.")
		else:
			wire_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I think this one is not broken.")


func _on_workbench_pressed():
	if !Global.game_manager.allow_interaction: return
	if build_bomb_task != null:
		if (build_bomb_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I'm done building the atom bomb.")
		elif Global.inventory.has_item(Inventory.Items.BOMB_KIT):
			build_bomb_task.start_task()
		else:
			Global.text_manager.display_interaction_text("I need the atom bomb kit.")
	else:
		Global.text_manager.display_interaction_text("I don't have anything to use here.")
