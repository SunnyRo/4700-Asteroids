extends KinematicBody2D


var Bullet = preload("res://Clone/Objects/Bullet.tscn")
var explosions = preload("res://Clone/Objects/Explosion.tscn")
onready var Gun := $Gun
var inputVelocity = Vector2(0,0)
var velocity = Vector2(0,0)
var acceleration = 0.1	# Acceleration
var friction = 0.05		# Drag
var speed = 400
var rotationDir = 0
var rotationSpeed = .1
var shootCD = 5
var waiting = false
var immune = false
var jetPlaying = false
signal lost_life
export var lives = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	get_input()
	jetEffect()
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
		$LaserSound.play()
		for child in Gun.get_children():
			var b = Bullet.instance()
			get_tree().current_scene.add_child(b)
			b.transform = child.global_transform
			shootCD = 10

func jetEffect():
	if Input.is_action_pressed("ui_up"):
		if jetPlaying:
			pass
		else:
			$JetSound.play()
			jetPlaying = true
	else:
		$JetSound.stop()
		jetPlaying = false

func gethit():
	if !waiting and !immune:
		var explosion = explosions.instance()
		$"/root/Game/ExplosionSound".play()
		explosion.position = get_global_position()
		get_tree().current_scene.add_child(explosion)
		waiting = true
		set_physics_process(false)
		set_process_input(false)
		visible = false
		position.x = 1200
		position.y = 1200
		$JetSound.stop()
		$TimerSpawnBack.start()
		lives -= 1
		print(lives)
		emit_signal("lost_life")
	else:
		var explosion = explosions.instance()
		$"/root/Game/ExplosionSound".play()
		explosion.position = get_global_position()
		get_tree().current_scene.add_child(explosion)

func _on_TimerSpawnBack_timeout():
	set_physics_process(true)
	set_process_input(true)
	visible = true
	velocity = Vector2(0,0)
	position.x = get_viewport_rect().size.x/2
	position.y = get_viewport_rect().size.y/2
	$TimerSpawnBack.stop()
	$TimerImmune.start()
	immune = true
	set_modulate(Color(255,0,0))
	waiting = false


func _on_TimerImmune_timeout():
	immune = false
	set_modulate(Color(1,1,1,1))
	$TimerImmune.stop()
	
