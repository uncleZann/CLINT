extends Node2D
class_name base_level

func _ready() -> void:
	Globals.MainPlacmentTilemap = $MainPlacmentTilemap

var isInEscapeMenu: bool = false #just a var checking if player is in escape menu
func _process(_delta) -> void:
	if Input.is_action_just_pressed("escape"): #Just checks if escape is pressed
		if not isInEscapeMenu:
			$Ui/escapeMenu/escapeMenu.visible = true
			isInEscapeMenu = true
		else:
			$Ui/escapeMenu/escapeMenu.visible = false
			isInEscapeMenu = false

func _on_escape_menu_resume_pressed() -> void:  #Gets signal from "escapeMenu" and hides it
	$Ui/escapeMenu/escapeMenu.visible = false

func _on_in_game_ui_ui_change(num)  -> void: #Adding items #WIP
	var item = preload("res://Scenes/Items/placment_item.tscn")
	if num == 1:
		var theitem = item.instantiate()
		$itemsHome.add_child(theitem)
