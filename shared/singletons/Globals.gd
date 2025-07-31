extends KURO_Component

enum { JUDGE_HIT, JUDGE_MISS }
func kuro_init():
	start_global_timer()

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

func set_all_process(node: Node, val: bool, recurs: bool):
	node.set_process(val)
	node.set_physics_process(val)
	node.set_process_input(val)
	node.set_process_unhandled_input(val)
	node.set_process_unhandled_key_input(val)
	
	if not recurs: return
	for child in node.get_children():
		if child is Node:
			self.set_all_process(child, val, recurs)

func get_property_type(obj: Object, property_name: String) -> int:
	for prop in obj.get_property_list():
		if prop.name == property_name:
			return prop.type
	return TYPE_NIL  # Return NIL if property not found

var _offset : int = 0  # microseconds
var _started : bool = false
func start_global_timer():
	_offset = Time.get_ticks_usec()
	_started = true

func reset_global_timer():
	start_global_timer()

func get_global_timer() -> int:
	if not _started:
		return 0
	return Time.get_ticks_usec() - _offset

func _crash(msg: String):
	var popup = preload("res://shared/crash.tscn").instantiate()
	var dia = popup.get_node("CrashDialouge")

	var diamsg = dia.get_node("msg")
	var text = diamsg.rich_text
	text = text.replace("{CrashMessageGoesHere}", msg)
	diamsg.rich_text = text

	add_child(popup)
	diamsg.apply()
	await popup.close_requested
	OS.crash(msg)

func crash(msg: String):
	print("CRASH: %s" % msg)
	push_error("Crash = %s" % msg)
	await get_tree().create_timer(0.1, true, false, true).timeout  # wait a little bit for error to push to con
	OS.crash(msg)
