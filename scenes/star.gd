extends Node2D

@onready var txt = $Label
@onready var area = $Area2D
@onready var sprite = $Sprite2D
@onready var cursor = $Cursor
@onready var cursor_anim = $Cursor/AnimationPlayer

@export var index : int
@export var star_scale = 0.1


var inside_star = false

var star_white = preload("res://assets/sprites/star.png")

func _ready():
	var sc = (5-int(StarData.star_data[index]["vmag"]))*star_scale
	
	txt.text = StarData.star_data[index]["identifier"]
	print(txt.text)
	
	sprite.scale = Vector2(sc, sc)
	sprite.self_modulate = StarData.star_data[index]["col"]

#Checks if star is clicked
func _process(delta):
	if Input.is_action_just_pressed("click"):
		if inside_star:
			SignalBus.star_clicked.emit(index, self.global_position)
			cursor.visible = true
			cursor_anim.current_animation = "idle"
		else:
			cursor.visible = false
			cursor_anim.current_animation = "RESET"


#when hovering over star, show off nametag
func _on_area_2d_mouse_entered():
	txt.visible = true
	inside_star = true


func _on_area_2d_mouse_exited():
	txt.visible = false
	inside_star = false
