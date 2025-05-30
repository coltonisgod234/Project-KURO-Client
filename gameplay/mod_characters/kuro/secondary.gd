extends KURO_Ability

func activate():
	print("doing the thing")
	var children := $Executor.get_children()
	children.pick_random().apply()
