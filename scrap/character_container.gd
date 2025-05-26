extends Node2D

func load_character(scene_path):
	var character = load(scene_path)
	self.add_child(character)

var mode = "game"
var selected_character = null
func handle_character_mode():
	var children = get_children()
	for i in range(len(children)):
		var key = "key%d" % i
		if Input.is_action_just_pressed("Character") and mode != "character":
			mode = "character"
			selected_character = null
			print("SELECTING character")
			return

		if Input.is_action_just_pressed(key) and mode == "character":
			selected_character = children[i]
			print("SELECTED CHARACTER %s" % selected_character)
			return

func handle_ability_mode(num_keys:int):
	if Input.is_action_just_pressed("Ability") and mode != "ability":
		mode = "ability"
		print("SELECTING ability")
		return
	
	if Input.is_action_just_pressed("key1") and mode == "ability":
		print("SELECTED ability PRIMARY")
		selected_character.primary()
		mode = "game"
		return

	if Input.is_action_just_pressed("key2") and mode == "ability":
		print("RAN ability SECONDARY")
		selected_character.secondary()
		mode = "game"
		return

var num_lanes = 0
func _process(_delta: float):
	handle_character_mode()
	handle_ability_mode(num_lanes)

func _ready():
	num_lanes = 4
	load_character("res://gameplay/Characters/violet.tscn")
