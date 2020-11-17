extends Label


func _ready():
	var player = get_tree().get_root().find_node("PlayerKinecticBody",true,false)
	
	change_text()
	
func change_text():
	var player = get_tree().get_root().find_node("PlayerKineticBody",true,false)
	player.connect("lost_life", self, "change_text")
	text = str(player.lives)
