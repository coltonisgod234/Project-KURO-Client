extends Node

@export var value: DisplayServer.WindowMode
func apply():
	DisplayServer.window_set_mode(value)
