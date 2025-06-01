extends KURO_Component
class_name KURO_EffectExecutor

func apply_all_effects(name: String):
	for child in self.get_children():
		child.apply()

func apply_argument(effect: String, propname: String, value):
	var effect_object = self.get_node(effect)
	effect_object.set(propname, value)

func apply(name: String):
	self.get_node(name).apply()

func apply_random_effect_bagged_random(last_effect_applied):
	var child = self.get_children().pick_random()
	while child == last_effect_applied:
		print("[apply_random_effect_bagged_random] Got the same as last time, picking again! %s" % [child])
		child = self.get_children().pick_random()
	
	print("[apply_random_effect_bagged_random] Picked a good child %s" % [child])
	child.apply()
	randomize()
	return child

func apply_random_effect():
	var child = self.get_children().pick_random()
	child.apply()
	randomize()
	return child
