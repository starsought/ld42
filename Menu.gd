extends Node


func _ready():
	$Fade.connect('faded', self, 'actually_start_game')


func _input(e):
	pass


var started = false
func _process(delta):
	#if Input.is_action_just_pressed('ui_accept'):
	if Input.is_key_pressed(KEY_SPACE) and not started:
		started = true
		start_game()


func start_game():
	$Fade.show()
	$Fade.fade_to_black(0.2)


func actually_start_game():
	get_tree().change_scene("res://Game.tscn")