extends Node

var cursorS = preload("res://scene/Cursor.tscn")
var cursor

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#	spawnCursor() # TODO remove

func spawnCursor():
	if cursor == null:
		cursor = cursorS.instantiate()
		GameManager.main.add_child(cursor)

func deleteCursor():
	if cursor != null:
		GameManager.main.remove_child(cursor)	
		cursor.queue_free()
