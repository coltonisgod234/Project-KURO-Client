extends KURO_Effect

func apply():
	var hud = await Globals.wait_for_component("MainHUD")
	var combo = await hud.wait_for_component("Combo")

	combo.set_count(0)
