extends Entity

func _process(delta):
    for i in get_slide_count():
        var collision = get_slide_collision(i)
        if collision.collider.is_in_group("Map"):
            die()
        if collision.collider.is_in_group("Enemy") and collision.collider.has_method("take_damage"):
            collision.collider.take_damage(10)
            die()
        


func _physics_process(delta):
    move()