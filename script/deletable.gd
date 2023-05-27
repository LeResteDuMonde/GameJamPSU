extends Node2D

func highlight(g):
	var high = get_node("Highlight")
	if high != null:
		high.visible = true
	
func unhighlight(g):
	var high = get_node("Highlight")
	if high != null:
		high.visible = false

func delete(g):
	print_debug("delete")
#	AudioManager.play("clic")
	queue_free()
