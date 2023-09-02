extends Node2D # This is the script for the Node that detects when you want to init a decision
class_name storyDetectors

signal storyDetected
func _on_questionmark_button_pressed():
	storyDetected.emit()
	queue_free()
