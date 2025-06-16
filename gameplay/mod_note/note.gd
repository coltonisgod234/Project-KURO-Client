extends Node2D

var speed: float = 0
@export var go_up := false

func _process(_delta:float):
	match go_up:
		true:
			position.y -= speed * _delta
		false:
			position.y += speed * _delta
	#print("NOTE PROCESSING AND MOVING Y TO %s" % position.y)
