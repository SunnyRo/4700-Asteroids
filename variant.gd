extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_edges : Array = []
var BAsteroids = preload("res://Variant/Objects/BAsteroid.tscn")
var SeekingEnemy = preload("res://Variant/Objects/SeekingEnemy.tscn")
var angular_speed = 0
var count = 0
var counter = 0
var seekCount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
		randomize()
		pass
	
func _process(delta):
	if count == 60:
		asteroidSpawning()
		count = 0
	if seekCount == 500:
		seekSpawning()
		seekCount = 0
	count += 1
	seekCount += 1
	

func seekSpawning():
	var seekEnemy = SeekingEnemy.instance()
	screen_edges.append(Vector2.ZERO)
	screen_edges.append(Vector2(rand_range(0,get_viewport().size.x),0))
	screen_edges.append(Vector2(0,rand_range(0,get_viewport().size.y)))
	screen_edges.append(Vector2(rand_range(0,get_viewport().size.x),600))
	screen_edges.append(Vector2(1024,rand_range(0,get_viewport().size.y)))
	seekEnemy.position = screen_edges[rand_range(0,screen_edges.size())]
	screen_edges.clear()
	add_child(seekEnemy)

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
