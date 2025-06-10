extends Node2D

var NoteScene = Scenes.Note
signal beatcounter_too_large(lane_node: Node)

var timings: Array
var current_beat: int = 0
var lane_num: int = 0

@export var pixels_per_lane:float = self.scale.y
@export var forgiveness:int = 0
@export var hit_window:int = 70

var sec_since_start: float = 1.0
var last_update_time: int = 0  # in microseconds

func get_current_beat():
	if current_beat == len(timings):
		#print("Not spawning because the number got to big!!")
		beatcounter_too_large.emit(self)
		return

	return timings[current_beat]

func fabricate_handle(judge_type, note=null):
	if note == null:
		note = get_current_beat()

	match judge_type:
		Globals.JUDGE_HIT:
			$Key.hit(note, lane_num)
		Globals.JUDGE_MISS:
			$Key.miss(note, lane_num)

func _ready():
	print("[Lane%d] ready!" % lane_num)

var should_count_sec: bool = true
func update_sec_since_map_start():
	var now = Time.get_ticks_usec()
	var elapsed_usec = now - last_update_time
	last_update_time = now
	sec_since_start += float(elapsed_usec) / 1_000_000.0  # convert to seconds

var should_do_spawns: bool = true
func do_spawns():
	var this_ittr = get_current_beat()
	if this_ittr == null: return

	var time = this_ittr["time"]
	var spd = this_ittr["speed"]
	if time <= sec_since_start:
		print("[Lane%s] Spawning, beat_counter is now %s" % [lane_num, current_beat])
		spawn_note(spd, time)
		current_beat += 1

func _process(__delta:float):
	update_sec_since_map_start()
	do_spawns()
	for child in $NoteContainer.get_children():
		#print("Eval note on %s" % child)
		$Key.eval_note(child, lane_num)

func spawn_note(speed: float, time: float):
	var note_instance = NoteScene.instantiate()
	note_instance.position = Vector2(0, 700)
	note_instance.speed = speed
	note_instance.time = time
	$NoteContainer.add_child(note_instance)
