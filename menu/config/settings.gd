extends KURO_Effect

@export var DoneButton: Button
var data: Dictionary[String, Dictionary]

func apply():
	await DoneButton.pressed

func set_segment(key: String, segment: Dictionary):
	data.set(key, segment)

## asserts data.get(segment) is not null
func set_value(segment: String, key: String, value: Dictionary, default = null):
	if default == null: default = {}
	data.get_or_add(segment, default).set(key, value)

func apply_settings():
	ConfigManager.reload(data)

func save_settings():
	var stringified_data = JSON.stringify(data)
	var file = FileAccess.open("user://config.json", FileAccess.ModeFlags.WRITE)
	file.store_string(stringified_data)
	file.close()
