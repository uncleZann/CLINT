extends CanvasLayer



func _on_menu_button_pressed():
	menuVisibility(true)



func _on_close_button_pressed():
	menuVisibility(false)


func _on_button_pressed():
	spawnItem()



func spawnItem():
	var placment_item = preload("res://Scenes/Items/placment_item.tscn")
	var TheItem = placment_item.instantiate()
	owner.add_child(TheItem)
	TheItem.position = Globals.cameraPosition
	menuVisibility(false)

func menuVisibility(isVisible: bool):
	$Default.visible = isVisible


var isInFullScreen = false
func _on_screen_button_pressed():
	if not isInFullScreen:
		print("full")
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		isInFullScreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		isInFullScreen = false
