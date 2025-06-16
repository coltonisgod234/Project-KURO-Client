extends KURO_Effect

@export var range_a: float
@export var range_b: float
@export var extra_score: float
@export var judge: int

var mainhud
var score
var lanemanager
func kuro_init():
	lanemanager = Globals.s_wait_for_component("LaneManager")
	mainhud = Globals.s_wait_for_component("MainHUD")
	score = mainhud.s_wait_for_component("Score")

func apply():
	for lane in lanemanager.get_children():
		for beat in lane.get_node("NoteContainer").get_children():
			var time = beat.time
			print("[hit_within_range] Checking %s %s (@ %s)" % [lane.name, beat.name, time])
			if (
				abs(time - lane.sec_since_start) >= range_a and
				abs(time - lane.sec_since_start) < range_b
			):
				lane.fabricate_handle(judge, beat)
				score.add_count(extra_score)
