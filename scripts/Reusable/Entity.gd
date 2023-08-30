##This file is part of PreWatergun.

##PreWatergun is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

##PreWatergun is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

##You should have received a copy of the GNU Affero General Public License along with PreWatergun. If not, see <https://www.gnu.org/licenses/>.
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
