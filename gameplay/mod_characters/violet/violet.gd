extends KURO_Character

var reserve: int = 0
var motivation: float = 1.0
var default_motivation_spd: float = 0.05
var motivation_speed: float = default_motivation_spd
var life := 100.0

const STATE_VIOLET_EUPHORIC = 1.0
const STATE_VIOLET_DYSPHORIC = -1.0
var state = STATE_VIOLET_EUPHORIC
var note_hit_counter := 0

func toggle_state():
	if state == STATE_VIOLET_EUPHORIC:
		state = STATE_VIOLET_DYSPHORIC
		motivation = 0.0
		motivation_speed = default_motivation_spd
		
	elif state == STATE_VIOLET_DYSPHORIC:
		state = STATE_VIOLET_EUPHORIC
		motivation = 0.0
		motivation_speed = default_motivation_spd

func primary():
	if life <= 0: return
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	$Primary.activate()

func secondaryA():
	if life <= 0: return
	if $AbilityStun.is_stunned(): return
	if $SecondaryA/ExitTimer.is_stunned(): return
	$SecondaryA.activate()

func _process(_delta:float):
	motivation = lerp(motivation, state, motivation_speed * _delta)
	#print(motivation)

func kuro_init():
	print("[Violet] me waiting for bro")
	print("[Violet] in the thing")
	
