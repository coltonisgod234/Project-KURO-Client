extends KURO_Component

@export var target_name: String
var target = null

@export var error_text := "????"

func profiled():
	if target == null: return error_text
	if not target.has_meta("profile_start"): return error_text
	var elapsed = Time.get_ticks_usec() - target.get_meta("profile_start")
	return elapsed

func percent():
	var elapsed = profiled()
	if elapsed is not int:
		return error_text

	var full = Performance.get_monitor(Performance.TIME_PROCESS)
	return 1 / (full - elapsed)

func _process(_delta):
	if target == null:
		if get_tree().current_scene.has_node(target_name):
			target = get_tree().current_scene.get_node(target_name)

		return

	target.set_meta("profile_start", Time.get_ticks_usec())
	#print(percent())
