extends KURO_Component

signal counter_changed(old_count, new_count)
var count := 0.0
@export var text_template := "%d"

func kuro_init():
	set_count(0)

func update(old_count):
	self.text = text_template % count
	counter_changed.emit(old_count, count)
	if not self.has_node("AnimationPlayer"):
		print("[ui_counter.gd] No animation player for this counter, skipping animation")
		return
	
	$AnimationPlayer.play("counter_up")

func get_count():
	return count

func set_count(val):
	var old_count := count
	count = val
	update(old_count)

func add_count(val):
	if val < 0:
		return

	var old_count := count
	count += val
	update(old_count)

func sub_count(val):
	var old_count := count
	count -= val
	update(old_count)

func sub_count_positive_only(val):
	if val > 0:
		return

	var old_count := count
	count -= val
	update(old_count)

func mult_count(val):
	var old_count := count
	count *= val
	update(old_count)
