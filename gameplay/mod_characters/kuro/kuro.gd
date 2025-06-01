extends KURO_Character

@export var life: float
@export var LastEffectApplied: Node
@export var LastEffectMultiplexed: Node
@export var LastEffectAppliedHumanFriendlyName: String

func kuro_init():
	pass

func primary():
	if life < 0.0: return
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	$Primary.activate()
	$AbilityStun.stun_for(0.5)

func secondaryA(skip_checks=false, no_stun=false):
	if not skip_checks:
		if life < 0.0: return
		if $AbilityStun.is_stunned(): return
		if $SecondaryA/Cooldown.is_stunned(): return
	$SecondaryA.activate()

	if not no_stun:
		$SecondaryA/Cooldown.stun_for(1.0)

func secondaryB(skip_checks=false, no_stun=false):
	if not skip_checks:
		if life < 0.0: return
		if $AbilityStun.is_stunned(): return
		if $SecondaryB/Cooldown.is_stunned(): return
	$SecondaryB.activate()

	if not no_stun:
		$SecondaryB/Cooldown.stun_for(1.0)

func secondaryC():
	return
