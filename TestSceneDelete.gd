extends Node2D

var user_prefs: WorldData

# Called when the node enters the scene tree for the first time.
func _ready():
	user_prefs = WorldData.load_or_create()




func _on_button_pressed():
	print(user_prefs.changed)



func _on_button_2_pressed():
	if user_prefs:
		user_prefs.playerReputation += 1
		user_prefs.save()
