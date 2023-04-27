extends KinematicBody2D
class_name Entity

#Speed
export (int) var speed = 200

#Wetness
export (int) var wetness = 0
export (int) var max_wetness = 100

#OnWater
export (bool) var OnWater = false

export (Vector2) var velocity = Vector2()


#On Water Functions
func water_entered():
	print("water_left")
	OnWater = true

func water_left():
	print("water_entered")
	OnWater = false

func move():
	velocity = move_and_slide(velocity)

#Damage and Dying Functions
func take_damage(amount):
	wetness += amount

func heal_damage(amount):
	wetness -= amount

func wetness_logic():
	if wetness > max_wetness:
		die()
	if wetness < 0:
		wetness = 0

func die():
	queue_free()