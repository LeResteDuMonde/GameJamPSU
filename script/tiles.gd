extends Node

#@export var tileMap : Resource
var levelID = 1
var path = "res://tileMap/level" + str(levelID) + ".txt"
var tileR = preload("res://scene/Tile.tscn")
var ceiling = preload("res://sprite/groundTile1.png")
var sand = preload("res://sprite/sandTile1.png")
var stone = preload("res://sprite/stoneTile1.png")

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
				
				if(tileID != "X"): t.add_to_group("tiles" + tileID)
				
				if(tileID == "S") : setTex(t,sand)
				elif(tileID == "P") : setTex(t,stone)
				else:
					if(i > 0 and tileMap[(i-1)*WIDTH+j] == "0"): tileID = "C"
					elif(i < HEIGHT - 2 and tileMap[(i+1)*WIDTH+j] == "0"): tileID = "F"
					if(tileID == "F") : setTex(t,ceiling,true)
					elif(tileID == "C") : setTex(t,ceiling)		
				add_child(t)
				t.global_position = pos
		
	pass # Replace with function body.

func setTex(t,tex, flip = false):
	var sprite = t.get_node("Sprite2D")
	sprite.texture = tex
	sprite.flip_v = flip

func loadFile(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content
