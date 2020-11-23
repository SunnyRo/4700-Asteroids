extends Area2D

var velocity = Vector2(0,0)
var desired = Vector2()
var theta
var speed = 1
var life = 10
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var bullet_node = get_tree().get_root().find_node("ScoreNum",true,false)
onready var bScore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	display()
	seek()

func display():
	self.look_at(player.position)
	
func seek():
	velocity = Vector2(speed,0)
	position += velocity.rotated(rotation)

func _on_SeekingEnemy_body_entered(body):
	if body.is_in_group("player"):
		body.gethit()
		queue_free()
		
func damage(amount: int):
	life -= amount
	if life <= 0:
		bScore += 100
		bullet_node.update_score(bScore)
		queue_free()
