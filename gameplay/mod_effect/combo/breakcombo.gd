extends KURO_Effect

func apply():
	var hud = Globals.s_wait_for_component("MainHUD")
	var combo = hud.s_wait_for_component("Combo")

	combo.set_count(0)
