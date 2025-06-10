extends Node2D

var time: float
var speed: int = 0

func _process(_delta:float):
	position.y -= speed * _delta
	#print("NOTE PROCESSING AND MOVING Y TO %s" % position.y)
