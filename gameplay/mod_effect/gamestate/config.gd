extends Control

#@export var json: JSON
@export var config_path = "user://config.json"
var json

func load_file():
	var file_content = FileAccess.get_file_as_string(config_path)
	json = JSON.new()
	json.parse_string(file_content)

func write_file():
	var file = FileAccess.open(config_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(json.data))
	file.close()
