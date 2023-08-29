extends Node2D
class_name base_level

func _ready():
	Globals.MainPlacmentTilemap = $MainPlacmentTilemap

func _process(_delta) -> void:
	if Input.is_action_just_pressed("escape"):
		$Ui/EscapeMenu.visible = true

func _on_escape_menu_resume_pressed() -> void:
	$Ui/EscapeMenu.visible = false



var item = preload("res://Scenes/Items/placment_item.tscn")

func _on_in_game_ui_ui_change(num):
	if num == 1:
		var theitem = item.instantiate()
		$itemsHome.add_child(theitem)
