extends KURO_Effect

@export var amount: int = 0
@export var amount_range_high: int = 0

func apply():
	var hud = Globals.s_wait_for_component("MainHUD")
	var score = hud.s_wait_for_component("Score")
	
	var a: int = amount
	if amount_range_high != 0:
		a = randi_range(amount, amount_range_high)

	score.add_count(a)
