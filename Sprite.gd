extends Sprite

var animations = {
	'idle': {
		'd': [ 0,  1,  0,  1],
		'r': [ 8,  9,  8,  9],
		'u': [16, 17, 16, 17],
	},
	'walk': {
		'd': [ 2,  3,  4,  5],
		'r': [10, 11, 12, 13],
		'u': [18, 19, 20, 21],
	},
	'tape': {
		'd': [ 6,  7,  6,  7],
		'r': [14, 15, 14, 15],
		'u': [22, 23, 22, 23],
	},
}

var index = 0
var state = 'idle'
var face = 0
var face_index = 0


func _ready():
	$Time.connect('timeout', self, 'tick')
	$Facetime.connect('timeout', self, 'face_tick')
	$Facetime.wait_time = 0.5
	set_state('idle')


func tick():
	index = (index+1) % 4

func face_tick():
	face_index = (face_index+1) % 2


func set_state(s):
	index = 0
	face_index = 0
	$Time.stop()
	$Facetime.stop()
	if s == 'idle':
		$Time.wait_time = 0.5
	else:
		$Time.wait_time = 0.15
	$Time.start()
	$Facetime.start()


func set_frame(s, v):
	if s != state:
		state = s
		set_state(s)
	flip_h = false
	$Face.hide()
	match v:
		Vector2(0, 1):
			frame = animations[state]['d'][index]
			place_face(state, index, face_index)
		Vector2(0, -1):
			frame = animations[state]['u'][index]
		Vector2(1, 0):
			frame = animations[state]['r'][index]
		Vector2(-1, 0):
			flip_h = true
			frame = animations[state]['r'][index]


func set_face(area, happy):
	match area:
		0: face = 0
		1: face = 4
		2: face = 8
		3: face = 12
	if happy:
		face += 2


func place_face(s, i, face_i):
	$Face.show()
	i = i % 2
	match s:
		'idle':
			if i == 0:
				$Face.position.y = 1
			else:
				$Face.position.y = 0
			$Face.frame = face + face_i
		'walk':
			if i == 0:
				$Face.position.y = 0
			else:
				$Face.position.y = 1
			$Face.frame = face + face_i