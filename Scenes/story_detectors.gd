extends Node2D
class_name storyDetectors

signal storyDetected

#name dont matter
func _on_area_2d_body_entered(_body):
	storyDetected.emit()
