extends Resource
class_name  WorldData

@export var decisionAlreadySeen: Array
@export var playerCash: float
@export var playerGold: float
@export var playerReputation: float
@export var socialconnections: float
@export var fitnesslevel: float
@export var health: float
@export var knowledge: float

@export var itemsForSavingArray: Array

static func load_or_create(path) -> WorldData:
	var res: WorldData = load(path) as WorldData
	if !res:
		res = WorldData.new()
	return res

func save(path) -> void:
	ResourceSaver.save(self, path)
