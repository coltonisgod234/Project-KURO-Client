extends KURO_Component

func load_map(filepath:String):
	var file = FileAccess.open(filepath, FileAccess.READ)

	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	if error != OK:
		push_error("BAD MAP JSON!! JSON READ ERROR %s @ LINE %s!!", [json.get_error_message(), json.get_error_line()])
		return ERR_PARSE_ERROR
	
	return json

func parse_map_songfile(json):
	var map_songfile = json.data["audio"]
	if map_songfile is not String:
		push_error("BAD MAP JSON!! UNEXPECTED NON-STRING TYPE FOR PARAMETER AUDIOFILE!!")
		return ERR_INVALID_DATA
	
	return map_songfile

func parse_map_num_lanes(json):
	if json.data["lanes"] is not Array:
		push_error("BAD MAP JSON!! UNEXPECTED NON-ARRAY TYPE FOR PARAMETER LANES!!")
		return ERR_INVALID_DATA

	var map_lanecount = len(json.data["lanes"])
	return map_lanecount

func parse_map_notes(json):
	var lanes = []
	
	for i in range(len(json.data["lanes"])):
		lanes.append(
			json.data["lanes"][i]["notes"]
		)
	
	return lanes
