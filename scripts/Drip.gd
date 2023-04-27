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
