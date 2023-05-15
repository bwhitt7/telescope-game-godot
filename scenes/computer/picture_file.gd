extends VBoxContainer

@export var picture : ImageTexture
@export var file_name : String

func _ready():
	$Label.text = file_name
	#$Button.icon = picture
	var icon = picture.get_image()
	icon.resize(32, 18)
	var icon_img = ImageTexture.create_from_image(icon)
	
	$Button.icon = icon_img

func _on_button_button_down():
	SignalBus.pic_clicked.emit(picture, file_name)

#func _get_drag_data(at_position):
#	var data = {}
#	var drag_texture = TextureRect.new()
#	drag_texture.texture = $Button.icon
#	drag_texture.rect_size = Vector2(32, 18)
#
#	set_drag_preview(drag_texture)
#
#	return data

func _get_drag_data(at_position):
	var data = {node = self}
	var img = TextureRect.new()
	img.texture = $Button.icon
	set_drag_preview(img)
	print(data)
	return data
