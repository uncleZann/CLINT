extends CanvasLayer

@onready var PlacmentUi = $PlacmentUi
@onready var Inventory = $Inventory

var worldData: WorldData
	
#	saveItem(theItem, theItem.position)
#
#func saveItem(theItem, theItemPosition):
#	var placedItemsArray: Array = worldData.placedItemsArray
#	placedItemsArray.append({"item": theItem, "position": theItemPosition})
#	worldData.placedItemsArray = placedItemsArray
#	worldData.save(Globals.currentWorld)

func loadStats():
	worldData = Globals.worldData
	
	#$Inventory/ColorRect/Stats/decisionAlreadySeen.text = str("Decision's Seen: ",worldData.decisionAlreadySeen.size())
	$Inventory/ColorRect/HBoxContainer/Stats/playerCash.text = str("Cash: ",snapped(worldData.playerCash, 0.01), "$")
	$Inventory/ColorRect/HBoxContainer/Stats/playerGold.text = str("Gold: ", worldData.playerGold, "g")
	$Inventory/ColorRect/HBoxContainer/Stats/playerReputation.text = str("Reputation: ", worldData.playerReputation, "c")
	$Inventory/ColorRect/HBoxContainer/Stats/socialconnections.text = str("Connections: ", worldData.socialconnections, "x")
	$Inventory/ColorRect/HBoxContainer/Stats/fitnesslevel.text = str("Fitness Level: ", worldData.fitnesslevel, "bpm")
	$Inventory/ColorRect/HBoxContainer/Stats/health.text = str("Health: ",worldData.health, "hp")
	$Inventory/ColorRect/HBoxContainer/Stats/knowledge.text = str("Knowledge: ",worldData.knowledge, "iq")



func uiVisibility(PlacmentUiBool: bool, InventoryBool: bool):
	PlacmentUi.visible = PlacmentUiBool
	Inventory.visible = InventoryBool

# BUTTON INPUTS ----------- BUTTON INPUTS ----------- BUTTON INPUTS ----------- BUTTON INPUTS
func _on_menu_button_pressed():
	if not Inventory.visible:
		Inventory.visible = true
		worldData = WorldData.load_or_create(Globals.currentWorld)
		loadStats()
	else:
		uiVisibility(false, false)

func _on_close_button_pressed():
	uiVisibility(false, false)

var isInFullScreen = false
func _on_screen_button_pressed():
	if not isInFullScreen:
		print("full")
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		isInFullScreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		isInFullScreen = false

func _on_build_menu_pressed():
	uiVisibility(true, false)
# BUTTON INPUTS ----------- BUTTON INPUTS ----------- BUTTON INPUTS ----------- BUTTON INPUTS


func _on_update_stats_timer_timeout():
	loadStats()


func _on_item_container_button_hide_ui():
	uiVisibility(false, false)
