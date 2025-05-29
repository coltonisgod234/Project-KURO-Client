extends KURO_Ability

var is_in_secondary := false

func kuro_init():
	await Globals.wait_for_component("LaneManager")
	await Globals.exports["MainHUD"].wait_for_component("Score")
	Globals.exports["LaneManager"].note_judged.connect(_on_judgement)
	$ExitTimer.timeout.connect(_on_secondary_end)

func activate():
	sg.motivation = -1.0
	$ExitTimer.stun_for(3.0)
	is_in_secondary = true
	print("(Violet) Violet secA active")

func _on_secondary_end():
	sg.toggle_state()
	Globals.exports["MainHUD"].exports["Score"].add_count(
		sg.note_hit_counter *
		abs(sg.motivation) *
		sg.reserve)

	sg.note_hit_counter = 0
	$ExitTimer.stop()
	is_in_secondary = false

func _on_judgement(lane: Node2D, note: Node2D, judge:int, nonfabricated:int):
	if is_in_secondary and judge == Globals.JUDGE_HIT:
		sg.reserve += note.speed - abs(sg.motivation) * $ExitTimer.time_left
		sg.note_hit_counter += 1
	elif is_in_secondary and judge == Globals.JUDGE_MISS:
		sg.life -= clamp(note.speed * 0.1, 20.0, 100.0)
