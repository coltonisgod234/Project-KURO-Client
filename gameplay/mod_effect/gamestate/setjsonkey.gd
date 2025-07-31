extends KURO_Effect

@export var key: String
@export var value_str: String
@export var data: Dictionary

func apply():
	set_val(value_str)

func set_val(value):
	data.set(key, value)
	print(data)
