extends Node2D

var decisionAlreadySeen: Array

#NoTouch --------------------------------------------------------------
const filePath = "res://Scenes/Decisions/decisionsData.tres"
var decisionsDict = {}
func _ready():
	if FileAccess.file_exists(filePath):
		var loaded = load(filePath)
		decisionsDict = loaded.decisionsDict
		Globals.connect("decisionChanged", decisionChanged)
		decisionChanged()
	else:
		#load from web -- WIP
		print("Your Decisions file is mising")
#NoTouch --------------------------------------------------------------

func decisionChanged():
	decisionAlreadySeen = Globals.decisionAlreadySeen

var chosenDecision: int
#Decisions Data
var keywords: Array
var storydecision: String
var dec1: String
var dec2: String
var consequence1: Dictionary
var consequence2: Dictionary

func decisionsDictLoaded():
	keywords = decisionsDict[chosenDecision]["KEYWORDS"]
	storydecision = decisionsDict[chosenDecision]["STORYDECISION"]
	dec1 = decisionsDict[chosenDecision]["DEC1"]
	dec2 = decisionsDict[chosenDecision]["DEC2"]
	consequence1 = decisionsDict[chosenDecision]["CONSEQUENCE1"]
	consequence2 = decisionsDict[chosenDecision]["CONSEQUENCE2"]

# DecisionsLogic()  -  variables
var rng = RandomNumberGenerator.new()
func DecisionsLogic():
	chosenDecision = rng.randi_range(1, decisionsDict.size())

	if not decisionsDict.size() == decisionAlreadySeen.size():
		if not chosenDecision in decisionAlreadySeen:  #if the random num isnt in the array, it saves it and makes a world
			decisionAlreadySeen.append(chosenDecision) #adds it to the array
			Globals.decisionAlreadySeen = decisionAlreadySeen #saves it to globals
			decisionsDictLoaded() #calls
			keywordsfunc()   #calls -- kinda usless
			storyfunc() #calls
		else:
			print("trying again")
			DecisionsLogic() #trys again
	else:
		print("you have gone trough all the decisions")
		
func _on_story_detectors_story_detected():
	DecisionsLogic()

#NoTouch --------------------------------------------------------------
#NoTouch --------------------------------------------------------------
#NoTouch --------------------------------------------------------------
@onready var animationPlayer = $FullAnimations
@onready var mainText: RichTextLabel = $CanvasLayer/SizeControll/mainText/RichTextLabel
@onready var options = $CanvasLayer/SizeControll/Options
@onready var option1: Button = $CanvasLayer/SizeControll/Options/HBoxContainer/option1
@onready var option2: Button = $CanvasLayer/SizeControll/Options/HBoxContainer/option2

func keywordsfunc() -> void:
	$StartEndAnimations.play("default")
	for i in keywords:
		animationPlayer.play(i)
func storyfunc():    #add voice here
	mainText.text = storydecision
	start_dialogue()
func decisionfunc():
	options.visible = true
	option1.text = dec1
	option2.text = dec2
func _on_option_1_pressed() -> void:
	consequenceResoult(consequence1)
	option1.disabled = true
	option2.disabled = true
func _on_option_2_pressed() -> void:
	consequenceResoult(consequence2)
	option1.disabled = true
	option2.disabled = true

var itsEnding = false
# Ignore ------------- Ignore ------------- Ignore ------------- Ignore



# Touch ------------- Touch ------------- Touch ------------- Touch
func consequenceResoult(consequence: Dictionary) -> void:
	
	if consequence.has("time"):
		if consequence["time"]:
			mainText.text = consequence["consequenceText"]
			start_dialogue()
			mainText.text = "Now you wait (:"
			start_dialogue()
			await get_tree().create_timer(20).timeout
			endInteraction()
		else:
			mainText.text = consequence["consequenceText"]
			itsEnding = true
			start_dialogue()
	
	if consequence.has("reputation"):
		if consequence["reputation"]:
			print("+ reputation")
		else:
			print("- reputation")

	if consequence.has("socialconnections"):
		if consequence["socialconnections"]:
			print("+ socialconnections")
		else:
			print("- socialconnections")
		
	if consequence.has("playercash"):
		if consequence["playercash"]:
			print("+ playercash")
		else:
			print("- playercash")
	
	if consequence.has("socialconnections"):
		if consequence["socialconnections"]:
			print("+ socialconnections")
		else:
			print("- socialconnections")

	if consequence.has("playergold"):
		if consequence["playergold"]:
			print("+ playergold")
		else:
			print("- playergold")

	if consequence.has("fitnesslevel"):
		if consequence["fitnesslevel"]:
			print("+ fitnesslevel")
		else:
			print("- fitnesslevel")

	if consequence.has("health"):
		if consequence["health"]:
			print("+ health")
		else:
			print("- health")

	if consequence.has("knowledge"):
		if consequence["knowledge"]:
			print("+ knowledge")
		else:
			print("- knowledge")
# Touch ------------- Touch ------------- Touch ------------- Touch



# Ignore ------------- Ignore ------------- Ignore ------------- Ignore
func endInteraction() -> void:
	options.visible = false
	$StartEndAnimations.play_backwards("default")
	for i in keywords:
		animationPlayer.play(i + "b")
	mainText.text = ""
	option1.disabled = false
	option2.disabled = false

func start_dialogue() -> void:
	mainText.visible_ratio = 0
	while mainText.visible_ratio < 1:
		await get_tree().create_timer(0.05).timeout
		mainText.visible_characters += 1
	await get_tree().create_timer(1).timeout
	decisionfunc()
	if itsEnding:
		await get_tree().create_timer(1).timeout
		endInteraction()
		itsEnding = false
#Typing # Ignore ------------- Ignore ------------- Ignore ------------- Ignore
