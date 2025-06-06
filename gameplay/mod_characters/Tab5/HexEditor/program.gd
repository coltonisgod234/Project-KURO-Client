extends KURO_Ability

@export var character_slot_number: Node
var props
var attributes: Array
var selected_attribute: int

func reset_state():
	print("[Tab5] [HexEditor] Reset state")
	self.set_process(false)
	props = $Executor.apply("GetAttributes")
	print(props)
	$StopTimer.stop()

func kuro_init():
	reset_state()
	$StopTimer.timeout.connect(_on_timer_stop)

func activate():
	reset_state()
	$StopTimer.stun_for(10.0)

func _on_timer_stop():
	reset_state()

func change(eff: String):
	var prop = props[selected_attribute]
	var propname = prop.get("name")
	$Executor.apply_argument(eff, "attribute", propname)
	$Executor.apply(eff)

func _process(delta):
	if Input.is_action_just_pressed("key0"):  # D
		selected_attribute -= 1
	if Input.is_action_just_pressed("key1"):  # F
		selected_attribute += 1
	
	if Input.is_action_just_pressed("key2"):  # J
		change("Add")
	
	if Input.is_action_just_pressed("key3"):  # K
		change("Sub")

	#print(selected_attribute, attributes)
