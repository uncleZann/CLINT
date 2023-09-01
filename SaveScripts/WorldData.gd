extends Resource
class_name  WorldData

#signal WorldDataChange
## Ignore ------------- Ignore ------------- Ignore ------------- Ignore

@export var decisionAlreadySeen: Array
@export var playerCash: float
@export var playerGold: float
@export var playerReputation: float
@export var socialconnections: float
@export var fitnesslevel: float
@export var health: float
@export var knowledge: float

@export var AmmountMultiplayer: float

#func ChangeData(variableName: String, ammount: float):
#
#	ammount = ammount * 1#AmmountMultiplayer
#
#	if variableName == "playerReputation":
#		playerReputation += ammount
#	if variableName == "playerCash":
#		playerCash += ammount
#	if variableName == "playerGold":
#		playerGold += ammount
#	if variableName == "socialconnections":
#		socialconnections += ammount
#	if variableName == "fitnesslevel":
#		fitnesslevel += ammount
#	if variableName == "health":
#		health += ammount
#	if variableName == "knowledge":
#		knowledge += ammount
#
## Ignore ------------- Ignore ------------- Ignore ------------- Ignore
#func DecisionSeen(decision):
#	decisionAlreadySeen.append(decision)
#
#################################################################################

static func load_or_create(path) -> WorldData:
	
	#DirAccess.make_dir_absolute(path)
	var res: WorldData = load(path) as WorldData
	if !res:
		res = WorldData.new()
	return res

func save(path) -> void:
	ResourceSaver.save(self, path)
