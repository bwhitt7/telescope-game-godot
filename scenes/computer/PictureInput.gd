extends Control

@onready var img = $TextureRect
var item: Control = null

func _can_drop_data(at_position, data):
	return item == null

func _drop_data(at_position, data):
	print(data)
	print("dropped")
	var node: Control = data.node
	self.item = node
	set_image()
	
func set_image():
	img.texture = item.picture
