extends Node

func load_map(filepath:String):
	var file = FileAccess.open(filepath, FileAccess.READ)
	if file == null:
		push_error("BAD FILEPATH!! CANNOT ACCESS FILE %s, GOT NULL!!" % [filepath])
		return

	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	if error != OK:
		push_error("BAD MAP JSON!! JSON READ ERROR %s @ LINE %s!!" % [json.get_error_message(), json.get_error_line()])
		return ERR_PARSE_ERROR
	
	return json

func parse_map_length_usec(json):
	var map_length_usec = int(json.data.get("length"))
	print("[MapParser] map_length_usec is %s" % map_length_usec)
	if map_length_usec is not int:
		push_error("BAD MAP JSON!! UNEXPECTED NON-INT TYPE FOR PARAMETER LENGTH!!")
		return ERR_INVALID_DATA
	
	return map_length_usec

func parse_map_diffname(json):
	var map_diffname = json.data.get("difficulty_name")
	if map_diffname is not String:
		push_error("BAD MAP JSON!! UNEXPECTED NON-STRING TYPE FOR PARAMETER DIFFICULTY_NAME!!")
		return ERR_INVALID_DATA
	
	return map_diffname

func parse_map_songfile(json, root: String):
	var map_songfile = json.data.get("audio")
	map_songfile = root.path_join(map_songfile)  # Hack
	if map_songfile is not String:
		push_error("BAD MAP JSON!! UNEXPECTED NON-STRING TYPE FOR PARAMETER AUDIO!!")
		return ERR_INVALID_DATA
	
	return map_songfile

func parse_map_num_lanes(json):
	if json.data.get("lanes") is not Array:
		push_error("BAD MAP JSON!! UNEXPECTED NON-ARRAY TYPE FOR PARAMETER LANES!!")
		return ERR_INVALID_DATA

	var map_lanecount = len(json.data.get("lanes"))
	return map_lanecount

func parse_map_notes(json):
	var lanes = []
	
	for i in range(len(json.data.get("lanes"))):
		lanes.append(
			json.data["lanes"][i]["notes"]
		)
	
	return lanes
