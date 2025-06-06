extends KURO_Component

@export_group("Character HUDs")
@export var PixelsPerCharacter: float
@export var LeftSidePadding: float
@export var YPosition: float
@export var XPositionSeperation: float

func get_character(character_num):
	return $CharacterHolder.exports.get(character_num)

func load_character(scene, character_num):
	var character = scene.instantiate()
	character.position = Vector2(LeftSidePadding + character_num * (PixelsPerCharacter + XPositionSeperation), YPosition)
	character.export_name = "%d" % [character_num]
	$CharacterHolder.add_child(character)

var mode = "game"
var selected_character = null
func handle_character_mode():
	var children = $CharacterHolder.get_children()
	for i in range(len(children)):
		var key = "key%d" % i
		if Input.is_action_just_pressed("Character") and mode != "character":
			mode = "character"
			selected_character = null
			print("[CharacterManager] SELECTING character")
			return false

		if Input.is_action_just_pressed(key) and mode == "character":
			selected_character = children[i]
			print("[CharacterManager] SELECTED CHARACTER %s" % [selected_character.name])
			mode = "ability"
			return false
	
	return true

func handle_ability_mode(num_keys:int):
	if Input.is_action_just_pressed("Ability") and mode != "ability" and selected_character != null:
		mode = "ability"
		print("[CharacterManager] SELECTING ability")
	
	elif Input.is_action_just_pressed("key0") and mode == "ability" and selected_character != null:
		print("[CharacterManager] SELECTED ability PRIMARY")
		selected_character.primary()

	elif Input.is_action_just_pressed("key1") and mode == "ability" and selected_character != null:
		print("[CharacterManager] RAN ability SECONDARY 1")
		selected_character.secondaryA()

	elif Input.is_action_just_pressed("key2") and mode == "ability" and selected_character != null:
		print("[CharacterManager] RAN ability SECONDARY 2")
		selected_character.secondaryB()

	elif Input.is_action_just_pressed("key3") and mode == "ability" and selected_character != null:
		print("[CharacterManager] RAN ability SECONDARY 3")
		selected_character.secondaryC()
	else: return
	mode = "game"

var num_lanes = 0
func _process(_delta: float):
	if handle_character_mode():
		handle_ability_mode(num_lanes)

func kuro_init():
	num_lanes = 4
	#load_character("res://gameplay/Characters/violet.tscn")
