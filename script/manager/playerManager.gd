extends Node

var player

func _ready():
	player = GameManager.main.get_node("Player")
	
func movePlayer(delta,direction,jump):
	player.move(delta,direction,jump)
