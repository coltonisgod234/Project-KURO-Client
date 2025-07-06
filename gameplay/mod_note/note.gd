extends Node2D

var speed: float = 0
var time: float
@export var go_up := false

func _process(_delta:float):
	match go_up:
		true:
			position.y -= speed * _delta
		false, null:
			position.y += speed * _delta
		_:
			Globals.crash("note: `go_up` was not set to a boolean value")
	#print("NOTE PROCESSING AND MOVING Y TO %s" % position.y)
