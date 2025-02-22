extends Control
class_name TextManager

signal text_in_progress()
signal finished_text(force: bool)
signal finished_menu_text()

@onready var interaction = $Interaction
@onready var interaction_text = $Interaction/Interaction_Box/Interaction_Text
@onready var interaction_continue_button = $Interaction/INT_Continue

@onready var menu = $MenuTalk
@onready var menu_text = $MenuTalk/Interaction_Box/Interaction_Text
@onready var menu_continue_button = $MenuTalk/MENU_Continue

func _ready():
	interaction.visible = false
	menu.visible = false

func display_interaction_text(text):
	if interaction.visible: return
	text_in_progress.emit()
	interaction.visible = true
	interaction_text.text = text

func clear_text():
	interaction.visible = false
	finished_text.emit(true)

func _on_int_continue_pressed():
	interaction.visible = false
	finished_text.emit(false)

### Menu

func show_text_in_menu(text, col=Color(0,0,0,.75)):
	menu.visible = true
	$MenuTalk/Interaction_Box.color = col
	menu_text.text = text

func clear_menu_text():
	menu.visible = false

func _on_menu_continue_pressed():
	menu.visible = false
	finished_menu_text.emit()
