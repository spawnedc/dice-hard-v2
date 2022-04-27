extends Node2D

# func _ready():
# 	if GameWebSocket.isConnected:
# 		_on_connection_established()
# 	else:
# 		GameWebSocket.connect("connection_established", self, "_on_connection_established")


func _process(delta):
	$Background/ParallaxBackground.scroll_offset.x -= delta * 20


func _on_ConnectButton_pressed():
	$ConnectButton.visible = false
	$StatusText.visible = true
	$StatusText.text = "Connected. Waiting for opponent..."
	# GameWebSocket.init()


func _on_connection_established():
	$ConnectButton.visible = true
	$StatusText.visible = false
