extends Node

signal gloablsChange

var currentWorld

# Ignore ------------- Ignore ------------- Ignore ------------- Ignore
var worldExist1: bool
var worldExist2: bool
var worldExist3: bool
func save_data() -> void:
	var to_save = gameDataforSaving.new()
	to_save.worldExist1 = worldExist1
	to_save.worldExist2 = worldExist2
	to_save.worldExist3 = worldExist3
	ResourceSaver.save(to_save, "user://general_data.tres")
func load_data() -> void:
	var loaded = load("user://general_data.tres")
	worldExist1 = loaded.worldExist1
	worldExist2 = loaded.worldExist2
	worldExist3 = loaded.worldExist3
# Ignore ------------- Ignore ------------- Ignore ------------- Ignore




# Just Globals --- No Saving! ----------------- Just Globals --- No Saving!

var cameraPosition

signal colisionDetectedSignal   # For Decisions V
var colisionDetected: String:
	get:
		return colisionDetected
	set(value):
		colisionDetected = value
		colisionDetectedSignal.emit()

var MainPlacmentTilemap: TileMap: #Main tilemap for knowing where to place stuff
	get:
		return MainPlacmentTilemap
	set(value):
		MainPlacmentTilemap = value
		gloablsChange.emit()

# Just Globals --- No Saving! ----------------- Just Globals --- No Saving!
