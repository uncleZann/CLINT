extends StaticBody2D

func _on_area_2d_body_entered(_body):
	print("teleport")
	get_tree().change_scene_to_file("res://Scenes/Levels/base_level.tscn")
