extends Node2D  #Just a parent scene, for all the in-game items, that will be in the world
class_name base_item

# Buttons ------------ Buttons ------------ Buttons ------------ Buttons ------------ Buttons
func _on_collect_pressed() -> void:
	queue_free()
# Buttons ------------ Buttons ------------ Buttons ------------ Buttons ------------ Buttons
