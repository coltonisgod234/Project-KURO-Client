extends KURO_Ability

@export var range_a: float
@export var range_b: float
@export var cooldown: float

func kuro_init():
	await Globals.wait_for_component("LaneManager")

func activate():
	print("Doing the active")
	for lane in Globals.exports.get("LaneManager").get_children():
		for beat in lane.get_node("NoteContainer").get_children():
			var time = beat.time
			print("Checking %s %s (@ %s)" % [lane.name, beat.name, time])
			if (
				abs(time - lane.sec_since_start) >= range_a and
				abs(time - lane.sec_since_start) < range_b
			):
				print("This one is good")
				lane.fabricate_handle(Globals.JUDGE_HIT, beat)

	$Cooldown.stun_for(cooldown)
