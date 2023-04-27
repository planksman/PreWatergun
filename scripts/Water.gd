extends Area2D


func _Water_Entered(body:Node):
	if body.has_method("water_entered"):
		body.OnWater = true


func _Water_Exited(body:Node):
	if body.has_method("water_left"):
		body.OnWater = false
