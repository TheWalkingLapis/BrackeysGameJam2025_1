extends Task

@onready var document = $Document
@onready var signed = $Active/signed
@onready var sign_button = $Active/unsigned/sign_button
@onready var unsigned = $Active/unsigned

func _on_ready():
	document.visible = true
	signed.visible = false
	unsigned.visible = false

func start_task():
	started.emit()
	document.visible = false
	unsigned.visible = true
	signed.visible = false

func _on_document_pressed():
	if get_task_completed():
		return
	start_task()

func _on_sign_button_pressed():
	unsigned.visible = false
	signed.visible = true

func _on_signed_pressed():
	task_progression += 1
	signed.visible = false
	document.visible = true
	document.texture_hover = null
	set_task_completed()
