extends GridContainer

var picture = preload("res://scenes/computer/picture_file.tscn")
@export var day = 0

func _ready():
	if !Global.pics[day].is_empty():
		for file in Global.pics[day]:
			var pic = picture.instantiate()
			pic.picture = Global.pics[day][file]
			pic.file_name = file
			
			add_child(pic)
#
#func switch_folder(folder_name):
#
#	for file in Global.pics:
#		var pic = picture.instantiate()
#		pic.picture = Global.pics[day][file]
#		pic.file_name = file
#
#		add_child(pic)
