extends Node2D

onready var World = $".."

var tile_size = Vector2(1, 0.75)
var prev = Vector2(0, 0)
var walk_frame = 0

var free_movement = false

func get_input_direction():
#	var dir = Vector2(
#	int(Input.is_action_pressed('ui_right')) - int(Input.is_action_pressed('ui_left')),
#	int(Input.is_action_pressed('ui_down')) - int(Input.is_action_pressed('ui_up')))

	var dir = Vector2(
	int(Input.is_key_pressed(KEY_RIGHT)) - int(Input.is_key_pressed(KEY_LEFT)),
	int(Input.is_key_pressed(KEY_DOWN)) - int(Input.is_key_pressed(KEY_UP)))
	if dir.x and dir.y:
		dir.y = 0
	return dir


func _physics_process(delta):
	if Input.is_action_just_pressed('ui_accept') and not $Cooldown.time_left:
		World.interact()
		$Cooldown.start()

	var movement = get_input_direction()
	if movement:
		prev = movement
		walk(movement, delta)
	else:
		$Sprite.set_frame('idle', prev)


func walk(v, delta):
	$Sprite.set_frame('walk', v)
	var movement = v * delta * tile_size * 100
	if World.walkable(position + movement) or free_movement:
		position += movement