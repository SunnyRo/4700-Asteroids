extends Area2D


export var minSpeed = 40
export var maxSpeed = 140
export var minRotationRate = -10
export var maxRotationRate = 10

export var life: int = 1

var velocity = Vector2(0,0)
var rota = 0
var speed = 0

var rotationRate: float = 0


var timer = null
var collisionDelay = 2
var cantCollide = true

var BAsteroids = load("res://Variant/Objects/BAsteroid.tscn")
onready var bullet_node = get_tree().get_root().find_node("ScoreNum",true,false)
onready var sScore = 0
# generate random # of speed and rotationRate
func _ready():
	speed = rand_range(minSpeed,maxSpeed)
	
	
	rota = randi()%361
	#print(rota)
	rota = deg2rad(rota)
	velocity = Vector2(speed,0).rotated(rota)
	rotationRate = rand_range(minRotationRate,maxRotationRate)
	
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(collisionDelay)
	timer.connect("timeout", self, "_timeout_done")
	add_child(timer) 
	timer.start() 
	
func _timeout_done():
	cantCollide = false

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
	
func _on_SVAsteroid_area_entered(area):
		#print("hello")
		#print(area.name)
		
		if cantCollide == false:
			if area.is_in_group("SAsteroid"):
				var newPosition = area.position
				area.queue_free()
				print("helloooooo")
				var asteroid = BAsteroids.instance()
				asteroid.position = newPosition
				get_tree().current_scene.call_deferred("add_child", asteroid)
		else:
			pass
