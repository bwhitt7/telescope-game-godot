extends Node2D

@onready var player = $Player

var dialogue = preload("res://dialogue/test.dialogue")
var intro_text = true

func _ready():
	player.position = Global.player_pos
	if intro_text:
		#DialogueManager.show_example_dialogue_balloon(dialogue, "intro_text") 
		intro_text = false
