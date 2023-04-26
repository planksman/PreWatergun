extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_Water_body_entered(_body):
	if Input.is_action_pressed("Refill"):
		ammo = ammo + 30
		get_node("/root/Ammo").set_value(ammo)
