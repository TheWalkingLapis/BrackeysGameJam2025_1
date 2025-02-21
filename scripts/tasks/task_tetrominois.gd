extends Task

@onready var active = $Active

@onready var stage_4x3 = $"Active/4x3"
@onready var area_4x3 = $"Active/4x3/PlayArea"
@onready var slot_j0_4x3 = $"Active/4x3/Slot_J_0"
@onready var slot_j3_4x3 = $"Active/4x3/Slot_J_3"
@onready var slot_sq_4x3 = $"Active/4x3/Slot_Square"
@onready var j0_4x3 = $"Active/4x3/J_0"
@onready var j3_4x3 = $"Active/4x3/J_3"
@onready var sq_4x3 = $"Active/4x3/Square"

@onready var stage_5x4 = $"Active/5x4"
@onready var area_5x4 = $"Active/5x4/PlayArea"
@onready var slot_s0_5x4 = $"Active/5x4/Slot_S_0"
@onready var slot_j0_5x4 = $"Active/5x4/Slot_J_0"
@onready var slot_l0_5x4 = $"Active/5x4/Slot_L_0"
@onready var slot_t00_5x4 = $"Active/5x4/Slot_T_0_0"
@onready var slot_t01_5x4 = $"Active/5x4/Slot_T_0_1"
@onready var s0_5x4 = $"Active/5x4/S_0"
@onready var j0_5x4 = $"Active/5x4/J_0"
@onready var l0_5x4 = $"Active/5x4/L_0"
@onready var t00_5x4 = $"Active/5x4/T_0_0"
@onready var t01_5x4 = $"Active/5x4/T_0_1"

@onready var stage_6x6 = $"Active/6x6"
@onready var area_6x6 = $"Active/6x6/PlayArea"
@onready var slot_sq0_6x6 = $"Active/6x6/Slot_SQ_0"
@onready var slot_sq1_6x6 = $"Active/6x6/Slot_SQ_1"
@onready var slot_j0_6x6 = $"Active/6x6/Slot_J_0"
@onready var slot_l00_6x6 = $"Active/6x6/Slot_L_0_0"
@onready var slot_l01_6x6 = $"Active/6x6/Slot_L_0_1"
@onready var slot_s00_6x6 = $"Active/6x6/Slot_S_0_0"
@onready var slot_s01_6x6 = $"Active/6x6/Slot_S_0_1"
@onready var slot_s3_6x6 = $"Active/6x6/Slot_S_3"
@onready var slot_l2_6x6 = $"Active/6x6/Slot_L_2"
@onready var sq0_6x6 = $"Active/6x6/SQ_0"
@onready var sq1_6x6 = $"Active/6x6/SQ_1"
@onready var j0_6x6 = $"Active/6x6/J_0"
@onready var l00_6x6 = $"Active/6x6/L_0_0"
@onready var l01_6x6 = $"Active/6x6/L_0_1"
@onready var s00_6x6 = $"Active/6x6/S_0_0"
@onready var s01_6x6 = $"Active/6x6/S_0_1"
@onready var s3_6x6 = $"Active/6x6/S_3"
@onready var l2_6x6 = $"Active/6x6/L_2"

const block_slot_dict = {
	"j0": [Vector2(0,0), Vector2(-1,0), Vector2(0,-1),Vector2(0,-2)],
	"j3": [Vector2(0,0), Vector2(-1,0), Vector2(-2,0),Vector2(0,1)],
	"sq": [Vector2(0,0), Vector2(1,0), Vector2(0,1),Vector2(1,1)],
	"s0": [Vector2(0,0), Vector2(-1,0), Vector2(0,-1),Vector2(1,-1)],
	"t0": [Vector2(0,0), Vector2(-1,0), Vector2(0,1),Vector2(1,0)],
	"l0": [Vector2(0,0), Vector2(1,0), Vector2(0,-1),Vector2(0,-2)],
	"s3": [Vector2(0,0), Vector2(-1,0), Vector2(-1,-1),Vector2(0,1)],
	"l2": [Vector2(0,0), Vector2(-1,0), Vector2(0,1),Vector2(0,2)]
}
# how far (in half blocks) should the mouse location be from the sprite origin (top left). The block hit should be treated as (0,0) for above
const offset_dict = {
	"j0": Vector2(3, 5),
	"j3": Vector2(5, 1),
	"sq": Vector2(1, 1),
	"s0": Vector2(3, 3),
	"t0": Vector2(3, 1),
	"l0": Vector2(1, 5),
	"s3": Vector2(3, 3),
	"l2": Vector2(3, 1)
}
var type_dict = {} # ty godot, i love you

var half_block_size = 15

var stage = 0
var active_piece = null
var active_piece_offset = Vector2(0,0)
var grid = []

func _ready():
	type_dict[j0_4x3] = "j0"
	type_dict[j3_4x3] = "j3"
	type_dict[sq_4x3] = "sq"
	type_dict[s0_5x4] = "s0"
	type_dict[j0_5x4] = "j0"
	type_dict[l0_5x4] = "l0"
	type_dict[t00_5x4] = "t0"
	type_dict[t01_5x4] = "t0"
	type_dict[sq0_6x6] = "sq"
	type_dict[sq1_6x6] = "sq"
	type_dict[j0_6x6] = "j0"
	type_dict[l00_6x6] = "l0"
	type_dict[l01_6x6] = "l0"
	type_dict[s00_6x6] = "s0"
	type_dict[s01_6x6] = "s0"
	type_dict[s3_6x6] = "s3"
	type_dict[l2_6x6] = "l2"

func start_task():
	active.visible = true
	set_stage()
	started.emit(self)

func reset_task():
	super.reset_task()
	active.visible = false
	stage = 0

func set_stage():
	active_piece = null
	active_piece_offset = Vector2(0,0)
	if stage == 0:
		grid = make_grid(4,3)
		stage_4x3.visible = true
		stage_5x4.visible = false
		stage_6x6.visible = false
		j0_4x3.position = slot_j0_4x3.position
		j3_4x3.position = slot_j3_4x3.position
		sq_4x3.position = slot_sq_4x3.position
	elif stage == 1:
		grid = make_grid(5,4)
		stage_4x3.visible = false
		stage_5x4.visible = true
		stage_6x6.visible = false
		s0_5x4.position = slot_s0_5x4.position
		j0_5x4.position = slot_j0_5x4.position
		l0_5x4.position = slot_l0_5x4.position
		t00_5x4.position = slot_t00_5x4.position
		t01_5x4.position = slot_t01_5x4.position
	else:
		grid = make_grid(6,6)
		stage_4x3.visible = false
		stage_5x4.visible = false
		stage_6x6.visible = true
		sq0_6x6.position = slot_sq0_6x6.position
		sq1_6x6.position = slot_sq1_6x6.position
		j0_6x6.position = slot_j0_6x6.position
		l00_6x6.position = slot_l00_6x6.position
		l01_6x6.position = slot_l01_6x6.position
		s00_6x6.position = slot_s00_6x6.position
		s01_6x6.position = slot_s01_6x6.position
		s3_6x6.position = slot_s3_6x6.position
		l2_6x6.position = slot_l2_6x6.position

func _process(delta):
	if !active: return
	half_block_size = slot_sq_4x3.size.x / 4
	if active_piece != null:
		active_piece.position = get_local_mouse_position() - active_piece_offset

func make_grid(w,h):
	var g = []
	for y in h:
		g.append([])
		for x in w:
			g[y].append(null)
	return g

func get_click_coord(use_mouse_pos: bool = false):
	var coord = Vector2i(0,0)
	
	if stage == 0:
		var local = 0
		if use_mouse_pos:
			local = (get_global_mouse_position() - area_4x3.global_position)
		else:
			local = (active_piece.position + active_piece_offset - area_4x3.global_position)
		var scaling = area_4x3.size
		var cell_size = Vector2(scaling.x / 4, scaling.y / 3)
		coord = Vector2i(local.x / cell_size.x, local.y / cell_size.y)
	elif stage == 1:
		var local = 0
		if use_mouse_pos:
			local = (get_global_mouse_position() - area_5x4.global_position)
		else:
			local = (active_piece.position + active_piece_offset - area_5x4.global_position)
		var scaling = area_5x4.size
		var cell_size = Vector2(scaling.x / 5, scaling.y / 4)
		coord = Vector2i(local.x / cell_size.x, local.y / cell_size.y)
	else:
		var local = 0
		if use_mouse_pos:
			local = (get_global_mouse_position() - area_6x6.global_position)
		else:
			local = (active_piece.position + active_piece_offset - area_6x6.global_position)
		var scaling = area_6x6.size
		var cell_size = Vector2(scaling.x / 6, scaling.y / 6)
		coord = Vector2i(local.x / cell_size.x, local.y / cell_size.y)
	return coord
	
func get_coord_pos(coord):
	var pos = Vector2(0,0)
	var cell_coord = half_block_size * 2 * coord
	
	if stage == 0:
		pos = cell_coord + area_4x3.global_position
	elif stage == 1:
		pos = cell_coord + area_5x4.global_position
	else:
		pos = cell_coord + area_6x6.global_position
	return pos

func in_grid(vec):
	return vec.y >= 0 and vec.y < len(grid) and vec.x >= 0 and vec.x < len(grid[0])

func fits_in_grid(coord, block_type):
	var offsets = block_slot_dict[block_type]
	for vec in offsets:
		var pos = Vector2(coord) + vec
		if !in_grid(pos) or grid[pos.y][pos.x] != null:
			return false
	return true

func place_in_grid(coord, block) -> bool:
	if active_piece == null: return false
	var block_type = type_dict[block]
	if !fits_in_grid(coord, block_type): return false
	var offsets = block_slot_dict[block_type]
	for vec in offsets:
		var pos = Vector2(coord) + vec
		grid[pos.y][pos.x] = block
	active_piece.global_position = get_coord_pos(coord) - active_piece_offset + half_block_size * Vector2(1,1)
	active_piece = null
	active_piece_offset = Vector2(0,0)
	return true

func remove_from_grid(block):
	for y in len(grid):
		for x in len(grid[0]):
			if grid[y][x] == block:
				grid[y][x] = null

func check_stage_clear():
	for y in len(grid):
		for x in len(grid[0]):
			if grid[y][x] == null:
				return false
	return true

func _on_play_area_pressed():
	if active_piece == null:
		var coords = get_click_coord(true)
		if grid[coords.y][coords.x] != null:
			var block = grid[coords.y][coords.x]
			remove_from_grid(block)
			active_piece = block
			active_piece_offset = half_block_size * offset_dict[type_dict[block]]
	else:
		var coords = get_click_coord()
		var success = place_in_grid(coords, active_piece)
		if success:
			if check_stage_clear():
				stage += 1
				set_stage()

### Stage 4x3 (0)

func on_slot_pressed_helper(slot, block):
	if active_piece == null and (slot.position == block.position):
		active_piece = block
		active_piece_offset = half_block_size * offset_dict[type_dict[block]]
	elif active_piece == block:
		active_piece = null
		active_piece_offset = Vector2(0,0)
		block.position = slot.position

func _on_slot_j_0_4x3_pressed():
	on_slot_pressed_helper(slot_j0_4x3, j0_4x3)

func _on_slot_j_3_4x3_pressed():
	on_slot_pressed_helper(slot_j3_4x3, j3_4x3)

func _on_slot_square_4x3_pressed():
	on_slot_pressed_helper(slot_sq_4x3, sq_4x3)

### Stage 5x4 (1)

func _on_slot_s_0_5x4_pressed():
	on_slot_pressed_helper(slot_s0_5x4, s0_5x4)

func _on_slot_j_0_5x4_pressed():
	on_slot_pressed_helper(slot_j0_5x4, j0_5x4)

func _on_slot_l_0_5x4_pressed():
	on_slot_pressed_helper(slot_l0_5x4, l0_5x4)

func _on_slot_t_0_0_5x4_pressed():
	on_slot_pressed_helper(slot_t00_5x4, t00_5x4)

func _on_slot_t_0_1_5x4_pressed():
	on_slot_pressed_helper(slot_t01_5x4, t01_5x4)

### Stage 6x6 (2)

func _on_slot_sq_0_6x6_pressed():
	on_slot_pressed_helper(slot_sq0_6x6, sq0_6x6)

func _on_slot_sq_1_6x6_pressed():
	on_slot_pressed_helper(slot_sq1_6x6, sq1_6x6)

func _on_slot_j_0_6x6_pressed():
	on_slot_pressed_helper(slot_j0_6x6, j0_6x6)

func _on_slot_l_0_0_6x6_pressed():
	on_slot_pressed_helper(slot_l00_6x6, l00_6x6)

func _on_slot_l_0_1_6x6_pressed():
	on_slot_pressed_helper(slot_l01_6x6, l01_6x6)

func _on_slot_s_0_0_6x6_pressed():
	on_slot_pressed_helper(slot_s00_6x6, s00_6x6)

func _on_slot_s_0_1_6x6_pressed():
	on_slot_pressed_helper(slot_s01_6x6, s01_6x6)

func _on_slot_s_3_6x6_pressed():
	on_slot_pressed_helper(slot_s3_6x6, s3_6x6)

func _on_slot_l_2_6x6_pressed():
	on_slot_pressed_helper(slot_l2_6x6, l2_6x6)
