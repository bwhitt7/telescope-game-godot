extends CharacterBody2D

@export var speed : int = 100
@onready var action_finder = $Area2D

var action : Actionable

func _physics_process(delta):
	velocity.x = (Input.get_action_strength("right") - Input.get_action_strength("left")) * speed
	move_and_slide()



#func check_action():
#	var areas : Array[Area2D] = action_finder.get_overlapping_areas()
#	var short_dist : float = INF
#	var next_action : Actionable = null
#	for area in areas:
#		var dist : float = area.global_position.distance_to(global_position)
#		if dist < short_dist:
#			short_dist = dist
#			next_action = area
#	if action != next_action or not is_instance_valid(next_action):
#		action = next_action
#		SignalBus.emit_signal("nearest_actionable_changed", action)
#
#func _unhandled_input(event):
#	if event.is_action_pressed("interact"): 
#		get_viewport().set_input_as_handled()
#		if is_instance_valid(owner.action):
#			owner.action.emit_signal("actioned")
