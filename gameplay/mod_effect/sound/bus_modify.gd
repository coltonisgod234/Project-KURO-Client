extends KURO_Effect

@export var bus_name: String = "Master"

@export_category("Volume")
@export var change_volume: bool
@export var db: float

@export_category("Mute")
@export var change_mute: bool
@export var mute: bool

@export_category("Solo")
@export var change_solo: bool
@export var solo: bool

func apply():
	var idx = AudioServer.get_bus_index(bus_name)
	if change_volume:
		AudioServer.set_bus_volume_db(idx, db)
	if change_mute:
		AudioServer.set_bus_mute(idx, mute)
	if change_solo:
		AudioServer.set_bus_solo(idx, solo)
