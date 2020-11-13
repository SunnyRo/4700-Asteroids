extends KinematicBody2D


var Bullet = preload("res://Bullet.tscn")

onready var Gun := $Gun
var inputVelocity = Vector2(0,0)
var velocity = Vector2(0,0)
var acceleration = 0.1	# Acceleration
var friction = 0.05		# Drag
var speed = 400
var deadzone = 0.2  	# If you ever change friction, Find new deadzone and change deadzone
var rotationDir = 0
var rotationSpeed = .1
var shootCD = 5
var waiting = false

onready var score = 0
var lives = 3
signal lost_life
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	get_input()
	rotation += rotationDir * rotationSpeed
	velocity = move_and_slide(velocity)
	wrap()
	if shootCD > 0:
		shootCD -= 1
	
	
func wrap():
	if position.x <= -15:
		position.x = get_viewport_rect().size.x

	if position.x > get_viewport_rect().size.x + 15:
		position.x = 0

	if position.y <= -15:
		position.y = get_viewport_rect().size.y

	if position.y > get_viewport_rect().size.y + 15:
		position.y = 0


func get_input():
	inputVelocity = Vector2(0,0)
	rotationDir = 0
	if Input.is_action_pressed("ui_up"):
		inputVelocity.x += 1
		inputVelocity = inputVelocity.rotated(rotation)
	if Input.is_action_pressed("ui_left"):
		rotationDir -= 1
	elif Input.is_action_pressed("ui_right"):
		rotationDir += 1
	inputVelocity = inputVelocity.normalized() * speed
	
	if inputVelocity.length() > 0:
		velocity = velocity.linear_interpolate(inputVelocity, acceleration)
	else:
		# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
		
	if Input.is_action_pressed("shoot"):
		shoot()
		
func shoot():
	if shootCD == 0:
		for child in Gun.get_children():
			var b = Bullet.instance()
			get_tree().current_scene.add_child(b)
			b.transform = child.global_transform
			shootCD = 5
func gethit():
	if !waiting:
		waiting = true
		set_physics_process(false)
		set_process_input(false)
		visible = false
		
		lives -= 1
		print(lives)
		emit_signal("lost_life")
		
		$TimerSpawnBack.start()
		print("timmer starts")
	
	


func _on_TimerSpawnBack_timeout():
	print("timmer stopped")
	set_physics_process(true)
	set_process_input(true)
	visible = true
	position.x = get_viewport_rect().size.x/2
	position.y = get_viewport_rect().size.y/2
	$TimerSpawnBack.stop()
	waiting = false
