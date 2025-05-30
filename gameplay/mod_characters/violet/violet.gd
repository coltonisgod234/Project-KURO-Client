extends KURO_Character

var reserve: int = 0
var motivation: float = 0.0
@export var default_motivation_spd: float = 0.15
var motivation_speed: float = default_motivation_spd
var life := 100.0

@export var STATE_VIOLET_EUPHORIC: float = 1.0
@export var STATE_VIOLET_DYSPHORIC: float = -1.0
var state = STATE_VIOLET_EUPHORIC
var note_hit_counter := 0

@export_category("Effects")
@export var positive_effect_threshold: float = 0.3
@export var negative_effect_threshold: float = -0.3
@export var multiplication: float = 0.01

func kuro_init():
	await Globals.wait_for_component("LaneManager")

func toggle_state():
	if state == STATE_VIOLET_EUPHORIC:
		state = STATE_VIOLET_DYSPHORIC
		motivation_speed = default_motivation_spd
		
	elif state == STATE_VIOLET_DYSPHORIC:
		state = STATE_VIOLET_EUPHORIC
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
	if motivation < negative_effect_threshold:
		life -= abs(motivation) * multiplication

	if motivation > positive_effect_threshold:
		Globals.exports.get("LaneManager").allow_miss = false
		life -= abs(motivation) * multiplication
	else:
		Globals.exports.get("LaneManager").allow_miss = true
	#print(motivation)
