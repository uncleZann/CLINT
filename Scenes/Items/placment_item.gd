extends base_item

func itemMoving() -> void:  #For moving the item on the screen
		var mouseTile = tilemap.local_to_map(get_global_mouse_position())
		var local_pos = tilemap.map_to_local(mouseTile)
		var world_pos = tilemap.to_global(local_pos)
		global_position = world_pos
