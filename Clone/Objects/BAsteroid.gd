extends Area2D


export var minSpeed = 40
export var maxSpeed = 140
export var minRotationRate = -10
export var maxRotationRate = 10

export var life: int = 1
var SAsteroids = preload("res://Clone/Objects/SAsteroid.tscn")
var velocity = Vector2(0,0)
var rota = 0
var speed = 0

var rotationRate: float = 0


onready var bullet_node = get_tree().get_root().find_node("ScoreNum",true,false)
onready var bScore = 0
# generate random # of speed and rotationRate
func _ready():
	speed = rand_range(minSpeed,maxSpeed)
	
	
	rota = randi()%361
	#print(rota)
	rota = deg2rad(rota)
	velocity = Vector2(speed,0).rotated(rota)
	rotationRate = rand_range(minRotationRate,maxRotationRate)
	

func _physics_process(delta):
	
	position += velocity * delta
	rotation_degrees += rotationRate * delta
	wrap()
	
	
# check the damage then remove asteroid from the scene
func damage(amount: int):
	life -= amount
	if life <= 0:
		var asteroid1 = SAsteroids.instance()
		asteroid1.position = position
		get_tree().current_scene.call_deferred("add_child", asteroid1)
		var asteroid2 = SAsteroids.instance()
		asteroid2.position = position
		get_tree().current_scene.call_deferred("add_child", asteroid2)
		
		bScore += 10
		bullet_node.update_score(bScore)
		
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


func _on_BAsteroid_body_entered(body):
	body.gethit()
	queue_free()


