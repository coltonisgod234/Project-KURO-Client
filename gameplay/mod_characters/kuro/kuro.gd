extends KURO_Character

func kuro_init():
	pass

func primary():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	$Primary.activate()
	$AbilityStun.stun_for(0.5)

func secondaryA(skip_checks=false, no_stun=false):
	if not skip_checks:
		if $AbilityStun.is_stunned(): return
		if $SecondaryA/Cooldown.is_stunned(): return
	$SecondaryA.activate()

	if not no_stun:
		$SecondaryA/Cooldown.stun_for(1.0)

func secondaryB(skip_checks=false, no_stun=false):
	if not skip_checks:
		if $AbilityStun.is_stunned(): return
		if $SecondaryB/Cooldown.is_stunned(): return
	$SecondaryB.activate()

	if not no_stun:
		$SecondaryB/Cooldown.stun_for(1.0)

func secondaryC():
	return
