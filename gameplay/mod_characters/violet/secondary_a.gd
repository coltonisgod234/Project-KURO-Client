extends KURO_Ability

var is_in_secondary := false
@export var miss_damage_modifier: float
@export var strength: float

func kuro_init():
	await Globals.wait_for_component("LaneManager")
	Globals.exports.get("LaneManager").note_judged.connect(_on_judgement)

	await Globals.exports.get("MainHUD").wait_for_component("Score")
	$ExitTimer.timeout.connect(_on_secondary_end)

func activate():
	sg.motivation = -1.0
	$ExitTimer.stun_for(3.0)
	is_in_secondary = true
	print("[Violet] Violet secA active")

func _on_secondary_end():
	sg.toggle_state()
	print("[Violet] Secondary is done!")
	$Executor.apply_argument("AddScore", "amount", (sg.note_hit_counter *
		strength *
		sg.reserve)
	)
	$Executor.apply("AddScore")

	sg.note_hit_counter = 0
	is_in_secondary = false

func _on_judgement(lane: Node2D, note: Node2D, judge:int, nonfabricated:int):
	if is_in_secondary and judge == Globals.JUDGE_HIT:
		sg.reserve += note.speed + abs(sg.motivation) * $ExitTimer.time_left
		sg.note_hit_counter += 1

	elif is_in_secondary and judge == Globals.JUDGE_MISS:
		sg.life -= note.speed * miss_damage_modifier
		print("[Violet] Bruh")
