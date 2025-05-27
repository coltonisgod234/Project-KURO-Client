#extends Node2D
extends KURO_Component
class_name KURO_Character

func primary():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return

func secondaryA():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return

func secondaryB():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return

func secondaryC():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
