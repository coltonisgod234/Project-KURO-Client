extends Node2D

func load_character(scene_path):
	var character = load(scene_path)
	var scene = character.instantiate()
	self.add_child(scene)

var mode = "game"
var selected_character = null

func _process(_delta: float):
	var children = get_children()
	for i in range(len(children)):
		var key = "key%s" % i
		if Input.is_action_just_pressed("Character") and mode != "character":
			mode = "character"
			selected_character = null

			print("MODE: character selection")
			return
		
		if Input.is_action_just_pressed(key) and mode == "character":
			selected_character = children[i]
			mode = "ability"

			print("MODE character SELECTED %s" % selected_character)
			return
		
		if Input.is_action_just_pressed(key) and mode == "ability":
			match key:
				"key0":
					print("MODE ability HIT KEY %s" % key)
					selected_character.primary()
				"key1":
					print("MODE ability HIT KEY %s" % key)
					selected_character.secondary()
				_:
					print("MODE ability HIT UNKNOWN KEY %s" % key)
					return

func _ready():
	load_character("res://gameplay/Characters/violet.tscn")
