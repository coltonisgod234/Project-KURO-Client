extends Node

var SongSelectChartPanelButtonGroup := preload("res://menu/songsel/chart/bgroup.tres")
var SongSelectDifficultyPanelButtonGroup := preload("res://menu/songsel/diff/bgroup.tres")
var SongSelectCurrentChartRootPath: String
var server_ip: String = ""
var username
var password
var APIBearerToken: String = ""

func unset_login_resources(server_ip: String):
	username = null
	password = null
	server_ip = server_ip
	APIBearerToken = ""
