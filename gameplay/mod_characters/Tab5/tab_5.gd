extends KURO_Character

@export_category("Programs")
@export var program: Node
@export var installation_delay_sec: float

@export_category("Corruption")
@export var corruption: float
@export var installation_cost_corruption: float
@export var execution_cost_corruption: float
@export var termination_cost_corruption: float

@export_category("Log")
@export var max_log_lines: int
@export var log: Array[String]

func get_program_name():
	if program == null:
		#print("No program")
		return
	return program.ability_name

func append_log(text: String):
	log.append(text)
	if log.size() > max_log_lines:
		log.pop_front()

func log_to_string():
	return "\n".join(log)

func funny_apt_thing(name):
	append_log("Reading package lists... Done")
	await $MiscTimer.set_and_wait(0.1)
	append_log("Building dependency tree... Done")
	await $MiscTimer.set_and_wait(0.14)
	append_log("Reading state information... Done")
	await $MiscTimer.set_and_wait(0.14)
	append_log("The following NEW packages will be installed:")
	append_log("   %s" % name)
	await $MiscTimer.set_and_wait(0.15)
	append_log("0 upgraded-")
	append_log("1 newly installed-")
	append_log("0 to remove-")
	await $MiscTimer.set_and_wait(0.12)
	append_log("and %s not upgraded-" % randi_range(200, 727))
	append_log("Need to get %s kB of archives." % randi_range(200, 727))
	await $MiscTimer.set_and_wait(0.13)
	append_log("Get:1 https://projectkuro.com/%s" % name)
	await $MiscTimer.set_and_wait(0.2)
	append_log("Setting up %s ..." % name)
	await $MiscTimer.set_and_wait(0.10)

func install_program(name: String):
	append_log("$ apt install %s" % name)
	await $AbilityStun.set_and_wait(installation_delay_sec)
	corruption += installation_cost_corruption
	program = $Programs.get_node(name)

	await funny_apt_thing(name)


func primary():
	if program.can_process():
		append_log("$ pkill %s")

	if program == null:
		append_log("Command not found.")
		return

	program.set_process(true)
	program.activate()
	append_log("$ %s" % program.ability_name)

func secondaryA():
	install_program("AutoHotKey")

func secondaryB():
	install_program("HexEditor")

func secondaryC():
	pass
