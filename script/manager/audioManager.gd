extends Node

var soundR = preload("res://scene/Sound.tscn")
var crossFadeTimer = 0
var music
var ambience
const FADER_SPEED = 2
const FADER_TIME = 40

func _ready():
	music = play("music/music1")
	music.volume_db = -80
	ambience = play("spaceAthmosphere")
#	crossFader = GameManager.main.get_node("BackgroundMusic")
#	print(crossFader)

func _process(delta):
	if(crossFadeTimer > FADER_TIME and music.volume_db < 0) : 
		music.volume_db += delta * FADER_SPEED
#		print(music.volume_db)
		ambience.volume_db -= delta * FADER_SPEED / 50
	else:
		crossFadeTimer += delta
	
func play(clip_name, count = 1, time = 0,db = 1):
	var s = soundR.instantiate()
	add_child(s)
	
	var clip
	if(count > 1):
		var clips = []
		for i in range(count):
			clips.append("res://audio/" + clip_name + str(i+1) + ".wav")
		clip = clips.pick_random()
	else:
		clip = "res://audio/" + clip_name + ".wav"
	
#	print(clip)
	s.play_clip(clip, time)
	s.volume_db = db
	
	return s
	
func clear():
	for n in get_children():
		remove_child(n)
		n.queue_free()
