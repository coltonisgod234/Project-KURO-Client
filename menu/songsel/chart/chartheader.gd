extends KURO_Component

@export var title: String
@export var artist: String
@export var length_sec: int
@export var charter: String
@export var BPM: int
@export var diffs: Array
#@export var diff_shadow: Node

func seconds_to_hhmmsscc(time_sec = null) -> String:
	if time_sec == null: time_sec = length_sec
	var hours = time_sec / 3600
	var minutes = (time_sec % 3600) / 60
	var seconds = time_sec % 60
	var centiseconds = int((time_sec - int(time_sec)) * 100)
	
	return "%02d:%02d:%02d.%02d" % [hours, minutes, seconds, centiseconds]
