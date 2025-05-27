extends KURO_Character

var reserve: int = 0
var motivation: float = 0.0
var motivation_speed: float = 0.1

const STATE_VIOLET_EUPHORIC = -1.0
const STATE_VIOLET_DYSPHORIC = 1.0
var state = STATE_VIOLET_EUPHORIC
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
	print("[Violet] Violet pri nostun, contin.")
	toggle_state()

func secondaryA():
	print("[Violet] Violet secA executed")
	if $AbilityStun.is_stunned(): return
	if $SecondaryA/Cooldown.is_stunned(): return
	print("[Violet] Violet secA nostun, contin.")
	$SecondaryA.activate()

func secondaryB():
	if $AbilityStun.is_stunned(): return
	if $SecondaryA/Cooldown.is_stunned(): return

func secondaryC():
	if $AbilityStun.is_stunned(): return
	if $SecondaryA/Cooldown.is_stunned(): return

func _process(_delta:float):
	motivation = lerp(motivation, state, motivation_speed * _delta)
	#print(motivation)

func kuro_init():
	print("[Violet] me waiting for bro")
	print("[Violet] in the thing")
	
