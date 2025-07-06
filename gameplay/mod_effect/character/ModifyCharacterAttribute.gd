extends KURO_Effect

@export var amount: int = 0
@export var amount_range_high: int = 0
@export var character_slot_number: int = 0
@export var attribute: String
enum Operations {
	ADD,
	SUBTRACT,
	MULTIPLY,
	DIVIDE
}
@export var operation: Operations

func apply():
	var charmgr = Globals.s_wait_for_component("CharacterManager")
	var character = charmgr.s_wait_for_component("%d" % character_slot_number)
	
	var a: int = amount
	if amount_range_high != 0:
		a = randi_range(amount, amount_range_high)

	var data = character.get(attribute)

	match operation:
		Operations.ADD:
			character.set(attribute, data + a)
		Operations.SUBTRACT:
			character.set(attribute, data - a)
		Operations.MULTIPLY:
			character.set(attribute, data * a)
		Operations.DIVIDE:
			character.set(attribute, data / a)
		_:
			Globals.crash("ModifyCharacterAttribute: unknown operation")
