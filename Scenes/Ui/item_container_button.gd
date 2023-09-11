extends Button

signal hideUI

func spawnItem():
	var placment_item = preload("res://Scenes/Items/placment_item.tscn")
	var theItem = placment_item.instantiate()
	theItem.isMoving = true
	get_node("/root").add_child(theItem)
	theItem.position = Globals.cameraPosition
	hideUI.emit()

func _on_pressed():
	spawnItem()
