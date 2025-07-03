extends KURO_Component

@export var recover_amount: float

func kuro_init():
	var lanemgr = Globals.s_wait_for_component("LaneManager")
	lanemgr.note_judged.connect(note_judged)

func note_judged(lane: Node2D, note: Node2D, real_judge, nonfabricated_judge):
	print("NOTE HAS BEEN JUDGED %s (reall y %s)" % [real_judge, nonfabricated_judge])
	if nonfabricated_judge == Globals.JUDGE_HIT:
		if sg.corruption >= 0.0:
			sg.corruption -= recover_amount
