extends Node2D

@export var mainGameScene : PackedScene


func _on_start_button_button_up():
	Global.setup()
	get_tree().change_scene_to_packed(mainGameScene)
	


func _on_quit_button_button_up():
	get_tree().quit()
