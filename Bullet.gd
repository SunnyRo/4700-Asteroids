extends Area2D

var speed = 750
var life = 0
var explosions = preload("res://Explosion.tscn")
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
	
# when another area enter this area bullet
func _on_Bullet_area_entered(area):
	if area.is_in_group("damageable"):
		area.damage(1)
		var explosion = explosions.instance()
		explosion.position = get_global_position()
		get_tree().current_scene.add_child(explosion)
		queue_free()
		
