extends KURO_Character

func kuro_init():
	pass

func primary():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	$Primary.activate()

func secondaryA():
	pass

func secondaryB():
	pass

func secondaryC():
	pass
