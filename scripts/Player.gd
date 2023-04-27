extends Entity

#Making an Reusable Entity Class_Name.
#export (int) var speed = 200

#Delete if you aren't planning to use it.
@export var rotation_speed = 1.5

var ammo = 0
@export var fake_name = str(UsernameStuff.current_username)
#export (bool) var OnWater = false

@onready var WGTimer = get_node("Timers/WGTimer")
@onready var ShootTimer = get_node("Timers/ShootTimer")
@onready var fake_name_label = get_node("Sprites/Authority")
#var velocity = Vector2()

func _ready():
	set_multiplayer_authority(name.to_int())
	print(str(is_multiplayer_authority()))
	$Sprites/Authority.visible = true
	$Camera2D.enabled = is_multiplayer_authority()
	$Hud.visible = is_multiplayer_authority()
	
	fake_name_label.text = UsernameStuff.current_username
	
	randomize()
	spawn()
	

func get_input():
	if not is_multiplayer_authority(): return
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
			fire_projectile.rpc()
			update_ammo_counter()


func update_ammo_counter():
	if not is_multiplayer_authority(): return
	get_node("Hud/Control/Ammo").set_text(str("Ammo: ")+str(ammo)+ "/100")

func update_wetness_counter():
	get_node("Hud/Control/Wetness").set_text(str("Wetness: ")+str(round(wetness)) + "/" + str(max_wetness))

func _process(delta):
	
	fake_name_label.rotation = -rotation
	fake_name_label.global_position = position + Vector2(-47,-50)
	
	if not is_multiplayer_authority(): return
	if ammo > 100:
		ammo = 100
		update_ammo_counter()
		
	wetness_logic()
	update_wetness_counter()
	wetness -= delta * 2
	
	get_node("Hud/Control/Timer").scale.x = WGTimer.time_left * 2
	if WGTimer.time_left <= 0:
		get_node("Hud/Control/Timer").visible = false
	else:
		get_node("Hud/Control/Timer").visible = true

	if OnWater == true:
		get_node("Hud/Control/Recharge").visible = true
	else:
		get_node("Hud/Control/Recharge").visible = false
	
func _physics_process(_delta):
	if not is_multiplayer_authority(): return
	get_input()
	move()
	
func spawn():
	position = get_parent().get_parent().spawnpoints.get_child(randi_range(0,get_parent().get_parent().spawnpoints.get_child_count() - 1)).position

@rpc("call_local")
func die():
	super.die()
	randomize()
	spawn()

	update_ammo_counter()
	ammo = 0
	wetness = 0

@rpc("call_local")
func fire_projectile():
	var drip = preload("res://scenes/Prefabs/Drip.tscn").instantiate()
	drip.who_shot = name
	drip.position = get_node("Muzzle").global_position
	drip.rotation = rotation
	drip.velocity = Vector2(300,0).rotated(rotation)
	get_parent().add_child(drip, true)
