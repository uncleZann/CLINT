extends Node

func _ready():
	VisibleOnScreenEnabler2D

# Ignore ------------- Ignore ------------- Ignore ------------- Ignore
var worldExist1: bool
var worldExist2: bool
var worldExist3: bool
func save_data():
	var to_save = gameDataforSaving.new()
	to_save.worldExist1 = worldExist1
	to_save.worldExist2 = worldExist2
	to_save.worldExist3 = worldExist3
	ResourceSaver.save(to_save, "user://general_data.tres")
func load_data():
	var loaded = load("user://general_data.tres")
	worldExist1 = loaded.worldExist1
	worldExist2 = loaded.worldExist2
	worldExist3 = loaded.worldExist3
# Ignore ------------- Ignore ------------- Ignore ------------- Ignore
#specific world
var current_world
signal gloablsChange
signal decisionChanged
var decisionAlreadySeen: Array:
	get:
		return decisionAlreadySeen
	set(value):
		decisionAlreadySeen = value
		decisionChanged.emit()
# Ignore ------------- Ignore ------------- Ignore ------------- Ignore

var playerCash: int:
	get:
		return playerCash
	set(value):
		playerCash = value
		gloablsChange.emit()
var playerGold: int:
	get:
		return playerGold
	set(value):
		playerGold = value
		gloablsChange.emit()
var playerReputation: float

func specific_world_save_data(file_path:String):
	var to_save = gameDataforSaving.new()
	to_save.playerCash = playerCash
	to_save.playerGold = playerGold
	to_save.decisionAlreadySeen = decisionAlreadySeen
	to_save.playerReputation = playerReputation
	ResourceSaver.save(to_save, file_path)
func specific_world_load_data(file_path:String):
	var loaded = load(file_path)
	playerCash = loaded.playerCash
	playerGold = loaded.playerGold
	playerReputation = loaded.playerReputation
	
	#ignore
	decisionAlreadySeen = loaded.decisionAlreadySeen

# Ignore ------------- Ignore ------------- Ignore ------------- Ignore
signal colisionDetectedSignal
var colisionDetected: String:
	get:
		return colisionDetected
	set(value):
		colisionDetected = value
		colisionDetectedSignal.emit()

signal playerSpeedChange
var playerSpeed: int:
	get:
		return playerSpeed
	set(value):
		playerSpeed = value
		playerSpeedChange.emit()
