extends Area2D

var speed = 750
var life = 0

func _physics_process(delta):
	position += transform.x * speed * delta
	wrap()
	lifeCount()
	
func wrap():
	if position.x <= -15:
		position.x = get_viewport_rect().size.x

	if position.x > get_viewport_rect().size.x + 15:
		position.x = 0

	if position.y <= -15:
		position.y = get_viewport_rect().size.y

	if position.y > get_viewport_rect().size.y + 15:
		position.y = 0

func lifeCount():
	if life >= 60:
		queue_free()
	life += 1
	
func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
