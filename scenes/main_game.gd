extends Node

@onready var label = $CanvasLayer/Control/MarginContainer/VBoxContainer/VSplitContainer2/Label
@onready var list = $CanvasLayer/Control/MarginContainer/VBoxContainer/VSplitContainer2/ItemList
@onready var cam = $StarCamera
@onready var butt = $CanvasLayer/Control/MarginContainer/VBoxContainer/Button
@onready var butt_mark = $CanvasLayer/Control/MarginContainer/VBoxContainer/Button2
@onready var star3d = $CanvasLayer/SubViewportContainer/SubViewport/Star
var star = []
var button_state = "goto"
var button_hide_state = false


func _ready():
	SignalBus.star_clicked.connect(_star_clicked)

func _star_clicked(index, pos):
	star = [StarData.star_data[index], pos]
	list.clear()

	var name = star[0]["identifier"]
	if name.begins_with("NAME"):
		name = name.trim_prefix("NAME ")
	elif name.begins_with("*"):
		name = name.trim_prefix("* ")
		
	label.text = name
	list.add_item("RA: " + str(star[0]["ra"]))
	list.add_item("Dec: " + str(star[0]["dec"]))
	list.add_item("Apparent Magnitude: " + str(star[0]["vmag"]))
	list.add_item("Star Type: " + str(star[0]["spec_type"]))
	list.add_item("Object Type: " + str(star[0]["typ"]))


#zooms in on the star
func _on_button_button_down():
	if button_state == "goto":
		button_state = "zoomed"
		butt.text = "Zoom out"
		cam.set("disabled", true)
#		SignalBus.star_zoomed.emit(star[0], true)
		$CanvasLayer/SubViewportContainer.visible = true
		star3d.set_prop(star[0])
		$StarMap.visible = false
		cam.visible = false
		butt_mark.visible = true
		
	else:
		button_state = "goto"
		butt.text = "Go To"
		cam.set("disabled", false)
#		SignalBus.star_zoomed.emit(star[0], false)
		$CanvasLayer/SubViewportContainer.visible = false
		$StarMap.visible = true
		cam.visible = true
		butt_mark.visible = false
	

#Hides telescope view
func _on_button_hide_button_down():
	$CanvasLayer/Control/TelescopeView.visible = button_hide_state
	button_hide_state = !button_hide_state

#Exists the telescope
func _on_button_exit_button_down():
	Global.player_pos = Vector2(205, 300)
	get_tree().change_scene_to_file("res://scenes/telescope_room.tscn")
	
	
#Marks star
func _on_button_2_button_down():
	var file_name = "img_"+star[0]["identifier"]+".png"
	var file_name2 = "img_"+star[0]["identifier"]+".fits"
	var screenshot_path = "res://pictures/"
	var img = get_viewport().get_texture().get_image()
	
	img = star3d.get_viewport().get_texture().get_image()
	var tex = ImageTexture.create_from_image(img)
	
	img.save_png(screenshot_path+file_name)
	Global.mark_target(star[0]["identifier"])
	
	Global.pics[str(Global.day)][file_name2] = tex
