extends KURO_Component
#extends Node2D

signal note_judged(lane: Node2D, note: Node2D, real_judge, nonfabricated_judge)

var allow_miss := true

func kuro_init():
	print("[LaneManager] Lane Manager ready")

#func kuro_initalize():
#	print("[LaneManager] Lane Manager ready")

func spawn_lane(i, map_lanes, pixels_per_lane):
	print("[LaneManager] Initalizing Lane #%d" % i)
	var lane = Scenes.Lane.instantiate()
	lane.timings = map_lanes[i]
	lane.lane_num = i
	lane.position = Vector2(pixels_per_lane + i * pixels_per_lane, 35)
	lane.get_node("Key").note_miss.connect(_on_note_miss)
	lane.get_node("Key").note_hit.connect(_on_note_hit)
	lane.set_process(true)
	#lane.note_destroyed.connect(_on_note_destroyed)
	self.add_child(lane)

func _on_note_miss(lane, note):
	print("[LaneManager] miss")
	if not allow_miss:
		print("[LaneManager] missed, but fabricated a hit anyway")
		note_judged.emit(lane, note, Globals.JUDGE_HIT, Globals.JUDGE_MISS)
		return

	note_judged.emit(lane, note, Globals.JUDGE_MISS, Globals.JUDGE_MISS)

func _on_note_hit(lane, note):
	print("[LaneManager] hit")
	note_judged.emit(lane, note, Globals.JUDGE_HIT, Globals.JUDGE_HIT)
