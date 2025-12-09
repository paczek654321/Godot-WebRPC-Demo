# Web RTC Demo
## About
This project is a simple implementation of WebRTC in the Godot Engine with a [NodeJS signaling server](https://github.com/paczek654321/Godot-WebRPC-Demo-Backend)
## Features
- Simple GUI
- WebRTC connection between 2 instances
- Simple chat
## File structure
- `signaling_manager.gd` - The script responsible for connecting and exchanging data with the [signaling server](https://github.com/paczek654321/Godot-WebRPC-Demo-Backend)
- `webrtc_client.gd` - Base class responsible for initiating, maintaining and utilizing the WebRTC connection
- `main_menu.gd` - A script that connects the `webrtc_client.gd` to the GUI
- `webrtc/` - [The official GDExtension for native WebRTC support in Godot (v1.1.0)](https://github.com/godotengine/webrtc-native) - licensed seperately to the rest of the project
## How to run
1. Clone this repository and open the project using the Godot Engine
2. Deploy the [NodeJS signaling server](https://github.com/paczek654321/Godot-WebRPC-Demo-Backend)
