extends KURO_Component

var selection: Dictionary

func set_selection(s: Dictionary):
	selection = s
	for i in range(len(self.get_children())):
		var child = self.get_child(i)
		var thing = selection.get(&"%s" % [i])  # Disgusting hack. It isn't pretty but it works.
		child.update_character_information(thing)
		print("%s | %s | %s | %s" % [i, child, thing, selection])

func kuro_init():
	for child in self.get_children():
		child.character_changed.connect(_on_character_changed.bind(child))

func _on_character_changed(character_dict, slot):
	selection.set(slot.name, character_dict)
	print(selection)
