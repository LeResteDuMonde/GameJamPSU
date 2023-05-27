extends Node
	
@onready var ui = get_tree().root.get_node("Main/UI")
@onready var titleScreen = ui.get_node("TitleScreen")
@onready var levelSelectScreen = ui.get_node("LevelSelect")
@onready var controlScreen = ui.get_node("ControlScreen")
@onready var destructScreen = ui.get_node("DestructScreen")
@onready var endScreen = ui.get_node("EndScreen")

func _ready():
	# Show Title Screen first
	TitleManager.displayTitleScreen()

func displayTitleScreen():
	print("Show Title Screen")
	titleScreen.visible = true
	
func displayLevelSelect():
	levelSelectScreen.visible = true
	
func displayControlScreen():
	controlScreen.visible = true
	
func displayDestructScreen():
	print("Show Destruct Screen")
	destructScreen.visible = true
		
func displayEndScreen(winner):
	endScreen.visible = true
	if winner == 1:
		endScreen.get_node("Player1").visible = true
	elif winner == 2:
		endScreen.get_node("Player2").visible = true
	else:
		endScreen.get_node("Death").visible = true
	
@onready var player1Interstice = ui.get_node("Player1Interstice")
@onready var player2Interstice = ui.get_node("Player2Interstice")

func displayIntersticeScreen(player):
	print("Display Interstice Screen for ", player)
	if player==1:
		player1Interstice.visible = true
	elif player==2:
		player2Interstice.visible = true
	
func hideTitleScreens():
	titleScreen.visible = false
	controlScreen.visible = false
	destructScreen.visible = false
	endScreen.visible = false
	player1Interstice.visible = false
	player2Interstice.visible = false
	levelSelectScreen.visible = false
	endScreen.get_node("Player1").visible = false
	endScreen.get_node("Player2").visible = false
	endScreen.get_node("Death").visible = false
	
func _input(event):
	if event.is_action_pressed("click"):
		if titleScreen.visible or endScreen.visible:
			hideTitleScreens()
			displayLevelSelect()
			CursorManager.spawnCursor()
		elif controlScreen.visible or player1Interstice.visible or player2Interstice.visible:
			hideTitleScreens()
			GameManager.startPlayPhase()
		elif destructScreen.visible:
			hideTitleScreens()
			GameManager.startDeletePhase()
