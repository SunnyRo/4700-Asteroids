extends Area2D


export var minSpeed = 40
export var maxSpeed = 140
export var minRotationRate = -10
export var maxRotationRate = 10


onready var node = get_tree().get_root().get_node("LivesNum")
onready var bullet_node = get_tree().get_root().find_node("ScoreNum",true,false)

export var life: int = 3

var velocity = Vector2(0,0)
var rota = 0
var speed = 0

onready var sScore = 0

var rotationRate: float = 0
# generate random # of speed and rotationRate
func _ready():
	
	
	speed = rand_range(minSpeed,maxSpeed)
	
	
	rota = randi()%361
	#print(rota)
	rota = deg2rad(rota)
	velocity = Vector2(speed,0).rotated(rota)
	rotationRate = rand_range(minRotationRate,maxRotationRate)
	node._ready()
	
	

func _physics_process(delta):
	
	position += velocity * delta
	rotation_degrees += rotationRate * delta
	wrap()
	
	
# check the damage then remove asteroid from the scene
func damage(amount: int):
	life -= amount
	
	
	if life <= 0:
		sScore += 10
		bullet_node.update_score(sScore)
		queue_free()


func wrap():
	if position.x <= -15:
		position.x = get_viewport_rect().size.x

	if position.x > get_viewport_rect().size.x + 15:
		position.x = 0

	if position.y <= -15:
		position.y = get_viewport_rect().size.y

	if position.y > get_viewport_rect().size.y + 15:
		position.y = 0


func _on_Asteroid_body_entered(body):
	body.gethit()
	queue_free()
