extends Node2D
class_name base_item

var tilemap: TileMap
@onready var mainArea: Area2D = $MainCollisionArea

# Checks ------------ Checks #
var isItemPickedup: bool = false
# Checks ------------ Checks #

func _ready(): #called at instance
	tilemap = Globals.MainPlacmentTilemap

func _process(_delta) -> void: #Called every frame
	itemMoving()
	itemPlacing()

func itemMoving() -> void:  #For moving the item on the screen
	if isItemPickedup == true:
		var mouseTile = tilemap.local_to_map(get_global_mouse_position())
		var local_pos = tilemap.map_to_local(mouseTile)
		var world_pos = tilemap.to_global(local_pos)
		global_position = world_pos
func itemPlacing() -> void: # for placing items
	if not mainArea.get_overlapping_areas().size() > 0:
		if Input.is_action_just_pressed("LMB"):
			set_process(false)
			set_process_unhandled_input(false)
			isItemPickedup = false


# Buttons ------------ Buttons ------------ Buttons ------------ Buttons ------------ Buttons
func _on_collect_pressed() -> void:
	queue_free()
# Buttons ------------ Buttons ------------ Buttons ------------ Buttons ------------ Buttons


# Checks ------------ Checks ------------ Checks ------------ Checks ------------ Checks

# Checks ------------ Checks ------------ Checks ------------ Checks ------------ Checks
