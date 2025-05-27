#extends Node2D
extends KURO_Component
class_name KURO_Character

func primary():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	$Primary.activate()

func secondaryA():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	$SecondaryA.activate()

func secondaryB():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	$SecondaryB.activate()

func secondaryC():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	$SecondaryC.activate()
