extends KURO_Character

var reserve: int = 0
var motivation: float = 0

const STATE_VIOLET_EUPHORIC = -1.0
const STATE_VIOLET_DYSPHORIC = 1.0
var state = STATE_VIOLET_EUPHORIC

func toggle_state():
	if state == STATE_VIOLET_EUPHORIC:
		state = STATE_VIOLET_DYSPHORIC
		motivation = -0.5
		
	elif state == STATE_VIOLET_DYSPHORIC:
		state = STATE_VIOLET_EUPHORIC
		motivation = +0.5

func primary():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	toggle_state()

func secondary():
	if $AbilityStun.is_stunned(): return
	if $Secondary/Cooldown.is_stunned(): return

func _process(_delta:float):
	motivation = lerp(motivation, state, 0.01 * _delta)
	#print(motivation)

func init():
	current_scene.note_judgement.connect(_on_judgement)
	$Secondary/ExitTimer.timeout.connect(_on_secondary_end)

func _on_secondary_end():
	motivation = 0.0

func _on_judgement(score:int, note:Node, lane:Node):
	reserve += score
