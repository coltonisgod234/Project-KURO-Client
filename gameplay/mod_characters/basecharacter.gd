extends Node2D
class_name KURO_Character

var priority: int = -1
var lane_manager = null

var current_scene = null
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
