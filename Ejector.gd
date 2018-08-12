extends Node2D


var has_tape = true
var can_take = true
var can_return = true


func _ready():
	$Area.connect('body_entered', self, 'offer')
	$Area.connect('body_exited', self, 'remove_offer')
	$Take.hide()
	$Eject.hide()
	$BareSprite.hide()
	$TapeSprite.show()


func offer(body):
	if has_tape and can_take:
		$Take.show()
		$Eject.hide()
	if not has_tape and can_return:
		$Take.hide()
		$Eject.show()


func remove_offer(body):
	$Take.hide()
	$Eject.hide()


func take_tape():
	has_tape = false
	$BareSprite.show()
	$TapeSprite.hide()
	$Take.hide()
	if can_return:
		$Eject.show()


func return_tape():
	has_tape = true
	$BareSprite.hide()
	$TapeSprite.show()
	$Eject.hide()
	if can_take:
		$Take.show()