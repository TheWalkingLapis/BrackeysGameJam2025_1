extends Control
class_name TextManager

signal text_in_progress()
signal finished_text(force: bool)

@onready var interaction = $Interaction
@onready var interaction_text = $Interaction/Interaction_Box/Interaction_Text
@onready var interaction_continue_button = $Interaction/INT_Continue

func _ready():
	interaction.visible = false

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
