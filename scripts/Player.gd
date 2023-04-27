extends Entity

#Making an Reusable Entity Class_Name.
#export (int) var speed = 200

#Delete if you aren't planning to use it.
export (float) var rotation_speed = 1.5

var ammo = 0
#export (bool) var OnWater = false

onready var WGTimer = get_node("Timers/WGTimer")
onready var ShootTimer = get_node("Timers/ShootTimer")

#var velocity = Vector2()

	

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed("Refill") and WGTimer.is_stopped():
		if OnWater == true:
			if ammo <= 100:
				if ammo != 100:
					WGTimer.start()
				ammo += 20
				update_ammo_counter()
			
	if Input.is_action_pressed("click") and ShootTimer.is_stopped():
		if ammo >= 1:
			ammo -= 10
			ShootTimer.start()
			fire_projectile()
			update_ammo_counter()


func update_ammo_counter():
	get_node("Hud/CanvasLayer/Ammo").set_text(str("Ammo: ")+str(ammo))


func _process(delta):
	if ammo > 100:
		ammo = 100
		update_ammo_counter()
	
	get_node("Hud/CanvasLayer/Timer").rect_scale.x = WGTimer.time_left * 2
	if WGTimer.time_left <= 0:
		get_node("Hud/CanvasLayer/Timer").visible = false
	else:
		get_node("Hud/CanvasLayer/Timer").visible = true

	if OnWater == true:
		get_node("Hud/CanvasLayer/Recharge").visible = true
	else:
		get_node("Hud/CanvasLayer/Recharge").visible = false
	
func _physics_process(_delta):
	get_input()
	move()


func fire_projectile():
	var drip = preload("res://scenes/Prefabs/Drip.tscn").instance()
	drip.position = get_node("Muzzle").global_position
	drip.rotation = rotation
	drip.velocity = Vector2(300,0).rotated(rotation)
	owner.add_child(drip)
