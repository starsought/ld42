extends Node


func _ready():
	$World.connect('game_over', self, 'end_game')
	$Interface/Fade.set_alpha(1)
	$Interface/Fade.fade_from_black(0.2)


func end_game():
	$Interface/Fade.connect('faded', self, 'actually_end_game')
	$Interface/Fade.fade_to_black(0.8)


func actually_end_game():
	$World/Player.position = $World/EndWarp.position
	$Interface/Fade.disconnect('faded', self, 'actually_end_game')
	$Interface/Fade.fade_from_black(0.4)
	$World/Player.prev = Vector2(0, 1)
	$World/Player/Sprite.set_face(1, true)