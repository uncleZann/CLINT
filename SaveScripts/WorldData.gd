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

static func load_or_create(path) -> WorldData:
	
	#DirAccess.make_dir_absolute(path)
	var res: WorldData = load(path) as WorldData
	if !res:
		res = WorldData.new()
	return res

func save(path) -> void:
	ResourceSaver.save(self, path)
