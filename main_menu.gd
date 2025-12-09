extends "res://webrtc_client.gd"

var input: String:
	get():
		if $VBoxContainer/Input.text == "":
			return $VBoxContainer/Input.placeholder_text
		return $VBoxContainer/Input.text

func join() -> void:
	$VBoxContainer/HBoxContainer/Join.disabled = true
	start()

func message() -> void: send_message(input)

func _ready() -> void:
	super()
	message_recieved.connect(display_message)

func display_message(text: String) -> void:
	$output.text += text + "\n"
