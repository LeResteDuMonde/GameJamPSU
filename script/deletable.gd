extends Node2D

func highlight():
	modulate.a = 0.5
	
func unhighlight():
	modulate.a = 1

func delete():
	queue_free()