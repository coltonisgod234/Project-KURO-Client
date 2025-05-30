extends KURO_Effect

@export var attribute_name: String
@export var a: float
@export var b: float
@export var character_slot_num: int

func get_exported_properties(obj: Object) -> Array:
	var exports = []
	for prop in obj.get_script().get_property_list():
		if (prop.usage & PROPERTY_USAGE_EDITOR) != 0:
			exports.append(prop.name)
		print(exports)
	return exports

func apply():
	var slot = "%d" % character_slot_num
	var mgr = await Globals.wait_for_component("CharacterManager")
	var character = mgr.get_character(slot)
	if character == null:
		print("Character is null!")
		return
	
	if attribute_name == "":
		attribute_name = get_exported_properties(character).pick_random()
		print(attribute_name)

	var number = randf_range(a,b)
	var typ = Globals.get_property_type(character, attribute_name)
	var value_coerced = Globals.coerce_value_to_type(number, typ)
	
	var old_value = character.get(attribute_name)
	if old_value is not float or old_value is not int:
		print("Value is not float or str")
		return

	character.set(attribute_name, old_value + value_coerced)
	
	print("%s %s %s %s %s %s" % [slot, mgr, character, number, typ, value_coerced])
