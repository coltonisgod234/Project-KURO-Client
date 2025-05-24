extends KURO_Component

var LaneScene = preload("res://gameplay/mod_note/lane.gd")

func _ready():
	print("[LaneMgr] In _ready gonna check if the btich works!")
	depends.get("chartparser")
