extends KURO_Effect

signal display_name_available(name_: String)
signal drop_list_available(text: String)
signal pull_cost_available_as_str(value: String)  # formatted for user friendly
signal pull_cost_available(value: int)
@export var banner_name: String

func apply():
	$Fetch.endpoint = "/api/gacha/banners/%s" % [banner_name]
	await $Fetch.apply()
	var body = $Fetch.responce.body_utf8()
	var json = JSON.parse_string(body)
	print(json, body)
	if json == null:
		push_error("banner display JSON is null. This isn't good")
		return

	display_name_available.emit(json.get("display_name"))
	drop_list_available.emit(
		parse_drops_data(
			json.get("drops")))

	var pull_cost = json.get("pull_cost")
	pull_cost_available.emit(int(pull_cost))
	pull_cost_available_as_str.emit(pullcost_as_str(pull_cost))

func pullcost_as_str(pull_cost: int):
	return "pull costs x%d" % [pull_cost]

func weights_to_percent(drops):
	var total_weight = 0
	for drop in drops:
		total_weight += drop.get("weight", 0)

	var percentages = []
	for drop in drops:
		var w = drop.get("weight", 0)
		var pct = 0.0
		if total_weight > 0:
			pct = (w / total_weight) * 100.0
		percentages.append({"item": drop.get("item", ""), "percent": pct})
	return percentages

func parse_drops_data(list):
	## build a user-friendly string representing the drops table for a banner
	## takes in the json list data representing this table.
	var s: String = "%12s | %-6s\n" % ["item name", "chance%"]
	
	var chances = weights_to_percent(list)
	for object in chances:
		var item_name = object.get("item")
		var weight = object.get("percent")
		s += "%12s | %-6.2f%%\n" % [item_name, weight]
	print(s)
	return s
