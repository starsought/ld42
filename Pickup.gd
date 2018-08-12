extends Node2D

signal got_it


func _ready():
	$Area.connect('body_entered', self, 'pickup')


func pickup(body):
	# body should always be player
	emit_signal('got_it')
	$Area/Hitbox.disabled = true