extends KURO_Character

@export var drunkness: float
@export var beer: int

func secondaryA():
	if $AbilityStun.is_stunned(): return
	if drunkness <= 0.0:
		print("No you no drunk")
		return
	$SecondaryA.activate()

func secondaryB():
	if $AbilityStun.is_stunned(): return
	if beer <= 0:
		print("No you no beer")
		return
	$SecondaryB.activate()
