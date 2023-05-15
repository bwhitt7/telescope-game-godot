extends Node

var player_pos = Vector2(443, 300)

var target_list = []
var target_found = []
var day = 1
var pics = {}
var credits = 0
var turn_in_store = {}
var turn_in = {}

func setup():
	day = 1
	pics[str(day)] = {}
	pick_targets()

func pick_targets():
	target_list = ["Betelgeuse", "Dog Star"]
	target_found = [false, false]

func mark_target(target):
	var index = target_list.find(target)
	if index > -1:
		target_found[index] = true
		print("Found target!")

func turn_in_stuff(data):
	pass

func next_day():
	day = day + 1;
	pics[str(day)] = {}
	
