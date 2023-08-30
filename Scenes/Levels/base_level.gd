extends Node2D
class_name base_level

func _ready() -> void:
	Globals.MainPlacmentTilemap = $MainPlacmentTilemap
	spawnItems()

func _process(_delta) -> void:
	if Input.is_action_just_pressed("escape"): #Just checks if escape is pressed
		$Ui/EscapeMenu.visible = true

func _on_escape_menu_resume_pressed() -> void:  #Gets signal from "escapeMenu" and hides it
	$Ui/EscapeMenu.visible = false

func _on_in_game_ui_ui_change(num)  -> void: #Adding items #WIP
	var item = preload("res://Scenes/Items/placment_item.tscn")
	if num == 1:
		var theitem = item.instantiate()
		$itemsHome.add_child(theitem)

func spawnItems():
	print(Globals.MainPlacmentTilemap)
