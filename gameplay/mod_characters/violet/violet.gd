extends KURO_Character

var reserve: int = 0
@export var motivation: float = 0.0
@export var default_motivation_spd: float = 0.15
@export var motivation_speed: float = default_motivation_spd
@export var life := 100.0
@export var ReadableStatus: String
@export var ReadableState: String

@export var STATE_VIOLET_EUPHORIC: float = 1.0
@export var STATE_VIOLET_DYSPHORIC: float = -1.0
@export var state = STATE_VIOLET_EUPHORIC
var note_hit_counter := 0

@export_category("Effects")
@export var positive_effect_threshold: float = 0.3
@export var negative_effect_threshold: float = -0.3
@export var multiplication: float = 0.01

signal state_change(new_state: float, old_state: float)
signal life_changed(new_life: float)
signal motivation_changed(motivation: float)

func toggle_state():
	if state == STATE_VIOLET_EUPHORIC:
		state = STATE_VIOLET_DYSPHORIC
		ReadableState = "dysphoric"
		motivation_speed = default_motivation_spd
		
	elif state == STATE_VIOLET_DYSPHORIC:
		state = STATE_VIOLET_EUPHORIC
		ReadableState = "euphoric"
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

func secondaryB():
	pass

func secondaryC():
	pass

func _process(__delta:float):
	#motivation = lerp(motivation, state, motivation_speed * __delta)
	motivation += sign(state) * motivation_speed * __delta
	if motivation < negative_effect_threshold:
		life -= abs(motivation) * multiplication
		ReadableStatus = "Draining downwards"

	elif motivation > positive_effect_threshold:
		life -= abs(motivation) * multiplication
		$Executor.apply_argument("SetMissable", "missable", true)
		$Executor.apply("SetMissable")
		ReadableStatus = "Draining upwards"
	
	else:
		ReadableStatus = "OK"
