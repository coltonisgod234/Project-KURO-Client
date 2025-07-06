extends KURO_Effect
class_name EffectGetGoodAttributes

@export var obj: Node
enum Modes {
	ALL_PROPS,
	EXPORTED_ONLY,
	SCRIPT_EXPORTED_ONLY,
}
@export var mode: Modes

func get_good_props_script_exported_only(o):
	if o == null:
		print("[GetCharacterEffects] o is fucking null what the hell?")
		return []

	var good = []
	var bad = Resource.new().get_property_list()
	for prop in o.get_script().get_property_list():
		if prop.usage & PROPERTY_USAGE_EDITOR != 0:
			if prop not in bad:
				good.append(prop)

	return good

func get_good_props_exported_only(o):
	if o == null:
		print("[GetCharacterEffects] o is fucking null what the hell?")
		return []

	var good = []
	for prop in o.get_script().get_property_list():
		if prop.usage & PROPERTY_USAGE_EDITOR != 0:
			good.append(prop)

	return good

func get_good_props_all(o):
	if o == null:
		print("[GetCharacterEffects] o is fucking null what the hell?")
		return []

	return obj.get_property_list()

func apply():
	match mode:
		Modes.ALL_PROPS:
			return get_good_props_all(obj)
		Modes.EXPORTED_ONLY:
			return get_good_props_exported_only(obj)
		Modes.SCRIPT_EXPORTED_ONLY:
			return get_good_props_script_exported_only(obj)
		_:
			return []
