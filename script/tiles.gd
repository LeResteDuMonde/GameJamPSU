extends Node

#@export var tileMap : Resource
var path = "res://tileMap/tileMap.txt"
var tileR = preload("res://scene/Tile.tscn")

const WIDTH = 40
const HEIGHT = 22
const SIZE = 16

func _ready():
	var tileMap = loadFile(path)
	
	for i in range(HEIGHT):
		for j in range(WIDTH):
			tileMap[j*i]

	
	pass # Replace with function body.

func loadFile(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content
