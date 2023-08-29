extends Control

func _on_savequit_pressed() -> void:
	Globals.specific_world_save_data(Globals.current_world)
	Globals.save_data()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

signal resumePressed

func _on_resume_pressed() -> void:
	print("emit in esacapemenucode")
	resumePressed.emit()
