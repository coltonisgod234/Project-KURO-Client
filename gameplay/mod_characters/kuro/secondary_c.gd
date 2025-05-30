extends KURO_Ability

func kuro_init():
	print("Secondary C ready")

func activate():
	var children := $Executor.get_children()
	var effect = children.pick_random()
	var character = randi_range(1,2)
	$Executor.apply_argument(effect.name, "character_slot_num", character)
	$Executor.apply_effect(effect.name)
