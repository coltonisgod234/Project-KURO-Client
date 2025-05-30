extends KURO_Ability

func activate():
	var abilitiy = randi_range(0,1)
	match abilitiy:
		0:
			sg.secondaryA(true, true)
		1:
			sg.secondaryB(true, true)
