extends Label

func _ready():
	#var ast = get_tree().get_root().find_node("Asteroid",true,false)
	#ast.connect("asteroid_destroyed", self, "change_text")
	#change_text()
	pass
func change_text():
	#var ast = get_tree().get_root().find_node("Asteroid",true,false)
	
	#text = str(ast.score)
	pass
func update_score(score):
	text = str(int(text) + score)
