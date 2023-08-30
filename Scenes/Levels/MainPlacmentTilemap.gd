extends TileMap

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var width =  1000
var height =  1000

func _ready():
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.seed = randi()
	altitude.frequency = 0.005
	generate_chunk()
	

func generate_chunk():
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			var moist = moisture.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*10.0
			var temp = temperature.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*10.0
			var alt = altitude.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*10.0
			
			if alt > 3.0:
				@warning_ignore("integer_division", "narrowing_conversion")
				set_cell(0, Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y), 0.0, Vector2(3, round((temp+10.0)/5.0)))
			else:
				@warning_ignore("integer_division", "narrowing_conversion")
				set_cell(0, Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y), 0.0, Vector2(round((moist+10.0)/5.0), round((temp+10.0)/5.0)))
	itemSpawner()

var item = preload("res://Scenes/Items/test_item.tscn")

func itemSpawner():
	var usedPlacmentPoints: Array = []
	
	for i in 2500:
		await get_tree().create_timer(0.01).timeout
		var cells = get_used_cells(0)
		var cellsSize = cells.size()
		var randomCell = cells[randi_range(1, cellsSize)]
		var local_pos = map_to_local(randomCell)
		var world_pos = to_global(local_pos)
		var itemPosition = Vector2(world_pos.x, world_pos.y)
		
		if not itemPosition in usedPlacmentPoints:
			var theItem = item.instantiate()
			theItem.position = itemPosition
			owner.add_child.call_deferred(theItem)
			usedPlacmentPoints.append(itemPosition)
	
