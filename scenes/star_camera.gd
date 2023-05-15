extends Camera2D
@export var move_speed = 50
@export var disabled = false

func _physics_process(delta):
	#Get input direction
	if disabled == false:
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		
		position = position + (input_direction * move_speed)
