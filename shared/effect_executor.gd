extends KURO_Component
class_name KURO_EffectExecutor

func apply_argument(effect_name: String, propname: String, value):
	print("Applying arg... %s, %s = %s" % [effect_name, propname, value])
	var effect_object = self.get_node(effect_name)
	if effect_object == null:
		print("Wtf its null")
		return

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
		if not child.has_method("apply"):
			print("[effect_executor.gd] wtf no apply method")
			return "wtf no apply method"

		print("Applying... %s" % child.name)
		await child.apply()

func apply_argument_to_all(propname: String, value):
	for child in self.get_children():
		print("[effect_executor.gd] applying argument %s = %s on %s..." % [propname, value, child])
		child.set(propname, value)

func apply_arguments_from_dictionary(d:Dictionary):
	for effect_name in d:
		var effect = d.get(effect_name)
		for attribute in effect:
			var value = effect.get(attribute)  # Fuck GDScript
			self.apply_argument(effect_name, attribute, value)
