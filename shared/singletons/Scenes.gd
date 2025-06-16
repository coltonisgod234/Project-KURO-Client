extends Node

var Main := preload("res://main.tscn")
var Note := preload("res://gameplay/mod_note/note.tscn")
var Lane := preload("res://gameplay/mod_note/lane.tscn")
var LaneManager := preload("res://gameplay/mod_management/lane_manager.tscn")
var SongPlayer := preload("res://gameplay/mod_management/song_player.tscn")
var HUD := preload("res://gameplay/mod_HUD/hud.tscn")
var BaseCharacter := preload("res://gameplay/mod_characters/basecharacter.tscn")

var CharacterManager := preload("res://gameplay/mod_characters/character_manager.tscn")
var CharacterViolet := preload("res://gameplay/mod_characters/violet/violet.tscn")
var CharacterKuro := preload("res://gameplay/mod_characters/kuro/kuro.tscn")
var CharacterTab5 := preload("res://gameplay/mod_characters/Tab5/tab5.tscn")
var CharacterCloudy := preload("res://gameplay/mod_characters/cloudy/cloudy.tscn")
var CharacterCloudyPersonalityCloudy := preload("res://gameplay/mod_characters/cloudy/personality_cloudy/main.tscn")
#var CharacterCloudyPersonalityThunderstorm := preload("res://gameplay/mod_characters/cloudy/personality_thunderstorm/main.tscn")
#var CharacterCloudyPersonalityThunderlight := preload("res://gameplay/mod_characters/cloudy/personality_thunderlight/main.tscn")
var CharacterList: Dictionary[String, PackedScene] = {
	"Violet" = CharacterViolet,
	"Kuro" = CharacterKuro,
	#"Tab5" = CharacterTab5,
	#"Cloudy" = CharacterCloudy
}

var SongSelect := preload("res://menu/songsel/songselect.tscn")
var SongSelectChartHeader := preload("res://menu/songsel/chart/chartheader.tscn")
var SongSelectDifficultyHeader := preload("res://menu/songsel/diff/diffheader.tscn")

var TeamBuilder := preload("res://menu/teambuild/teambuilder.tscn")
var TeamBuildSelectCharacterDropdown := preload("res://menu/teambuild/char/selector/selector.tscn")

var CharacterDialougeBox := preload("res://dialouge/popup.tscn")
