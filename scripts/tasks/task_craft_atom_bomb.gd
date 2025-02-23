extends Task

@onready var active = $Active

@onready var upper_s = $Active/upper_source
@onready var upper_t = $Active/upper_target
@onready var upper_c = $Active/upper_control
@onready var lower_s = $Active/lower_source
@onready var lower_t = $Active/lower_target
@onready var lower_c = $Active/lower_control
@onready var c4_s = $Active/c4_source
@onready var c4_t = $Active/c4_target
@onready var c4_c = $Active/c4_control
@onready var shielding_s = $Active/shielding_source
@onready var shielding_t = $Active/shielding_target
@onready var shielding_c = $Active/shielding_control
@onready var uranium_s = $Active/uranium_source
@onready var uranium_t = $Active/uranium_target
@onready var uranium_c = $Active/uranium_control

var upper_done = false
var lower_done = false
var c4_done = false
var shielding_done = false
var uranium_done = false

var active_piece = null

func _process(delta):
	if !active.visible: return
	if active_piece != null:
		active_piece.position = get_local_mouse_position() - (active_piece.size / 2)

func start_task():
	if get_task_completed():
		return
	if !Global.inventory.has_item(Global.inventory.Items.BOMB_KIT):
		return
	upper_s.visible = true
	lower_s.visible = true
	c4_s.visible = true
	shielding_s.visible = true
	uranium_s.visible = true
	upper_t.visible = true
	lower_t.visible = true
	c4_t.visible = false
	shielding_t.visible = false
	uranium_t.visible = false
	upper_c.position = upper_s.position
	lower_c.position = lower_s.position
	c4_c.position = c4_s.position
	shielding_c.position = shielding_s.position
	uranium_c.position = uranium_s.position
	upper_done = false
	lower_done = false
	c4_done = false
	shielding_done = false
	uranium_done = false
	active_piece = null
	active.visible = true
	started.emit(self)
	if Global.auto_hide_on_task:
		Global.ui_manager.taskUI.hide_taskbar()

func reset_task():
	super.reset_task()
	active.visible = false

func task_done():
	active.visible = false
	Global.inventory.drop()
	Global.bomb_delivered = true
	set_task_completed()

func _on_leave_pressed():
	active.visible = false
	quit.emit()

## Source
 
func source_helper(source, control):
	if active_piece == control:
		control.position = source.position
		active_piece = null
	elif active_piece == null:
		active_piece = control

func _on_upper_source_pressed():
	source_helper(upper_s, upper_c)

func _on_lower_source_pressed():
	source_helper(lower_s, lower_c)

func _on_c_4_source_pressed():
	source_helper(c4_s, c4_c)

func _on_shielding_source_pressed():
	source_helper(shielding_s, shielding_c)

func _on_uranium_source_pressed():
	source_helper(uranium_s, uranium_c)

## Target

func target_helper(target: TextureButton, control: TextureRect):
	if active_piece == control:
		control.position = target.position
		active_piece = null
		return true
	return false

func check_win():
	if upper_done and lower_done:
		if !c4_t.visible:
			c4_t.visible = true
		if !shielding_t.visible:
			shielding_t.visible = true
		if c4_done and shielding_done:
			if !uranium_t.visible:
				uranium_t.visible = true
			if uranium_done:
				task_done()

func _on_upper_target_pressed():
	if target_helper(upper_t, upper_c): 
		upper_done = true
		upper_s.visible = false
		check_win()

func _on_lower_target_pressed():
	if target_helper(lower_t, lower_c): 
		lower_done = true
		lower_s.visible = false
		check_win()

func _on_c_4_target_pressed():
	if target_helper(c4_t, c4_c): 
		c4_done = true
		c4_s.visible = false
		check_win()

func _on_shielding_target_pressed():
	if target_helper(shielding_t, shielding_c): 
		shielding_done = true
		shielding_s.visible = false
		check_win()

func _on_uranium_target_pressed():
	if target_helper(uranium_t, uranium_c): 
		uranium_done = true
		uranium_s.visible = false
		check_win()
