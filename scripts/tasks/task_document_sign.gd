extends Task

@onready var signed = $Active/signed
@onready var sign_button = $Active/unsigned/sign_button
@onready var unsigned = $Active/unsigned

func _on_ready():
	signed.visible = false
	unsigned.visible = false

func start_task():
	if get_task_completed():
		return
	started.emit()
	unsigned.visible = true
	signed.visible = false

func _on_sign_button_pressed():
	unsigned.visible = false
	signed.visible = true

func _on_signed_pressed():
	signed.visible = false
	set_task_completed()
