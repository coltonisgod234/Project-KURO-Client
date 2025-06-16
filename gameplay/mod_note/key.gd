extends Area2D

signal note_destroyed(lane_node: Node, note: Node)
signal note_hit(lane_node: Node, note: Node)
signal note_miss(lane_node: Node, note: Node)

func hit(node, lane_num):
	note_hit.emit(self, node)
	note_destroyed.emit(self, node)
	node.queue_free()
	$AudioStreamPlayer.play()

func miss(node, lane_num):
	note_miss.emit(self, node)
	note_destroyed.emit(self, node)
	node.queue_free()
	$AudioStreamPlayer.play()

func eval_note(node, lane_num):
	var key = "key%s" % lane_num
	var is_pressed = Input.is_action_pressed(key)
	if self.overlaps_area(node.get_node("Area")):
		node.set_meta("key_been_inside", true)
		#print("NODE IS OVERLAPPING")
		if is_pressed:
			hit(node, lane_num)
		
		return

	elif node.get_meta("key_been_inside"):
		miss(node, lane_num)
