extends Node2D

var NoteScene = preload("res://gameplay/note.tscn")
signal beatcounter_too_large(lane_node: Node)

var timings: Array
var current_beat: int = 0
var lane_num: int

@export var pixels_per_lane:int = self.scale.y
@export var forgiveness:int = 0
@export var hit_window:int = 70

var sec_since_start: float = 1.0
var last_update_time: int = 0  # in microseconds

func _ready():
	print("Lane ready %s" % lane_num)

var should_count_sec: bool = true
func update_sec_since_map_start():
	var now = Time.get_ticks_usec()
	var elapsed_usec = now - last_update_time
	last_update_time = now
	sec_since_start += float(elapsed_usec) / 1_000_000.0  # convert to seconds

var should_do_spawns: bool = true
func do_spawns():
	if current_beat == len(timings):
		#print("Not spawning because the number got to big!!")
		beatcounter_too_large.emit(self)
		return

	var this_ittr = timings[current_beat]
	var time = this_ittr["time"]
	var spd = this_ittr["speed"]
	if time < sec_since_start:
		print("%s LANE SPAWNING AND BEAT IS NOW %s" % [lane_num, current_beat])
		spawn_note(spd)
		current_beat += 1

func _process(delta:float):
	if should_count_sec: update_sec_since_map_start()
	if should_do_spawns: do_spawns()
	for child in $NoteContainer.get_children():
		$Key.eval_note(child, lane_num)

func spawn_note(speed: float):
	var note_instance = NoteScene.instantiate()
	note_instance.position = Vector2(0, 700)
	note_instance.speed = speed
	$NoteContainer.add_child(note_instance)
