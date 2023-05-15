extends Node

@export var star_scale = 1000

var star = preload("res://scenes/star.tscn")
var table = "res://assets/data/star_data2.json"
var star_data = []

var mapWidth = 500
var mapHeight = 500

var white = preload("res://assets/mat/star_white.tres")
var O = preload("res://assets/mat/star_O.tres")
var B = preload("res://assets/mat/star_B.tres")
var A = preload("res://assets/mat/star_A.tres")
var F = preload("res://assets/mat/star_F.tres")
var G = preload("res://assets/mat/star_G.tres")
var K = preload("res://assets/mat/star_K.tres")
var M = preload("res://assets/mat/star_M.tres")


var starMap = [
	{
		"name": "Betelgeuse",
		"RA": 88.79295833,
		"dec":7.407055556,
		"app_mag":0.45,
		"abs_mag":-6.02
	},
	
	{
		"name": "Rigel",
		"RA":78.63446667,
		"dec":-8.201638889,
		"app_mag":0.18,
		"abs_mag":-6.95
	},
	
	{
		"name": "Bellatrix",
		"RA":81.2827625,
		"dec":6.349702778,
		"app_mag":1.64,
		"abs_mag":-2.72
	},
	
	{
		"name": "Mintaka",
		"RA":83.00166667,
		"dec":-0.299094444,
		"app_mag":2.25,
		"abs_mag":-4.47
	},
	
	{
		"name": "Alnilam",
		"RA":84.0533875,
		"dec":-1.201919444,
		"app_mag":1.69,
		"abs_mag":-6.38
	},
	
	{
		"name": "Alnitak",
		"RA":85.18969583,
		"dec":-1.942572222,
		"app_mag":1.74,
		"abs_mag":-5.15
	},
	
	{
		"name": "Saiph",
		"RA":86.93912,
		"dec":-9.669605,
		"app_mag":2.07,
		"abs_mag":-4.65
	}
]



func _ready():
	table = FileAccess.get_file_as_string(table)
	table = JSON.parse_string(table)
	table = table["simbad"]
	
	
	#print(table)
	for s in table:
		star_data.append(createStar(s))
	

func createStar(data):
	#var star_scene = star.instantiate()
	var col = data["spec_type"]
	var nam = data["identifier"]
	var type = data["typ"]
	var sc = 1
	var mat
	
	var pos = Vector2(-data["ra_deg"]/90 * star_scale + 1000, -data["dec_deg"]/90 * star_scale)
	
	data["x"] = pos.x
	data["y"] = pos.y
	
	
	if nam.begins_with("NAME"):
		data["identifier"] = nam.trim_prefix("NAME ")
	elif nam.begins_with("*"):
		data["identifier"] = nam.trim_prefix("* ")
	
	if col.begins_with("O"):
		col = Color("#81a4ff")
		mat = O
	elif col.begins_with("B"):
		col = Color("#99B9FF")
		mat = B
	elif col.begins_with("A"):
		col = Color("#C9D9FF")
		mat = A
	elif col.begins_with("F"):
		col = Color("#ECEEFF")
		mat = F
	elif col.begins_with("G"):
		col = Color("#FFF2EE")
		mat = G
	elif col.begins_with("K"):
		col = Color("#FFE7D2")
		mat = K
	elif col.begins_with("M"):
		col = Color("#FFCC98")
		mat = M
	else:
		col = Color("#FFFFFF")
		mat = white
	
	
	if type.ends_with("SG") || type == "Supergiant" || type.ends_with("SG*"):
		sc = 1.5
	elif type.begins_with("Massiv"):
		sc = 1.3
	
	data["scale"] = sc
	data["col"] = col
	data["mat"] = mat
	
	return data
	
	#star_scene.set("position", pos)
	#star_scene.set("data", data)
	
	#add_child(star_scene)

#
#func randPosition():
#	return Vector2(randi() % 200, randi() % 200)
#




#func getXY(s_ra, s_dec, c_ra, c_dec):
#	s_ra = s_ra * (180/PI)
#	s_dec = s_dec * (180/PI)
#	c_ra = c_ra * (180/PI)
#	c_dec = c_dec * (180/PI)
#
#	var stdX = cos(s_dec) * sin(s_ra - c_ra) / (cos(c_dec) * cos(s_dec) * cos(s_ra - c_ra) + sin(c_dec) * sin(s_dec))
#	var stdY = (sin(c_dec) * cos(s_dec) * cos(s_ra - c_ra) - cos(c_dec) * sin(s_dec)) / (cos(c_dec) * cos(s_dec) * cos(s_ra - c_ra) + sin(c_dec) * sin(s_dec))
#
#	var starX = mapWidth - (pixelsPerRadW * stdX + mapCenterX)
#	var starY = pixelsPerRadH * stdY + mapCenterY
#
#	return Vector2(starX, starY)
