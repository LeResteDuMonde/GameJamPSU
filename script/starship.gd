extends Area2D

func _ready():
	area_entered.connect(onAreaEntered)
	
func onAreaEntered(area):
	if area.get_node("..").name == "Player":
		GameManager.win()
