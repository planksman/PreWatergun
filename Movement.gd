extends KinematicBody2D


export (int) var speed = 200
var rotation_dir = 0
export (float) var rotation_speed = 1.5
var ammo = 0
export (bool) var OnWater = false
onready var WGTimer = get_node("/root/DemoGame/Player/WGTimer")


var velocity = Vector2()

	

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed("Refill") and WGTimer.is_stopped():
		if OnWater == true:
			if ammo <= 90:
				WGTimer.start(1)
				ammo += 20
				get_node("/root/DemoGame/Ammo").set_text(str(ammo))
			
	if Input.is_action_pressed("click"):
		if ammo >= 1:
			ammo -= 10
			get_node("/root/DemoGame/Ammo").set_text(str(ammo))

	
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_Water_body_entered(_body):
	OnWater = true

func _on_Water_body_exited(_body):
	OnWater = false
