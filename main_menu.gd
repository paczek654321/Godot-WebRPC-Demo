extends "res://webrtc_client.gd"

var input: String:
	get(): return $VBoxContainer/Input.text

func join() -> void:
	$VBoxContainer/HBoxContainer/Join.disabled = true
	start()

func message() -> void: send_message(input)
