##This file is part of PreWatergun.

##PreWatergun is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

##PreWatergun is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

##You should have received a copy of the GNU Affero General Public License along with PreWatergun. If not, see <https://www.gnu.org/licenses/>.

extends Entity

var who_shot

func _ready():
	set_multiplayer_authority(name.to_int())

func _process(delta):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("Map"):
			die()
		if collision.get_collider().is_in_group("Enemy") and collision.get_collider().has_method("take_damage"):
			collision.get_collider().take_damage(10)
			die()
		if collision.get_collider().is_in_group("player") and collision.get_collider().name != who_shot and collision.get_collider().has_method("take_damage"):
			collision.get_collider().take_damage(10)
			die()

func die():
	super.die()
	queue_free()

func _physics_process(delta):
	move()
