extends Node2D

var num_keys: int = 0
var LaneScene = preload("res://gameplay/lane.tscn")
signal map_fully_ended

@export var pixels_per_lane: int = 48

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
	
	for i in range(num_keys):
		lanes.append(
			json.data["lanes"][i]["notes"]
		)
	
	return lanes

func start_song(songfile):
	if songfile is not String:
		push_error("BAD PARAMETER!! UNEXPECTED NON-STRING TYPE FOR PARAMETER AUDIOFILE!!")
		return ERR_INVALID_DATA

	var file = FileAccess.open(songfile, FileAccess.READ)
	if not file:
		push_error("Can't open file: %s" % songfile)
		return ERR_INVALID_DATA
		
	var stream = AudioStreamOggVorbis.load_from_file(songfile)
	if stream is not AudioStream:
		push_error("BAD MAP SONGFILE!! %s IS NOT OF TYPE AUDIOSTREAM!!" % [songfile])
		return ERR_INVALID_DATA
	
	print("Loaded song %s" % songfile)
	$SongPlayer.stream = stream
	$SongPlayer.play()

func stop_song():
	$SongPlayer.stop()
	$SongPlayer.stream = null

func _ready():
	var map = load_map("res://testdata/testmap.json")
	num_keys = parse_map_num_lanes(map)  # MUST BE PARSED FIRST
	var map_lanes = parse_map_notes(map)
	var map_songfile = parse_map_songfile(map)
	start_song(map_songfile)
	for i in range(num_keys):
		var lane = LaneScene.instantiate()
		lane.timings = map_lanes[i]
		lane.lane_num = i
		lane.position = Vector2(pixels_per_lane + i * pixels_per_lane, 35)
		lane.note_miss.connect(_on_note_miss)
		lane.note_hit.connect(_on_note_hit)
		lane.note_destroyed.connect(_on_note_destroyed)
		lane.beatcounter_too_large.connect(_on_beatcounter_too_large)
		self.add_child(lane)

func _on_note_destroyed(lane, note):
	print("note destoyed apparently ok cool")
	pass

func _on_note_miss(lane, note):
	print("YOU DOIN BAD")
	$HUD/ScoreCounter.add_score(-note.speed)
	$HUD/ComboCounter.set_combo(0)

func _on_note_hit(lane, note):
	print("YOU DO GOOD")
	$HUD/ScoreCounter.add_score(+note.speed)
	$HUD/ComboCounter.add_combo(+1)

func _on_beatcounter_too_large(lane):
	print("THE BEATCOUNTER IS TOO LARGE")
	lane.should_do_spawns = false
