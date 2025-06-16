extends Node2D

var NoteScene = Scenes.Note
signal beatcounter_too_large(lane_node: Node)

var timings: Array
var current_beat: int = 0
var lane_num: int = 0

@export var spawn_at_y: float

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

var should_do_spawns: bool = true
func do_spawns():
	var this_ittr = get_current_beat()
	if this_ittr == null: return

	var time = this_ittr["time"] / 1_000_000.0  # Seconds are a dumb unit
	var spd = this_ittr["speed"]
	var travel_time = (600 - 70) / spd  # Distance over speed
	var spawn_time = time - travel_time
	#print("[Lane%d] it works so good man %f" % [lane_num, spawn_time])
	if spawn_time <= Globals.get_global_timer() / 1_000_000.0:  # Dumb BS
		print("[Lane%s] Spawning, beat_counter is now %s" % [lane_num, current_beat])
		spawn_note(spd)
		current_beat += 1

func _process(_delta:float):
	do_spawns()
	for child in $NoteContainer.get_children():
		#print("Eval note on %s" % child)
		$Key.eval_note(child, lane_num)

func spawn_note(speed: float):
	var note_instance = NoteScene.instantiate()
	note_instance.position = Vector2(0, spawn_at_y)
	note_instance.speed = speed
	note_instance.set_meta("key_been_inside", false)
	$NoteContainer.add_child(note_instance)
