##This file is part of PreWatergun.

##PreWatergun is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

##PreWatergun is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

##You should have received a copy of the GNU Affero General Public License along with PreWatergun. If not, see <https://www.gnu.org/licenses/>.
extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_Water_body_entered(_body):
	if Input.is_action_pressed("Refill"):
		ammo = ammo + 30
		get_node("/root/Ammo").set_value(ammo)
