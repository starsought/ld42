extends Control

signal faded


func _ready():
	$Smoother.connect('tween_completed', self, 'tween_completed')


func set_alpha(a):
	$Color.color.a = a


func fade_to_black(time):
	$Smoother.interpolate_method(self, 'set_alpha', 0, 1, time,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Smoother.start()


func fade_from_black(time):
	$Smoother.interpolate_method(self, 'set_alpha', 1, 0, time,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Smoother.start()


func tween_completed(o, k):
	emit_signal('faded')