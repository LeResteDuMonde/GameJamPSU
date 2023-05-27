extends Node

var playerS = preload("res://scene/Player.tscn")
var player
var playerInitialPos

func _ready():
	player = GameManager.main.get_node("Player")
	playerInitialPos = player.position
	
func movePlayer(delta,direction,jump):
	if GameManager.isPlayPhase:
		player.move(delta,direction,jump)

func respawnPlayer():
	player.position = playerInitialPos
	player.velocity = Vector2.ZERO
#	player = playerS.instantiate()
#	GameManager.main.add_child(player)

var player1Sprite = preload("res://sprite/spritePlayer1.png")
var player2Sprite = preload("res://sprite/spritePlayer2.png")

func setPlayer(nb):
	if nb == 1:
		player.get_node("Sprite2D").set_texture(player1Sprite)
	elif nb == 2:
		player.get_node("Sprite2D").set_texture(player2Sprite)
