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

#dying of oxygene
var timeEnable = false
var timeStamp = 0
var timeToDeath = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("Main")
	
	# Show Title Screen first
	displayTitleScreen()
	
func _process(delta):
	#print(Time.get_ticks_msec() - timeStamp, isPlayPhase, timeEnable)
	if timeEnable and isPlayPhase and timeStamp + timeToDeath*1000 < Time.get_ticks_msec():
		killPlayer()
	
	
func quit():
	get_tree().quit()
	
var titleS = preload("res://scene/TitleScreen.tscn")
var title

func displayTitleScreen():
	print("Show Title Screen")
	title = titleS.instantiate()
	main.get_node("UI").add_child(title)
	
func hideTitleScreen():
	if title!=null:
		print("Hide Title Screen")		
		main.get_node("UI").remove_child(title)
		title.queue_free()
		title = null
	if interstice!=null:
		print("Hide interstice")
		main.get_node("UI").remove_child(interstice)
		interstice.queue_free()
		interstice = null
			
func _input(event):
	if event.is_action_pressed("click") and (title != null or interstice != null):
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
		#switchToPlayPhase()
		displayIntersticeScreen(currPlayer-1)
	
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
	
var player1Interstice = load("res://scene/interstice/Player1Interstice.tscn")
var player2Interstice = load("res://scene/interstice/Player1Interstice.tscn")
var interstice = null
func displayIntersticeScreen(player):
	isPlayPhase=false
	print_debug("interstice screen %d"%player)
	if player==1:
		interstice = player2Interstice.instantiate()
	if player==2:
		interstice = player1Interstice.instantiate()
	main.get_node("UI").add_child(interstice)
		
	
func switchPlayer():	
	if currPlayer == 1:
		currPlayer = 2
	elif currPlayer == 2:
		currPlayer = 1
	print(currPlayer)
	PlayerManager.setPlayer(currPlayer)
	
func switchToDeletePhase():
	get_tree().call_group("Monster", "pauseMonster")
	print("Finishing Play Phase")
	switchPlayer()
	isPlayPhase = false
	PlayerManager.respawnPlayer()
	
	print("Entering Delete Phase")
	isDeletePhase = true
	CursorManager.spawnCursor()
	
func switchToPlayPhase():
	print("Finishing Delete Phase")
	hideTitleScreen()
	isDeletePhase = false
	CursorManager.deleteCursor()
	
	print("Starting Play Phase for Player", currPlayer)
	get_tree().call_group("Monster", "respawn")
	get_tree().call_group("Monster", "resumeMonster")
	isPlayPhase = true
	
	
func startTimer():
	print("reset timer")
	timeStamp =  Time.get_ticks_msec()
