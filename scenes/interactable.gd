extends Node2D


@export var label_text : String
@export var interaction : Dictionary
@export var size_x : float = 1
@export var size_y : float = 1

@onready var label = $Label
var inside = false

func _ready():
	label.text = label_text
	$Area2D/CollisionShape2D.scale = Vector2(size_x, size_y)
	$Area2D/ColorRect.scale = Vector2(size_x, size_y)

func _on_area_2d_body_entered(body):
	label.visible = true
	inside = true

func _on_area_2d_body_exited(body):
	label.visible = false
	inside = false

func _process(delta):
	if Input.is_action_just_pressed("interact") && inside:
		run_interaction()


func run_interaction():
	if interaction.has("scene"):
		get_tree().change_scene_to_file(interaction["scene"])
