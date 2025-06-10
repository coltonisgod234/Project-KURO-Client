extends KURO_Component
class_name KURO_EffectExecutor

func apply_all_effects(name: String):
	for child in self.get_children():
		await child.apply()

func apply_argument(effect: String, propname: String, value):
	var effect_object = self.get_node(effect)
	effect_object.set(propname, value)

func apply(name: String):
	var node = self.get_node(name)
	if node.has_method("apply"):
		return node.apply()
	else: return "wtf no apply method"

func apply_random_effect_bagged_random(last_effect_applied):
	var child = self.get_children().pick_random()
	while child == last_effect_applied:
		print("[apply_random_effect_bagged_random] Got the same as last time, picking again! %s" % [child])
		child = self.get_children().pick_random()
	
	print("[apply_random_effect_bagged_random] Picked a good child %s" % [child])
	await child.apply()
	randomize()
	return child

func apply_random_effect():
	var child = self.get_children().pick_random()
	await child.apply()
	randomize()
	return child

func apply_in_succession():
	for child in self.get_children():
		await child.apply()
