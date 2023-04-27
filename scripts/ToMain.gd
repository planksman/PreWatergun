extends Node

@export var player: PackedScene
@export var map: PackedScene

@onready var ip_address = get_node("%Ip")
@onready var map_instance = get_node("MapInstance")
@onready var network_node = get_node("Network")
@onready var spawnpoints = get_node("Map/SpawnPoints")

#func _process(_delta):
	#if Input.is_action_pressed("ui_cancel"):
		#get_tree().change_scene_to_file("res://Menu.tscn")


func _on_host_game_pressed():
	setup_upnp(get_node("%PortHost").text)
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(int((get_node("%PortHost").text)))
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_disconnected.connect(remove_player)
	multiplayer.peer_connected.connect(add_player)
	
	load_game()
	add_player(multiplayer.get_unique_id())
	
func _on_join_game_pressed():
	setup_upnp(get_node("%PortJoin").text)
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip_address.text, int(get_node("%PortJoin").text))
	multiplayer.multiplayer_peer = peer
	
	
	multiplayer.connected_to_server.connect(load_game)
	multiplayer.server_disconnected.connect(server_offline)
	multiplayer.server_disconnected.connect(kick_everyone)
	


func load_game():
	%MultiplayerConfig.hide()
	#var map_inst = map.instantiate()
	#map_instance.add_child(map_inst)
	
@rpc("any_peer")
func add_player(id):
	print(str(id) + " Has joined the server")
	var player_instance = player.instantiate()
	player_instance.name = str(id)
	player_instance.fake_name = get_node("%Username").text
	network_node.add_child(player_instance)

@rpc("any_peer")
func remove_player(id):
	if network_node.get_node(str(id)):
		print(str(id) + " Has left the server.")
		network_node.get_node(str(id)).queue_free()
		
func kick_everyone():
	for i in network_node.get_child_count():
		network_node.get_child(i).queue_free()
		
func server_offline():
	%MultiplayerConfig.show()
	if map_instance.get_child(0):
		map_instance.get_child(0).queue_free()
		
func setup_upnp(port):
	var upnp = UPNP.new()
	upnp.discover()
	var result = upnp.add_port_mapping(port.to_int())
