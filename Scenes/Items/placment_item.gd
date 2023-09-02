extends base_item # A parent scene, for item that you will be a able to place and buy

@onready var mainArea: Area2D = $MainCollisionArea
var tilemap: TileMap

func _ready(): #called at instance
	tilemap = Globals.MainPlacmentTilemap

func _process(_delta) -> void: #Called every frame
	itemMoving()
	itemPlacing()

func itemMoving() -> void:   #For moving the items
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		var mouseTile = tilemap.local_to_map(get_global_mouse_position())
		var local_pos = tilemap.map_to_local(mouseTile)
		var world_pos = tilemap.to_global(local_pos)
		global_position = world_pos
		
func itemPlacing() -> void: # for placing items
	if not mainArea.get_overlapping_areas().size() > 0:
		if Input.is_action_just_pressed("LMB"):
			set_process(false)
			set_process_unhandled_input(false)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
