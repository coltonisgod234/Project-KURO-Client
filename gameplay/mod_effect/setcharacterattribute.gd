extends KURO_Effect

@export var attribute_name: String
@export var n: int
@export var character_slot_num: int

func apply():
	var slot = "%d" % character_slot_num
	var mgr = await Globals.wait_for_component("CharacterManager")
	var character = mgr.exports.get(slot)

	character.set(attribute_name, n)
