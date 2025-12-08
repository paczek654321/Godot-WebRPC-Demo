class_name SignalingManager

signal connected

var ws := WebSocketPeer.new()

var webrtc_connection := WebRTCPeerConnection.new()

func _init(tree: SceneTree, _webrtc_connection: WebRTCPeerConnection, url: String) -> void:
	webrtc_connection = _webrtc_connection
	
	tree.process_frame.connect(process)
	
	ws.connect_to_url(url)
	
	webrtc_connection.ice_candidate_created.connect(send_candidate)
	webrtc_connection.session_description_created.connect(send_session)

func process() -> void:
	if (ws.get_ready_state() == WebSocketPeer.STATE_CLOSED): return
	
	if webrtc_connection.get_connection_state() == WebRTCPeerConnection.ConnectionState.STATE_CONNECTED:
		ws.close()
		connected.emit()
	
	ws.poll()
	while ws.get_available_packet_count():
		var packet: Dictionary = JSON.parse_string(ws.get_packet().get_string_from_utf8())
		match packet["type"]:
			"create_offer": webrtc_connection.create_offer()
			"candidate": webrtc_connection.add_ice_candidate.callv(packet["payload"])
			"session": webrtc_connection.set_remote_description.callv(packet["payload"])

func send_candidate(mid: String, index: int, sdp: String) -> void:
	ws.send_text(JSON.stringify({"type": "candidate", "payload": [mid, index, sdp]}))

func send_session(type: String, sdp: String) -> void:
	webrtc_connection.set_local_description(type, sdp)
	ws.send_text(JSON.stringify({"type": "session", "payload": [type, sdp]}))
