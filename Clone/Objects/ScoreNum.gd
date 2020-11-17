extends Label

func _ready():
	pass
func update_score(score):
	text = str(int(text) + score)
