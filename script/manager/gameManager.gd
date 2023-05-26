extends Node

var main
var cursor
var main_r = preload("res://scene/Main.tscn")
var root
var web 

var isDeletePhase = false
var player1Alive = true
var player2Alive = true
var currPlayer = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("Main")
	cursor = main.get_node("Cursor")
	
	# Show Title Screen first
	displayTitleScreen()

func quit():
	get_tree().quit()
	
var titleS = preload("res://scene/TitleScreen.tscn")
var title

func displayTitleScreen():
	print("Show Title Screen")
	title = titleS.instantiate()
	main.add_child(title)
	
func _input(event):
	if event.is_action_released("click") and title != null:
		print("Hide Title Screen")
		title.queue_free()
	
func killPlayer():
	if currPlayer == 1:
		player1Alive = false
	elif currPlayer == 2:
		player2Alive = false
		
	if not player1Alive and not player2Alive:
		displayEndScreen(0)
	else:
		switchToPlayPhase()
	
func win():
	if not player1Alive:
		displayEndScreen(2)
	elif not player2Alive:
		displayEndScreen(1)
	else:
		switchToDeletePhase()
	
var endS = preload("res://scene/EndScreen.tscn")

func displayEndScreen(winner):
	main.add_child(endS.instantiate())
	
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

	if currPlayer == 1:
		currPlayer = 2
	elif currPlayer == 2:
		currPlayer = 1
	print("Starting Play Phase for Player", currPlayer)
	PlayerManager.respawnPlayer(Vector2.ZERO)
