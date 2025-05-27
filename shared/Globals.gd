extends Node

func wait_for_component(component_name):
	print("[Globals.gd] Waiting for %s" % component_name)
	while component_name not in self.exports:
		pass
	
	print("[Globals.gd] Done waiting for %s" % component_name)

enum { JUDGE_MISS = 0, JUDGE_HIT = 1 }
#var LaneManager
var exports: Dictionary
