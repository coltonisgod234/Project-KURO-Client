extends KURO_Character

var reserve: int = 0
var motivation: float = 0.0
var motivation_speed: float = 0.1

const STATE_VIOLET_EUPHORIC = -1.0
const STATE_VIOLET_DYSPHORIC = 1.0
var state = STATE_VIOLET_EUPHORIC
var is_in_secondary := false
var note_hit_counter := 0

func toggle_state():
	if state == STATE_VIOLET_EUPHORIC:
		state = STATE_VIOLET_DYSPHORIC
		motivation = -0.5
		motivation_speed = 0.01
		
	elif state == STATE_VIOLET_DYSPHORIC:
		state = STATE_VIOLET_EUPHORIC
		motivation = +0.5
		motivation_speed = 0.01

func primary():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	toggle_state()

func secondaryA():
	print("[Violet] Violet secA executed")
	if $AbilityStun.is_stunned(): return
	if $Secondary/Cooldown.is_stunned(): return
	
	print("[Violet] Violet secA nostun, contin.")
	motivation = -1.0
	$Secondary/ExitTimer.stun_for(3.0)
	is_in_secondary = true
	print("[Violet] Violet secA active")

func secondaryB():
	if $AbilityStun.is_stunned(): return
	if $Secondary/Cooldown.is_stunned(): return

func secondaryC():
	if $AbilityStun.is_stunned(): return
	if $Secondary/Cooldown.is_stunned(): return

func _process(_delta:float):
	motivation = lerp(motivation, state, motivation_speed * _delta)
	#print(motivation)

func _ready():
	lane_manager.note_judged.connect(_on_judgement)
	$Secondary/ExitTimer.timeout.connect(_on_secondary_end)

func _on_secondary_end():
	toggle_state()
	is_in_secondary = false
	Globals.Score.add_count((note_hit_counter * motivation) * reserve)
	note_hit_counter = 0

func _on_judgement(lane: Node2D, note: Node2D, judge:int, nonfabricated:int):
	if is_in_secondary:
		reserve += note.speed
		note_hit_counter += 1
