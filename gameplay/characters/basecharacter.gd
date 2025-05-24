extends Node2D

class_name KURO_Character
var priority: int = -1

func init():
	pass

var current_scene = null
func primary():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return

func secondary():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return

func _ready():
	current_scene = get_tree().current_scene
	init()
