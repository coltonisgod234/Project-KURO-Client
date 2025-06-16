extends KURO_Component

#func _init():
#	for character in Scenes.CharacterList.keys():
#		self.add_item(character)

signal character_changed(new_character)

@export var selector_x_pos_offset: int
@export var force_y_pos_zero: bool
@export var selected_character: Dictionary

func set_selected_character_to_object(node):
	var character = {
		"character_name": node.character_name,
	}
	update_character_information(character)

func update_character_information(character):
	if character == null:
		print("fuck off")
		return
	self.selected_character = character
	self.text = character.get("character_name", "ERROR")
	character_changed.emit(character)

func _on_pressed() -> void:
	var dropdown = Scenes.TeamBuildSelectCharacterDropdown.instantiate()
	dropdown.position.x += selector_x_pos_offset
	if force_y_pos_zero:
		dropdown.position.y = 0

	self.add_child(dropdown)
	self.set_selected_character_to_object(await dropdown.apply())
	dropdown.queue_free()
