extends Node

var main
var cursor
var main_r = preload("res://scene/Main.tscn")
var root
var web 

var isDeletePhase = false
var lastPlayer = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("Main")
	cursor = main.get_node("Cursor")

func quit():
	get_tree().quit()
		
func switchToDeletePhase():
	print("Finishing Play Phase")
#	PlayerManager.deletePlayer()
	
	print("Entering Delete Phase")
	isDeletePhase = true
	CursorManager.spawnCursor()
	
func switchToPlayPhase():
	print("Finishing Delete Phase")
	isDeletePhase = false
	CursorManager.deleteCursor()

	lastPlayer = 1 - lastPlayer
	print("Starting Play Phase for Player", lastPlayer + 1)
	PlayerManager.respawnPlayer(Vector2.ZERO)
