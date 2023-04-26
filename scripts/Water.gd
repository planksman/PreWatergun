extends Area2D


func _Water_Entered(body:Node):
	if body.is_in_group("player"):
		body.OnWater = true


func _Water_Exited(body:Node):
	if body.is_in_group("player"):
		body.OnWater = false
