extends Node2D

var decisionAlreadySeen: Array
var worldData: WorldData

#NoTouch -------------------------------------------------------------- # Decisions
const filePath = "res://Scenes/Decisions/decisionsData.tres"
var decisionsDict = {}
func _ready():
	if FileAccess.file_exists(filePath):
		var loaded = load(filePath)
		decisionsDict = loaded.decisionsDict
		worldData = WorldData.load_or_create(Globals.currentWorld)
	else:
		#load from web -- WIP
		print("Your Decisions file is mising")
#NoTouch -------------------------------------------------------------- # Decisions
####################
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
var rng = RandomNumberGenerator.new()
func DecisionsLogic():
	chosenDecision = rng.randi_range(1, decisionsDict.size())
	if not decisionsDict.size() == decisionAlreadySeen.size():
		if not chosenDecision in decisionAlreadySeen:  #if the random num isnt in the array, it saves it and makes a world
			decisionAlreadySeen.append(chosenDecision) #adds it to the array
			worldData.decisionAlreadySeen = decisionAlreadySeen #saves it to the speciufc world singleton
			decisionsDictLoaded() #calls
			START_INTERACTION()
		else:
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
func START_INTERACTION():
	$CanvasLayer.visible = true
	storyfunc() #calls
func storyfunc():    #add voice here
	keywordsfunc()
	mainText.text = storydecision
	start_dialogue()
func keywordsfunc() -> void:
	$StartEndAnimations.play("default")
	for i in keywords:
		animationPlayer.play(i)
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
func consequenceResoult(consequence: Dictionary) -> void:
	if consequence.has("time"):
		if consequence["time"]:
			mainText.text = consequence["consequenceText"]
			start_dialogue()
			await get_tree().create_timer(3).timeout
			endInteraction()
		else:
			mainText.text = consequence["consequenceText"]
			itsEnding = true
			start_dialogue()

	if consequence.has("reputation"):
		if consequence["reputation"]:
			worldData.playerReputation += 0.1
			saveConsequence()
		else:
			worldData.playerReputation -= 0.1
			saveConsequence()

	if consequence.has("socialconnections"):
		if consequence["socialconnections"]:
			worldData.socialconnections += 0.1
			saveConsequence()
		else:
			worldData.socialconnections -= 0.1
			saveConsequence()

	if consequence.has("playercash"):
		if consequence["playercash"]:
			worldData.playerCash += 0.1
			saveConsequence()
		else:
			worldData.playerCash -= 0.1
			saveConsequence()

	if consequence.has("socialconnections"):
		if consequence["socialconnections"]:
			worldData.socialconnections += 0.1
			saveConsequence()
		else:
			worldData.socialconnections -= 0.1
			saveConsequence()

	if consequence.has("playergold"):
		if consequence["playergold"]:
			worldData.playerGold += 0.1
			saveConsequence()
		else:
			worldData.playerGold -= 0.1
			saveConsequence()

	if consequence.has("fitnesslevel"):
		if consequence["fitnesslevel"]:
			worldData.fitnesslevel += 0.1
			saveConsequence()
		else:
			worldData.fitnesslevel -= 0.1
			saveConsequence()

	if consequence.has("health"):
		if consequence["health"]:
			worldData.health += 0.1
			saveConsequence()
		else:
			worldData.health -= 0.1
			saveConsequence()

	if consequence.has("knowledge"):
		if consequence["knowledge"]:
			worldData.knowledge += 0.1
			saveConsequence()
		else:
			worldData.knowledge -= 0.1
			saveConsequence()

func saveConsequence():
	worldData.save(Globals.currentWorld)

# Ignore ------------- Ignore ------------- Ignore ------------- Ignore
func endInteraction() -> void:
	options.visible = false
	$StartEndAnimations.play_backwards("default")
	for i in keywords:
		animationPlayer.play(i + "b")
	mainText.text = ""
	option1.disabled = false
	option2.disabled = false
	$CanvasLayer.visible = false
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
