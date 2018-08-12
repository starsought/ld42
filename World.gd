extends Node

signal game_over


func _ready():
	# Hide the tape-activated areas.
	$Map/Area1.hide()
	$Map/Area2.hide()
	$Map/Area3.hide()
	
	# Hide the crumbled versions of the lobby.
	$Map/Lobby1.show()
	$Map/Lobby2.hide()
	$Map/Lobby3.hide()
	$Map/Lobby4.hide()
	
	# Hide the hints.
	$Hints/Area1.hide()
	$Hints/Area2.hide()
	$Hints/Area3.hide()
	
#	$Map.hide()
	$Tapes/V4.can_take = false
	$Tapes/V4.take_tape()
	$Tapes/V4.remove_offer(null)
	$Keys/K1.set_title("Heart")
	$Keys/K2.set_title("Soul")
	$Keys/K3.set_title("Spirit")

	$Audio.enable('noise')
	
	$Tapes/V1/Area.connect('body_entered', self, 'hide_spacebar')


func walkable(xy):
	var can_walk = false
	var cell = $Map/Base.world_to_map(xy)

	# Every Map Layer
	if $Map.visible:
		for layer in $Map.get_children():
			if layer.visible and layer.get_cellv(cell) in [0, 1]:
				can_walk = true
				break

	# Obstacles
	for obs in $Obstacles.get_children():
		var blocked_cell = $Map/Base.world_to_map(obs.position)
		if blocked_cell == cell and not obs.lowered:
			can_walk = false
	return can_walk


func interact():
	if $Tapes/V1/Take.visible:
		$Tapes/V1.take_tape()
		$Map/Path1.hide()
		$Map/Area1.show()
		$Audio.insert()
		$Audio.enable('chords')
		$Audio.disable('noise')
		$Player/Sprite.set_face(1, false)
	elif $Tapes/V2/Take.visible:
		$Tapes/V2.take_tape()
		$Map/Path2.hide()
		$Map/Area2.show()
		$Audio.insert()
		$Audio.enable('ostinato')
		$Audio.disable('noise')
		$Player/Sprite.set_face(2, false)
	elif $Tapes/V3/Take.visible:
		$Tapes/V3.take_tape()
		$Map/Path3.hide()
		$Map/Area3.show()
		$Audio.insert()
		$Audio.enable('bass')
		$Audio.enable('ostinato')
		$Audio.disable('noise')
		$Player/Sprite.set_face(3, false)

	elif $Tapes/V1/Eject.visible:
		$Tapes/V1.return_tape()
		$Map/Path1.show()
		$Map/Area1.hide()
		$Audio.eject()
		$Audio.disable('chords')
		$Audio.enable('noise')
		$Player/Sprite.set_face(0, false)
	elif $Tapes/V2/Eject.visible:
		$Tapes/V2.return_tape()
		$Map/Path2.show()
		$Map/Area2.hide()
		$Audio.eject()
		$Audio.disable('ostinato')
		$Audio.enable('noise')
		$Player/Sprite.set_face(0, false)
	elif $Tapes/V3/Eject.visible:
		$Tapes/V3.return_tape()
		$Map/Path3.show()
		$Map/Area3.hide()
		$Audio.eject()
		$Audio.disable('bass')
		$Player/Sprite.set_face(0, false)
		# Don't re-enable the noise after key three.

	elif $Tapes/V4/Eject.visible:
		$Tapes/V4.return_tape()
		emit_signal('game_over')

	elif $Keys/K1/Text.visible:
		$Keys/K1.take()
		$Obstacles/Final1.lower()
		$Obstacles/Path2.lower()
		$Obstacles/Path3A.lower()
		$Map/Lobby1.hide()
		$Map/Lobby2.show()
		$Hints/Area1.show()
		$Audio.enable('drums')
		$Player/Sprite.set_face(1, true)
	elif $Keys/K2/Text.visible:
		$Keys/K2.take()
		$Obstacles/Final2.lower()
		$Obstacles/Path3B.lower()
		$Map/Lobby2.hide()
		$Map/Lobby3.show()
		$Hints/Area1.hide()
		$Hints/Area2.show()
		$Audio.enable('chords')
		$Player/Sprite.set_face(2, true)
	elif $Keys/K3/Text.visible:
		$Keys/K3.take()
		$Obstacles/Final3.lower()
		$Map/Lobby3.hide()
		$Map/Lobby4.show()
		$Hints/Area2.hide()
		$Hints/Area3.show()
		$Player/Sprite.set_face(3, true)

func hide_spacebar(x):
	$Hints/Interact.hide()