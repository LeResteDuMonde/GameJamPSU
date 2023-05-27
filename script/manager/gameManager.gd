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
	
	
func _process(delta):
	#print(Time.get_ticks_msec() - timeStamp, isPlayPhase, timeEnable)
	if timeEnable && isPlayPhase:
		oxygenDisplay.visible = true
		oxygenDisplay.text = "No more oxygen! %d s" % (timeToDeath-(Time.get_ticks_msec()-timeStamp)/1000)
		
		
	if timeEnable and isPlayPhase and timeStamp + timeToDeath*1000 < Time.get_ticks_msec():
		killPlayer()
	
	
func quit():
	get_tree().quit()
	
func killPlayer():
	if isPlayPhase:
		AudioManager.play("death")
		endPlayPhase()
		if currPlayer == 1:
			print("Killed Player 1")
			player1Alive = false
		elif currPlayer == 2:
			print("Killed Player 2")
			player2Alive = false
			
		if not player1Alive and not player2Alive:
			TitleManager.displayEndScreen(0)
		else:
			switchPlayer()
			PlayerManager.respawnPlayer()
			TitleManager.displayIntersticeScreen(currPlayer)
	
func win():
	endPlayPhase()	
	if not player1Alive:
		TitleManager.displayEndScreen(2)
	elif not player2Alive:
		TitleManager.displayEndScreen(1)
	else:
		TitleManager.displayDestructScreen()

		
	
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
	TitleManager.displayIntersticeScreen(currPlayer)
	
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
