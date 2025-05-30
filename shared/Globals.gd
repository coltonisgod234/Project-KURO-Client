extends KURO_Component

enum { JUDGE_HIT, JUDGE_MISS }

func coerce_value_to_type(value, target_type: int) -> Variant:
	var input_type := typeof(value)

	if input_type == target_type:
		return value  # No conversion needed

	match target_type:
		TYPE_INT:
			if input_type in [TYPE_FLOAT, TYPE_STRING, TYPE_BOOL]:
				return int(value)
		TYPE_FLOAT:
			if input_type in [TYPE_INT, TYPE_STRING, TYPE_BOOL]:
				return float(value)
		TYPE_STRING:
			return str(value)
		TYPE_BOOL:
			if input_type in [TYPE_INT, TYPE_FLOAT, TYPE_STRING]:
				return bool(value)
		_:
			return value  # Fallback to original

	return value

func get_property_type(obj: Object, property_name: String) -> int:
	for prop in obj.get_property_list():
		if prop.name == property_name:
			return prop.type
	return TYPE_NIL  # Return NIL if property not found
