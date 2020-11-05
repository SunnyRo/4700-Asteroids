extends Area2D


export var minSpeed: float = 10
export var maxSpeed: float = 20
export var minRotationRate: float = -10
export var maxRotationRate: float = 10

export var life: int = 20


var speed: float = 0
var rotationRate: float = 0
# generate random # of speed and rotationRate
func _ready():
	speed = rand_range(minSpeed,maxSpeed)
	rotationRate = rand_range(minRotationRate,maxRotationRate)

func _physics_process(delta):
	position.x += speed * delta
	position.y += speed * delta
	rotation_degrees += rotationRate * delta
	
	
# check the damage then remove asteroid from the scene
func damage(amount: int):
	life -= amount
	if life <= 0:
		queue_free()
# remove the asteroid when it exits the scene
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

