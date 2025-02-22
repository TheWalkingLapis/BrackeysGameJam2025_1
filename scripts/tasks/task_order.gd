extends Task

@onready var active = $Active
@onready var normal_shop = $Active/Screen_normal
@onready var bomb_shop = $Active/Screen_bomb
@onready var plutonium_shop = $Active/Screen_plutonium
@onready var code = $Active/Screen_code
@onready var correct = $Active/Screen_correct
@onready var wrong = $Active/Screen_wrong

@onready var unlock_button = $Active/Buttons/Unlock_plutonium
@onready var locked_order_button = $Active/Buttons/Order_plutonium

@onready var block_cereal = $Active/Buttons/Block_cereal
@onready var block_coffee = $Active/Buttons/Block_coffee
@onready var block_uranium = $Active/Buttons/Block_uranium
@onready var block_hazmat = $Active/Buttons/Block_hazmat
@onready var block_bomb = $Active/Buttons/Block_bomb
@onready var block_plutonium = $Active/Buttons/Block_plutonium

@onready var bomb_icon = $Active/Icons/bomb_icon
@onready var plutonium_icon = $Active/Icons/plutonium_icon

@onready var digit1 = $Active/Code/Digit1
@onready var digit2 = $Active/Code/Digit2
@onready var digit3 = $Active/Code/Digit3
@onready var digit4 = $Active/Code/Digit4

var plutonium_unlocked = false
var digits = [0,0,0,0]

func start_task():
	if get_task_completed():
		return
	reset_screen()
	active.visible = true
	match Global.game_manager.current_day:
		0:
			normal_shop.visible = true
		1:
			normal_shop.visible = true
		2:
			normal_shop.visible = true
		3:
			normal_shop.visible = true
		4:
			bomb_shop.visible = true
		5:
			if plutonium_unlocked:
				plutonium_shop.visible = true
				unlock_button.visible = false
				locked_order_button.visible = true
			else:
				bomb_shop.visible = true
	
	$Active/Buttons.visible = true
	$Active/Icons.visible = true
	$Active/Code.visible = false
	
	if Global.game_manager.current_day == 5:
		block_cereal.visible = true
		block_coffee.visible = true
		block_uranium.visible = true
		block_hazmat.visible = true
		block_bomb.visible = true
	elif Global.game_manager.current_day == 4:
		block_plutonium.visible = true
	else:
		block_bomb.visible = true
		block_plutonium.visible = true
	
	bomb_icon.visible = Global.game_manager.current_day >= 4
	plutonium_icon.visible = (Global.game_manager.current_day == 5 and plutonium_unlocked)
	
	started.emit(self)
	if Global.auto_hide_on_task:
		Global.ui_manager.taskUI.hide_taskbar()

func reset_task():
	super.reset_task()
	active.visible = false
	
	bomb_icon.visible = false
	plutonium_icon.visible = false
	
	block_cereal.visible = false
	block_coffee.visible = false
	block_uranium.visible = false
	block_hazmat.visible = false
	block_bomb.visible = false
	block_plutonium.visible = false
	
	plutonium_unlocked = false
	
	reset_screen()

func reset_screen():
	normal_shop.visible = false
	bomb_shop.visible = false
	plutonium_shop.visible = false
	code.visible = false
	wrong.visible = false
	correct.visible = false
	unlock_button.visible = true
	locked_order_button.visible = false

func _on_leave_pressed():
	active.visible = false
	var all_ordered = (Global.cereal_bar_ordered and Global.coffee_cup_ordered and Global.uranium_ordered and Global.hazmat_suit_ordered)
	if  Global.game_manager.current_day >= 4:
		all_ordered = all_ordered and Global.bomb_ordered
	if  Global.game_manager.current_day == 5:
		all_ordered = Global.plutonium_ordered
	if !all_ordered:
		quit.emit()
	else:
		set_task_completed()

func _on_order_cereal_bar_pressed():
	if !Global.cereal_bar_ordered:
		Global.cereal_bar_ordered = true
		block_cereal.visible = true

func _on_order_coffee_cup_pressed():
	if !Global.coffee_cup_ordered:
		Global.coffee_cup_ordered = true
		block_coffee.visible = true

func _on_order_uranium_pressed():
	if !Global.uranium_ordered:
		Global.uranium_ordered = true
		block_uranium.visible = true

func _on_order_hazamt_suit_pressed():
	if !Global.hazmat_suit_ordered:
		Global.hazmat_suit_ordered = true
		block_hazmat.visible = true

func _on_order_bomb_pressed():
	if !Global.bomb_ordered and Global.game_manager.current_day == 4:
		Global.bomb_ordered = true
		block_bomb.visible = true

func _on_unlock_plutonium_pressed():
	if !plutonium_unlocked and Global.game_manager.current_day == 5:
		bomb_shop.visible = false
		code.visible = true
		digits = [0,0,0,0]
		digit1.text = "0"
		digit2.text = "0"
		digit3.text = "0"
		digit4.text = "0"
		$Active/Code.visible = true
		$Active/Icons.visible = false
		$Active/Buttons.visible = false

func unlock_success():
	code.visible = false
	$Active/Code.visible = false

func _on_order_plutonium_pressed():
	if plutonium_unlocked and Global.game_manager.current_day == 5:
		Global.plutonium_ordered = true
		block_plutonium.visible = true

func _on_digit_1_pressed():
	digits[0] = (digits[0] + 1) % 10
	digit1.text = str(digits[0])

func _on_digit_2_pressed():
	digits[1] = (digits[1] + 1) % 10
	digit2.text = str(digits[1])

func _on_digit_3_pressed():
	digits[2] = (digits[2] + 1) % 10
	digit3.text = str(digits[2])

func _on_digit_4_pressed():
	digits[3] = (digits[3] + 1) % 10
	digit4.text = str(digits[3])


func _on_submit_pressed():
	code.visible = false
	$Active/Code.visible = false
	for i in range(4):
		if digits[i] != Global.plutonium_code[i]:
			# WRONG
			wrong.visible = true
			return
	# CORRECT
	correct.visible = true


func _on_correct_continue_pressed():
	correct.visible = false
	$Active/Icons.visible = true
	$Active/Buttons.visible = true
	plutonium_icon.visible = true
	bomb_shop.visible = false
	plutonium_shop.visible = true
	unlock_button.visible = false
	locked_order_button.visible = true
	plutonium_unlocked = true

func _on_wrong_continue_pressed():
	wrong.visible = false
	bomb_shop.visible = true
	$Active/Icons.visible = true
	$Active/Buttons.visible = true
