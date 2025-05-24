extends Area2D

@export var note_miss_line: int = -35

signal note_destroyed(lane_node: Node, note: Node)
signal note_hit(lane_node: Node, note: Node)
signal note_miss(lane_node: Node, note: Node)

func eval_note(node, lane_num):
	var key = "key%s" % lane_num
	var is_pressed = Input.is_action_pressed(key)
	if self.overlaps_area(node.get_node("Area2D")):
		#print("NODE IS OVERLAPPING")
		if is_pressed:
			note_hit.emit(self, node)
			note_destroyed.emit(self, node)
			node.queue_free()

	elif node.position.y < 0:
		note_miss.emit(self, node)
		note_destroyed.emit(self, node)
		node.queue_free()
