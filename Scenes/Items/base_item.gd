extends Node2D  #Just a parent scene, for all the in-game items, that will be in the world
class_name base_item

# Buttons ------------ Buttons ------------ Buttons ------------ Buttons ------------ Buttons
func _on_collect_pressed() -> void:
	pickupItem()
	
	itemPickedUp()
	
	await get_tree().create_timer(1.5).timeout
	queue_free()
# Buttons ------------ Buttons ------------ Buttons ------------ Buttons ------------ Buttons

func pickupItem():
	$Sprite2D.visible = false
	$Collect.visible = false
	$MidLabel.text = str("+1.0")

#Default Functions
func itemPickedUp():
	print("pixked")
