extends base_level

var worldData: WorldData

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/random_world_exploration.tscn")

func spawnItems():
	worldData = Globals.worldData
	var itemsForSavingArray = worldData.itemsForSavingArray
	
	var itemForSpawning = preload("res://Scenes/Items/placment_item.tscn")
	
	for i in itemsForSavingArray.size():
		var theItem = itemForSpawning.instantiate()
		theItem.isMoving = false
		theItem.theResource = load("res://Resources/ItemPlacment/testRed.tres")
		theItem.position = itemsForSavingArray[i]["position"]
		add_child(theItem)
