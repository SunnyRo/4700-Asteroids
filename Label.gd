extends Label

var sizex = get_viewport_rect().size.x
var sizey = get_viewport_rect().size.y
var x = sizex + 700
var y = sizey + 550
var time = 0

func _ready():

	pass

func _process(delta):
	time += delta / 10
	y -= time
	self.rect_global_position = Vector2(x, y)
