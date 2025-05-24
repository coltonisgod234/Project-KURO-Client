extends Node
class_name KURO_DependencySystem

var components = {}

func register_component(name: String, node: Node) -> void:
	components[name] = node
	print("Registered: %s as '%s'" % [node, name])

func inject_all() -> void:
	for name in components:
		var comp = components[name]
		if comp.has_method("get_required_dependencies") and comp.has_method("inject_dependencies"):
			var deps = {}
			for dep_name in comp.get_required_dependencies():
				var found = components.get(dep_name, null)
				if found == null:
					print("⚠️ Missing dep: %s for %s" % [dep_name, name])
				else:
					deps[dep_name] = found
			comp.depends = deps
