extends Node


func _process(delta):
	if Input.action_press("KEY_ESCAPE"):
		get_tree().quit()
