extends Node

var sound_r = preload("res://scene/Sound.tscn")

func play(clip_name, count = 0):
	var s = sound_r.instantiate()
	add_child(s)
	
	var clip
	if(count > 0):
		var clips = []
		for i in range(count):
			clips.append("res://audio/" + clip_name + str(i+1) + ".wav")
		clip = clips.pick_random()
	else:
		clip = "res://audio/" + clip_name + ".wav"
	
#	print(clip)
	s.play_clip(clip)
	
func clear():
	for n in get_children():
		remove_child(n)
		n.queue_free()
