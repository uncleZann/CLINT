extends Node2D
class_name storyDetectors

signal storyDetected

func _on_questionmark_button_pressed():
	storyDetected.emit()
