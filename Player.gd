extends KinematicBody2D

var velocity = Vector2(0,0)
var acceleration = 20	# Acceleration
var friction = 8		# Drag
var maxVelocity = 8  	# Max speed
var deadzone = 0.2  	# If you ever change friction, Find new deadzone and change deadzone


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):

	# Movement Controls around Up and Down
	if Input.is_action_pressed("ui_up"):
		velocity.y += -acceleration*delta
	elif Input.is_action_pressed("ui_down"):
		velocity.y += acceleration*delta
	else:	# Deceleration
		if abs(velocity.y) <= deadzone:
			velocity.y = 0
		if abs(velocity.y) > 0:
			velocity.y -= sign(velocity.y)*friction*delta
		
		
	# Movement Controls around Left and Right
	if Input.is_action_pressed("ui_left"):
		velocity.x += -acceleration*delta
	elif Input.is_action_pressed("ui_right"):
		velocity.x += acceleration*delta
	else:	# Deceleration
		if abs(velocity.x) <= deadzone:
			velocity.x = 0
		if abs(velocity.x) > 0:
			velocity.x -= sign(velocity.x)*friction*delta
		
	# Movement
	velocity = Vector2(clamp(velocity.x, -maxVelocity, maxVelocity), clamp(velocity.y, -maxVelocity, maxVelocity))	# Clamping to limit max speed
	move_and_collide(velocity)
	#print(velocity) # Used to find deadzone
	wrap()
	
func wrap():
	if position.x <= -15:
		position.x = get_viewport_rect().size.x

	if position.x > get_viewport_rect().size.x + 15:
		position.x = 0

	if position.y <= -15:
		position.y = get_viewport_rect().size.y

	if position.y > get_viewport_rect().size.y + 15:
		position.y = 0
