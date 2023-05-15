extends Node2D

@onready var list = $Control/Notepad/ItemList
@onready var screenshot_file = $Control/Picture/VBoxContainer/TextureRect
@onready var screenshot = $Control/Picture
@onready var screenshot_file_name = $Control/Picture/VBoxContainer/MarginContainer/Label

@onready var pic_explore = $Control/FileExplorer

var check_no = preload("res://assets/sprites/computer/check.png")
var check_yes = preload("res://assets/sprites/computer/check_yes.png")
var folder = preload("res://scenes/computer/day_folder.tscn")


func _ready():
	$Control/Label.text = str(Global.day)
	SignalBus.pic_clicked.connect(_pic_clicked)
	list.clear()
	for i in Global.target_list.size():
		if Global.target_found[i]:
			list.add_item(Global.target_list[i], check_yes, false)
		else:
			list.add_item(Global.target_list[i], check_no, false)
	
	for i in Global.pics:
		var f = folder.instantiate()
		f.day = i
		$Control/FileExplorer/VBoxContainer/MarginContainer/ScrollContainer/TabContainer.add_child(f)


#Doors button that leaves the computer
func _on_exit_button_down():
	Global.player_pos = Vector2(350, 300)
	get_tree().change_scene_to_file("res://scenes/telescope_room.tscn")


#X button on file explore closes it
func _on_x_button_button_down():
	pic_explore.visible = false

#Clicking on the picture folder makes the file explore visible
func _on_pictures_button_down():
	pic_explore.visible = true


#Clicking on a picture in the file explorer makes the picture viewer visible
func _pic_clicked(file, file_name):
	screenshot.visible = true
	screenshot_file.texture = file
	screenshot_file_name.text = file_name
	

#X button on picture viewer hides it
func _on_x_button_2_button_down():
	screenshot.visible = false


func _on_button_button_down():
	Global.next_day()
	$Control/Label.text = str(Global.day)
