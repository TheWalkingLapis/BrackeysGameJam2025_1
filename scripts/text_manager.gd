extends Control
class_name TextManager

signal finished_text()

@onready var text_box = $RichTextLabel
@onready var continue_button = $Buttons/Continue

func _ready():
	self.visible = false

func display_news_and_mail(day):
	self.visible = true
	text_box.text = "AMOGUS AMOGUS"

func _on_continue_pressed():
	self.visible = false
	finished_text.emit()
