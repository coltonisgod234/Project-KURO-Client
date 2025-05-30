extends KURO_Ability

func activate():
	print("[Violet] (primary.gd) Executed")
	sg.toggle_state()
	$Cooldown.stun_for(1.0)
