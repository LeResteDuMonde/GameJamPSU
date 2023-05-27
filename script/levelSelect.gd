extends Area2D

@onready var highlight = get_node("Highlight")

func _ready():
	area_entered.connect(onAreaEntered)
	area_exited.connect(onAreaExited)
	
var selected = false

func onAreaEntered(area):
	selected = true
	if area.owner.name == "Cursor":
		highlight.visible = true

func onAreaExited(area):
	selected = false
	if area.owner.name == "Cursor":
		highlight.visible = false

var level1 = preload("res://scene/Level1.tscn")

func loadLevel(level):
	GameManager.startGame(level.instantiate())


func _input(event):
	if event.is_action_pressed("click") && selected && TitleManager.levelSelectScreen.visible:
		if name == "Level1": loadLevel(level1)
