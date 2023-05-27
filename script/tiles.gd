extends Node

#@export var tileMap : Resource
var path = "res://tileMap/tileMap.txt"
var tileR = preload("res://scene/Tile.tscn")
var spriteCeiling = preload("res://sprite/groundTile1.png")

const WIDTH = 42
const HEIGHT = 23
const SIZE = 16

func _ready():
	var tileMap = loadFile(path)
	print(tileMap.length())
#	print(tileMap[WIDTH*HEIGHT])
	for i in range(HEIGHT):
		for j in range(WIDTH):
			var tileID = tileMap[i*WIDTH+j]
			
#			print(tileID)
			if(tileID != "0"):
				var t = tileR.instantiate()
#				print(Vector2(j,i))
				var iM = (i - (HEIGHT-1) / 2) * SIZE
				var jM = (j - (WIDTH-1) / 2) * SIZE
				var pos = Vector2(jM,iM)
				
				if(tileMap[(i-1)*WIDTH+j] == "0"):
					t.get_node("Sprite2D").texture = spriteCeiling
					
				t.add_to_group("tiles" + tileID)
				add_child(t)
				t.global_position = pos
		
	pass # Replace with function body.

func loadFile(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content
