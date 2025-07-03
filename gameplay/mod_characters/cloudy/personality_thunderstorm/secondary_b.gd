extends KURO_Ability

@export var beer_loss: int
@export var beer_gain_lo: int
@export var beer_gain_hi: int
@export var stuntime: float
@export var ability_stun: Timer
@export var arrest_chance: int

func activate():
	if $Cooldown.is_stunned(): return
	print("PHASE 1")
	sg.beer -= beer_loss

	print("PHASE 2")
	await ability_stun.set_and_wait(stuntime)
	
	print("PHASE 3")
	sg.beer += randi_range(beer_gain_lo, beer_gain_hi)
	
	print("PHASE 4")
	if randi_range(0, arrest_chance) == 0:
		print("HE HAVE BEEN ARREST")

	print("DONE")
