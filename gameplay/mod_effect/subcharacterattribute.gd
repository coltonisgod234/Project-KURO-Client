extends KURO_Effect

@export var attribute_name: String
@export var a: float
@export var b: float
@export var character_slot_num: int

func apply():
	var slot = "%d" % character_slot_num
	var mgr = await Globals.wait_for_component("CharacterManager")
	var character = mgr.exports.get(slot)
	if character == null:
		print("Character is null!")
		return

	var number = randf_range(a,b)
	var typ = Globals.get_property_type(character, attribute_name)
	var value_coerced = Globals.coerce_value_to_type(number, typ)
	character.set(attribute_name, character.get(attribute_name) - value_coerced)
	
	print("%s %s %s %s %s %s" % [slot, mgr, character, number, typ, value_coerced])
