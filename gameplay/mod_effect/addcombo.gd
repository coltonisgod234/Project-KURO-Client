extends KURO_Effect

@export var amount: int = 0
@export var amount_range_high: int = 0

func apply():
	var hud = await Globals.wait_for_component("MainHUD")
	var combo = await hud.wait_for_component("Combo")
	
	var a: int = amount
	if amount_range_high != 0:
		a = randi_range(amount, amount_range_high)

	combo.add_count(a)
