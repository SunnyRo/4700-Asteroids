extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


	# Movement Controls around Up and Down
	#if Input.is_action_pressed("ui_up"):
		#velocity.y += -acceleration*delta
	#elif Input.is_action_pressed("ui_down"):
		#velocity.y += acceleration*delta
	#else:	# Deceleration
		#if abs(velocity.y) <= deadzone:
			#velocity.y = 0
		#if abs(velocity.y) > 0:
			#velocity.y -= sign(velocity.y)*friction*delta
		
		
	# Movement Controls around Left and Right
	#if Input.is_action_pressed("ui_left"):
		#velocity.x += -acceleration*delta
	#elif Input.is_action_pressed("ui_right"):
		#velocity.x += acceleration*delta
	#else:	# Deceleration
		#if abs(velocity.x) <= deadzone:
			#velocity.x = 0
		#if abs(velocity.x) > 0:
			#velocity.x -= sign(velocity.x)*friction*delta
			
			

	#else:	# Deceleration
		#if abs(velocity.x) <= deadzone:
			#velocity.x = 0
		#if abs(velocity.x) > 0:
			#velocity.x -= sign(velocity.x)*friction*delta
