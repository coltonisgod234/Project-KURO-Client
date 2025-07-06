extends KURO_Component
#extends Control

@export var score: Node
@export var miss: Node
@export var hit: Node
@export var combo: Node

var lane_manager = null
func kuro_init():
	lane_manager = Globals.s_wait_for_component("LaneManager")
	lane_manager.note_judged.connect(_on_note_judged)
	#init_ComboCounter()
	#init_ScoreCounter()
	return

func _on_hit(lane, note):
	combo.add_count(+1)
	hit.add_count(1)
	score.add_count(note.speed / 1.5)

func _on_miss(lane, note):
	score.set_count(0)
	miss.add_count(1)
	combo.sub_count_positive_only(1.5 / note.speed)

func _on_note_judged(lane: Node2D, note: Node2D, judge: int, nonfacbricated: int):
	match judge:
		Globals.JUDGE_MISS:
			_on_miss(lane, note)
		Globals.JUDGE_HIT:
			_on_hit(lane, note)
		_:
			Globals.crash("HUD: unknown judgement")
