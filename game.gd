extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_edges : Array = []
var BAsteroids = preload("res://BAsteroid.tscn")
var angular_speed = 0
var count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
		randomize()
		pass
	
func _process(delta):
	if count == 60:
		asteroidSpawning()
		count = 0
	count += 1
	

func asteroidSpawning():
	var asteroid = BAsteroids.instance()
	screen_edges.append(Vector2.ZERO)
	screen_edges.append(Vector2(rand_range(0,get_viewport().size.x),0))
	screen_edges.append(Vector2(0,rand_range(0,get_viewport().size.y)))
	screen_edges.append(Vector2(rand_range(0,get_viewport().size.x),600))
	screen_edges.append(Vector2(1024,rand_range(0,get_viewport().size.y)))
	asteroid.position = screen_edges[rand_range(0,screen_edges.size())]
	screen_edges.clear()
	add_child(asteroid)
