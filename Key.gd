extends Node2D

var has_key = true


func _ready():
	$Area.connect('body_entered', self, 'offer')
	$Area.connect('body_exited', self, 'remove_offer')
	$Text.hide()


func set_title(tit):
	$Text.text = tit


func offer(body):
	if has_key:
		$Text.show()


func remove_offer(body):
	$Text.hide()


func take():
	has_key = false
	$Sprites/Item.hide()
	$Sprites/Bare.show()
	remove_offer(null)