extends Control

@export var newspapers_aliens: Texture2D
@export var newspapers_pandemic: Texture2D

@onready var mail: Control = $Mail
@onready var mail_txt: RichTextLabel = $Mail/Text
@onready var news: TextureRect = $News

@onready var news_continue_button: Button = $News_to_Mail
@onready var mail_continue_button: Button = $Start_day

var has_news = false

func day(day):
	if day == 3:
		news.texture = newspapers_pandemic
		has_news = true
	elif day == 4:
		news.texture = newspapers_aliens
		has_news = true
	else:
		has_news = false
	news.visible = has_news
	news_continue_button.visible = has_news
	mail.visible = !has_news
	mail_continue_button.visible = !has_news

func _on_news_to_mail_pressed():
	news.visible = false
	news_continue_button.visible = false
	mail.visible = true
	mail_continue_button.visible = true


func _on_start_day_pressed():
	Global.game_manager.start_day()
