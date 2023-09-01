extends Control
#
#signal UiChange
#
#func _on_button_pressed() -> void:
#	UiChange.emit(1)
#	SwitchScreen()
#func _on_shop_button_pressed() -> void:
#	SwitchScreen()
#func _on_exit_button_pressed() -> void:
#	SwitchScreen()
#
#func SwitchScreen() -> void:
#	if $DefaultCanvas.visible:
#		$DefaultCanvas.visible = false
#		$OnScreenCanvas.visible = true
#	else:
#		$DefaultCanvas.visible = true
#		$OnScreenCanvas.visible = false
#
#func _process(_delta):
#	$OnScreenCanvas/OnScreen/TopButtonsContainer/FpsLabel.text = str("FPS: ", Engine.get_frames_per_second())
