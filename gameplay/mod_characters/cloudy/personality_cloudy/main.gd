extends KURO_Character

func secondaryA():
	if $AbilityStun.is_stunned(): return
	if $SecondaryA/Cooldown.is_stunned(): return
	$SecondaryA.activate()
