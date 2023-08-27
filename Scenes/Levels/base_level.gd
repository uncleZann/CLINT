extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		$CanvasLayer.visible = true
		$Ui/CanvasLayer.visible = false
	
	$Ui/CanvasLayer/Control/VBoxContainer/Label.text = str("Cash: ", Globals.playerCash, "Gold: ", Globals.playerGold)


func _on_escape_menu_resume_pressed():
	print("pressed")
	$CanvasLayer.visible = false
	$Ui/CanvasLayer.visible = true
