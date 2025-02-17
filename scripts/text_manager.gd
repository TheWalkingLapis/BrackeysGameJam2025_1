extends Control
class_name TextManager

signal text_in_progress()
signal finished_text(force: bool)

@onready var news_and_mail = $News_and_Mail
@onready var mail_text = $News_and_Mail/Mail_Text
@onready var news_text = $News_and_Mail/News_Text
@onready var news_mail_continue_button = $News_and_Mail/NAM_Continue

@onready var interaction = $Interaction
@onready var interaction_text = $Interaction/Interaction_Box/Interaction_Text
@onready var interaction_continue_button = $Interaction/Interaction_Box/INT_Continue

func _ready():
	news_and_mail.visible = false
	interaction.visible = false

func display_news_and_mail(day):
	text_in_progress.emit()
	news_and_mail.visible = true
	mail_text.text = "AMOGUS -mail- AMOGUS"
	news_text.text = "AMOGUS -news- AMOGUS"

func display_interaction_text(text):
	text_in_progress.emit()
	interaction.visible = true
	interaction_text.text = text

func clear_text():
	news_and_mail.visible = false
	interaction.visible = false
	finished_text.emit(true)

func _on_nam_continue_pressed():
	news_and_mail.visible = false
	finished_text.emit(false)

func _on_int_continue_pressed():
	interaction.visible = false
	finished_text.emit(false)
