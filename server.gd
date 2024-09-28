extends Node

# Function to get the port from environment variables or default to 8080
func get_port():
	# Get the environment variable for the port provided by Railway
	var port_env = OS.get_environment("PORT")
	if port_env != "":
		return int(port_env)
	else:
		# Default to 443 for local testing
		return 443

func _ready():
	var port = get_port()
	print("Server started JEK, listening on port %d" % port)
	start_server(port)

# Function to start the server
func start_server(port: int):
	var peer = ENetMultiplayerPeer.new()
	print("This is a new test to ensure Railway rebuilds correctly")
	
	# Start server, listen for up to 5 clients
	var result = peer.create_server(port, 5)
	
	if result == OK:
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(_on_peer_connected)
		multiplayer.peer_disconnected.connect(_on_peer_disconnected)
		print("DEBUG")
		print("Server started BRO, listening on port %d" % port)
	else:
		print("Error starting server: %s" % result)

# Handle new connections
func _on_peer_connected(id: int):
	print("Client with ID %d connected" % id)

# Handle disconnections
func _on_peer_disconnected(id: int):
	print("Client with ID %d disconnected" % id)
