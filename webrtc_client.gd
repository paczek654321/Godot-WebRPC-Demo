extends Node

var channel: WebRTCDataChannel
var connection := WebRTCPeerConnection.new()

signal message_recieved

func _ready() -> void: set_process(false)

func start() -> void:
	connection.initialize\
	({
		"iceServers":
		[{
			"urls": [ "stun:stun.l.google.com:19302" ]
		}]
	})
	channel = connection.create_data_channel("chat", {"negotiated": true, "id": 1})
	
	set_process(true)
	
	var signaling_manager := SignalingManager.new(get_tree(), connection, "ws://localhost:8080")
	
	await signaling_manager.connected
	send_message("Connected")

func _process(_delta: float) -> void:
	connection.poll()
	if channel.get_ready_state() == WebRTCDataChannel.STATE_OPEN:
		while channel.get_available_packet_count() > 0:
			message_recieved.emit(channel.get_packet().get_string_from_utf8())

func send_message(message: String) -> void:
	channel.put_packet(message.to_utf8_buffer())
