extends Node2D

var star = preload("res://scenes/star.tscn")

var mapWidth = 500
var mapHeight = 500

var pixelSize = 3.8
var bin = 1
var fLen = 25

var mapWidthRad = 2 * atan((pixelSize * bin * mapWidth / 1000) / (2 * fLen))
var mapHeightRad = 2 * atan((pixelSize * bin * mapHeight / 1000) / (2 * fLen))

var mapCenterX = mapWidth/2
var mapCenterY = mapHeight/2

var pixelsPerRadW = 20#mapWidth / mapWidthRad
var pixelsPerRadH = 20#mapHeight / mapHeightRad



func _ready():
	#print(table)
	
	#looks through all loaded star data and creates star scenes
	for i in StarData.star_data.size():
		createStar(i)
	

#
func createStar(index):
	var star_scene = star.instantiate()
	star_scene.set("index", index)
	star_scene.set("position", Vector2(StarData.star_data[index]["x"], StarData.star_data[index]["y"]))
	
	add_child(star_scene)
