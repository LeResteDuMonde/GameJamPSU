extends Node

var main
var main_r = preload("res://scene/Main.tscn")
var root
var web 

var isDeletePhase = false
var isPlayPhase = false
var player1Alive = true
var player2Alive = true
var currPlayer = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("Main")
	
	# Show Title Screen first
	displayTitleScreen()

func quit():
	get_tree().quit()
	
var titleS = preload("res://scene/TitleScreen.tscn")
var title

func displayTitleScreen():
	print("Show Title Screen")
	title = titleS.instantiate()
	main.get_node("UI").add_child(title)
	
func _input(event):
	if event.is_action_released("click") and title != null:
		print("Hide Title Screen")
		title.queue_free()
		switchToPlayPhase()
	
func killPlayer():
	if currPlayer == 1:
		print("Killed Player 1")
		player1Alive = false
	elif currPlayer == 2:
		print("Killed Player 2")
		player2Alive = false
		
	if not player1Alive and not player2Alive:
		displayEndScreen(0)
	else:
		switchPlayer()
		PlayerManager.respawnPlayer()
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
	var end = endS.instantiate()
	main.get_node("UI").add_child(end)
	if winner == 1:
		end.get_node("Player1").visible = true
	elif winner == 2:
		end.get_node("Player2").visible = true
	else:
		end.get_node("Death").visible = true
	
func switchPlayer():	
	if currPlayer == 1:
		currPlayer = 2
	elif currPlayer == 2:
		currPlayer = 1
	print(currPlayer)
	PlayerManager.setPlayer(currPlayer)
	
func switchToDeletePhase():
	print("Finishing Play Phase")
	switchPlayer()
	isPlayPhase = false
	PlayerManager.respawnPlayer()
	
	print("Entering Delete Phase")
	isDeletePhase = true
	CursorManager.spawnCursor()
	
func switchToPlayPhase():
	print("Finishing Delete Phase")
	isDeletePhase = false
	CursorManager.deleteCursor()
	
	print("Starting Play Phase for Player", currPlayer)
	GameManager.main.get_node("CagedMonster").respawn()
	isPlayPhase = true
