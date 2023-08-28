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
	chosenDecision = rng.randi_range(1,1)#(1, decisionsDict.size())

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
@onready var mainText = $CanvasLayer/Story/Control/RichTextLabel
func keywordsfunc():
	for i in keywords:
		animationPlayer.play(i)
func storyfunc():    #add voice here
	mainText.text = storydecision
	start_dialogue()
func decisionfunc():
	$CanvasLayer/Decisions/Control.visible = true
	$CanvasLayer/Decisions/Control/HBoxContainer/option1.text = dec1
	$CanvasLayer/Decisions/Control/HBoxContainer/option2.text = dec2
func _on_option_1_pressed():
	consequenceResoult(consequence1)
	$CanvasLayer/Decisions/Control/HBoxContainer/option1.disabled = true
	$CanvasLayer/Decisions/Control/HBoxContainer/option2.disabled = true
func _on_option_2_pressed():
	consequenceResoult(consequence2)
	$CanvasLayer/Decisions/Control/HBoxContainer/option1.disabled = true
	$CanvasLayer/Decisions/Control/HBoxContainer/option2.disabled = true
# Ignore ------------- Ignore ------------- Ignore ------------- Ignore



# Touch ------------- Touch ------------- Touch ------------- Touch
func consequenceResoult(consequence):
	
	if consequence["time"]:
		mainText.text = consequence["consequenceText"]
		start_dialogue()
		await get_tree().create_timer(7).timeout
		endInteraction()
	else:
		mainText.text = consequence["consequenceText"]
		start_dialogue()
		await get_tree().create_timer(5).timeout
		endInteraction()
	
	if consequence["reputation"]:
		print("+ reputation")
	else:
		print("- reputation")
	
	if consequence["playercash"]:
		print("+ playercash")
	else:
		print("- playercash")

# Touch ------------- Touch ------------- Touch ------------- Touch



# Ignore ------------- Ignore ------------- Ignore ------------- Ignore
func endInteraction():
	$CanvasLayer/Decisions/Control.visible = false
	for i in keywords:
		animationPlayer.play(i + "b")
	mainText.text = ""
	$CanvasLayer/Decisions/Control/HBoxContainer/option1.disabled = false
	$CanvasLayer/Decisions/Control/HBoxContainer/option2.disabled = false

func start_dialogue():
	mainText.visible_ratio = 0
	while mainText.visible_ratio < 1:
		await get_tree().create_timer(0.05).timeout
		mainText.visible_characters += 1
	await get_tree().create_timer(1).timeout
	decisionfunc()
#Typing # Ignore ------------- Ignore ------------- Ignore ------------- Ignore
