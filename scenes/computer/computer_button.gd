extends Button

@onready var txt = $Label
#@export var file_image : Texture2D
@export var label : String

func _ready():
	txt.text = label
	#icon = file_image
