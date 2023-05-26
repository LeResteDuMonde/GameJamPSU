extends Node

var cursorS = preload("res://scene/Cursor.tscn")
var cursor

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#	spawnCursor() # TODO remove

func spawnCursor():
#	print("spawn cursor")
	cursor = cursorS.instantiate()
	GameManager.main.add_child(cursor)

func deleteCursor():
#	print("del cursor")
	if cursor != null:
		cursor.queue_free()
