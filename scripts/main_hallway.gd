extends Room

var allowed_rooms = {
	0: ["Plan", "Office"],
	1: ["Plan", "Office"],
	2: ["Plan", "Office"],
	3: ["Plan", "Office"],
	4: ["Plan", "Office"],
	5: ["Plan", "Office"]
}

var room_not_allowed_txt = "I shouldn't go there"
var break_txt = "I should take a break first"

func try_enter_room(room, break_active_txt=break_txt, not_allowed_txt=room_not_allowed_txt):
	if Global.game_manager.allow_interaction:
		if room in allowed_rooms[Global.game_manager.current_day]:
			Global.room_manager.change_room_to(room)
		elif Global.time_manager.break_active:
			Global.text_manager.display_interaction_text(break_txt)
		else:
			Global.text_manager.display_interaction_text(room_not_allowed_txt)

func _on_hr_pressed():
	try_enter_room("Office")

func _on_boss_pressed():
	try_enter_room("Boss")

func _on_kitchen_pressed():
	try_enter_room("Kitchen")

func _on_storage_pressed():
	try_enter_room("Storage")

func _on_passage_pressed():
	try_enter_room("Passage")

func _on_plan_pressed():
	try_enter_room("Plan")

func _on_restaurant_pressed():
	if Global.time_manager.break_active:
		Global.room_manager.change_room_to("Restaurant")
	else:
		Global.text_manager.display_interaction_text("I got no time to leave")
