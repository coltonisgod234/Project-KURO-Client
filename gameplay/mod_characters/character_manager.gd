extends KURO_Component

func load_character(scene, character_num):
	var character = scene.instantiate()
	character.position = Vector2(80 + character_num * 200, 0)
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
			print("[CharacterManager] SELECTING character")
			return

		if Input.is_action_just_pressed(key) and mode == "character":
			selected_character = children[i]
			print("[CharacterManager] SELECTED CHARACTER %s" % selected_character)
			return

func handle_ability_mode(num_keys:int):
	if Input.is_action_just_pressed("Ability") and mode != "ability" and selected_character != null:
		mode = "ability"
		print("[CharacterManager] SELECTING ability")
		return
	
	if Input.is_action_just_pressed("key0") and mode == "ability" and selected_character != null:
		print("[CharacterManager] SELECTED ability PRIMARY")
		selected_character.primary()
		mode = "game"
		return

	if Input.is_action_just_pressed("key1") and mode == "ability" and selected_character != null:
		print("[CharacterManager] RAN ability SECONDARY 1")
		selected_character.secondaryA()
		mode = "game"
		return

	if Input.is_action_just_pressed("key2") and mode == "ability" and selected_character != null:
		print("[CharacterManager] RAN ability SECONDARY 2")
		selected_character.secondaryB()
		mode = "game"
		return

	if Input.is_action_just_pressed("key1") and mode == "ability" and selected_character != null:
		print("[CharacterManager] RAN ability SECONDARY 3")
		selected_character.secondaryC()
		mode = "game"
		return

var num_lanes = 0
func _process(_delta: float):
	handle_character_mode()
	handle_ability_mode(num_lanes)

func kuro_init():
	num_lanes = 4
	#load_character("res://gameplay/Characters/violet.tscn")
