extends Node

var playerS = preload("res://scene/Player.tscn")
@onready var player = GameManager.main.get_node("Player")
var level
var playerInitialPos

func spawnPlayer(lev):
	print(lev)
	level = lev
#	playerInitialPos = level.get_node("PlayerSpawn").position 
#	GameManager.main.get_node("Level/PlayerSpawn").position
	player.jumpIsAnalogic = true
	setPlayer(1)
	respawnPlayer()
	
func movePlayer(delta,direction,jump):
	if GameManager.isPlayPhase:
		player.move(delta,direction,jump)

func respawnPlayer():
	playerInitialPos = level.get_node("PlayerSpawn").position 
	player.position = playerInitialPos
	player.velocity = Vector2.ZERO
#	player = playerS.instantiate()
#	GameManager.main.add_child(player)

var player1 = preload("res://animation/player1.tres")
var player2 = preload("res://animation/player2.tres")

func setPlayer(nb):
	if nb == 1:
		player.get_node("Sprites/Body").sprite_frames = player1
		player.get_node("PointLight2D").color = Color(.49,.79,.39,.5)		
	elif nb == 2:
		player.get_node("Sprites/Body").sprite_frames = player2
		player.get_node("PointLight2D").color = Color(.34,.76,.89,.5)
		
