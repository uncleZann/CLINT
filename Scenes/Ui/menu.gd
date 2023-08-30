extends Control

@onready var mainMenu = $mainMenu
@onready var optionsMenu = $optionsMenu
@onready var playMenu = $playMenu

func playClickSound() -> void:
	$ClickSoundPlayer.play()
	await get_tree().create_timer(0.03).timeout


#MainMenu --- BUTTON LOGIC
func _on_play_pressed() -> void:
	playClickSound()
	#get_tree().change_scene_to_file("res://Scenes/Levels/base_level.tscn")
	mainMenu.visible = false
	playMenu.visible = true
func _on_options_pressed() -> void:
	playClickSound()
	mainMenu.visible = false
	optionsMenu.visible = true
func _on_quit_pressed() -> void:
	playClickSound()
	get_tree().quit()
#MainMenu --- BUTTON LOGIC

#OptionsMenu  --- BUTTON LOGIC
func _on_back_pressed() -> void:
	playClickSound()
	mainMenu.visible = true
	optionsMenu.visible = false
#OptionsMenu  --- BUTTON LOGIC

#---------------------------------------------------------------------------------#

#PlayMenu  --- BUTTON LOGIC
func _on_play_back_pressed() -> void: #Makes it visible
	playClickSound()
	mainMenu.visible = true
	playMenu.visible = false

var user_prefs: WorldData
func _ready() -> void:
	
	if FileAccess.file_exists("user://general_data.tres"): #Saves or loads general_data.tres
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

func change_scene_to_world() -> void: #Changes scene to our Home World
	get_tree().change_scene_to_file("res://Scenes/Levels/main_home_level.tscn")

func _on_load_1_pressed() -> void:
	playClickSound()
	var path = "user://world1.tres"
	user_prefs = WorldData.load_or_create(path)
	Globals.currentWorld = path
	change_scene_to_world()
func _on_start_new_1_pressed() -> void:
	playClickSound()
	var path = "user://world1.tres"
	user_prefs = WorldData.load_or_create(path)
	Globals.worldExist1 = true
	Globals.currentWorld = path
	change_scene_to_world()

func _on_load_2_pressed() -> void:
	playClickSound()
	var path = "user://world2.tres"
	user_prefs = WorldData.load_or_create(path)
	Globals.currentWorld = path
	change_scene_to_world()
func _on_start_new_2_pressed() -> void:
	playClickSound()
	var path = "user://world2.tres"
	user_prefs = WorldData.load_or_create(path)
	Globals.currentWorld = path
	Globals.worldExist2 = true
	change_scene_to_world()

func _on_load_3_pressed() -> void:
	playClickSound()
	var path = "user://world3.tres"
	user_prefs = WorldData.load_or_create(path)
	Globals.currentWorld = path
	change_scene_to_world()
func _on_start_new_3_pressed() -> void:
	playClickSound()
	var path = "user://world3.tres"
	user_prefs = WorldData.load_or_create(path)
	Globals.currentWorld = path
	Globals.worldExist3 = true
	change_scene_to_world()



func _on_delete_world_1_pressed() -> void:
	pass
func _on_delete_world_2_pressed() -> void:
	pass
func _on_delete_world_3_pressed() -> void:
	pass
#PlayMenu  --- BUTTON LOGIC
