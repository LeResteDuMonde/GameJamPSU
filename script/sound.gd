extends AudioStreamPlayer

func play_clip(clip):
	stream = load(clip)
	play()
	
func _on_finished():
	queue_free()
