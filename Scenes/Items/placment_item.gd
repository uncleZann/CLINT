extends base_item # A parent scene, for item that you will be a able to place and buy

@export var theResource: Resource
var itemNameType: String

@onready var mainArea: Area2D = $MainCollisionArea
var tilemap: TileMap

var worldData: WorldData

func _ready(): #called at instance
	tilemap = Globals.MainPlacmentTilemap
	worldData = WorldData.load_or_create(Globals.currentWorld)
	
	itemNameType = theResource.itemName
	$Sprite2D.texture = theResource.spriteTexture

func _process(_delta) -> void: #Called every frame
	itemMoving()
	itemPlacing()
	

var isMoving: bool
func itemMoving() -> void:   #For moving the items
	if isMoving:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		var mouseTile = tilemap.local_to_map(get_global_mouse_position())
		var local_pos = tilemap.map_to_local(mouseTile)
		var world_pos = tilemap.to_global(local_pos)
		global_position = world_pos
		
func itemPlacing() -> void: # for placing items
	if not mainArea.get_overlapping_areas().size() > 0:
		if Input.is_action_just_pressed("LMB") and isMoving:
			isMoving = false
			#set_process_unhandled_input(false)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$ResourceProductionTimer.start()
			
			#Save
			saveItemPosition()

func itemPickedUp():
	Globals.itemsForSavingArray = worldData.itemsForSavingArray
	var mouseTile = tilemap.local_to_map(get_global_mouse_position())
	var local_pos = tilemap.map_to_local(Vector2(mouseTile.x, mouseTile.y + 1))
	
	var result = find_position(Globals.itemsForSavingArray, local_pos)
	
	print(Globals.itemsForSavingArray.find(result))
	Globals.itemsForSavingArray.remove_at(Globals.itemsForSavingArray.find(result))
	worldData.itemsForSavingArray = Globals.itemsForSavingArray

func find_position(array, target_position):
	for item in array:
		if item["position"] == target_position:
			return item
	return null

func saveItemPosition():
	Globals.itemsForSavingArray = worldData.itemsForSavingArray
	Globals.itemsForSavingArray.append({"type": itemNameType, "position": global_position})
	worldData.itemsForSavingArray = Globals.itemsForSavingArray

func _on_timer_timeout():
	worldData.playerCash += 0.05
