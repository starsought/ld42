extends CanvasLayer


func _ready():
	$Pause.hide()


#func _process(delta):
	#if Input.is_action_just_pressed('ui_cancel'):
		#pauseunpause()


func pauseunpause():
	if get_tree().paused:
		get_tree().paused = false
		$Pause.hide()
	else:
		get_tree().paused = true
		$Pause.show()