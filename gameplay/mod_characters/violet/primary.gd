extends KURO_Ability

func activate():
	print("[Violet] (primary.gd) Executed")
	sg.toggle_state()
	print("Thingy should be the wait now")
	$Cooldown.stun_for(1.0)
