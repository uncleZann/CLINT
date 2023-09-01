extends base_item

@onready var mainArea: Area2D = $MainCollisionArea
var tilemap: TileMap

func _ready(): #called at instance
	tilemap = Globals.MainPlacmentTilemap

func _process(_delta) -> void: #Called every frame
	itemMoving()
	itemPlacing()

func itemMoving() -> void:  #For moving the item on the screen
		#print(get_viewport().size)
#		print(get_global_mouse_position().clamp(Vector2.ZERO, get_viewport().size))
#		print(get_global_mouse_position())
#.clamp(-get_viewport().size, get_viewport().size)**

		var mouseTile = tilemap.local_to_map(get_global_mouse_position())
		var local_pos = tilemap.map_to_local(mouseTile)
		var world_pos = tilemap.to_global(local_pos)
		global_position = world_pos
		
func itemPlacing() -> void: # for placing items
	if not mainArea.get_overlapping_areas().size() > 0:
		if Input.is_action_just_pressed("LMB"):
			set_process(false)
			set_process_unhandled_input(false)
