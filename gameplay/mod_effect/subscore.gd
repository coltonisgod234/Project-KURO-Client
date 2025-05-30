extends KURO_Effect

@export var amount: int = 0
@export var amount_range_high: int = 10

func apply():
	var hud = await Globals.wait_for_component("MainHUD")
	var score = await hud.wait_for_component("Score")
	
	var a: int = amount
	if amount_range_high != 0:
		a = randi_range(amount, amount_range_high)

	score.sub_count_positive_only(a)
