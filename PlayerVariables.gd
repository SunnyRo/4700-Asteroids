extends Node

var health = 100
var score = 0
var lives = 3
signal asteroid_destroyed
signal lost_life

func aster_destr():
	score += 10
	print(score)
	emit_signal("asteroid_destroyed")
	
func ship_destroyed():
	lives -= 1
	print(lives)
	emit_signal("lost_life")
