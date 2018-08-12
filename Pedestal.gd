extends Node2D


var lowered = false


func _ready():
	pass


func lower():
	lowered = true
	$Raised.hide()