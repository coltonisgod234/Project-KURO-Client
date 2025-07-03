extends KURO_Effect

@export var StopTimer: Timer
@export var Executor: KURO_EffectExecutor
@export var corruption_increase: float
@export var stun_time: float

func kuro_init():
	var lanemgr = Globals.s_wait_for_component("LaneManager")
	lanemgr.note_judged.connect(_on_note_judged)

func activate():
	StopTimer.stun_for(stun_time)
	await StopTimer.timeout
	print("\n\n\n\n\nTIMEOUT")
	Executor.apply("ResetMissable")
	return

func _process(_delta):
	Executor.apply("SetMissable")

func _on_note_judged(lane: Node2D, note: Node2D, real_judge, nonfabricated_judge):
	print("note judged yay")
	if nonfabricated_judge == Globals.JUDGE_MISS and real_judge == Globals.JUDGE_HIT:
		if (sg.corruption + corruption_increase) <= sg.max_corruption:
			sg.corruption += corruption_increase
