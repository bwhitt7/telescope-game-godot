extends VBoxContainer

@export var folder_name : String

func _ready():
	$Label.text = folder_name

func _on_button_button_down():
	SignalBus.folder_clicked.emit(folder_name)
