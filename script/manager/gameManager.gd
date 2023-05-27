extends Node

var main
var main_r = preload("res://scene/Main.tscn")
var root
var web 
var oxygenDisplay

var isDeletePhase = false
var isPlayPhase = false
var player1Alive = true
var player2Alive = true
var currPlayer

#dying of oxygene
var timeEnable = false
var timeStamp = 0
var timeToDeath = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("Main")
	oxygenDisplay = main.get_node("UI/OxygenLabel")
	currPlayer = 1
	
	# Show Title Screen first
	displayTitleScreen()
	
func _process(delta):
	#print(Time.get_ticks_msec() - timeStamp, isPlayPhase, timeEnable)
	if timeEnable && isPlayPhase:
		oxygenDisplay.visible = true
		oxygenDisplay.text = "No more oxygen! %d s" % (timeToDeath-(Time.get_ticks_msec()-timeStamp)/1000)
		
		
	if timeEnable and isPlayPhase and timeStamp + timeToDeath*1000 < Time.get_ticks_msec():
		killPlayer()
	
	
func quit():
	get_tree().quit()
	
var titleS = preload("res://scene/titles/TitleScreen.tscn")
var title

var destructScreenS = preload("res://scene/titles/DestroyScreen.tscn")
var destructScreen

func displayTitleScreen():
	print("Show Title Screen")
	title = titleS.instantiate()
	main.get_node("UI").add_child(title)
	
func displayDestructScreen():
	print("Show Destruct Screen")
	destructScreen = destructScreenS.instantiate()
	main.get_node("UI").add_child(destructScreen)
	
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
	if destructScreen!=null:
		print("Hide destruct screen")
		main.get_node("UI").remove_child(destructScreen)
		destructScreen.queue_free()
		destructScreen = null
			
func _input(event):
	if event.is_action_pressed("click") and (title != null or interstice != null):
		hideTitleScreen()
		startPlayPhase()
	elif event.is_action_pressed("click") and (destructScreen != null):
		hideTitleScreen()
		startDeletePhase()
	
func killPlayer():
	if isPlayPhase:
#		AudioManager.play("death")
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
			displayIntersticeScreen()
	
func win():
	endPlayPhase()	
	if not player1Alive:
		displayEndScreen(2)
	elif not player2Alive:
		displayEndScreen(1)
	else:
		displayDestructScreen()
	
var endS = preload("res://scene/titles/EndScreen.tscn")
func displayEndScreen(winner):
	
	var end = endS.instantiate()
	main.get_node("UI").add_child(end)
	if winner == 1:
		end.get_node("Player1").visible = true
	elif winner == 2:
		end.get_node("Player2").visible = true
	else:
		end.get_node("Death").visible = true
	
var player1Interstice = load("res://scene/titles/Player1Interstice.tscn")
var player2Interstice = load("res://scene/titles/Player2Interstice.tscn")
var interstice = null

func displayIntersticeScreen():
	isPlayPhase=false
	print_debug("interstice screen %d"%currPlayer)
	if currPlayer==1:
		interstice = player1Interstice.instantiate()
	if currPlayer==2:
		interstice = player2Interstice.instantiate()
	main.get_node("UI").add_child(interstice)
		
	
func switchPlayer():	
	if currPlayer == 1:
		currPlayer = 2
	elif currPlayer == 2:
		currPlayer = 1
	print("Player is now ", currPlayer)
	PlayerManager.setPlayer(currPlayer)
	
func endPlayPhase():
	print("Finishing Play Phase")
	isPlayPhase = false	
	get_tree().call_group("Monster", "pauseMonster")	
	
func startDeletePhase():
	print("Starting Delete Phase")
	switchPlayer()
	PlayerManager.respawnPlayer()
	isDeletePhase = true
	CursorManager.spawnCursor()
	
func endDeletePhase():
	print("Finishing Delete Phase")
	isDeletePhase = false
	CursorManager.deleteCursor()
	displayIntersticeScreen()
	
func startPlayPhase():
	print("Starting Play Phase for Player", currPlayer)
	AudioManager.play("getToTheBase")
	get_tree().call_group("Monster", "respawn")
	get_tree().call_group("Monster", "resumeMonster")
	isPlayPhase = true
	startTimer()

func startTimer():
#	print("reset timer")
	timeStamp =  Time.get_ticks_msec()
