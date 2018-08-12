extends Node


func _ready():
	pass


func match_name(track):
	match track:
		'drums'    : return $Tracks/Drums
		'bass'     : return $Tracks/Bass
		'chords'   : return $Tracks/Chords
		'ostinato' : return $Tracks/Ostinato
		'noise'    : return $Tracks/Noise


func set_volume(track, v):
	match_name(track).set_volume_db(v)

func set_all(v):
	for track in $Tracks.get_children():
		track.set_volume_db(v)

func fade_in(track):
	var obj = match_name(track)
	$Fade.interpolate_method(obj, 'set_volume_db', -60, 0, 4,
		Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Fade.start()

func fade_out(track):
	var obj = match_name(track)
	$Fade.interpolate_method(obj, 'set_volume_db', 0, -60, 4,
		Tween.TRANS_EXPO, Tween.EASE_IN)
	$Fade.start()

func enable(track):
	fade_in(track)

func disable(track):
	fade_out(track)

func insert():
	$Effects/Insert.play()

func eject():
	$Effects/Eject.play()