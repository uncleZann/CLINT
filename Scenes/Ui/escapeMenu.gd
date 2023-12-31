extends Control

var worldData: WorldData

func _on_savequit_pressed() -> void:
	Globals.worldData.save(Globals.currentWorld)
	Globals.save_data()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/Ui/menu.tscn")

signal resumePressed
func _on_resume_pressed() -> void:
	resumePressed.emit()
