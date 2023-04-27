extends CharacterBody2D
class_name Entity

#Speed
@export var speed = 200

#Wetness
@export var wetness = 0
@export var max_wetness = 100

#OnWater
@export var OnWater = false


#On Water Functions
func water_entered():
	print("water_left")
	OnWater = true

func water_left():
	print("water_entered")
	OnWater = false

func move():
	move_and_slide()

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
	#dying would possibly have seperate codes because networking.
	pass
	#queue_free()
