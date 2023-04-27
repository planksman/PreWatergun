extends Node

@onready var animplayer = get_node("%AnimationPlayer")
var scene_to_switch_to

func change_scene(animation: String, to_scene: String):
	scene_to_switch_to = to_scene
	animplayer.play(animation)

func load_scene():
	get_tree().change_scene_to_file(scene_to_switch_to)
