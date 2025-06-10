extends Node

func load_map(filepath:String):
	var file = FileAccess.open(filepath, FileAccess.READ)

	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	if error != OK:
		push_error("BAD CHART JSON!! JSON READ ERROR %s @ LINE %s!!", [json.get_error_message(), json.get_error_line()])
		return ERR_PARSE_ERROR
	
	return json

func parse_chart_title(json: JSON) -> String:
	var title = json.data.get("title")
	if title is not String:
		push_error("BAD MAP JSON!! UNEXPECTED NON-STRING TYPE FOR PARAMETER title!!")
		return ""
	
	return title

func parse_chart_artist(json: JSON) -> String:
	var artist = json.data.get("artist")
	if artist is not String:
		push_error("BAD MAP JSON!! UNEXPECTED NON-STRING TYPE FOR PARAMETER artist!!")
		return ""
	
	return artist

func parse_chart_length(json: JSON) -> float:
	var length = json.data.get("length")
	if length is not String:
		push_error("BAD MAP JSON!! UNEXPECTED NON-STRING TYPE FOR PARAMETER length!!")
		return 0.0
	
	return length

func parse_chart_diffs(json: JSON, root: String) -> Array:
	var diffs = json.data.get("diffs")
	if diffs is not Array:
		push_error("BAD MAP JSON!! UNEXPECTED NON-ARRAY TYPE FOR PARAMETER length!!")
		return []
	
	var new_diffs = []
	for diff in diffs:
		new_diffs.append(root.path_join(diff))
	
	print(new_diffs)
	return new_diffs
