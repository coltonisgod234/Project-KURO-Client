extends Control

#var Cooldown = null
#func _ready():
# var p = Globals.WhatComponentAmIAPartOf(self)
#	p.

var p = null
func _ready():
	p = get_parent()

func _process(_delta: float) -> void:
	print(p.time_left)
	$Stunbar.show_percentage = 1 / p.time_left
