extends Node2D

var speed: int = 0

func _process(delta:float):
	position.y -= speed * delta
	#print("NOTE PROCESSING AND MOVING Y TO %s" % position.y)
