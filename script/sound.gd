extends AudioStreamPlayer

func play_clip(clip, time = 0):
	stream = load(clip)
	play()
	
	if(time != 0):
		print("time1")
		await get_tree().create_timer(time).timeout
		print("time2")
		queue_free()
		
	
func _on_finished():
	queue_free()
