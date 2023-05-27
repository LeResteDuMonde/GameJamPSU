extends Node

var playerS = preload("res://scene/Player.tscn")
var player
var playerInitialPos

func _ready():
	player = GameManager.main.get_node("Player")
	playerInitialPos = GameManager.main.get_node("Level/PlayerSpawn").position
	respawnPlayer()
	
func movePlayer(delta,direction,jump):
	if GameManager.isPlayPhase:
		player.move(delta,direction,jump)

func respawnPlayer():
	player.position = playerInitialPos
	player.velocity = Vector2.ZERO
#	player = playerS.instantiate()
#	GameManager.main.add_child(player)

var player1 = preload("res://animation/player1.tres")
var player2 = preload("res://animation/player2.tres")

func setPlayer(nb):
	if nb == 1:
		player.get_node("Sprites/Body").sprite_frames = player1
	elif nb == 2:
		player.get_node("Sprites/Body").sprite_frames = player2
