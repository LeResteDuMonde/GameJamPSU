extends Node

var playerS = preload("res://scene/Player.tscn")
var player

func _ready():
	player = GameManager.main.get_node("Player")
	
func movePlayer(delta,direction,jump):
	player.move(delta,direction,jump)

func respawnPlayer(position):
	print("TODO respawn")
#	player = playerS.instantiate()
#	GameManager.main.add_child(player)
