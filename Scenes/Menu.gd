extends Control

@onready var mainMenu = $mainMenu
@onready var optionsMenu = $optionsMenu
@onready var playMenu = $playMenu

func playClickSound():
	$ClickSoundPlayer.play()
	await get_tree().create_timer(0.03).timeout


#MainMenu
func _on_play_pressed():
	playClickSound()
	#get_tree().change_scene_to_file("res://Scenes/Levels/base_level.tscn")
	mainMenu.visible = false
	playMenu.visible = true

	
func _on_options_pressed():
	playClickSound()
	mainMenu.visible = false
	optionsMenu.visible = true


func _on_quit_pressed():
	playClickSound()
	get_tree().quit()
#MainMenu

#OptionsMenu
func _on_back_pressed():
	playClickSound()
	mainMenu.visible = true
	optionsMenu.visible = false
#OptionsMenu

#PlayMenu
func _on_play_back_pressed():
	playClickSound()
	mainMenu.visible = true
	playMenu.visible = false

func _ready():
	if FileAccess.file_exists("user://general_data.tres"):
		Globals.load_data()
	else:
		Globals.save_data()
	
	if Globals.worldExist1:
		$playMenu/slots/SaveSlot1/VBoxContainer/startNew1.visible = false
	else:
		$playMenu/slots/SaveSlot1/VBoxContainer/Load1.visible = false
	if Globals.worldExist2:
		$playMenu/slots/SaveSlot2/VBoxContainer/startNew2.visible = false
	else:
		$playMenu/slots/SaveSlot2/VBoxContainer/Load2.visible = false
	if Globals.worldExist3:
		$playMenu/slots/SaveSlot3/VBoxContainer/startNew3.visible = false
	else:
		$playMenu/slots/SaveSlot3/VBoxContainer/Load3.visible = false


func change_scene_to_world():
	get_tree().change_scene_to_file("res://Scenes/Levels/base_level.tscn")


func _on_load_1_pressed():
	playClickSound()
	var path = "user://data1.tres"
	Globals.current_world = path
	Globals.specific_world_load_data(path)
	change_scene_to_world()
func _on_start_new_1_pressed():
	playClickSound()
	var path = "user://data1.tres"
	Globals.current_world = path
	Globals.worldExist1 = true
	change_scene_to_world()

func _on_load_2_pressed():
	playClickSound()
	var path = "user://data2.tres"
	Globals.current_world = path
	Globals.specific_world_load_data(path)
	change_scene_to_world()
func _on_start_new_2_pressed():
	playClickSound()
	var path = "user://data2.tres"
	Globals.current_world = path
	Globals.worldExist2 = true
	change_scene_to_world()

func _on_load_3_pressed():
	playClickSound()
	var path = "user://data3.tres"
	Globals.current_world = path
	Globals.specific_world_load_data(path)
	change_scene_to_world()
func _on_start_new_3_pressed():
	playClickSound()
	var path = "user://data3.tres"
	Globals.current_world = path
	Globals.worldExist3 = true
	change_scene_to_world()

func _on_delete_world_1_pressed():
	if FileAccess.file_exists("user://data1.tres"):
		OS.move_to_trash("user://data1.tres")
func _on_delete_world_2_pressed():
	if FileAccess.file_exists("user://data2.tres"):
		OS.move_to_trash("user://data2.tres")
func _on_delete_world_3_pressed():
	if FileAccess.file_exists("user://data3.tres"):
		OS.move_to_trash("user://data3.tres")
