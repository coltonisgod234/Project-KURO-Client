extends KURO_Component
#extends Control

var lane_manager = null
func kuro_init():
	await Globals.wait_for_component("LaneManager")
	Globals.exports["LaneManager"].note_judged.connect(_on_note_judged)
	#init_ComboCounter()
	#init_ScoreCounter()
	return

func _on_hit(lane, note):
	$ComboCounter.add_count(+1)
	$ScoreCounter.add_count(note.speed / 1.5)

func _on_miss(lane, note):
	$ComboCounter.set_count(0)
	$ScoreCounter.sub_count_positive_only(1.5 / note.speed)

func _on_note_judged(lane: Node2D, note: Node2D, judge: int, nonfacbricated: int):
	match judge:
		Globals.JUDGE_MISS:
			_on_miss(lane, note)
		
		Globals.JUDGE_HIT:
			_on_hit(lane, note)
