extends Node

var playerS = preload("res://scene/Player.tscn")
var player
var playerInitialPos

func _ready():
	player = GameManager.main.get_node("Player")
	playerInitialPos = player.position
	
func movePlayer(delta,direction,jump):
	if not GameManager.isDeletePhase:
		player.move(delta,direction,jump)

func respawnPlayer():
	player.position = playerInitialPos
#	player = playerS.instantiate()
#	GameManager.main.add_child(player)
